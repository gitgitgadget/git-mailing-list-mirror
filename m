From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 2/3] Add compare with previous action.
Date: Thu, 19 Apr 2007 19:10:42 +0000
Message-ID: <20070419191042.19224.60676.stgit@lathund.dewire.com>
References: <20070419191036.19224.81654.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 19 21:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hebyu-0001MY-SD
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 21:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766938AbXDSTH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 15:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766943AbXDSTH1
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 15:07:27 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21294 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1766938AbXDSTHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 15:07:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E63AF8275B3;
	Thu, 19 Apr 2007 21:01:34 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20737-09; Thu, 19 Apr 2007 21:01:34 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 57063802873;
	Thu, 19 Apr 2007 21:01:34 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 16E36291D9;
	Thu, 19 Apr 2007 21:10:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 8UzQOZKg93ri; Thu, 19 Apr 2007 19:10:42 +0000 (UTC)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id C4E01291DA;
	Thu, 19 Apr 2007 21:10:42 +0200 (CEST)
In-Reply-To: <20070419191036.19224.81654.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45038>

When only one item is selected, add a compare action for the previous
version. 

This solution has a wart, such that when two consequent commits are
selected the menu shows only a "Show commit diff".

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   32 +++++++++++++++++++++++
 .../internal/actions/GitCompareRevisionAction.java |   15 ++++++++++-
 2 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index bd80324..5655105 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -16,10 +16,12 @@
  */
 package org.spearce.egit.ui;
 
+import java.io.IOException;
 import java.util.Date;
 
 import org.eclipse.compare.CompareConfiguration;
 import org.eclipse.compare.structuremergeviewer.ICompareInput;
+import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IResourceChangeEvent;
 import org.eclipse.core.resources.IResourceChangeListener;
@@ -61,8 +63,12 @@ import org.eclipse.team.internal.ui.history.DialogHistoryPageSite;
 import org.eclipse.team.ui.history.HistoryPage;
 import org.eclipse.team.ui.history.IHistoryCompareAdapter;
 import org.eclipse.team.ui.history.IHistoryPageSite;
+import org.spearce.egit.core.GitProvider;
 import org.spearce.egit.core.internal.mapping.GitFileRevision;
+import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.internal.actions.GitCompareRevisionAction;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.ObjectId;
 
 public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		IHistoryCompareAdapter {
@@ -104,6 +110,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 		final GitCompareRevisionAction compareAction = new GitCompareRevisionAction(
 				"Compare");
+		final GitCompareRevisionAction compareActionPrev = new GitCompareRevisionAction(
+				"Show commit");
 		tree.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
 				// update the current
@@ -116,14 +124,38 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				compareAction.setCurrentFileRevision(fileRevisions[0]);
 				compareAction.selectionChanged(new StructuredSelection(
 						selection2));
+				IProject project = ((IResource) getInput()).getProject();
+				GitProvider provider = (GitProvider)RepositoryProvider
+						.getProvider(project);
+				RepositoryMapping repositoryMapping = provider.getData().getRepositoryMapping(project);
+				ObjectId parentId = (ObjectId)((GitFileRevision)selection2[0]).getCommit().getParentIds().get(0);
+				try {
+					if (selection2.length == 1) {
+						Commit parent = repositoryMapping.getRepository().mapCommit(parentId);
+						IFileRevision previous = new GitFileRevision(parent,
+								((GitFileRevision)selection2[0]).getResource(),
+								((GitFileRevision)selection2[0]).getCount()+1);
+//						compareActionPrev.setCurrentFileRevision(selection2[0]);
+						compareActionPrev.setCurrentFileRevision(null);
+						compareActionPrev.selectionChanged(new StructuredSelection(new IFileRevision[] {selection2[0], previous}));
+					} else {
+						compareActionPrev.setCurrentFileRevision(null);
+						compareActionPrev.selectionChanged(new StructuredSelection(new IFileRevision[0]));
+					}
+				} catch (IOException e1) {
+					// TODO Auto-generated catch block
+					e1.printStackTrace();
+				}
 			}
 		});
 		compareAction.setPage(this);
+		compareActionPrev.setPage(this);
 		MenuManager menuMgr = new MenuManager();
 		Menu menu = menuMgr.createContextMenu(tree);
 		menuMgr.addMenuListener(new IMenuListener() {
 			public void menuAboutToShow(IMenuManager menuMgr) {
 				menuMgr.add(compareAction);
+				menuMgr.add(compareActionPrev);
 			}
 		});
 		menuMgr.setRemoveAllWhenShown(true);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
index 9487197..d5780a5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
@@ -32,8 +32,10 @@ import org.eclipse.ui.IReusableEditor;
 import org.eclipse.ui.IWorkbenchPage;
 import org.eclipse.ui.actions.BaseSelectionListenerAction;
 import org.spearce.egit.core.GitWorkspaceFileRevision;
+import org.spearce.egit.core.internal.mapping.GitFileRevision;
 import org.spearce.egit.ui.internal.GitCompareFileRevisionEditorInput;
 import org.spearce.egit.ui.internal.GitResourceNode;
+import org.spearce.jgit.lib.ObjectId;
 
 /**
  * Action to invoke a Git based compare on selected revivsions in the history window.
@@ -188,7 +190,18 @@ public class GitCompareRevisionAction extends BaseSelectionListenerAction {
 			return shouldShow();
 		}
 		else if (selection.size() == 2){
-			this.setText(TeamUIMessages.CompareRevisionAction_CompareWithOther);
+			IFileRevision rev1=(IFileRevision)selection.toArray()[0];
+			IFileRevision rev2=(IFileRevision)selection.toArray()[1];
+			System.out.println("Compare "+rev1.getContentIdentifier()+" with "+rev2.getContentIdentifier());
+			if (rev1 instanceof GitFileRevision && rev2 instanceof GitFileRevision) {
+				ObjectId pid = (ObjectId) ((GitFileRevision)rev1).getCommit().getParentIds().get(0);
+				if (pid.equals(((GitFileRevision)rev2).getCommit().getCommitId())) {
+					this.setText("Show commit diff");
+				} else {
+					this.setText(TeamUIMessages.CompareRevisionAction_CompareWithOther);
+				}
+			} else
+				this.setText(TeamUIMessages.CompareRevisionAction_CompareWithOther);
 			return shouldShow();
 		}
 
