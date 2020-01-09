//
//  ViewController.swift
//  CirclePluseAnimation
//
//  Created by Apple Guru on 9/1/20.
//  Copyright © 2020 Apple Guru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
   var pulseLayers = [CAShapeLayer]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            profileImage.layer.cornerRadius = profileImage.frame.size.width/2.0
            createPulse()
        }
        
        func createPulse() {
            for _ in 0...2 {
                let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.width/2.0, startAngle: 2, endAngle: 4, clockwise: true)
                let pulseLayer = CAShapeLayer()
                pulseLayer.path = circularPath.cgPath
                pulseLayer.lineWidth = 2.0
                pulseLayer.fillColor = UIColor.clear.cgColor
                pulseLayer.lineCap = CAShapeLayerLineCap.round
                pulseLayer.position = CGPoint(x: self.view.frame.size.width/2.0, y: self.view.frame.size.height/2.0)
                self.view.layer.addSublayer(pulseLayer)
                pulseLayers.append(pulseLayer)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.animatePulse(index: 0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.animatePulse(index: 1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.animatePulse(index: 2)
                    }
                }
            }
        }
        
        func animatePulse(index: Int) {
            pulseLayers[index].strokeColor = UIColor.blue.cgColor
            //pulseLayer.strokeColor = UIColor.black.cgColor

            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.duration = 2.0
            scaleAnimation.fromValue = 0.0
            scaleAnimation.toValue = 1.0
            scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            scaleAnimation.repeatCount = .greatestFiniteMagnitude
            pulseLayers[index].add(scaleAnimation, forKey: "scale")
            
            let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
            opacityAnimation.duration = 2.0
            opacityAnimation.fromValue = 0.9
            opacityAnimation.toValue = 0.0
            opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            opacityAnimation.repeatCount = .greatestFiniteMagnitude
            pulseLayers[index].add(opacityAnimation, forKey: "opacity")

            
            
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }


    }

