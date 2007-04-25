From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Fix layout problems in history view
Date: Wed, 25 Apr 2007 21:54:58 +0200
Message-ID: <20070425195458.19846.74255.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearc@spearce.org
X-From: git-owner@vger.kernel.org Wed Apr 25 21:56:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgnap-00052a-Pm
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbXDYTz2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbXDYTz2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:55:28 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14347 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754174AbXDYTz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:55:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8DC8A80265D;
	Wed, 25 Apr 2007 21:49:30 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00371-09; Wed, 25 Apr 2007 21:49:30 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 01F3E802651;
	Wed, 25 Apr 2007 21:49:29 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 39FDC28DEA;
	Wed, 25 Apr 2007 21:55:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id G2erMwCPoIrj; Wed, 25 Apr 2007 21:54:59 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 42E7828DE5;
	Wed, 25 Apr 2007 21:54:59 +0200 (CEST)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45554>

Before this fix the rows in the history view sometimes (often)
got the wrong line height, leaving only half lines visible.
Also adjust column widths a little and add "Tags" header and
do not display time for workspace files.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   40 ++++++++++++-----------
 1 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index c72e1f1..7bc947b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -100,7 +100,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		layout.marginHeight = 0;
 		layout.marginWidth = 0;
 		localComposite.setLayout(layout);
-		GridData data = new GridData(GridData.FILL_BOTH);
+		GridData data = new GridData(SWT.FILL, SWT.FILL, true, true);
 		data.grabExcessVerticalSpace = true;
 		localComposite.setLayoutData(data);
 
@@ -201,9 +201,11 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				String rs = rss.substring(rss.length()-10);
 				String id = ((IFileRevision) element).getContentIdentifier();
 				if (appliedPatches!=null) {
-					StGitPatch patch = (StGitPatch) appliedPatches.get(new ObjectId(id));
-					if (patch!=null)
-						return patch.getName();
+					if (!id.equals("Workspace")) {
+						StGitPatch patch = (StGitPatch) appliedPatches.get(new ObjectId(id));
+						if (patch!=null)
+							return patch.getName();
+					}
 				}
 				if (id != null)
 					if (id.length() > 9) // make sure "Workspace" is spelled out
@@ -217,10 +219,12 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 			if (columnIndex == 2)
 				return ""; // TAGS
 
-			if (columnIndex == 3)
-				return new Date(((IFileRevision) element).getTimestamp())
-						.toString();
-
+			if (columnIndex == 3) {
+				Date d = new Date(((IFileRevision) element).getTimestamp());
+				if (d.getTime() == -1)
+					return "";
+				return d.toString();
+			}
 			if (columnIndex == 4)
 				return ((IFileRevision) element).getAuthor();
 
@@ -243,8 +247,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				| SWT.FULL_SELECTION | SWT.VIRTUAL);
 		tree.setHeaderVisible(true);
 		tree.setLinesVisible(true);
-
-		GridData data = new GridData(GridData.FILL_BOTH);
+		GridData data = new GridData(SWT.FILL, SWT.FILL, true, true);
 		tree.setLayoutData(data);
 		tree.setData("HEAD");
 		tree.addListener(SWT.SetData, new Listener() {
@@ -314,13 +317,12 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 					.getFileHistoryFor((IResource) getInput(),
 							IFileHistoryProvider.SINGLE_LINE_OF_DESCENT, null/* monitor */);
 			fileRevisions = fileHistoryFor.getFileRevisions();
-			tree.clearAll(true);
+			tree.removeAll();
 			tree.setItemCount(fileRevisions.length);
 			tree.setData(fileRevisions);
+			tree.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,true));
 			System.out.println("inputchanged, invoking refresh");
 			viewer.refresh();
-			tree.getParent().layout();
-			tree.getParent().getParent().layout();
 		}
 
 		public void dispose() {
@@ -363,7 +365,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		col.setResizable(true);
 		col.setText("^");
 		// X col.addSelectionListener(headerListener);
-		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(10,
+		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(15,
 				true));
 
 		// revision
@@ -371,22 +373,22 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		col.setResizable(true);
 		col.setText(TeamUIMessages.GenericHistoryTableProvider_Revision);
 		// X col.addSelectionListener(headerListener);
-		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(10,
+		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(15,
 				true));
 
 		// tags
 		col = new TreeColumn(tree, SWT.NONE);
 		col.setResizable(true);
-		// X col.setText(CVSUIMessages.HistoryView_tags);
+		col.setText("Tags");
 		// X col.addSelectionListener(headerListener);
-		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(20,
+		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(15,
 				true));
 		// creation date
 		col = new TreeColumn(tree, SWT.NONE);
 		col.setResizable(true);
 		col.setText(TeamUIMessages.GenericHistoryTableProvider_RevisionTime);
 		// X col.addSelectionListener(headerListener);
-		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(20,
+		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(30,
 				true));
 
 		// author
@@ -402,7 +404,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		col.setResizable(true);
 		col.setText(TeamUIMessages.GenericHistoryTableProvider_Comment);
 		// X col.addSelectionListener(headerListener);
-		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(50,
+		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(35,
 				true));
 	}
 
