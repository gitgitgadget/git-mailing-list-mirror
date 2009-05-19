From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/6] Add ref rename support to the branch dialog
Date: Wed, 20 May 2009 01:13:15 +0200
Message-ID: <1242774798-23639-4-git-send-email-robin.rosenberg@dewire.com>
References: <20090507155117.GS30527@spearce.org>
 <1242774798-23639-1-git-send-email-robin.rosenberg@dewire.com>
 <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com>
 <1242774798-23639-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed May 20 01:14:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6YVj-0003TA-5w
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 01:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbZESXNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 19:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbZESXNe
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 19:13:34 -0400
Received: from mail.dewire.com ([83.140.172.130]:25881 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052AbZESXN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 19:13:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 282F6145D123;
	Wed, 20 May 2009 01:13:25 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yqa1huZOYi4H; Wed, 20 May 2009 01:13:24 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.11])
	by dewire.com (Postfix) with ESMTP id 5117F145D125;
	Wed, 20 May 2009 01:13:22 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242774798-23639-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119575>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    9 ++
 .../ui/internal/dialogs/BranchSelectionDialog.java |   92 +++++++++++++++----
 .../src/org/spearce/egit/ui/uitext.properties      |    4 +
 3 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 654e155..1d52973 100644
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
@@ -929,6 +935,9 @@
 	public static String BranchSelectionDialog_QuestionNewBranchTitle;
 
 	/** */
+	public static String BranchSelectionDialog_QuestionNewBranchNameMessage;
+
+	/** */
 	public static String BranchSelectionDialog_QuestionNewBranchMessage;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index 9aad95b..6700768 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -48,8 +48,10 @@
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.RefRename;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RefUpdate.Result;
 
 /**
  * The branch and reset selection dialog
@@ -277,6 +279,30 @@ private void refNameFromDialog() {
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
@@ -284,32 +310,57 @@ protected void createButtonsForButtonBar(Composite parent) {
 			newButton.setFont(JFaceResources.getDialogFont());
 			newButton.setText(UIText.BranchSelectionDialog_NewBranch);
 			((GridLayout)parent.getLayout()).numColumns++;
+			Button renameButton = new Button(parent, SWT.PUSH);
+			renameButton.setText("&Rename");
+			renameButton.addSelectionListener(new SelectionListener() {
+				public void widgetSelected(SelectionEvent e) {
+					// check what ref name the user selected, if any.
+					refNameFromDialog();
+
+					InputDialog labelDialog = getRefNameInputDialog(NLS
+							.bind(
+									UIText.BranchSelectionDialog_QuestionNewBranchNameMessage,
+									refName));
+					if (labelDialog.open() == Window.OK) {
+						String newRefName = Constants.R_HEADS + labelDialog.getValue();
+						try {
+							RefRename renameRef = repo.renameRef(refName, newRefName);
+							if (renameRef.rename() != Result.RENAMED) {
+								MessageDialog.openError(getShell(),
+										"Rename failed",
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
+					InputDialog labelDialog = getRefNameInputDialog(UIText.BranchSelectionDialog_QuestionNewBranchMessage);
 					if (labelDialog.open() == Window.OK) {
 						String newRefName = Constants.R_HEADS + labelDialog.getValue();
 						RefUpdate updateRef;
@@ -338,6 +389,7 @@ public String isValid(String newText) {
 					}
 				}
 
+
 				public void widgetDefaultSelected(SelectionEvent e) {
 					widgetSelected(e);
 				}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 1d21c81..2a40439 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -340,6 +340,9 @@ BranchSelectionDialog_ErrorCouldNotRefresh=Could not refresh list of branches
 BranchSelectionDialog_ErrorCouldNotRefreshBranchList=Could not refresh list of branches
 BranchSelectionDialog_ErrorCouldNotResolve=Could not attempt to resolve {0}
 BranchSelectionDialog_ErrorInvalidRefName=Invalid ref name
+BranchSelectionDialog_ErrorCouldNotRenameRef=Failed to rename branch {0} -> {1}, status={2}
+BranchSelectionDialog_ErrorCouldNotRenameRef2=Failed to rename branch {0} -> {1}
+
 BranchSelectionDialog_LocalBranches=Local Branches
 BranchSelectionDialog_NewBranch=&New branch
 BranchSelectionDialog_NoBranchSeletectMessage=You must select a valid ref.
@@ -347,6 +350,7 @@ BranchSelectionDialog_NoBranchSeletectTitle=No branch/tag selected
 BranchSelectionDialog_OkCheckout=&Checkout
 BranchSelectionDialog_OkReset=&Reset
 BranchSelectionDialog_QuestionNewBranchMessage=Enter name of new branch. It will branch from the selected branch. refs/heads/ will be prepended to the name you type
+BranchSelectionDialog_QuestionNewBranchNameMessage=Enter new name of the {0} branch. refs/heads/ will be prepended to the name you type
 BranchSelectionDialog_QuestionNewBranchTitle=New branch
 BranchSelectionDialog_ReallyResetMessage=Resetting will overwrite any changes in your working directory.\n\nDo you wish to continue?
 BranchSelectionDialog_ReallyResetTitle=Really reset?
-- 
1.6.3.dirty
