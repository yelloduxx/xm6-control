import SwiftUI
import SonyHeadphonesKit

/// App preferences, in the standard ⌘, window rather than as checkboxes under the
/// headphone controls they have nothing to do with.
struct SettingsView: View {
    @EnvironmentObject private var controller: HeadphonesController
    @EnvironmentObject private var settings: AppSettings

    var body: some View {
        Form {
            Section {
                Toggle("Show only in the menu bar", isOn: $settings.menuBarOnly)
            } footer: {
                Text("Hides the Dock icon. The menu bar panel stays available and can reopen the main window.")
            }

            Section {
                LabeledContent("Desktop & Notification Center") {
                    Text("Edit Widgets\u{2026}, then XM6 Control")
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("Widget")
            } footer: {
                Text("Right-click the desktop or open Notification Center and choose Edit Widgets to add the XM6 widget.")
            }

            Section {
                Toggle("Write protocol log", isOn: $controller.protocolLoggingEnabled)
                LabeledContent("Protocol", value: protocolText)
            } header: {
                Text("Diagnostics")
            } footer: {
                Text("Writes a hex transcript of every frame to protocol.log in Application Support.")
            }
        }
        .formStyle(.grouped)
        .frame(width: 460)
        .fixedSize(horizontal: false, vertical: true)
    }

    private var protocolText: String {
        switch controller.protocolVersion {
        case .v2: return "Sony v2"
        case .v1: return "Sony v1"
        case .unknown: return "Not identified"
        }
    }
}
