From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Fix merges involving clean subtrees with StrategySimpleTwoWayInCore
Date: Thu,  5 Mar 2009 17:05:24 -0800
Message-ID: <1236301524-18540-2-git-send-email-spearce@spearce.org>
References: <1236301524-18540-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 02:07:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfOWi-0007zV-Fd
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 02:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbZCFBFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 20:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754162AbZCFBFa
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 20:05:30 -0500
Received: from george.spearce.org ([209.20.77.23]:45819 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbZCFBF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 20:05:28 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 72D2538215; Fri,  6 Mar 2009 01:05:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 35D0B38211;
	Fri,  6 Mar 2009 01:05:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.96.gc65e7
In-Reply-To: <1236301524-18540-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112363>

If a both sides modify files in the same subtree, but do so in a
non-conflicting way, we should still be able to merge them by an
automated merge strategy.  Recursing into the subtree permits us
to do this merge.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/merge/SimpleMergeTest.java    |  204 ++++++++++++++++++++
 .../jgit/merge/StrategySimpleTwoWayInCore.java     |   32 ++-
 2 files changed, 225 insertions(+), 11 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
index e99f017..c5755a8 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
@@ -146,6 +146,210 @@ public void testTrivialTwoWay_validSubtreeSort() throws Exception {
 		assertFalse(tw.next());
 	}
 
+	public void testTrivialTwoWay_concurrentSubtreeChange() throws Exception {
+		final DirCache treeB = DirCache.read(db);
+		final DirCache treeO = DirCache.read(db);
+		final DirCache treeT = DirCache.read(db);
+		{
+			final DirCacheBuilder b = treeB.builder();
+			final DirCacheBuilder o = treeO.builder();
+			final DirCacheBuilder t = treeT.builder();
+
+			b.add(makeEntry("d/o", FileMode.REGULAR_FILE));
+			b.add(makeEntry("d/t", FileMode.REGULAR_FILE));
+
+			o.add(makeEntry("d/o", FileMode.REGULAR_FILE, "o !"));
+			o.add(makeEntry("d/t", FileMode.REGULAR_FILE));
+
+			t.add(makeEntry("d/o", FileMode.REGULAR_FILE));
+			t.add(makeEntry("d/t", FileMode.REGULAR_FILE, "t !"));
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
+		assertEquals("d/o", tw.getPathString());
+		assertCorrectId(treeO, tw);
+
+		assertTrue(tw.next());
+		assertEquals("d/t", tw.getPathString());
+		assertCorrectId(treeT, tw);
+
+		assertFalse(tw.next());
+	}
+	
+	public void testTrivialTwoWay_conflictSubtreeChange() throws Exception {
+		final DirCache treeB = DirCache.read(db);
+		final DirCache treeO = DirCache.read(db);
+		final DirCache treeT = DirCache.read(db);
+		{
+			final DirCacheBuilder b = treeB.builder();
+			final DirCacheBuilder o = treeO.builder();
+			final DirCacheBuilder t = treeT.builder();
+
+			b.add(makeEntry("d/o", FileMode.REGULAR_FILE));
+			b.add(makeEntry("d/t", FileMode.REGULAR_FILE));
+
+			o.add(makeEntry("d/o", FileMode.REGULAR_FILE));
+			o.add(makeEntry("d/t", FileMode.REGULAR_FILE, "o !"));
+
+			t.add(makeEntry("d/o", FileMode.REGULAR_FILE, "t !"));
+			t.add(makeEntry("d/t", FileMode.REGULAR_FILE, "t !"));
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
+		assertFalse(merge);
+	}
+
+	public void testTrivialTwoWay_leftDFconflict1() throws Exception {
+		final DirCache treeB = DirCache.read(db);
+		final DirCache treeO = DirCache.read(db);
+		final DirCache treeT = DirCache.read(db);
+		{
+			final DirCacheBuilder b = treeB.builder();
+			final DirCacheBuilder o = treeO.builder();
+			final DirCacheBuilder t = treeT.builder();
+
+			b.add(makeEntry("d/o", FileMode.REGULAR_FILE));
+			b.add(makeEntry("d/t", FileMode.REGULAR_FILE));
+
+			o.add(makeEntry("d", FileMode.REGULAR_FILE));
+
+			t.add(makeEntry("d/o", FileMode.REGULAR_FILE));
+			t.add(makeEntry("d/t", FileMode.REGULAR_FILE, "t !"));
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
+		assertFalse(merge);
+	}
+
+	public void testTrivialTwoWay_rightDFconflict1() throws Exception {
+		final DirCache treeB = DirCache.read(db);
+		final DirCache treeO = DirCache.read(db);
+		final DirCache treeT = DirCache.read(db);
+		{
+			final DirCacheBuilder b = treeB.builder();
+			final DirCacheBuilder o = treeO.builder();
+			final DirCacheBuilder t = treeT.builder();
+
+			b.add(makeEntry("d/o", FileMode.REGULAR_FILE));
+			b.add(makeEntry("d/t", FileMode.REGULAR_FILE));
+
+			o.add(makeEntry("d/o", FileMode.REGULAR_FILE));
+			o.add(makeEntry("d/t", FileMode.REGULAR_FILE, "o !"));
+
+			t.add(makeEntry("d", FileMode.REGULAR_FILE));
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
+		assertFalse(merge);
+	}
+
+	public void testTrivialTwoWay_leftDFconflict2() throws Exception {
+		final DirCache treeB = DirCache.read(db);
+		final DirCache treeO = DirCache.read(db);
+		final DirCache treeT = DirCache.read(db);
+		{
+			final DirCacheBuilder b = treeB.builder();
+			final DirCacheBuilder o = treeO.builder();
+			final DirCacheBuilder t = treeT.builder();
+
+			b.add(makeEntry("d", FileMode.REGULAR_FILE));
+
+			o.add(makeEntry("d", FileMode.REGULAR_FILE, "o !"));
+
+			t.add(makeEntry("d/o", FileMode.REGULAR_FILE));
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
+		assertFalse(merge);
+	}
+
+	public void testTrivialTwoWay_rightDFconflict2() throws Exception {
+		final DirCache treeB = DirCache.read(db);
+		final DirCache treeO = DirCache.read(db);
+		final DirCache treeT = DirCache.read(db);
+		{
+			final DirCacheBuilder b = treeB.builder();
+			final DirCacheBuilder o = treeO.builder();
+			final DirCacheBuilder t = treeT.builder();
+
+			b.add(makeEntry("d", FileMode.REGULAR_FILE));
+
+			o.add(makeEntry("d/o", FileMode.REGULAR_FILE));
+
+			t.add(makeEntry("d", FileMode.REGULAR_FILE, "t !"));
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
+		assertFalse(merge);
+	}
+
 	private void assertCorrectId(final DirCache treeT, final TreeWalk tw) {
 		assertEquals(treeT.getEntry(tw.getPathString()).getObjectId(), tw
 				.getObjectId(0));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
index 0f8b4e1..3ebe397 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
@@ -115,7 +115,7 @@ protected boolean mergeImpl() throws IOException {
 				final int modeO = tw.getRawMode(T_OURS);
 				final int modeT = tw.getRawMode(T_THEIRS);
 				if (modeO == modeT && tw.idEqual(T_OURS, T_THEIRS)) {
-					same();
+					add(T_OURS, DirCacheEntry.STAGE_0);
 					continue;
 				}
 
@@ -124,8 +124,24 @@ protected boolean mergeImpl() throws IOException {
 					add(T_THEIRS, DirCacheEntry.STAGE_0);
 				else if (modeB == modeT && tw.idEqual(T_BASE, T_THEIRS))
 					add(T_OURS, DirCacheEntry.STAGE_0);
-				else {
-					conflict();
+				else if (tw.isSubtree()) {
+					if (nonTree(modeB)) {
+						add(T_BASE, DirCacheEntry.STAGE_1);
+						hasConflict = true;
+					}
+					if (nonTree(modeO)) {
+						add(T_OURS, DirCacheEntry.STAGE_2);
+						hasConflict = true;
+					}
+					if (nonTree(modeT)) {
+						add(T_THEIRS, DirCacheEntry.STAGE_3);
+						hasConflict = true;
+					}
+					tw.enterSubtree();
+				} else {
+					add(T_BASE, DirCacheEntry.STAGE_1);
+					add(T_OURS, DirCacheEntry.STAGE_2);
+					add(T_THEIRS, DirCacheEntry.STAGE_3);
 					hasConflict = true;
 				}
 			}
@@ -143,14 +159,8 @@ else if (modeB == modeT && tw.idEqual(T_BASE, T_THEIRS))
 			}
 		}
 
-		private void same() throws IOException {
-			add(T_OURS, DirCacheEntry.STAGE_0);
-		}
-
-		private void conflict() throws IOException {
-			add(T_BASE, DirCacheEntry.STAGE_1);
-			add(T_OURS, DirCacheEntry.STAGE_2);
-			add(T_THEIRS, DirCacheEntry.STAGE_3);
+		private static boolean nonTree(final int mode) {
+			return mode != 0 && !FileMode.TREE.equals(mode);
 		}
 
 		private void add(final int tree, final int stage) throws IOException {
-- 
1.6.2.96.gc65e7
