From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/3] Tell the branch dialog how to create a new branch.
Date: Wed, 24 Sep 2008 23:56:23 +0200
Message-ID: <1222293383-26016-3-git-send-email-robin.rosenberg@dewire.com>
References: <1222293383-26016-1-git-send-email-robin.rosenberg@dewire.com>
 <1222293383-26016-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 24 23:59:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KicO8-0000DW-Ug
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 23:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbYIXV5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 17:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYIXV5i
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 17:57:38 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:34423 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbYIXV5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 17:57:37 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 4420438B23; Wed, 24 Sep 2008 23:57:24 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 1011D389BC; Wed, 24 Sep 2008 23:57:24 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id D298337E44;
	Wed, 24 Sep 2008 23:57:23 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1222293383-26016-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96696>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../ui/internal/dialogs/BranchSelectionDialog.java |   98 ++++++++++++++++++--
 1 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index 158738c..26d423a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -17,14 +17,21 @@
 
 import org.eclipse.jface.dialogs.Dialog;
 import org.eclipse.jface.dialogs.IDialogConstants;
+import org.eclipse.jface.dialogs.IInputValidator;
+import org.eclipse.jface.dialogs.InputDialog;
 import org.eclipse.jface.dialogs.MessageDialog;
 import org.eclipse.jface.layout.GridDataFactory;
 import org.eclipse.jface.layout.GridLayoutFactory;
+import org.eclipse.jface.resource.JFaceResources;
+import org.eclipse.jface.window.Window;
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.events.DisposeEvent;
 import org.eclipse.swt.events.DisposeListener;
+import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.events.SelectionListener;
 import org.eclipse.swt.graphics.Font;
 import org.eclipse.swt.graphics.FontData;
+import org.eclipse.swt.layout.GridLayout;
 import org.eclipse.swt.layout.RowLayout;
 import org.eclipse.swt.widgets.Button;
 import org.eclipse.swt.widgets.Composite;
@@ -35,6 +42,10 @@
 import org.eclipse.swt.widgets.Tree;
 import org.eclipse.swt.widgets.TreeItem;
 import org.spearce.egit.core.op.ResetOperation.ResetType;
+import org.spearce.egit.ui.Activator;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.Repository;
 
 /**
@@ -81,9 +92,9 @@ protected Composite createDialogArea(Composite base) {
 		}
 		
 		try {
-			fillTreeWithBranches();
+			fillTreeWithBranches(null);
 		} catch (IOException e) {
-			e.printStackTrace();
+			Activator.logError("Could not refresh list of branches", e);
 		}
 		
 		return parent;
@@ -121,7 +132,7 @@ public void handleEvent(Event event) {
 		});
 	}
 
-	private void fillTreeWithBranches() throws IOException {
+	private void fillTreeWithBranches(String select) throws IOException {
 		String branch = repo.getFullBranch();
 		List<String> branches = new ArrayList<String>(repo.getAllRefs()
 				.keySet());
@@ -197,6 +208,8 @@ public void widgetDisposed(DisposeEvent e) {
 				branchTree.showItem(item);
 			}
 			else item.setText(shortName);
+			if (ref.equals(select))
+				branchTree.select(item);
 		}
 	}
 	
@@ -220,12 +233,7 @@ public ResetType getResetType() {
 	
 	@Override
 	protected void okPressed() {
-		TreeItem[] selection = branchTree.getSelection();
-		refName = null;
-		if (selection != null && selection.length > 0) {
-			TreeItem item = selection[0];
-			refName = (String) item.getData();
-		}
+		refNameFromDialog();
 		if (refName == null) {
 			MessageDialog.openWarning(getShell(), "No branch/tag selected", "You must select a valid ref.");
 			return;
@@ -244,9 +252,79 @@ protected void okPressed() {
 		super.okPressed();
 	}
 
+	private void refNameFromDialog() {
+		TreeItem[] selection = branchTree.getSelection();
+		refName = null;
+		if (selection != null && selection.length > 0) {
+			TreeItem item = selection[0];
+			refName = (String) item.getData();
+		}
+	}
+
 	@Override
 	protected void createButtonsForButtonBar(Composite parent) {
-		createButton(parent, IDialogConstants.OK_ID, IDialogConstants.OK_LABEL, true);
+		if (!showResetType) {
+			Button newButton = new Button(parent, SWT.PUSH);
+			newButton.setFont(JFaceResources.getDialogFont());
+			newButton.setText("New branch");
+			((GridLayout)parent.getLayout()).numColumns++;
+			newButton.addSelectionListener(new SelectionListener() {
+
+				public void widgetSelected(SelectionEvent e) {
+					// check what ref name the user selected, if any.
+					refNameFromDialog();
+
+					InputDialog labelDialog = new InputDialog(
+							getShell(),
+							"New branch",
+							"Enter name of new branch. It will branch from the selected branch. refs/heads/ will be prepended to the name you type",
+							null, new IInputValidator() {
+								public String isValid(String newText) {
+									String testFor = Constants.R_HEADS + newText;
+									try {
+										if (repo.resolve(testFor) != null)
+											return "Already exists";
+									} catch (IOException e1) {
+										Activator.logError(String.format(
+												"Could not attempt to resolve %s", testFor), e1);
+									}
+									if (!Repository.isValidRefName(testFor))
+										return "Invalid ref name";
+									return null;
+								}
+							});
+					labelDialog.setBlockOnOpen(true);
+					if (labelDialog.open() == Window.OK) {
+						String newRefName = Constants.R_HEADS + labelDialog.getValue();
+						RefUpdate updateRef;
+						try {
+							updateRef = repo.updateRef(newRefName);
+							ObjectId startAt;
+							if (refName == null)
+								startAt = repo.resolve(Constants.HEAD);
+							else
+								startAt = repo.resolve(refName);
+							updateRef.setNewObjectId(startAt);
+							updateRef.update();
+						} catch (IOException e1) {
+							Activator.logError(String.format(
+									"Could not create new ref %s", newRefName), e1);
+						}
+						try {
+							branchTree.removeAll();
+							fillTreeWithBranches(newRefName);
+						} catch (IOException e1) {
+							Activator.logError("Could not refresh list of branches",e1);
+						}
+					}
+				}
+
+				public void widgetDefaultSelected(SelectionEvent e) {
+					widgetSelected(e);
+				}
+			});
+		}
+		createButton(parent, IDialogConstants.OK_ID, showResetType ? "Reset" : "Checkout", true);
 		createButton(parent, IDialogConstants.CANCEL_ID, IDialogConstants.CANCEL_LABEL, false);
 	}
 
-- 
1.6.0.1.310.gf789d0.dirty
