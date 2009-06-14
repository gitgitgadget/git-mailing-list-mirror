From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH v6 6/7] Improve error reporting in the branch dialog
Date: Sun, 14 Jun 2009 21:47:29 +0200
Message-ID: <1245008849-12132-3-git-send-email-robin.rosenberg@dewire.com>
References: <20090612200228.GR16497@spearce.org>
 <1245008849-12132-1-git-send-email-robin.rosenberg@dewire.com>
 <1245008849-12132-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 14 21:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFvgN-0004ct-0n
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 21:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761944AbZFNTrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 15:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760675AbZFNTrv
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 15:47:51 -0400
Received: from mail.dewire.com ([83.140.172.130]:2887 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757251AbZFNTrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 15:47:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F0CF8146D006;
	Sun, 14 Jun 2009 21:47:41 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kiShl9ftCgK7; Sun, 14 Jun 2009 21:47:33 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id CBA1A147D5BE;
	Sun, 14 Jun 2009 21:47:32 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <1245008849-12132-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121557>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    6 ++
 .../ui/internal/dialogs/BranchSelectionDialog.java |   59 ++++++++++++--------
 .../src/org/spearce/egit/ui/uitext.properties      |    2 +
 3 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 76764ab..b0e8c3e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -899,6 +899,12 @@
 	public static String BranchSelectionDialog_ErrorCouldNotRenameRef2;
 
 	/** */
+	public static String BranchSelectionDialog_BranchSelectionDialog_CreateFailedTitle;
+
+	/** */
+	public static String BranchSelectionDialog_BranchSelectionDialog_RenamedFailedTitle;
+
+	/** */
 	public static String BranchSelectionDialog_BranchSuffix_Current;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index f0c13d1..09b6381 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -104,7 +104,7 @@ getShell().setText(
 
 		try {
 			fillTreeWithBranches(null);
-		} catch (IOException e) {
+		} catch (Throwable e) {
 			Activator.logError(UIText.BranchSelectionDialog_ErrorCouldNotRefresh, e);
 		}
 
@@ -294,6 +294,7 @@ public String isValid(String newText) {
 						} catch (IOException e1) {
 							Activator.logError(NLS.bind(
 									UIText.BranchSelectionDialog_ErrorCouldNotResolve, testFor), e1);
+							return e1.getMessage();
 						}
 						if (!Repository.isValidRefName(testFor))
 							return UIText.BranchSelectionDialog_ErrorInvalidRefName;
@@ -332,27 +333,28 @@ public void widgetSelected(SelectionEvent e) {
 						try {
 							RefRename renameRef = repo.renameRef(refName, newRefName);
 							if (renameRef.rename() != Result.RENAMED) {
-								MessageDialog.openError(getShell(),
-										UIText.BranchSelectionDialog_ErrorRenameFailed,
-										NLS.bind(UIText.BranchSelectionDialog_ErrorCouldNotRenameRef,
-												new Object[] { refName, newRefName, renameRef.getResult() }));
-								Activator.logError(NLS.bind(
-										UIText.BranchSelectionDialog_ErrorCouldNotRenameRef2,
-												new Object[] { refName, newRefName }), null);
+								reportError(
+										null,
+										UIText.BranchSelectionDialog_BranchSelectionDialog_RenamedFailedTitle,
+										UIText.BranchSelectionDialog_ErrorCouldNotRenameRef,
+										refName, newRefName, renameRef
+												.getResult());
 							}
-							// FIXME: Update HEAD
-						} catch (IOException e1) {
-							Activator.logError(NLS.bind(
-									UIText.BranchSelectionDialog_ErrorCouldNotRenameRef2,
-															newRefName), e1);
+						} catch (Throwable e1) {
+							reportError(
+									e1,
+									UIText.BranchSelectionDialog_BranchSelectionDialog_RenamedFailedTitle,
+									UIText.BranchSelectionDialog_ErrorCouldNotRenameRef,
+									refName, newRefName, e1.getMessage());
 						}
 						try {
 							branchTree.removeAll();
 							fillTreeWithBranches(newRefName);
-						} catch (IOException e1) {
-							Activator.logError(
-									UIText.BranchSelectionDialog_ErrorCouldNotRefreshBranchList,
-											e1);
+						} catch (Throwable e1) {
+							reportError(
+									e1,
+									UIText.BranchSelectionDialog_BranchSelectionDialog_RenamedFailedTitle,
+									UIText.BranchSelectionDialog_ErrorCouldNotRefreshBranchList);
 						}
 					}
 				}
@@ -387,18 +389,20 @@ public void widgetSelected(SelectionEvent e) {
 							updateRef.setNewObjectId(startAt);
 							updateRef.setRefLogMessage("branch: Created from " + startBranch, false); //$NON-NLS-1$
 							updateRef.update();
-						} catch (IOException e1) {
-							Activator.logError(NLS.bind(
+						} catch (Throwable e1) {
+							reportError(
+									e1,
+									UIText.BranchSelectionDialog_BranchSelectionDialog_CreateFailedTitle,
 									UIText.BranchSelectionDialog_ErrorCouldNotCreateNewRef,
-															newRefName), e1);
+									newRefName);
 						}
 						try {
 							branchTree.removeAll();
 							fillTreeWithBranches(newRefName);
-						} catch (IOException e1) {
-							Activator.logError(
-									UIText.BranchSelectionDialog_ErrorCouldNotRefreshBranchList,
-											e1);
+						} catch (Throwable e1) {
+							reportError(e1,
+									UIText.BranchSelectionDialog_BranchSelectionDialog_CreateFailedTitle,
+									UIText.BranchSelectionDialog_ErrorCouldNotRefreshBranchList);
 						}
 					}
 				}
@@ -419,4 +423,11 @@ createButton(parent, IDialogConstants.OK_ID,
 	protected int getShellStyle() {
 		return super.getShellStyle() | SWT.RESIZE;
 	}
+
+	private void reportError(Throwable e, String title, String message,
+			Object... args) {
+		String msg = NLS.bind(message, args);
+		MessageDialog.openError(getShell(), title, msg);
+		Activator.logError(msg, e);
+	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index a2fd720..a141c90 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -333,6 +333,8 @@ WindowCachePreferencePage_packedGitMMAP=Use virtual memory mapping
 
 BranchSelectionDialog_TitleCheckout=Checkout: {0}
 BranchSelectionDialog_TitleReset=Reset: {0}
+BranchSelectionDialog_BranchSelectionDialog_CreateFailedTitle=New branch creation failed
+BranchSelectionDialog_BranchSelectionDialog_RenamedFailedTitle=Rename failed
 BranchSelectionDialog_BranchSuffix_Current=\ (current)
 BranchSelectionDialog_ErrorAlreadyExists=Already exists
 BranchSelectionDialog_ErrorCouldNotCreateNewRef=Could not create new ref {0}
-- 
1.6.3.2.199.g7340d
