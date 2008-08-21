From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/4] Support post order tree handling during TreeWalk
Date: Thu, 21 Aug 2008 13:57:36 -0700
Message-ID: <1219352258-15431-2-git-send-email-spearce@spearce.org>
References: <1219352258-15431-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:58:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHEz-0002Z3-F0
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbYHUU5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbYHUU5n
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:57:43 -0400
Received: from george.spearce.org ([209.20.77.23]:41818 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586AbYHUU5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:57:40 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2D0213837A; Thu, 21 Aug 2008 20:57:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 018E538375;
	Thu, 21 Aug 2008 20:57:38 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.112.g9c75
In-Reply-To: <1219352258-15431-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93206>

Some (rare) applications need to handle a tree after they have dealt
with the tree's children.  An example of such an application is one
implementing rmdir, where the directory should be cleaned up after
all files/subdirectories were already removed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/PostOrderTreeWalkTest.java       |  189 ++++++++++++++++++++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   53 ++++++-
 2 files changed, 241 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/PostOrderTreeWalkTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/PostOrderTreeWalkTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/PostOrderTreeWalkTest.java
new file mode 100644
index 0000000..145a56e
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/PostOrderTreeWalkTest.java
@@ -0,0 +1,189 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.treewalk;
+
+import java.io.ByteArrayInputStream;
+
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheBuilder;
+import org.spearce.jgit.dircache.DirCacheEntry;
+import org.spearce.jgit.dircache.DirCacheIterator;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectWriter;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+import static org.spearce.jgit.lib.FileMode.REGULAR_FILE;
+import static org.spearce.jgit.lib.FileMode.TREE;
+
+public class PostOrderTreeWalkTest extends RepositoryTestCase {
+	public void testInitialize_NoPostOrder() throws Exception {
+		final TreeWalk tw = new TreeWalk(db);
+		assertFalse(tw.isPostOrderTraversal());
+	}
+
+	public void testInitialize_TogglePostOrder() throws Exception {
+		final TreeWalk tw = new TreeWalk(db);
+		assertFalse(tw.isPostOrderTraversal());
+		tw.setPostOrderTraversal(true);
+		assertTrue(tw.isPostOrderTraversal());
+		tw.setPostOrderTraversal(false);
+		assertFalse(tw.isPostOrderTraversal());
+	}
+
+	public void testResetDoesNotAffectPostOrder() throws Exception {
+		final TreeWalk tw = new TreeWalk(db);
+		tw.setPostOrderTraversal(true);
+		assertTrue(tw.isPostOrderTraversal());
+		tw.reset();
+		assertTrue(tw.isPostOrderTraversal());
+
+		tw.setPostOrderTraversal(false);
+		assertFalse(tw.isPostOrderTraversal());
+		tw.reset();
+		assertFalse(tw.isPostOrderTraversal());
+	}
+
+	public void testNoPostOrder() throws Exception {
+		final DirCache tree = DirCache.read(db);
+		{
+			final DirCacheBuilder b = tree.builder();
+
+			b.add(makeFile("a"));
+			b.add(makeFile("b/c"));
+			b.add(makeFile("b/d"));
+			b.add(makeFile("q"));
+
+			b.finish();
+			assertEquals(4, tree.getEntryCount());
+		}
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		tw.setPostOrderTraversal(false);
+		tw.addTree(new DirCacheIterator(tree));
+
+		assertModes("a", REGULAR_FILE, tw);
+		assertModes("b", TREE, tw);
+		assertTrue(tw.isSubtree());
+		assertFalse(tw.isPostChildren());
+		tw.enterSubtree();
+		assertModes("b/c", REGULAR_FILE, tw);
+		assertModes("b/d", REGULAR_FILE, tw);
+		assertModes("q", REGULAR_FILE, tw);
+	}
+
+	public void testWithPostOrder_EnterSubtree() throws Exception {
+		final DirCache tree = DirCache.read(db);
+		{
+			final DirCacheBuilder b = tree.builder();
+
+			b.add(makeFile("a"));
+			b.add(makeFile("b/c"));
+			b.add(makeFile("b/d"));
+			b.add(makeFile("q"));
+
+			b.finish();
+			assertEquals(4, tree.getEntryCount());
+		}
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		tw.setPostOrderTraversal(true);
+		tw.addTree(new DirCacheIterator(tree));
+
+		assertModes("a", REGULAR_FILE, tw);
+
+		assertModes("b", TREE, tw);
+		assertTrue(tw.isSubtree());
+		assertFalse(tw.isPostChildren());
+		tw.enterSubtree();
+		assertModes("b/c", REGULAR_FILE, tw);
+		assertModes("b/d", REGULAR_FILE, tw);
+
+		assertModes("b", TREE, tw);
+		assertTrue(tw.isSubtree());
+		assertTrue(tw.isPostChildren());
+
+		assertModes("q", REGULAR_FILE, tw);
+	}
+
+	public void testWithPostOrder_NoEnterSubtree() throws Exception {
+		final DirCache tree = DirCache.read(db);
+		{
+			final DirCacheBuilder b = tree.builder();
+
+			b.add(makeFile("a"));
+			b.add(makeFile("b/c"));
+			b.add(makeFile("b/d"));
+			b.add(makeFile("q"));
+
+			b.finish();
+			assertEquals(4, tree.getEntryCount());
+		}
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		tw.setPostOrderTraversal(true);
+		tw.addTree(new DirCacheIterator(tree));
+
+		assertModes("a", REGULAR_FILE, tw);
+
+		assertModes("b", TREE, tw);
+		assertTrue(tw.isSubtree());
+		assertFalse(tw.isPostChildren());
+
+		assertModes("q", REGULAR_FILE, tw);
+	}
+
+	private DirCacheEntry makeFile(final String path) throws Exception {
+		final byte[] pathBytes = Constants.encode(path);
+		final DirCacheEntry ent = new DirCacheEntry(path);
+		ent.setFileMode(REGULAR_FILE);
+		ent.setObjectId(new ObjectWriter(db).computeBlobSha1(pathBytes.length,
+				new ByteArrayInputStream(pathBytes)));
+		return ent;
+	}
+
+	private static void assertModes(final String path, final FileMode mode0,
+			final TreeWalk tw) throws Exception {
+		assertTrue("has " + path, tw.next());
+		assertEquals(path, tw.getPathString());
+		assertEquals(mode0, tw.getFileMode(0));
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 7a09878..6d0ef02 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -147,10 +147,14 @@ public static TreeWalk forPath(final Repository db, final String path,
 
 	private boolean recursive;
 
+	private boolean postOrderTraversal;
+
 	private int depth;
 
 	private boolean advance;
 
+	private boolean postChildren;
+
 	AbstractTreeIterator currentHead;
 
 	/**
@@ -235,6 +239,36 @@ public void setRecursive(final boolean b) {
 		recursive = b;
 	}
 
+	/**
+	 * Does this walker return a tree entry after it exits the subtree?
+	 * <p>
+	 * If post order traversal is enabled then the walker will return a subtree
+	 * after it has returned the last entry within that subtree. This may cause
+	 * a subtree to be seen by the application twice if {@link #isRecursive()}
+	 * is false, as the application will see it once, call
+	 * {@link #enterSubtree()}, and then see it again as it leaves the subtree.
+	 * <p>
+	 * If an application does not enable {@link #isRecursive()} and it does not
+	 * call {@link #enterSubtree()} then the tree is returned only once as none
+	 * of the children were processed.
+	 * 
+	 * @return true if subtrees are returned after entries within the subtree.
+	 */
+	public boolean isPostOrderTraversal() {
+		return postOrderTraversal;
+	}
+
+	/**
+	 * Set the walker to return trees after their children.
+	 * 
+	 * @param b
+	 *            true to get trees after their children.
+	 * @see #isPostOrderTraversal()
+	 */
+	public void setPostOrderTraversal(final boolean b) {
+		postOrderTraversal = b;
+	}
+
 	/** Reset this walker so new tree iterators can be added to it. */
 	public void reset() {
 		trees = new AbstractTreeIterator[0];
@@ -379,6 +413,7 @@ public boolean next() throws MissingObjectException,
 		try {
 			if (advance) {
 				advance = false;
+				postChildren = false;
 				popEntriesEqual();
 			}
 
@@ -387,6 +422,12 @@ public boolean next() throws MissingObjectException,
 				if (t.eof()) {
 					if (depth > 0) {
 						exitSubtree();
+						if (postOrderTraversal) {
+							advance = true;
+							postChildren = true;
+							return true;
+						}
+						popEntriesEqual();
 						continue;
 					}
 					return false;
@@ -587,6 +628,17 @@ public boolean isSubtree() {
 	}
 
 	/**
+	 * Is the current entry a subtree returned after its children?
+	 * 
+	 * @return true if the current node is a tree that has been returned after
+	 *         its children were already processed.
+	 * @see #isPostOrderTraversal()
+	 */
+	public boolean isPostChildren() {
+		return postChildren && isSubtree();
+	}
+
+	/**
 	 * Enter into the current subtree.
 	 * <p>
 	 * If the current entry is a subtree this method arranges for its children
@@ -675,7 +727,6 @@ private void exitSubtree() throws CorruptObjectException {
 		for (int i = 0; i < trees.length; i++)
 			trees[i] = trees[i].parent;
 		currentHead = min();
-		popEntriesEqual();
 	}
 
 	private CanonicalTreeParser parserFor(final ObjectId id)
-- 
1.6.0.112.g9c75
