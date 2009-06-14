From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH v6 5b/6] Add ref rename support to the branch dialog
Date: Sun, 14 Jun 2009 21:47:28 +0200
Message-ID: <1245008849-12132-2-git-send-email-robin.rosenberg@dewire.com>
References: <20090612200228.GR16497@spearce.org>
 <1245008849-12132-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 14 21:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFvgN-0004ct-Kn
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 21:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763012AbZFNTry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 15:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761906AbZFNTry
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 15:47:54 -0400
Received: from mail.dewire.com ([83.140.172.130]:2891 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758002AbZFNTrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 15:47:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2C26B147D5BB;
	Sun, 14 Jun 2009 21:47:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u6K4y35x5FAz; Sun, 14 Jun 2009 21:47:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id E82DB147D5B1;
	Sun, 14 Jun 2009 21:47:31 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <1245008849-12132-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121556>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |   16 +++
 .../ui/internal/dialogs/BranchSelectionDialog.java |  108 ++++++++++++++++----
 .../src/org/spearce/egit/ui/uitext.properties      |    7 ++
 3 files changed, 110 insertions(+), 21 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 654e155..76764ab 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -893,6 +893,12 @@
 	public static String BranchSelectionDialog_ErrorCouldNotRefresh;
 
 	/** */
+	public static String BranchSelectionDialog_ErrorCouldNotRenameRef;
+
+	/** */
+	public static String BranchSelectionDialog_ErrorCouldNotRenameRef2;
+
+	/** */
 	public static String BranchSelectionDialog_BranchSuffix_Current;
 
 	/** */
@@ -929,6 +935,12 @@
 	public static String BranchSelectionDialog_QuestionNewBranchTitle;
 
 	/** */
+	public static String BranchSelectionDialog_QuestionNewBranchNameTitle;
+
+	/** */
+	public static String BranchSelectionDialog_QuestionNewBranchNameMessage;
+
+	/** */
 	public static String BranchSelectionDialog_QuestionNewBranchMessage;
 
 	/** */
@@ -943,6 +955,8 @@
 	/** */
 	public static String BranchSelectionDialog_ErrorInvalidRefName;
 
+	public static String BranchSelectionDialog_ErrorRenameFailed;
+
 	/** */
 	public static String BranchSelectionDialog_OkCheckout;
 
@@ -952,6 +966,8 @@
 	/** */
 	public static String BranchSelectionDialog_Refs;
 
+	public static String BranchSelectionDialog_Rename;
+
 	/** */
 	public static String HistoryPage_ShowAllVersionsForProject;
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index 9aad95b..f0c13d1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -48,8 +48,11 @@
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.RefRename;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RefUpdate.Result;
 
 /**
  * The branch and reset selection dialog
@@ -173,7 +176,7 @@ private void fillTreeWithBranches(String select) throws IOException {
 					curSubPrefix = null;
 				}
 
-				int slashPos = shortName.indexOf("/");
+				int slashPos = shortName.indexOf("/"); //$NON-NLS-1$
 				if (slashPos > -1) {
 					String remoteName = shortName.substring(0, slashPos);
 					shortName = shortName.substring(slashPos+1);
@@ -277,6 +280,30 @@ private void refNameFromDialog() {
 		}
 	}
 
+	private InputDialog getRefNameInputDialog(String prompt) {
+		InputDialog labelDialog = new InputDialog(
+				getShell(),
+				UIText.BranchSelectionDialog_QuestionNewBranchTitle,
+				prompt,
+				null, new IInputValidator() {
+					public String isValid(String newText) {
+						String testFor = Constants.R_HEADS + newText;
+						try {
+							if (repo.resolve(testFor) != null)
+								return UIText.BranchSelectionDialog_ErrorAlreadyExists;
+						} catch (IOException e1) {
+							Activator.logError(NLS.bind(
+									UIText.BranchSelectionDialog_ErrorCouldNotResolve, testFor), e1);
+						}
+						if (!Repository.isValidRefName(testFor))
+							return UIText.BranchSelectionDialog_ErrorInvalidRefName;
+						return null;
+					}
+				});
+		labelDialog.setBlockOnOpen(true);
+		return labelDialog;
+	}
+
 	@Override
 	protected void createButtonsForButtonBar(Composite parent) {
 		if (!showResetType) {
@@ -284,43 +311,81 @@ protected void createButtonsForButtonBar(Composite parent) {
 			newButton.setFont(JFaceResources.getDialogFont());
 			newButton.setText(UIText.BranchSelectionDialog_NewBranch);
 			((GridLayout)parent.getLayout()).numColumns++;
+			Button renameButton = new Button(parent, SWT.PUSH);
+			renameButton.setText(UIText.BranchSelectionDialog_Rename);
+			renameButton.addSelectionListener(new SelectionListener() {
+				public void widgetSelected(SelectionEvent e) {
+					// check what ref name the user selected, if any.
+					refNameFromDialog();
+
+					String branchName;
+					if (refName.startsWith(Constants.R_HEADS))
+						branchName = refName.substring(Constants.R_HEADS.length());
+					else
+						branchName = refName;	
+					InputDialog labelDialog = getRefNameInputDialog(NLS
+							.bind(
+									UIText.BranchSelectionDialog_QuestionNewBranchNameMessage,
+									branchName));
+					if (labelDialog.open() == Window.OK) {
+						String newRefName = Constants.R_HEADS + labelDialog.getValue();
+						try {
+							RefRename renameRef = repo.renameRef(refName, newRefName);
+							if (renameRef.rename() != Result.RENAMED) {
+								MessageDialog.openError(getShell(),
+										UIText.BranchSelectionDialog_ErrorRenameFailed,
+										NLS.bind(UIText.BranchSelectionDialog_ErrorCouldNotRenameRef,
+												new Object[] { refName, newRefName, renameRef.getResult() }));
+								Activator.logError(NLS.bind(
+										UIText.BranchSelectionDialog_ErrorCouldNotRenameRef2,
+												new Object[] { refName, newRefName }), null);
+							}
+							// FIXME: Update HEAD
+						} catch (IOException e1) {
+							Activator.logError(NLS.bind(
+									UIText.BranchSelectionDialog_ErrorCouldNotRenameRef2,
+															newRefName), e1);
+						}
+						try {
+							branchTree.removeAll();
+							fillTreeWithBranches(newRefName);
+						} catch (IOException e1) {
+							Activator.logError(
+									UIText.BranchSelectionDialog_ErrorCouldNotRefreshBranchList,
+											e1);
+						}
+					}
+				}
+				public void widgetDefaultSelected(SelectionEvent e) {
+					widgetSelected(e);
+				}
+			});
 			newButton.addSelectionListener(new SelectionListener() {
 
 				public void widgetSelected(SelectionEvent e) {
 					// check what ref name the user selected, if any.
 					refNameFromDialog();
 
-					InputDialog labelDialog = new InputDialog(
-							getShell(),
-							UIText.BranchSelectionDialog_QuestionNewBranchTitle,
-							UIText.BranchSelectionDialog_QuestionNewBranchMessage,
-							null, new IInputValidator() {
-								public String isValid(String newText) {
-									String testFor = Constants.R_HEADS + newText;
-									try {
-										if (repo.resolve(testFor) != null)
-											return UIText.BranchSelectionDialog_ErrorAlreadyExists;
-									} catch (IOException e1) {
-										Activator.logError(NLS.bind(
-												UIText.BranchSelectionDialog_ErrorCouldNotResolve, testFor), e1);
-									}
-									if (!Repository.isValidRefName(testFor))
-										return UIText.BranchSelectionDialog_ErrorInvalidRefName;
-									return null;
-								}
-							});
-					labelDialog.setBlockOnOpen(true);
+					InputDialog labelDialog = getRefNameInputDialog(UIText.BranchSelectionDialog_QuestionNewBranchNameMessage);
 					if (labelDialog.open() == Window.OK) {
 						String newRefName = Constants.R_HEADS + labelDialog.getValue();
 						RefUpdate updateRef;
 						try {
 							updateRef = repo.updateRef(newRefName);
+							Ref startRef = repo.getRef(refName);
 							ObjectId startAt;
 							if (refName == null)
 								startAt = repo.resolve(Constants.HEAD);
 							else
 								startAt = repo.resolve(refName);
+							String startBranch;
+							if (startRef != null)
+								startBranch = refName;
+							else
+								startBranch = startAt.name();
+							startBranch = repo.shortenRefName(startBranch);
 							updateRef.setNewObjectId(startAt);
+							updateRef.setRefLogMessage("branch: Created from " + startBranch, false); //$NON-NLS-1$
 							updateRef.update();
 						} catch (IOException e1) {
 							Activator.logError(NLS.bind(
@@ -338,6 +403,7 @@ public String isValid(String newText) {
 					}
 				}
 
+
 				public void widgetDefaultSelected(SelectionEvent e) {
 					widgetSelected(e);
 				}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 1d21c81..a2fd720 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -340,6 +340,10 @@ BranchSelectionDialog_ErrorCouldNotRefresh=Could not refresh list of branches
 BranchSelectionDialog_ErrorCouldNotRefreshBranchList=Could not refresh list of branches
 BranchSelectionDialog_ErrorCouldNotResolve=Could not attempt to resolve {0}
 BranchSelectionDialog_ErrorInvalidRefName=Invalid ref name
+BranchSelectionDialog_ErrorCouldNotRenameRef=Failed to rename branch {0} -> {1}, status={2}
+BranchSelectionDialog_ErrorCouldNotRenameRef2=Failed to rename branch {0} -> {1}
+BranchSelectionDialog_ErrorRenameFailed=Rename failed
+
 BranchSelectionDialog_LocalBranches=Local Branches
 BranchSelectionDialog_NewBranch=&New branch
 BranchSelectionDialog_NoBranchSeletectMessage=You must select a valid ref.
@@ -347,7 +351,9 @@ BranchSelectionDialog_NoBranchSeletectTitle=No branch/tag selected
 BranchSelectionDialog_OkCheckout=&Checkout
 BranchSelectionDialog_OkReset=&Reset
 BranchSelectionDialog_QuestionNewBranchMessage=Enter name of new branch. It will branch from the selected branch. refs/heads/ will be prepended to the name you type
+BranchSelectionDialog_QuestionNewBranchNameMessage=Enter new name of the {0} branch. refs/heads/ will be prepended to the name you type
 BranchSelectionDialog_QuestionNewBranchTitle=New branch
+BranchSelectionDialog_QuestionNewBranchNameTitle=Rename branch
 BranchSelectionDialog_ReallyResetMessage=Resetting will overwrite any changes in your working directory.\n\nDo you wish to continue?
 BranchSelectionDialog_ReallyResetTitle=Really reset?
 BranchSelectionDialog_RemoteBranches=Remote Branches
@@ -357,6 +363,7 @@ BranchSelectionDialog_ResetTypeMixed=&Mixed (working directory unmodified)
 BranchSelectionDialog_ResetTypeSoft=&Soft (Index and working directory unmodified)
 BranchSelectionDialog_Tags=Tags
 BranchSelectionDialog_Refs=&Refs
+BranchSelectionDialog_Rename=&Rename
 
 Decorator_exceptionMessage=Errors occurred while applying Git decorations to resources.
 
-- 
1.6.3.2.199.g7340d
