From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Fix TreeWalk to correctly handle missing subtrees
Date: Wed, 13 Aug 2008 14:42:22 -0700
Message-ID: <1218663742-1276-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 23:43:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTO7t-0002Nb-Md
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbYHMVmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 17:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbYHMVmZ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:42:25 -0400
Received: from george.spearce.org ([209.20.77.23]:59360 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbYHMVmY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 17:42:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DC44A38376; Wed, 13 Aug 2008 21:42:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1CB9E381FD;
	Wed, 13 Aug 2008 21:42:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92280>

When we are walking through a pair of trees and one of the two trees has
added a new subtree in the middle we need to make sure we use the special
EmptyTreeIterator as a placeholder for the other tree which is missing
that path entry.

This fixes the issue Robin noticed where pulling up the difference for
"55e9a699df...0f0ae68377 org.spearce.jgit.test" showed files deleted
by 0f0a when they were not even touched.  The addition of a new subtree
("revwalk") by 0f0a is what threw the iteration off, causing the other
tree (55e9's) to enter into the wrong subtree at the wrong time.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

  This is on top of my misc-cleanup series.

 .../jgit/treewalk/TreeWalkBasicDiffTest.java       |  116 ++++++++++++++++++++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |    3 +-
 2 files changed, 118 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/TreeWalkBasicDiffTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/TreeWalkBasicDiffTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/TreeWalkBasicDiffTest.java
new file mode 100644
index 0000000..a25c273
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/TreeWalkBasicDiffTest.java
@@ -0,0 +1,116 @@
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
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectWriter;
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.lib.Tree;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
+
+public class TreeWalkBasicDiffTest extends RepositoryTestCase {
+	public void testMissingSubtree_DetectFileAdded_FileModified()
+			throws Exception {
+		final ObjectWriter ow = new ObjectWriter(db);
+		final ObjectId aFileId = ow.writeBlob("a".getBytes());
+		final ObjectId bFileId = ow.writeBlob("b".getBytes());
+		final ObjectId cFileId1 = ow.writeBlob("c-1".getBytes());
+		final ObjectId cFileId2 = ow.writeBlob("c-2".getBytes());
+
+		// Create sub-a/empty, sub-c/empty = hello.
+		final ObjectId oldTree;
+		{
+			final Tree root = new Tree(db);
+			{
+				final Tree subA = root.addTree("sub-a");
+				subA.addFile("empty").setId(aFileId);
+				subA.setId(ow.writeTree(subA));
+			}
+			{
+				final Tree subC = root.addTree("sub-c");
+				subC.addFile("empty").setId(cFileId1);
+				subC.setId(ow.writeTree(subC));
+			}
+			oldTree = ow.writeTree(root);
+		}
+
+		// Create sub-a/empty, sub-b/empty, sub-c/empty.
+		final ObjectId newTree;
+		{
+			final Tree root = new Tree(db);
+			{
+				final Tree subA = root.addTree("sub-a");
+				subA.addFile("empty").setId(aFileId);
+				subA.setId(ow.writeTree(subA));
+			}
+			{
+				final Tree subB = root.addTree("sub-b");
+				subB.addFile("empty").setId(bFileId);
+				subB.setId(ow.writeTree(subB));
+			}
+			{
+				final Tree subC = root.addTree("sub-c");
+				subC.addFile("empty").setId(cFileId2);
+				subC.setId(ow.writeTree(subC));
+			}
+			newTree = ow.writeTree(root);
+		}
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset(new ObjectId[] { oldTree, newTree });
+		tw.setRecursive(true);
+		tw.setFilter(TreeFilter.ANY_DIFF);
+
+		assertTrue(tw.next());
+		assertEquals("sub-b/empty", tw.getPathString());
+		assertEquals(FileMode.MISSING, tw.getFileMode(0));
+		assertEquals(FileMode.REGULAR_FILE, tw.getFileMode(1));
+		assertEquals(ObjectId.zeroId(), tw.getObjectId(0));
+		assertEquals(bFileId, tw.getObjectId(1));
+
+		assertTrue(tw.next());
+		assertEquals("sub-c/empty", tw.getPathString());
+		assertEquals(FileMode.REGULAR_FILE, tw.getFileMode(0));
+		assertEquals(FileMode.REGULAR_FILE, tw.getFileMode(1));
+		assertEquals(cFileId1, tw.getObjectId(0));
+		assertEquals(cFileId2, tw.getObjectId(1));
+
+		assertFalse(tw.next());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 9f373e6..aa05736 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -606,11 +606,12 @@ public class TreeWalk {
 	 */
 	public void enterSubtree() throws MissingObjectException,
 			IncorrectObjectTypeException, CorruptObjectException, IOException {
+		final AbstractTreeIterator ch = currentHead;
 		final AbstractTreeIterator[] tmp = new AbstractTreeIterator[trees.length];
 		for (int i = 0; i < trees.length; i++) {
 			final AbstractTreeIterator t = trees[i];
 			final AbstractTreeIterator n;
-			if (!t.eof() && FileMode.TREE.equals(t.mode))
+			if (t.matches == ch && !t.eof() && FileMode.TREE.equals(t.mode))
 				n = t.createSubtreeIterator(db);
 			else
 				n = new EmptyTreeIterator(t);
-- 
1.6.0.rc2.22.g71b99
