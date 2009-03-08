From: Robin Stocker <robin@nibor.org>
Subject: [EGIT PATCH] Show diff when double-clicking on file in commit dialog
Date: Sun, 08 Mar 2009 21:09:49 +0100
Message-ID: <49B4260D.6070501@nibor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 21:18:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgPRo-0000CV-Gd
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 21:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbZCHUQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 16:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbZCHUQi
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 16:16:38 -0400
Received: from securemail.seppmail.ch ([195.49.105.241]:56149 "EHLO
	securemail.seppmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbZCHUQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 16:16:38 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Mar 2009 16:16:37 EDT
Received: from localhost (localhost.seppmail.local [127.0.0.1])
	by securemail.seppmail.ch (Postfix) with SMTP id 006223C639
	for <git@vger.kernel.org>; Sun,  8 Mar 2009 21:10:06 +0100 (CET)
Received: from gnu.speedpc.ch (unknown [192.168.0.4])
	by securemail.seppmail.ch (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Sun,  8 Mar 2009 21:10:05 +0100 (CET)
Received: (qmail 11372 invoked from network); 8 Mar 2009 21:10:25 +0100
Received: from 217-162-182-112.dclient.hispeed.ch (HELO ?10.0.0.33?) (217.162.182.112)
  by mail.speedpc.ch with (DHE-RSA-AES256-SHA encrypted) SMTP; 8 Mar 2009 21:10:24 +0100
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112636>

It only compares the index version to the working tree version for now.
So if the file was already added to the index, the diff is empty. What
it should show is the diff that will be in the commit.

Signed-off-by: Robin Stocker <robin@nibor.org>
---

Hi,

An essential feature I miss in EGit at the moment (apart from the
synchronize view [1]) is seeing what changes one is about to commit. In
the Subclipse SVN plugin one can double-click a file in the commit
dialog and the diff is shown.

This patch is a first step for adding this to EGit. It only compares the
index version to the working tree version as I couldn't figure out an
easy way to get the HEAD version.

It's more a proof of concept than a final patch. What do you think?

[1] Someone is working on the synchronize view:
    http://github.com/yanns/egit/commits/compare-with-index

-- Robin, a different one :)

 .../egit/ui/internal/dialogs/CommitDialog.java     |   40 ++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index 8b7fe45..6999e87 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -18,6 +18,8 @@
 import java.util.Comparator;
 import java.util.Iterator;
 
+import org.eclipse.compare.CompareUI;
+import org.eclipse.compare.ITypedElement;
 import org.eclipse.core.resources.IFile;
 import org.eclipse.core.resources.IProject;
 import org.eclipse.jface.dialogs.Dialog;
@@ -52,9 +54,17 @@
 import org.eclipse.swt.widgets.Table;
 import org.eclipse.swt.widgets.TableColumn;
 import org.eclipse.swt.widgets.Text;
+import org.eclipse.team.core.RepositoryProvider;
+import org.eclipse.team.core.history.IFileHistory;
+import org.eclipse.team.core.history.IFileRevision;
+import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
 import org.eclipse.ui.model.WorkbenchLabelProvider;
+import org.spearce.egit.core.GitProvider;
+import org.spearce.egit.core.internal.storage.GitFileHistoryProvider;
+import org.spearce.egit.core.internal.storage.GitFileRevision;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.GitCompareFileRevisionEditorInput;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.PersonIdent;
@@ -262,6 +272,8 @@ public void modifyText(ModifyEvent e) {
 		resourcesTable.setLayoutData(GridDataFactory.fillDefaults().hint(600,
 				200).span(2,1).grab(true, true).create());
 
+		resourcesTable.addSelectionListener(new CommitItemSelectionListener());
+
 		resourcesTable.setHeaderVisible(true);
 		TableColumn statCol = new TableColumn(resourcesTable, SWT.LEFT);
 		statCol.setText(UIText.CommitDialog_Status);
@@ -505,6 +517,34 @@ public void widgetSelected(SelectionEvent e) {
 
 	}
 
+	class CommitItemSelectionListener extends SelectionAdapter {
+
+		public void widgetDefaultSelected(SelectionEvent e) {
+			IStructuredSelection selection = (IStructuredSelection) filesViewer.getSelection();
+
+			CommitItem commitItem = (CommitItem) selection.getFirstElement();
+			if (commitItem == null) {
+				return;
+			}
+
+			IProject project = commitItem.file.getProject();
+			GitProvider provider = (GitProvider) RepositoryProvider.getProvider(project);
+			GitFileHistoryProvider fileHistoryProvider = (GitFileHistoryProvider) provider.getFileHistoryProvider();
+
+			IFileHistory fileHistory = fileHistoryProvider.getFileHistoryFor(commitItem.file, 0, null);
+
+			IFileRevision baseFile = fileHistory.getFileRevision(GitFileRevision.INDEX);
+			IFileRevision nextFile = fileHistoryProvider.getWorkspaceFileRevision(commitItem.file);
+
+			ITypedElement base = new FileRevisionTypedElement(baseFile);
+			ITypedElement next = new FileRevisionTypedElement(nextFile);
+
+			GitCompareFileRevisionEditorInput input = new GitCompareFileRevisionEditorInput(base, next, null);
+			CompareUI.openCompareDialog(input);
+		}
+
+	}
+
 	@Override
 	protected void okPressed() {
 		commitMessage = commitText.getText();
-- 
1.6.1.2
