//
//  ContentView.swift
//  MacOSSwiftUIForms
//
//  Created by VOLKAN EFE on 24.03.2024.
//

import SwiftUI

struct FormData {
    var firstName: String
    var lastName: String
    var address: String
    var city: String
    var state: String
    var postCode: String
    var country: String
    var password: String
    var passwordAgain: String
}

class FormViewModel: ObservableObject{
    @Published var formData = FormData(firstName: "", lastName: "", address: "", city: "", state: "", postCode: "", country: "", password: "", passwordAgain: "")
}

struct ContentView: View {
    @StateObject var viewModel = FormViewModel()
    @State private var showDetails = false
    
    var body: some View {
        
        VStack{
            
            Text("Create Account")
                .font(.title)
                .padding(.top, 20)
            
            Form{
                
                Section{
                    
                    TextField("First Name", text: $viewModel.formData.firstName)
                    TextField("Last Name", text: $viewModel.formData.lastName)
                    
                }
                
                Section(footer: Text("Your password must be at least 8 characters long.")){
                    
                    SecureField("Create Password", text: $viewModel.formData.password)
                    SecureField("Confirm Password", text: $viewModel.formData.passwordAgain)
                    
                }
                
                Divider()
                
                Section(header: Text("Mailing Address")){
                    TextField("Street Adress", text: $viewModel.formData.address)
                    TextField("City", text: $viewModel.formData.city)
                    TextField("State", text: $viewModel.formData.state)
                    TextField("Post Code", text: $viewModel.formData.postCode)
                    TextField("Country", text: $viewModel.formData.country)
                    
                }
            }
            
            Divider()
            
         Button(action: {
             showDetails.toggle()
         }){
             Text("Continue")
                 .frame(width: 250, height: 50, alignment: .center)
                 .background(Color.blue)
                 .foregroundColor(.white)
                 .cornerRadius(8)
         }
         .padding()
            
            
        }
        .frame(width: 400, height: 500)
        .padding()
        .sheet(isPresented: $showDetails){
            DetailsView(formData: viewModel.formData)
        }
        
        
        
        
    }
}


struct DetailsView: View {
    var formData: FormData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Text("Entered Data")
                .font(.title)
                .padding()
            
            List{
                Text("First Name : \(formData.firstName)")
                Text("Last Name : \(formData.lastName)")
                Text("Adress : \(formData.address)")
                Text("City : \(formData.city)")
                Text("State : \(formData.state)")
                Text("Post Code : \(formData.postCode)")
                Text("Country : \(formData.country)")
                Spacer()
                Text("Password : \(formData.password)")
                Text("Password Again : \(formData.passwordAgain)")
            }
            Spacer()
            
        }
        .frame(width: 300, height: 400)
        .toolbar {
            Button("Close") {
                 presentationMode.wrappedValue.dismiss()
             }
        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
