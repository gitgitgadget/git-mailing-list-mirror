From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 10/10] Rewritten IndexTreeWalker
Date: Sun, 24 Feb 2008 00:50:43 +0100
Message-ID: <1203810643-28819-11-git-send-email-robin.rosenberg@dewire.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-3-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-4-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-5-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-6-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-7-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-8-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-9-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-10-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT4AU-0001IU-Q9
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbYBWXvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbYBWXvk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:51:40 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11235 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754700AbYBWXvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:51:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 931B180280B;
	Sun, 24 Feb 2008 00:51:00 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gqhmFhylP8N1; Sun, 24 Feb 2008 00:50:57 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D12F1802869;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 21B4D293F5; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1203810643-28819-10-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74895>

This one works better with git order and hopefull faster
though that is secondary. The IndexTreeWalker used the TreeIterator
for simplicity.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../spearce/jgit/lib/AbstractIndexTreeVisitor.java |    2 +-
 .../src/org/spearce/jgit/lib/IndexDiff.java        |    3 +-
 .../src/org/spearce/jgit/lib/IndexTreeVisitor.java |    3 +-
 .../src/org/spearce/jgit/lib/IndexTreeWalker.java  |  276 +++++++-------------
 .../src/org/spearce/jgit/lib/WorkDirCheckout.java  |    5 +-
 5 files changed, 105 insertions(+), 184 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AbstractIndexTreeVisitor.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AbstractIndexTreeVisitor.java
index 6f5ede4..c8962f0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AbstractIndexTreeVisitor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AbstractIndexTreeVisitor.java
@@ -29,7 +29,7 @@ import org.spearce.jgit.lib.GitIndex.Entry;
  *
  */
 public class AbstractIndexTreeVisitor implements IndexTreeVisitor {
-	public void finishVisitTree(Tree tree, Tree auxTree, int i, String curDir)
+	public void finishVisitTree(Tree tree, Tree auxTree, String curDir)
 			throws IOException {
 		// Empty
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexDiff.java b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexDiff.java
index 5ed22d3..45fc084 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexDiff.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexDiff.java
@@ -69,7 +69,8 @@ public class IndexDiff {
 					added.add(indexEntry.getName());
 					anyChanges = true;
 				} else if (indexEntry == null) {
-					removed.add(treeEntry.getFullName());
+					if (!(treeEntry instanceof Tree))
+						removed.add(treeEntry.getFullName());
 					anyChanges = true;
 				} else {
 					if (!treeEntry.getId().equals(indexEntry.getObjectId())) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeVisitor.java b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeVisitor.java
index 0510711..26f3a33 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeVisitor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeVisitor.java
@@ -58,11 +58,10 @@ public interface IndexTreeVisitor {
 	 *
 	 * @param tree
 	 * @param auxTree
-	 * @param i
 	 * @param curDir
 	 * @throws IOException
 	 */
-	public void finishVisitTree(Tree tree, Tree auxTree, int i, String curDir) throws IOException;
+	public void finishVisitTree(Tree tree, Tree auxTree, String curDir) throws IOException;
 
 	/**
 	 * Invoked after handling all child nodes of a tree, during two way merge.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
index c17cea1..8323310 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
@@ -82,189 +82,92 @@ public class IndexTreeWalker {
 	 * @throws IOException
 	 */
 	public void walk() throws IOException {
-		walk(mainTree, newTree, "/");
+		walk(mainTree, newTree, "");
 	}
 
 	private void walk(Tree tree, Tree auxTree, String curDir) throws IOException {
-		TreeEntry[] treeMembers = tree == null ? new TreeEntry[0] : tree.members();
-		TreeEntry[] auxTreeMembers = auxTree == null ? new TreeEntry[0] : auxTree.members();
-		int treeCounter = 0;
-		int auxTreeCounter = 0;
-		
+		TreeIterator mi = new TreeIterator(tree, TreeIterator.Order.POSTORDER);
+		TreeIterator ai = new TreeIterator(auxTree, TreeIterator.Order.POSTORDER);
+		TreeEntry m = mi.hasNext() ? mi.next() : null;
+		TreeEntry a = ai.hasNext() ? ai.next() : null;
 		int curIndexPos = indexCounter;
-		
-		while (treeCounter < treeMembers.length || 
-				indexCounter < indexMembers.length || 
-				auxTreeCounter < auxTreeMembers.length) {
-			TreeEntry h = treeCounter < treeMembers.length ? treeMembers[treeCounter] : null;
-			TreeEntry m = auxTreeCounter < auxTreeMembers.length ? auxTreeMembers[auxTreeCounter] : null;
-			Entry i = indexCounter < indexMembers.length ? indexMembers[indexCounter] : null;
-
-			String indexName = i == null ? null : i.getName();
-			String treeName = h == null ? null : h.getFullName();
-			String auxTreeName = m == null ? null : m.getFullName();
+		Entry i = indexCounter < indexMembers.length ? indexMembers[indexCounter++] : null;
+		while (m != null || a != null || i != null) {
+			int cmpma = compare(m, a);
+			int cmpmi = compare(m, i);
+			int cmpai = compare(a, i);
 			
-			if (treeName != null && indexName != null && auxTreeName != null) { 
-				if (eq(h, i) && eq(m, i)) {
-					// H == I == M
-					visitor.visitEntry(h, m, i, new File(root, treeName));
-					
-					treeCounter++;
-					indexCounter++;
-					auxTreeCounter++;
-				} else if (eq(h, i) && lt(h, m)) {
-					// H == I, H < M
-					visitor.visitEntry(h, null, i, new File(root, treeName));
-					
-					treeCounter++;
-					indexCounter++;
-				} else if (eq(h, m) && lt(h, i)) {
-					// H == M, H < I
-					if (h instanceof Tree) {
-						walk((Tree)h, (Tree)m, "/" + treeName);
-					} else {
-						visitor.visitEntry(h, m, null, new File(root, treeName));
-					}
-					
-					treeCounter++;
-					auxTreeCounter++;
-					
-					
-				} else if (eq(m, i) && lt(i, h)) {
-					// I == M, I < H
-					visitor.visitEntry(null, m, i, new File(root, indexName));
-					
-					indexCounter++;
-					auxTreeCounter++;
-				} else if (lt(h, i) && lt(h, m)) {
-					// H < I, H < M
-					if (h instanceof Tree) {
-						walk((Tree) h, null, "/" + treeName);
-					} else {
-						visitor.visitEntry(h, null, null, new File(root, treeName));
-					}
-					
-					treeCounter++;
-				} else if (lt(m, i) && lt(m, h)) {
-					// M < I, M < H
-					if (m instanceof Tree) {
-						walk(null, (Tree) m, "/" + auxTreeName);
-					} else {
-						visitor.visitEntry(null, m, null, new File(root, auxTreeName));
-					}
-					
-					auxTreeCounter++;
-				} else { // index entry is first
-					// I < H, I < M
-					visitor.visitEntry(null, null, i, new File(root, indexName));
-					
-					indexCounter++;
-				}
-			} else if (treeName != null && indexName != null) {
-				if (eq(h, i)) {
-					if (threeTrees)
-						visitor.visitEntry(h, null, i, new File(root, indexName));
-					else visitor.visitEntry(h, i, new File(root, indexName));
-					
-					treeCounter++;
-					indexCounter++;
-				} else if (lt(h, i)) {
-					if (h instanceof Tree) 
-						walk((Tree) h, null, "/" + treeName);
-					else {
-						if (threeTrees) {
-							visitor.visitEntry(h, null, null, new File(root, treeName));
-						} else visitor.visitEntry(h, null, new File(root, treeName));
-					}
-					
-					treeCounter++;
-				} else { // lt(i, h)
-					if (threeTrees) {
-						visitor.visitEntry(null, null, i, new File(root, indexName));
-					} else visitor.visitEntry(null, i, new File(root, indexName));
-					
-					indexCounter++;
-				}
-			} else if (treeName != null && auxTreeName != null) {
-				if (eq(h, m)) {
-					if (h instanceof Tree) {
-						walk((Tree) h, (Tree) m, "/" + treeName);
-					} else {
-						visitor.visitEntry(h, m, null, new File(root, treeName));
-					}
-					
-					treeCounter++;
-					auxTreeCounter++;
-				} else if (lt(h, m)) {
-					if (h instanceof Tree) {
-						walk((Tree) h, null, "/" + treeName);
-					} else {
-						visitor.visitEntry(h, null, null, new File(root, treeName));
-					}
-					
-					treeCounter++;
-				} else { // lt(m, h)
-					if (m instanceof Tree) {
-						walk(null, (Tree) m, "/" + auxTreeName);
-					} else {
-						visitor.visitEntry(null, m, null, new File("/" + auxTreeName));
-					}
-						
-					auxTreeCounter++;
-				}
-				
-			} else if (indexName != null && auxTreeName != null) {
-				if (eq(m, i)) {
-					visitor.visitEntry(null, m, i, new File(root, indexName));
-					
-					auxTreeCounter++;
-					indexCounter++;
-				} else if (lt(m, i)) {
-					if (m instanceof Tree) 
-						walk(null, (Tree) m, "/" + auxTreeName);
-					else {
-						visitor.visitEntry(null, m, null, new File(root, auxTreeName));
-					}
-					
-					auxTreeCounter++;
-				} else { // lt(i, m)
-					visitor.visitEntry(null, null, i, new File(root, indexName));
-					
-					indexCounter++;
-				}
-			} else if (treeName != null) {
-				if (h instanceof Tree) {
-					walk((Tree) h, null, "/" + treeName);
-				} else if (threeTrees)
-					visitor.visitEntry(h, null, null, new File(root, treeName));
-				else visitor.visitEntry(h, null, new File(root, treeName));
-				
-				treeCounter++;
-			} else if (auxTreeName != null) {
-				if (m instanceof Tree) {
-					walk(null, (Tree)m, "/" + auxTreeName);
-				} else visitor.visitEntry(null, m, null, new File(root, auxTreeName));
-				
-				auxTreeCounter++;
-			} else if (indexName != null) {
-				// need to check if we're done with this tree
-				String curDirNoSlash = curDir.substring(1);
-				if (!indexName.startsWith(curDirNoSlash + "/") && curDirNoSlash.length() != 0)
-					break;
-				
-				if (threeTrees)
-					visitor.visitEntry(null, null, i, new File(root, indexName));
-				else visitor.visitEntry(null, i, new File(root, indexName));
-				indexCounter++;
-			}
+			TreeEntry pm = cmpma <= 0 && cmpmi <= 0 ? m : null;
+			TreeEntry pa = cmpma >= 0 && cmpai <= 0 ? a : null;
+			Entry     pi = cmpmi >= 0 && cmpai >= 0 ? i : null;
+
+			if (pi != null)
+				visitEntry(pm, pa, pi, root);
+			else
+				finishVisitTree(pm, pa, curIndexPos, root);
+
+			if (pm != null) m = mi.hasNext() ? mi.next() : null;
+			if (pa != null) a = ai.hasNext() ? ai.next() : null;
+			if (pi != null) i = indexCounter < indexMembers.length ? indexMembers[indexCounter++] : null;
 		}
-		
-		if (threeTrees) {
-			visitor.finishVisitTree(tree, auxTree, indexCounter - curIndexPos, 
-					curDir.substring(1));
-		} else {
-			visitor.finishVisitTree(tree, indexCounter - curIndexPos, curDir);
+	}
+
+	private void visitEntry(TreeEntry t1, TreeEntry t2,
+			Entry i, File root) throws IOException {
+
+		assert t1 != null || t2 != null || i != null : "Needs at least one entry";
+		assert root != null : "Needs workdir";
+
+		if (t1 != null && t1.getParent() == null)
+			t1 = null;
+		if (t2 != null && t2.getParent() == null)
+			t2 = null;
+
+		File f = null;
+		if (i != null)
+			f = new File(root, i.getName());
+		else if (t1 != null)
+			f = new File(root, t1.getFullName());
+		else if (t2 != null)
+			f = new File(root, t2.getFullName());
+
+		if (t1 != null || t2 != null || i != null)
+			if (threeTrees)
+				visitor.visitEntry(t1, t2, i, f);
+			else
+				visitor.visitEntry(t1, i, f);
+	}
+
+	private void finishVisitTree(TreeEntry t1, TreeEntry t2, int curIndexPos, File root)
+			throws IOException {
+
+		assert t1 != null || t2 != null : "Needs at least one entry";
+		assert root != null : "Needs workdir";
+
+		if (t1 != null && t1.getParent() == null)
+			t1 = null;
+		if (t2 != null && t2.getParent() == null)
+			t2 = null;
+
+		File f = null;
+		String c= null;
+		if (t1 != null) {
+			c = t1.getFullName();
+			f = new File(root, c);
+		} else if (t2 != null) {
+			c = t2.getFullName();
+			f = new File(root, c);
 		}
+		if (t1 instanceof Tree || t2 instanceof Tree)
+			if (threeTrees)
+				visitor.finishVisitTree((Tree)t1, (Tree)t2, c);
+			else
+				visitor.finishVisitTree((Tree)t1, indexCounter - curIndexPos, c);
+		else if (t1 != null || t2 != null)
+			if (threeTrees)
+				visitor.visitEntry(t1, t2, null, f);
+			else
+				visitor.visitEntry(t1, null, f);
 	}
 
 	static boolean lt(TreeEntry h, Entry i) {
@@ -288,11 +191,30 @@ public class IndexTreeWalker {
 	}
 
 	static int compare(TreeEntry t, Entry i) {
+		if (t == null && i == null)
+			return 0;
+		if (t == null)
+			return 1;
+		if (i == null)
+			return -1;
 		return Tree.compareNames(t.getFullNameUTF8(), i.getNameUTF8(), TreeEntry.lastChar(t), TreeEntry.lastChar(i)); 
 	}
 	
 	static int compare(TreeEntry t1, TreeEntry t2) {
-		return Tree.compareNames(t1.getNameUTF8(), t2.getNameUTF8(), TreeEntry.lastChar(t1), TreeEntry.lastChar(t2)); 
+		if (t1 != null && t1.getParent() == null && t2 != null && t2.getParent() == null)
+			return 0;
+		if (t1 != null && t1.getParent() == null)
+			return -1;
+		if (t2 != null && t2.getParent() == null)
+			return 1;
+
+		if (t1 == null && t2 == null)
+			return 0;
+		if (t1 == null)
+			return 1;
+		if (t2 == null)
+			return -1;
+		return Tree.compareNames(t1.getFullNameUTF8(), t2.getFullNameUTF8(), TreeEntry.lastChar(t1), TreeEntry.lastChar(t2));
 	}
 	
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
index 04785e4..40ad332 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
@@ -243,11 +243,10 @@ public class WorkDirCheckout {
 			}
 	
 			@Override
-			public void finishVisitTree(Tree tree, Tree auxTree, int i,
-					String curDir) throws IOException {
+			public void finishVisitTree(Tree tree, Tree auxTree, String curDir) throws IOException {
 				if (curDir.length() == 0) return;
 				
-				if (auxTree != null && i == 0) {
+				if (auxTree != null) {
 					if (index.getEntry(curDir) != null)
 						removed.add(curDir);
 				} 
-- 
1.5.4.2
