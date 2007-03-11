From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 10/10] Display distance to head in history page
Date: Sun, 11 Mar 2007 19:16:09 +0100
Message-ID: <20070311181608.18012.60291.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:14:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSZ8-0006UP-8v
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933949AbXCKSOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933950AbXCKSOe
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:14:34 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1646 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933949AbXCKSOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:14:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A44CE802841;
	Sun, 11 Mar 2007 19:09:17 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26264-05; Sun, 11 Mar 2007 19:09:17 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id D19C8800199;
	Sun, 11 Mar 2007 19:09:16 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 0475F28CD7;
	Sun, 11 Mar 2007 19:16:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 8F95SD2gUT3A; Sun, 11 Mar 2007 19:16:21 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 21F9E291D2;
	Sun, 11 Mar 2007 19:16:09 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41960>

This makes it more apparent that the list is filtered and
when changes occurred.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../egit/core/GitWorkspaceFileRevision.java        |    2 -
 .../egit/core/internal/mapping/GitFileHistory.java |   19 +++---
 .../core/internal/mapping/GitFileRevision.java     |    9 ++-
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   74 +++++++++++++++--------
 4 files changed, 68 insertions(+), 36 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java
index 82047c7..9aa3593 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java
@@ -28,7 +28,7 @@ public class GitWorkspaceFileRevision extends GitFileRevision implements
 	private final IResource resource;
 
 	public GitWorkspaceFileRevision(IResource resource) {
-		super(null, resource);
+		super(null, resource, -1);
 		this.resource = resource;
 	}
 
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 6c114e9..78a2e68 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -72,7 +72,7 @@ public class GitFileHistory extends FileHistory {
 			try {
 				ret[i] = new GitFileRevision(repository
 						.mapCommit((ObjectId) parents.get(i)), grevision
-						.getResource());
+				.getResource(), -1);
 			} catch (IOException e) {
 				e.printStackTrace();
 				return null;
@@ -87,7 +87,7 @@ public class GitFileHistory extends FileHistory {
 		} else {
 			try {
 				Repository repository = getRepository();
-				return new GitFileRevision(repository.mapCommit(id), resource);
+				return new GitFileRevision(repository.mapCommit(id), resource, 0);
 			} catch (IOException e) {
 				e.printStackTrace();
 				return null;
@@ -125,7 +125,7 @@ public class GitFileHistory extends FileHistory {
 			}
 			if (activeDiffTreeEntries!=null)
 				initialResourceHash[initialResourceHash.length-1] = activeDiffTreeEntries[0].getId();
-			return collectHistory(initialResourceHash, null,
+			return collectHistory(0, initialResourceHash, null,
 					repository, commit);
 		} catch (IOException e) {
 			e.printStackTrace();
@@ -133,7 +133,7 @@ public class GitFileHistory extends FileHistory {
 		}
 	}
 
-	private Collection collectHistory(ObjectId[] lastResourceHash, TreeEntry lastEntry,
+	private Collection collectHistory(int count, ObjectId[] lastResourceHash, TreeEntry lastEntry,
 			Repository repository, Commit top) throws IOException {
 		if (top == null)
 			return Collections.EMPTY_LIST;
@@ -176,7 +176,7 @@ public class GitFileHistory extends FileHistory {
 			}
 			
 			if (currentResourceHash.length == 0 || !currentResourceHash[currentResourceHash.length-1].equals(lastResourceHash[currentResourceHash.length-1]))
-				ret.add(new GitFileRevision(previous, resource));
+				ret.add(new GitFileRevision(previous, resource, count));
 
 			lastResourceHash = currentResourceHash;
 			previous = current;
@@ -190,7 +190,7 @@ public class GitFileHistory extends FileHistory {
 					Commit mergeParent;
 					try {
 						mergeParent = repository.mapCommit(mergeParentId);
-						ret.addAll(collectHistory(lastResourceHash, currentEntry, repository, 
+						ret.addAll(collectHistory(0, lastResourceHash, currentEntry, repository, 
 								mergeParent));
 						// TODO: this gets us a lot of duplicates that we need
 						// to filter out
@@ -210,7 +210,8 @@ public class GitFileHistory extends FileHistory {
 				}
 			} else
 				current = null;
-
+			if (count>=0)
+				count++;
 		} while (current != null);
 
 		return ret;
@@ -252,8 +253,8 @@ public class GitFileHistory extends FileHistory {
 				((Tree)currentEntry).findMember(relativeResourceName[i]);
 			}
 			if (currentEntry != null)
-				revisions = new IFileRevision[] { new GitFileRevision(current,
-						resource) };
+				revisions = new IFileRevision[] { new GitFileRevision(current, resource,
+						-1) };
 			else
 				revisions = new IFileRevision[0];
 
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
index 31e2191..ad15cc0 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
@@ -44,7 +44,10 @@ public class GitFileRevision extends FileRevision {
 
 	private final Commit commit;
 
-	public GitFileRevision(Commit commit, IResource resource) {
+	private final int count;
+
+	public GitFileRevision(Commit commit, IResource resource, int count) {
+		this.count = count;
 		this.commit = commit;
 		this.resource = resource;
 	}
@@ -129,4 +132,8 @@ public class GitFileRevision extends FileRevision {
 	public IResource getResource() {
 		return resource;
 	}
+
+	public int getCount() {
+		return count;
+	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 77073f2..54635f5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -154,6 +154,19 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 		public String getColumnText(Object element, int columnIndex) {
 			if (columnIndex == 0) {
+				int count = ((GitFileRevision) element).getCount();
+				if (count < 0)
+					return "";
+				else
+					if (count == 0)
+						return "HEAD";
+					else
+						return "HEAD~"+count;
+			}
+			
+			if (columnIndex == 1) {
+				String rss = ((IFileRevision) element).getURI().toString();
+				String rs = rss.substring(rss.length()-10);
 				String id = ((IFileRevision) element).getContentIdentifier();
 				if (id != null)
 					if (id.length() > 9) // make sure "Workspace" is spelled out
@@ -161,20 +174,20 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 					else
 						return id;
 				else
-					return id;
+					return id + "@.." + rs;
 			}
 
-			if (columnIndex == 1)
+			if (columnIndex == 2)
 				return ""; // TAGS
 
-			if (columnIndex == 2)
+			if (columnIndex == 3)
 				return new Date(((IFileRevision) element).getTimestamp())
 						.toString();
 
-			if (columnIndex == 3)
+			if (columnIndex == 4)
 				return ((IFileRevision) element).getAuthor();
 
-			if (columnIndex == 4) {
+			if (columnIndex == 5) {
 				String comment = ((IFileRevision) element).getComment();
 				if (comment == null)
 					return null;
@@ -186,8 +199,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 			}
 			return Integer.toString(columnIndex);
 		}
-
-	}
+	};
 
 	private void createTree(Composite composite) {
 		tree = new Tree(composite, SWT.H_SCROLL | SWT.V_SCROLL | SWT.MULTI
@@ -200,23 +212,27 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		tree.setData("HEAD");
 		tree.addListener(SWT.SetData, new Listener() {
 			public void handleEvent(Event event) {
-				TreeItem item = (TreeItem) event.item;
-				Tree parent = item.getParent();
-				if (parent == null) {
-					item.setText(new String[] { "hej", "san" });
-					item.setData("");
-				} else {
-					ITableLabelProvider p = (ITableLabelProvider) viewer
-							.getLabelProvider();
-					for (int i = 0; i < 5; ++i) {
-						String text = p.getColumnText(
-								fileRevisions[event.index], i);
-						if (text != null)
-							item.setText(i, text);
-						else
-							item.setText(i, "");
+				try {
+					TreeItem item = (TreeItem) event.item;
+					Tree parent = item.getParent();
+					if (parent == null) {
+						item.setText(new String[] { "hej", "san" });
+						item.setData("");
+					} else {
+						ITableLabelProvider p = (ITableLabelProvider) viewer
+								.getLabelProvider();
+						for (int i = 0; i < 6; ++i) {
+							String text = p.getColumnText(
+									fileRevisions[event.index], i);
+							if (text != null)
+								item.setText(i, text);
+							else
+								item.setText(i, "");
+						}
+						item.setData(fileRevisions[event.index]);
 					}
-					item.setData(fileRevisions[event.index]);
+				} catch (Throwable b) {
+					b.printStackTrace();
 				}
 			}
 		});
@@ -294,12 +310,20 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 	private void createColumns() {
 		// X SelectionListener headerListener = getColumnListener(viewer);
-		// revision
+		// count from head
 		TreeColumn col = new TreeColumn(tree, SWT.NONE);
 		col.setResizable(true);
+		col.setText("^");
+		// X col.addSelectionListener(headerListener);
+		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(10,
+				true));
+
+		// revision
+		col = new TreeColumn(tree, SWT.NONE);
+		col.setResizable(true);
 		col.setText(TeamUIMessages.GenericHistoryTableProvider_Revision);
 		// X col.addSelectionListener(headerListener);
-		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(20,
+		((TableLayout) tree.getLayout()).addColumnData(new ColumnWeightData(10,
 				true));
 
 		// tags
