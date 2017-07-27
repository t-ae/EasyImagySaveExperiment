
import Cocoa
import EasyImagy


let SAVE_DIRECTORY = URL(fileURLWithPath: "/Users/USER_NAME/Desktop")

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "Image", withExtension: "jpg")!

        let image = NSImage(named: "Image")!
        
        saveImage(image: image, url: SAVE_DIRECTORY.appendingPathComponent("image1.png"))
        
        let easy = Image<RGBA>(nsImage: image)
    
        // this crashes
        // saveImage(image: easy!.nsImage, url: SAVE_DIRECTORY.appendingPathComponent("image2.png"))
        
        // this also crashes
        // saveImage(image: easy!.cgImage, url: SAVE_DIRECTORY.appendingPathComponent("image3.png"))
    }
}

func saveImage(image: NSImage, url: URL) -> Bool {
    let data = image.tiffRepresentation!
    let b = NSBitmapImageRep.imageReps(with: data).first! as! NSBitmapImageRep
    let pngData = b.representation(using: NSPNGFileType, properties: [:])!
    
    do {
        try pngData.write(to: url, options: Data.WritingOptions.atomic)
        print("save: \(url)")
        return true
    } catch(let e) {
        print("failed")
        return false
    }
}

func saveImage(image: CGImage, url: URL) -> Bool {
    let rep = NSBitmapImageRep(cgImage: image)
    let pngData = rep.representation(using: NSPNGFileType, properties: [:])!
    
    do {
        try pngData.write(to: url, options: Data.WritingOptions.atomic)
        print("save: \(url)")
        return true
    } catch(let e) {
        print("failed")
        return false
    }
}
