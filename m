From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/3] Support viewing all changes in a single compare editor
Date: Sat, 10 Jan 2009 02:14:35 +0100
Message-ID: <1231550077-1057-2-git-send-email-robin.rosenberg@dewire.com>
References: <1231550077-1057-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jan 10 02:16:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLSSQ-0002Kg-9L
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 02:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134AbZAJBOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 20:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbZAJBOp
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 20:14:45 -0500
Received: from mail.dewire.com ([83.140.172.130]:8468 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754945AbZAJBOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 20:14:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2F8431484F4F;
	Sat, 10 Jan 2009 02:14:41 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xjna1OcdrIuA; Sat, 10 Jan 2009 02:14:39 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id DE9831484F6C;
	Sat, 10 Jan 2009 02:14:38 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231550077-1057-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105057>

Instead of having to click on every file listed as a diff
an extra diff entry is inserted at the top. Double clicking
on it will launch a compare editor for all changed files.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../ui/internal/history/CommitFileDiffViewer.java  |   40 ++++++++++++--
 .../internal/history/FileDiffContentProvider.java  |   11 +++-
 .../ui/internal/history/FileDiffLabelProvider.java |   49 +++++++++++++++--
 .../spearce/egit/ui/internal/history/RevDiff.java  |   55 ++++++++++++++++++++
 4 files changed, 141 insertions(+), 14 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitFileDiffViewer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitFileDiffViewer.java
index ebec261..7549aa4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitFileDiffViewer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitFileDiffViewer.java
@@ -64,9 +64,17 @@ public void open(final OpenEvent event) {
 				if (s.isEmpty() || !(s instanceof IStructuredSelection))
 					return;
 				final IStructuredSelection iss = (IStructuredSelection) s;
-				final FileDiff d = (FileDiff) iss.getFirstElement();
-				if (walker != null && d.blobs.length == 2)
-					showTwoWayFileDiff(d);
+				if (iss.getFirstElement() instanceof RevDiff)
+					showTwoWayDiff((RevDiff)iss.getFirstElement());
+				else {
+					FileDiff d = (FileDiff)iss.getFirstElement();
+					if (walker != null && d.blobs.length == 2) {
+						if (iss.size() == 1)
+							showTwoWayFileDiff(d);
+						else
+							showTwoWayDiff(iss.toArray());
+					}
+				}
 			}
 		});
 
@@ -98,6 +106,23 @@ void showTwoWayFileDiff(final FileDiff d) {
 		CompareUI.openCompareEditor(in);
 	}
 
+	void showTwoWayDiff(RevDiff d) {
+		final GitCompareFileRevisionEditorInput in = new GitCompareFileRevisionEditorInput(d.left, d.right, null);
+		CompareUI.openCompareEditor(in);
+	}
+
+	void showTwoWayDiff(final Object[] d) {
+		FileDiff[] diffs = new FileDiff[d.length];
+		System.arraycopy(d, 0, diffs, 0, d.length);
+
+		final Repository db = walker.getRepository();
+		DiffSide base = new DiffSide(diffs, 0, db);
+		DiffSide next = new DiffSide(diffs, 1, db);
+
+		final GitCompareFileRevisionEditorInput in = new GitCompareFileRevisionEditorInput(base, next, null);
+		CompareUI.openCompareEditor(in);
+	}
+
 	TreeWalk getTreeWalk() {
 		return walker;
 	}
@@ -124,13 +149,16 @@ void doCopy() {
 		if (s.isEmpty() || !(s instanceof IStructuredSelection))
 			return;
 		final IStructuredSelection iss = (IStructuredSelection) s;
-		final Iterator<FileDiff> itr = iss.iterator();
+		final Iterator itr = iss.iterator();
 		final StringBuilder r = new StringBuilder();
 		while (itr.hasNext()) {
-			final FileDiff d = itr.next();
+			Object o = itr.next();
 			if (r.length() > 0)
 				r.append("\n");
-			r.append(d.path);
+			if (o instanceof FileDiff)
+				r.append(((FileDiff)o).path);
+			else
+				r.append(((RevDiff)o).left.getChildren().length + " files");
 		}
 
 		clipboard.setContents(new Object[] { r.toString() },
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffContentProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffContentProvider.java
index c84e9f3..25e7714 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffContentProvider.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffContentProvider.java
@@ -20,7 +20,7 @@
 
 	private RevCommit commit;
 
-	private FileDiff[] diff;
+	private Object[] diff;
 
 	public void inputChanged(final Viewer newViewer, final Object oldInput,
 			final Object newInput) {
@@ -32,7 +32,14 @@ public void inputChanged(final Viewer newViewer, final Object oldInput,
 	public Object[] getElements(final Object inputElement) {
 		if (diff == null && walk != null && commit != null) {
 			try {
-				diff = FileDiff.compute(walk, commit);
+				FileDiff[] fdiff = FileDiff.compute(walk, commit);
+				if (fdiff.length <= 1) {
+					diff = fdiff;
+				} else {
+					diff = new Object[fdiff.length + 1];
+					diff[0] = new RevDiff(fdiff, walk.getRepository());
+					System.arraycopy(fdiff, 0, diff, 1, fdiff.length);
+				}
 			} catch (IOException err) {
 				Activator.error("Can't get file difference of "
 						+ commit.getId() + ".", err);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffLabelProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffLabelProvider.java
index 60b3a5a..c78ba6e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffLabelProvider.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffLabelProvider.java
@@ -14,12 +14,49 @@
 class FileDiffLabelProvider extends BaseLabelProvider implements
 		ITableLabelProvider {
 	public String getColumnText(final Object element, final int columnIndex) {
-		final FileDiff c = (FileDiff) element;
-		switch (columnIndex) {
-		case 0:
-			return c.change;
-		case 1:
-			return c.path;
+		if (element instanceof FileDiff) {
+			final FileDiff c = (FileDiff) element;
+			switch (columnIndex) {
+			case 0:
+				return c.change;
+			case 1:
+				return c.path;
+			}
+		} else {
+			final RevDiff c = (RevDiff) element;
+			switch (columnIndex) {
+			case 0:
+				return "\u03a3";
+			case 1:
+				{
+					int mod = 0;
+					int add = 0;
+					int del = 0;
+					for (int i = 0; i < c.left.fileDiffs.length; ++i) {
+						if (c.left.fileDiffs[i].change.equals("A"))
+							add++;
+						if (c.left.fileDiffs[i].change.equals("M"))
+							mod++;
+						if (c.left.fileDiffs[i].change.equals("D"))
+							del++;
+					}
+					StringBuilder b = new StringBuilder();
+					if (add > 0) {
+						b.append(add + " added");
+					}
+					if (mod > 0) {
+						if (b.length() > 0)
+							b.append(", ");
+						b.append(mod + " changed");
+					}
+					if (del > 0) {
+						if (b.length() > 0)
+							b.append(", ");
+						b.append(del + " deleted");
+					}
+					return b.toString();
+				}
+			}
 		}
 		return "";
 	}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java
new file mode 100644
index 0000000..020ec73
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java
@@ -0,0 +1,55 @@
+package org.spearce.egit.ui.internal.history;
+
+import org.eclipse.compare.ITypedElement;
+import org.eclipse.compare.structuremergeviewer.IStructureComparator;
+import org.eclipse.swt.graphics.Image;
+import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
+import org.spearce.egit.core.internal.storage.GitFileRevision;
+import org.spearce.jgit.lib.Repository;
+
+class RevDiff {
+	DiffSide left;
+
+	DiffSide right;
+
+	RevDiff(FileDiff[] fileDiffs, Repository db) {
+		left = new DiffSide(fileDiffs, 0, db);
+		right = new DiffSide(fileDiffs, 1, db);
+	}
+}
+
+class DiffSide implements ITypedElement, IStructureComparator {
+	final FileDiff[] fileDiffs;
+
+	private final int side;
+
+	private final Repository db;
+
+	DiffSide(FileDiff[] fileDiffs, int side, Repository db) {
+		this.fileDiffs = fileDiffs;
+		this.side = side;
+		this.db = db;
+	}
+
+	public Image getImage() {
+		return null;
+	}
+
+	public String getName() {
+		return "EGit diff";
+	}
+
+	public String getType() {
+		return FOLDER_TYPE;
+	}
+
+	public Object[] getChildren() {
+		FileRevisionTypedElement[] ret = new FileRevisionTypedElement[fileDiffs.length];
+		for (int i = 0; i < ret.length; ++i) {
+			ret[i] = new FileRevisionTypedElement(GitFileRevision.inCommit(db,
+					fileDiffs[i].commit, fileDiffs[i].path,
+					fileDiffs[i].blobs[side]));
+		}
+		return ret;
+	}
+}
-- 
1.6.1.rc3.56.gd0306
