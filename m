From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 2/2] Initial wizard step for Robin's fetch functionality.
Date: Sun, 10 Feb 2008 21:32:26 -0200
Message-ID: <1202686346-2885-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 00:39:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOLlr-0002nH-SD
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 00:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbYBJXjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbYBJXjF
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 18:39:05 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1232 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751698AbYBJXjC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 18:39:02 -0500
Received: (qmail 73135 invoked by uid 0); 10 Feb 2008 21:42:23 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.376278 secs); 10 Feb 2008 23:42:23 -0000
Received: from unknown (HELO localhost.localdomain) (201.68.3.109)
  by cvxbsd.convex.com.br with SMTP; 10 Feb 2008 23:42:21 -0000
X-Mailer: git-send-email 1.5.3.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73438>

not to be commited.
---
Hi Robin,

This is what I understood from your dialog. You can use this in part and/or
integrate with your patch the way you think is best. Hope it helps.

[]s,
Roger.

 .../egit/ui/internal/wizards/GitCloneWizard.java   |  252 ++++++++++++++++++--
 1 files changed, 230 insertions(+), 22 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/wizards/GitCloneWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/wizards/GitCloneWizard.java
index e8ba87e..d2763b3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/wizards/GitCloneWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/wizards/GitCloneWizard.java
@@ -20,10 +20,17 @@ import org.eclipse.jface.viewers.IStructuredSelection;
 import org.eclipse.jface.wizard.Wizard;
 import org.eclipse.jface.wizard.WizardPage;
 import org.eclipse.swt.SWT;
-import org.eclipse.swt.layout.FillLayout;
+import org.eclipse.swt.events.KeyAdapter;
+import org.eclipse.swt.events.KeyEvent;
+import org.eclipse.swt.events.SelectionAdapter;
+import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Combo;
 import org.eclipse.swt.widgets.Composite;
 import org.eclipse.swt.widgets.Control;
 import org.eclipse.swt.widgets.Label;
+import org.eclipse.swt.widgets.Text;
 import org.eclipse.ui.IImportWizard;
 import org.eclipse.ui.IWorkbench;
 import org.spearce.egit.ui.UIIcons;
@@ -32,7 +39,7 @@ import org.spearce.egit.ui.UIIcons;
  * Import Git Repository Wizard. A front end to a git clone operation.
  */
 public class GitCloneWizard extends Wizard implements IImportWizard {
-	private WarningPage warning;
+	private CloneInputPage cloneInput;
 
 	public void init(IWorkbench arg0, IStructuredSelection arg1) {
 		// Empty
@@ -40,44 +47,245 @@ public class GitCloneWizard extends Wizard implements IImportWizard {
 
 	@Override
 	public void addPages() {
-		warning = new WarningPage();
-		addPage(warning);
+		cloneInput = new CloneInputPage();
+		addPage(cloneInput);
 	}
 
 	@Override
 	public boolean performFinish() {
+		System.out.println("fetch uri: " + cloneInput.getUri());
 		return true;
 	}
 }
 
-class WarningPage extends WizardPage {
-	private Composite container;
+class CloneInputPage extends WizardPage {
+	/** No authentication requested */
+	public static final int AUTH_NONE = 0;
+
+	/** User and password authentication requested */
+	public static final int AUTH_USER_PASS = 1;
+
+	/** SSH public key authentication requested */
+	public static final int AUTH_SSH_PUBLIC_KEY = 2;
+
+	private Composite localComposite;
+
+	private String[] authItems = new String[] { "None", "User/Password",
+			"SSH public key" };
+
+	private Combo authCombo;
+
+	private Text uriText;
+
+	private Text userText;
+
+	private Text passText;
+
+	private Text keyText;
 
 	/**
-	 * Warning message for new users alerting on how to use egit.
+	 * Wizard page that allows the user entering the location of a repository to
+	 * be cloned.
 	 */
-	public WarningPage() {
-		super("Warning Page", "Warning", UIIcons.WIZBAN_IMPORT_REPO);
-		setDescription("Git Import is not ready yet.");
+	public CloneInputPage() {
+		super("Clone Input Page", "Import Git Repository",
+				UIIcons.WIZBAN_IMPORT_REPO);
+		setDescription("Enter the location of the repository to be cloned.");
 	}
 
 	public void createControl(Composite parent) {
-		container = new Composite(parent, SWT.NULL);
-		FillLayout layout = new FillLayout();
-		container.setLayout(layout);
-		Label label1 = new Label(container, SWT.NULL);
-		label1.setText("\nUse Git (THE Git) to create or clone your repo."
-				+ "\nSelect the project in the navigator and"
-				+ "\ngo to the context menu's Team item and"
-				+ "\nbelow it you will find \"Share Project\"."
-				+ "\nSelect it and the rest is self explanatory.");
-
-		setControl(container);
+		localComposite = new Composite(parent, SWT.NULL);
+		GridLayout layout = new GridLayout();
+		layout.numColumns = 2;
+		localComposite.setLayout(layout);
+
+		Label uriLabel = new Label(localComposite, SWT.NULL);
+		uriLabel.setText("Location:");
+
+		uriText = new Text(localComposite, SWT.BORDER);
+		uriText.setText("");
+		GridData uriTextData = new GridData(SWT.FILL, SWT.DEFAULT, true, false);
+		uriText.setLayoutData(uriTextData);
+
+		Label authLabel = new Label(localComposite, SWT.NULL);
+		authLabel.setText("Authentication:");
+
+		authCombo = new Combo(localComposite, SWT.DROP_DOWN | SWT.READ_ONLY);
+		authCombo.setItems(authItems);
+		authCombo.select(0);
+
+		final Label userLabel = new Label(localComposite, SWT.NULL);
+		userLabel.setText("User:");
+		final GridData userLabelData = new GridData();
+		userLabelData.exclude = true;
+		userLabel.setLayoutData(userLabelData);
+
+		userText = new Text(localComposite, SWT.BORDER);
+		userText.setText("");
+		final GridData userTextData = new GridData(SWT.FILL, SWT.DEFAULT, true,
+				false);
+		userTextData.exclude = true;
+		userText.setLayoutData(userTextData);
+
+		final Label passLabel = new Label(localComposite, SWT.NULL);
+		passLabel.setText("Password:");
+		final GridData passLabelData = new GridData();
+		passLabelData.exclude = true;
+		passLabel.setLayoutData(passLabelData);
+
+		passText = new Text(localComposite, SWT.BORDER | SWT.PASSWORD);
+		passText.setText("");
+		final GridData passTextData = new GridData(SWT.FILL, SWT.DEFAULT, true,
+				false);
+		passTextData.exclude = true;
+		passText.setLayoutData(passTextData);
+
+		final Label keyLabel = new Label(localComposite, SWT.NULL);
+		keyLabel.setText("SSH public key:");
+		final GridData keyLabelData = new GridData();
+		keyLabelData.exclude = true;
+		keyLabel.setLayoutData(keyLabelData);
+
+		keyText = new Text(localComposite, SWT.BORDER | SWT.WRAP);
+		keyText.setText("");
+		final GridData keyTextData = new GridData(SWT.FILL, SWT.DEFAULT, true,
+				false);
+		keyTextData.exclude = true;
+		keyTextData.heightHint = 100;
+		keyText.setLayoutData(keyTextData);
+
+		KeyAdapter completeListener = new KeyAdapter() {
+			public void keyReleased(KeyEvent e) {
+				enableDisableFinish();
+			}
+		};
+
+		uriText.addKeyListener(completeListener);
+		userText.addKeyListener(completeListener);
+		passText.addKeyListener(completeListener);
+		keyText.addKeyListener(completeListener);
+
+		authCombo.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				int authRequested = getAuthRequested();
+				hideAll();
+				if (authRequested == AUTH_USER_PASS) {
+					userLabelData.exclude = false;
+					userLabel.setVisible(true);
+					userTextData.exclude = false;
+					userText.setVisible(true);
+
+					passLabelData.exclude = false;
+					passLabel.setVisible(true);
+					passTextData.exclude = false;
+					passText.setVisible(true);
+				} else if (authRequested == AUTH_SSH_PUBLIC_KEY) {
+					keyLabelData.exclude = false;
+					keyLabel.setVisible(true);
+					keyTextData.exclude = false;
+					keyText.setVisible(true);
+				}
+				localComposite.layout(false);
+				enableDisableFinish();
+			}
+
+			private void hideAll() {
+				userLabelData.exclude = true;
+				userLabel.setVisible(false);
+				userTextData.exclude = true;
+				userText.setVisible(false);
+
+				passLabelData.exclude = true;
+				passLabel.setVisible(false);
+				passTextData.exclude = true;
+				passText.setVisible(false);
+
+				keyLabelData.exclude = true;
+				keyLabel.setVisible(false);
+				keyTextData.exclude = true;
+				keyText.setVisible(false);
+			}
+		});
+
+		setControl(localComposite);
 		setPageComplete(false);
 	}
 
+	private void enableDisableFinish() {
+		boolean isComplete = false;
+		if (uriText.getText().length() > 0) {
+			isComplete = true;
+		}
+		int authRequested = getAuthRequested();
+		if (authRequested == AUTH_USER_PASS) {
+			if (userText.getText().length() == 0
+					|| passText.getText().length() == 0) {
+				isComplete = false;
+			}
+		} else if (authRequested == AUTH_SSH_PUBLIC_KEY) {
+			if (keyText.getText().length() == 0) {
+				isComplete = false;
+			}
+		}
+		setPageComplete(isComplete);
+	}
+
 	@Override
 	public Control getControl() {
-		return container;
+		return localComposite;
+	}
+
+	/**
+	 * Returns authentication method entered in the Wizard page.
+	 * 
+	 * @return String the authentication method chosen: <code>AUTH_NONE</code>,
+	 *         <code>AUTH_USER_PASS</code> or <code>AUTH_SSH_PUBLIC_KEY</code>.
+	 */
+	public int getAuthRequested() {
+		String text = authCombo.getText();
+		if (authItems[1].equals(text)) {
+			return AUTH_USER_PASS;
+		} else if (authItems[2].equals(text)) {
+			return AUTH_SSH_PUBLIC_KEY;
+		}
+
+		return AUTH_NONE;
+	}
+
+	/**
+	 * Returns the URI entered in the Wizard page.
+	 * 
+	 * @return String the URI entered in the Wizard page.
+	 */
+	public String getUri() {
+		return uriText.getText();
+	}
+
+	/**
+	 * Returns the user entered in the Wizard page.
+	 * 
+	 * @return String the user entered in the Wizard page.
+	 */
+	public String getUser() {
+		return userText.getText();
+	}
+
+	/**
+	 * Returns the password entered in the Wizard page.
+	 * 
+	 * @return String the password entered in the Wizard page.
+	 */
+	public String getPassword() {
+		return passText.getText();
+	}
+
+	/**
+	 * Returns the SSH public key entered in the Wizard page.
+	 * 
+	 * @return String the SSH public key entered in the Wizard page.
+	 */
+	public String getSshPublicKey() {
+		return keyText.getText();
 	}
 }
-- 
1.5.3.8
