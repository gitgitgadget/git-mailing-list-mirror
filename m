From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Fix merges involving subtrees with StrategySimpleTwoWayInCore
Date: Thu,  5 Mar 2009 17:05:23 -0800
Message-ID: <1236301524-18540-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 02:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfOWh-0007zV-F0
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 02:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbZCFBFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 20:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbZCFBF3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 20:05:29 -0500
Received: from george.spearce.org ([209.20.77.23]:45817 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbZCFBF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 20:05:28 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id CD1683821F; Fri,  6 Mar 2009 01:05:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C541F381D5;
	Fri,  6 Mar 2009 01:05:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.96.gc65e7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112362>

JGit mismerged two trees when the common ancestor tree contained two
trees named libelf-po and libelf, and libelf was modified on one side
of the merge, while libelf-po was unmodified by both:

  040000 tree ...    libelf-po
  040000 tree ...    libelf

Above is the correct sort order, as the second tree, libelf, must be
sorted as though it ends with '/', and thus comes after libelf-po.

JGit flipped the order during a merge as the strategy added the modified
subtree "libelf" directly to the DirCacheBuilder, rather than unfolding
its contents into the DirCache.  The result was a tree entry where only
file type entries were expected, and the DirCacheBuilder resorted its
contents to place "libelf" before "libelf-po".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This patch fixes the data corruption I reported earlier today,
 and that Peff helped me find so quickly.

 The second patch in this series fixes a long standing set of
 bugs with the merge code when dealing with concurrent (but not
 conflicting) modifications in subtrees.

 .../org/spearce/jgit/merge/SimpleMergeTest.java    |   93 ++++++++++++++++++++
 .../org/spearce/jgit/dircache/DirCacheBuilder.java |   17 +++--
 .../jgit/merge/StrategySimpleTwoWayInCore.java     |   27 +++---
 3 files changed, 119 insertions(+), 18 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
index 96064f5..e99f017 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
@@ -36,10 +36,20 @@
  */
 package org.spearce.jgit.merge;
 
+import java.io.ByteArrayInputStream;
 import java.io.IOException;
 
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheBuilder;
+import org.spearce.jgit.dircache.DirCacheEntry;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectWriter;
+import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.treewalk.TreeWalk;
 
 public class SimpleMergeTest extends RepositoryTestCase {
 
@@ -83,4 +93,87 @@ public void testTrivialTwoWay_conflict() throws IOException {
 		boolean merge = ourMerger.merge(new ObjectId[] { db.resolve("f"), db.resolve("g") });
 		assertFalse(merge);
 	}
+
+	public void testTrivialTwoWay_validSubtreeSort() throws Exception {
+		final DirCache treeB = DirCache.read(db);
+		final DirCache treeO = DirCache.read(db);
+		final DirCache treeT = DirCache.read(db);
+		{
+			final DirCacheBuilder b = treeB.builder();
+			final DirCacheBuilder o = treeO.builder();
+			final DirCacheBuilder t = treeT.builder();
+
+			b.add(makeEntry("libelf-po/a", FileMode.REGULAR_FILE));
+			b.add(makeEntry("libelf/c", FileMode.REGULAR_FILE));
+
+			o.add(makeEntry("Makefile", FileMode.REGULAR_FILE));
+			o.add(makeEntry("libelf-po/a", FileMode.REGULAR_FILE));
+			o.add(makeEntry("libelf/c", FileMode.REGULAR_FILE));
+
+			t.add(makeEntry("libelf-po/a", FileMode.REGULAR_FILE));
+			t.add(makeEntry("libelf/c", FileMode.REGULAR_FILE, "blah"));
+
+			b.finish();
+			o.finish();
+			t.finish();
+		}
+
+		final ObjectWriter ow = new ObjectWriter(db);
+		final ObjectId b = commit(ow, treeB, new ObjectId[] {});
+		final ObjectId o = commit(ow, treeO, new ObjectId[] { b });
+		final ObjectId t = commit(ow, treeT, new ObjectId[] { b });
+
+		Merger ourMerger = MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(db);
+		boolean merge = ourMerger.merge(new ObjectId[] { o, t });
+		assertTrue(merge);
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.setRecursive(true);
+		tw.reset(ourMerger.getResultTreeId());
+
+		assertTrue(tw.next());
+		assertEquals("Makefile", tw.getPathString());
+		assertCorrectId(treeO, tw);
+
+		assertTrue(tw.next());
+		assertEquals("libelf-po/a", tw.getPathString());
+		assertCorrectId(treeO, tw);
+
+		assertTrue(tw.next());
+		assertEquals("libelf/c", tw.getPathString());
+		assertCorrectId(treeT, tw);
+
+		assertFalse(tw.next());
+	}
+
+	private void assertCorrectId(final DirCache treeT, final TreeWalk tw) {
+		assertEquals(treeT.getEntry(tw.getPathString()).getObjectId(), tw
+				.getObjectId(0));
+	}
+
+	private ObjectId commit(final ObjectWriter ow, final DirCache treeB,
+			final ObjectId[] parentIds) throws Exception {
+		final Commit c = new Commit(db);
+		c.setTreeId(treeB.writeTree(ow));
+		c.setAuthor(new PersonIdent("A U Thor", "a.u.thor", 1L, 0));
+		c.setCommitter(c.getAuthor());
+		c.setParentIds(parentIds);
+		c.setMessage("Tree " + c.getTreeId().name());
+		return ow.writeCommit(c);
+	}
+
+	private DirCacheEntry makeEntry(final String path, final FileMode mode)
+			throws Exception {
+		return makeEntry(path, mode, path);
+	}
+
+	private DirCacheEntry makeEntry(final String path, final FileMode mode,
+			final String content) throws Exception {
+		final DirCacheEntry ent = new DirCacheEntry(path);
+		ent.setFileMode(mode);
+		final byte[] contentBytes = Constants.encode(content);
+		ent.setObjectId(new ObjectWriter(db).computeBlobSha1(
+				contentBytes.length, new ByteArrayInputStream(contentBytes)));
+		return ent;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
index 9a9d174..aee12fb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuilder.java
@@ -41,6 +41,7 @@
 import java.util.Arrays;
 
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.WindowCursor;
 import org.spearce.jgit.treewalk.AbstractTreeIterator;
@@ -133,6 +134,8 @@ public void keep(final int pos, int cnt) {
 	 *            UTF-8 encoded prefix to mount the tree's entries at. If the
 	 *            path does not end with '/' one will be automatically inserted
 	 *            as necessary.
+	 * @param stage
+	 *            stage of the entries when adding them.
 	 * @param db
 	 *            repository the tree(s) will be read from during recursive
 	 *            traversal. This must be the same repository that the resulting
@@ -146,8 +149,8 @@ public void keep(final int pos, int cnt) {
 	 * @throws IOException
 	 *             a tree cannot be read to iterate through its entries.
 	 */
-	public void addTree(final byte[] pathPrefix, final Repository db,
-			final AnyObjectId tree) throws IOException {
+	public void addTree(final byte[] pathPrefix, final int stage,
+			final Repository db, final AnyObjectId tree) throws IOException {
 		final TreeWalk tw = new TreeWalk(db);
 		tw.reset();
 		final WindowCursor curs = new WindowCursor();
@@ -159,16 +162,16 @@ public void addTree(final byte[] pathPrefix, final Repository db,
 		}
 		tw.setRecursive(true);
 		if (tw.next()) {
-			final DirCacheEntry newEntry = toEntry(tw);
+			final DirCacheEntry newEntry = toEntry(stage, tw);
 			beforeAdd(newEntry);
 			fastAdd(newEntry);
 			while (tw.next())
-				fastAdd(toEntry(tw));
+				fastAdd(toEntry(stage, tw));
 		}
 	}
 
-	private DirCacheEntry toEntry(final TreeWalk tw) {
-		final DirCacheEntry e = new DirCacheEntry(tw.getRawPath());
+	private DirCacheEntry toEntry(final int stage, final TreeWalk tw) {
+		final DirCacheEntry e = new DirCacheEntry(tw.getRawPath(), stage);
 		final AbstractTreeIterator i;
 
 		i = tw.getTree(0, AbstractTreeIterator.class);
@@ -184,6 +187,8 @@ public void finish() {
 	}
 
 	private void beforeAdd(final DirCacheEntry newEntry) {
+		if (FileMode.TREE.equals(newEntry.getRawMode()))
+			throw bad(newEntry, "Adding subtree not allowed");
 		if (sorted && entryCnt > 0) {
 			final DirCacheEntry lastEntry = entries[entryCnt - 1];
 			final int cr = DirCache.cmp(lastEntry, newEntry);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
index 893add9..0f8b4e1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
@@ -43,6 +43,7 @@
 import org.spearce.jgit.dircache.DirCacheBuilder;
 import org.spearce.jgit.dircache.DirCacheEntry;
 import org.spearce.jgit.errors.UnmergedPathException;
+import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.treewalk.AbstractTreeIterator;
@@ -143,27 +144,29 @@ else if (modeB == modeT && tw.idEqual(T_BASE, T_THEIRS))
 		}
 
 		private void same() throws IOException {
-			if (tw.isSubtree())
-				builder.addTree(tw.getRawPath(), db, tw.getObjectId(1));
-			else
-				add(T_OURS, DirCacheEntry.STAGE_0);
+			add(T_OURS, DirCacheEntry.STAGE_0);
 		}
 
-		private void conflict() {
+		private void conflict() throws IOException {
 			add(T_BASE, DirCacheEntry.STAGE_1);
 			add(T_OURS, DirCacheEntry.STAGE_2);
 			add(T_THEIRS, DirCacheEntry.STAGE_3);
 		}
 
-		private void add(final int tree, final int stage) {
+		private void add(final int tree, final int stage) throws IOException {
 			final AbstractTreeIterator i = getTree(tree);
 			if (i != null) {
-				final DirCacheEntry e;
-
-				e = new DirCacheEntry(tw.getRawPath(), stage);
-				e.setObjectIdFromRaw(i.idBuffer(), i.idOffset());
-				e.setFileMode(tw.getFileMode(tree));
-				builder.add(e);
+				if (FileMode.TREE.equals(tw.getRawMode(tree))) {
+					builder.addTree(tw.getRawPath(), stage, db, tw
+							.getObjectId(tree));
+				} else {
+					final DirCacheEntry e;
+
+					e = new DirCacheEntry(tw.getRawPath(), stage);
+					e.setObjectIdFromRaw(i.idBuffer(), i.idOffset());
+					e.setFileMode(tw.getFileMode(tree));
+					builder.add(e);
+				}
 			}
 		}
 
-- 
1.6.2.96.gc65e7
