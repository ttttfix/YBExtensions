//
//  UIColor+Extension.swift
//  MSTV
//
//  Created by morningstar on 2018/3/13.
//  Copyright © 2018年 morningstar. All rights reserved.
//

import UIKit

extension UIColor {
    
    //在extension中给系统的类扩充构造函数
    // -> 1.只能扩充‘便利构造函数’
    // -> 2.必须调用self.init()方法
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, a : CGFloat =  1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }

    convenience init?(hex : String, alpha : CGFloat =  1.0) {
        // 0xff0000
        // 1.判断字符串的长度是否符合
        guard hex.count >= 6 else {
            return nil
        }
        
        // 2.将字符串转成大写
        var tempHex = hex.uppercased()
        
        // 3.判断开头: 0x/#/##
        if tempHex.hasPrefix("0X") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        
        // 4.分别取出RGB
        // FF --> 255
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        
        // 5.将十六进制转成数字 emoji表情
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)

        self.init(r : CGFloat(r), g : CGFloat(g), b : CGFloat(b), a: alpha)
    }
    
    //没有参数  直接使用类方法
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func getRGBDelta(_ firstColor: UIColor, _ secondColor: UIColor) -> (CGFloat, CGFloat, CGFloat) {
        let firstRGB = firstColor.getRGB()
        let secRGB = secondColor.getRGB()
        
        return(firstRGB.0 - secRGB.0, firstRGB.1 - secRGB.1, firstRGB.2 - secRGB.2)
    }
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        guard let comps = cgColor.components else {
            fatalError("请保证传参是RGB")
        }
        return (comps[0] * 255, comps[1] * 255, comps[2] * 255)
    }


}
