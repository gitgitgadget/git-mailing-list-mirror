From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 03/10] Update compare window immediately
Date: Mon, 07 May 2007 23:29:27 +0200
Message-ID: <20070507212926.21546.73538.stgit@lathund.dewire.com>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAmF-0003qz-Uf
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966789AbXEGV3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966797AbXEGV3r
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:29:47 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12242 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966789AbXEGV3q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:29:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5AA45802676;
	Mon,  7 May 2007 23:23:40 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24643-09; Mon,  7 May 2007 23:23:39 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id C6D6C800783;
	Mon,  7 May 2007 23:23:39 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 6ABB5294E7;
	Mon,  7 May 2007 23:29:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id PUl+0AL2OWQu; Mon,  7 May 2007 23:29:32 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B2536294E9;
	Mon,  7 May 2007 23:29:27 +0200 (CEST)
In-Reply-To: <20070507212636.21546.29280.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46485>

Compute the commit diff for the selected revision in the history
view immediately when one version is selected if selection is
made with the left mouse button and a compare window is already
open. Thanks to the way git data structures are designed the diff
is usually instantenous.

We can't have it this way in the long run. Figure out something
better, like adding an icon to the history view for selecting
behaviour. Another ugly hack is the way I detect which mouse
button was clicked, if any so that right-clicking on a history
item does not cause the diff to be changed.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   47 +++++++++++++++++++----
 1 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 8be23ec..4b437a6 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -18,6 +18,7 @@ package org.spearce.egit.ui;
 
 import java.io.IOException;
 import java.util.Date;
+import java.util.List;
 import java.util.Map;
 
 import org.eclipse.compare.CompareConfiguration;
@@ -42,6 +43,8 @@ import org.eclipse.jface.viewers.TableLayout;
 import org.eclipse.jface.viewers.TreeViewer;
 import org.eclipse.jface.viewers.Viewer;
 import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.MouseEvent;
+import org.eclipse.swt.events.MouseListener;
 import org.eclipse.swt.events.SelectionAdapter;
 import org.eclipse.swt.events.SelectionEvent;
 import org.eclipse.swt.graphics.Image;
@@ -83,6 +86,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 	private IFileRevision[] fileRevisions;
 
+	protected boolean hintShowDiffNow;
+
 	public GitHistoryPage(Object object) {
 		setInput(object);
 	}
@@ -114,6 +119,20 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				"Compare");
 		final GitCompareRevisionAction compareActionPrev = new GitCompareRevisionAction(
 				"Show commit");
+		tree.addMouseListener(new MouseListener() {
+		
+			public void mouseUp(MouseEvent e) {
+			}
+		
+			public void mouseDown(MouseEvent e) {
+				hintShowDiffNow = e.button==1;
+			}
+		
+			public void mouseDoubleClick(MouseEvent e) {
+			}
+		
+		});
+
 		tree.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
 				// update the current
@@ -130,16 +149,25 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				GitProvider provider = (GitProvider)RepositoryProvider
 						.getProvider(project);
 				RepositoryMapping repositoryMapping = provider.getData().getRepositoryMapping(project);
-				ObjectId parentId = (ObjectId)((GitFileRevision)selection2[0]).getCommit().getParentIds().get(0);
 				try {
-					if (selection2.length == 1) {
-						Commit parent = repositoryMapping.getRepository().mapCommit(parentId);
-						IFileRevision previous = new GitFileRevision(parent,
-								((GitFileRevision)selection2[0]).getResource(),
-								((GitFileRevision)selection2[0]).getCount()+1);
-//						compareActionPrev.setCurrentFileRevision(selection2[0]);
-						compareActionPrev.setCurrentFileRevision(null);
-						compareActionPrev.selectionChanged(new StructuredSelection(new IFileRevision[] {selection2[0], previous}));
+					if (selection2.length == 1 && hintShowDiffNow) {
+						List parentIds = ((GitFileRevision)selection2[0]).getCommit().getParentIds();
+						if (parentIds.size() > 0) {
+							ObjectId parentId = (ObjectId)parentIds.get(0);
+							Commit parent = repositoryMapping.getRepository().mapCommit(parentId);
+							IFileRevision previous = new GitFileRevision(parent,
+									((GitFileRevision)selection2[0]).getResource(),
+									((GitFileRevision)selection2[0]).getCount()+1);
+							compareActionPrev.setCurrentFileRevision(null);
+							compareActionPrev.selectionChanged(new StructuredSelection(new IFileRevision[] {selection2[0], previous}));
+							System.out.println("detail="+e.detail);
+							tree.getDisplay().asyncExec(new Runnable() {
+								public void run() {
+									if (GitCompareRevisionAction.findReusableCompareEditor(GitHistoryPage.this.getSite().getPage()) != null)
+										compareActionPrev.run();
+								}
+							});
+						}
 					} else {
 						compareActionPrev.setCurrentFileRevision(null);
 						compareActionPrev.selectionChanged(new StructuredSelection(new IFileRevision[0]));
@@ -148,6 +176,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 					// TODO Auto-generated catch block
 					e1.printStackTrace();
 				}
+				hintShowDiffNow = false;
 			}
 		});
 		compareAction.setPage(this);
