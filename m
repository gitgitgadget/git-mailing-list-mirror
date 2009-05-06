From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/3] Add ref rename support to the branch dialog
Date: Thu,  7 May 2009 01:33:01 +0200
Message-ID: <1241652781-16873-4-git-send-email-robin.rosenberg@dewire.com>
References: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
 <1241652781-16873-2-git-send-email-robin.rosenberg@dewire.com>
 <1241652781-16873-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 07 01:33:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1qcN-000346-5c
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbZEFXdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 19:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbZEFXdN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:33:13 -0400
Received: from mail.dewire.com ([83.140.172.130]:27520 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbZEFXdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 19:33:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 983F914A8B5B;
	Thu,  7 May 2009 01:33:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id igIsUyYObqhW; Thu,  7 May 2009 01:33:07 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 5E9F214A8B5D;
	Thu,  7 May 2009 01:33:04 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc2.1.g868b6
In-Reply-To: <1241652781-16873-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118413>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    6 ++
 .../ui/internal/dialogs/BranchSelectionDialog.java |   89 +++++++++++++++-----
 .../src/org/spearce/egit/ui/uitext.properties      |    3 +
 3 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 654e155..1bf2dd3 100644
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
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index 9aad95b..a518c2a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -50,6 +50,8 @@
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RefUpdate.RenameRefUpdates;
+import org.spearce.jgit.lib.RefUpdate.Result;
 
 /**
  * The branch and reset selection dialog
@@ -277,6 +279,30 @@ private void refNameFromDialog() {
 		}
 	}
 
+	private InputDialog getRefNameInputDialog() {
+		InputDialog labelDialog = new InputDialog(
+				getShell(),
+				UIText.BranchSelectionDialog_QuestionNewBranchTitle,
+				UIText.BranchSelectionDialog_QuestionNewBranchMessage,
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
@@ -284,32 +310,54 @@ protected void createButtonsForButtonBar(Composite parent) {
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
+					InputDialog labelDialog = getRefNameInputDialog();
+					if (labelDialog.open() == Window.OK) {
+						String newRefName = Constants.R_HEADS + labelDialog.getValue();
+						try {
+							RenameRefUpdates renameRef = repo.renameRef(refName, newRefName);
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
+					InputDialog labelDialog = getRefNameInputDialog();
 					if (labelDialog.open() == Window.OK) {
 						String newRefName = Constants.R_HEADS + labelDialog.getValue();
 						RefUpdate updateRef;
@@ -338,6 +386,7 @@ public String isValid(String newText) {
 					}
 				}
 
+
 				public void widgetDefaultSelected(SelectionEvent e) {
 					widgetSelected(e);
 				}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 1d21c81..193f3ad 100644
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
-- 
1.6.3.rc2.1.g868b6
