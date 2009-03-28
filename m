From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Add cherry picking and revert support to JGit
Date: Fri, 27 Mar 2009 19:53:52 -0700
Message-ID: <1238208832-29427-2-git-send-email-spearce@spearce.org>
References: <1238208832-29427-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 03:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnOiM-0005sK-Gn
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 03:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760547AbZC1CyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 22:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758104AbZC1Cx6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 22:53:58 -0400
Received: from george.spearce.org ([209.20.77.23]:55151 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760429AbZC1Cx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 22:53:56 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id F0A0A38215; Sat, 28 Mar 2009 02:53:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2AED738211;
	Sat, 28 Mar 2009 02:53:53 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.471.g682837
In-Reply-To: <1238208832-29427-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114933>

A cherry-pick can be performed by a 3 way merge, where the base is
the parent of the commit you are cherry-picking, instead of using
the derived base from the commit graph.

By allowing the caller of a ThreeWayMerger to set the merge base
prior to invoking the merge method, we allow the caller to direct
us to execute a cherry-pick, or a revert.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/merge/CherryPickTest.java |  149 ++++++++++++++++++++
 .../src/org/spearce/jgit/merge/Merger.java         |   18 +++-
 .../jgit/merge/StrategySimpleTwoWayInCore.java     |    2 +-
 .../src/org/spearce/jgit/merge/ThreeWayMerger.java |   41 ++++++
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |    2 +-
 5 files changed, 209 insertions(+), 3 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/merge/CherryPickTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/merge/CherryPickTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/CherryPickTest.java
new file mode 100644
index 0000000..78a5553
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/CherryPickTest.java
@@ -0,0 +1,149 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ * Copyright (C) 2008, Robin Rosenberg
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
+package org.spearce.jgit.merge;
+
+import java.io.ByteArrayInputStream;
+
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheBuilder;
+import org.spearce.jgit.dircache.DirCacheEntry;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectWriter;
+import org.spearce.jgit.lib.PersonIdent;
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.treewalk.TreeWalk;
+
+public class CherryPickTest extends RepositoryTestCase {
+	public void testPick() throws Exception {
+		// B---O
+		// \----P---T
+		//
+		// Cherry-pick "T" onto "O". This shouldn't introduce "p-fail", which
+		// was created by "P", nor should it modify "a", which was done by "P".
+		//
+		final DirCache treeB = DirCache.read(db);
+		final DirCache treeO = DirCache.read(db);
+		final DirCache treeP = DirCache.read(db);
+		final DirCache treeT = DirCache.read(db);
+		{
+			final DirCacheBuilder b = treeB.builder();
+			final DirCacheBuilder o = treeO.builder();
+			final DirCacheBuilder p = treeP.builder();
+			final DirCacheBuilder t = treeT.builder();
+
+			b.add(makeEntry("a", FileMode.REGULAR_FILE));
+
+			o.add(makeEntry("a", FileMode.REGULAR_FILE));
+			o.add(makeEntry("o", FileMode.REGULAR_FILE));
+
+			p.add(makeEntry("a", FileMode.REGULAR_FILE, "q"));
+			p.add(makeEntry("p-fail", FileMode.REGULAR_FILE));
+
+			t.add(makeEntry("a", FileMode.REGULAR_FILE));
+			t.add(makeEntry("t", FileMode.REGULAR_FILE));
+
+			b.finish();
+			o.finish();
+			p.finish();
+			t.finish();
+		}
+
+		final ObjectWriter ow = new ObjectWriter(db);
+		final ObjectId B = commit(ow, treeB, new ObjectId[] {});
+		final ObjectId O = commit(ow, treeO, new ObjectId[] { B });
+		final ObjectId P = commit(ow, treeP, new ObjectId[] { B });
+		final ObjectId T = commit(ow, treeT, new ObjectId[] { P });
+
+		ThreeWayMerger twm = MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(db);
+		twm.setBase(P);
+		boolean merge = twm.merge(new ObjectId[] { O, T });
+		assertTrue(merge);
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.setRecursive(true);
+		tw.reset(twm.getResultTreeId());
+
+		assertTrue(tw.next());
+		assertEquals("a", tw.getPathString());
+		assertCorrectId(treeO, tw);
+
+		assertTrue(tw.next());
+		assertEquals("o", tw.getPathString());
+		assertCorrectId(treeO, tw);
+
+		assertTrue(tw.next());
+		assertEquals("t", tw.getPathString());
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
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java b/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
index db3e329..2d5d44f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
@@ -179,9 +179,25 @@ protected AbstractTreeIterator mergeBase(final int aIdx, final int bIdx)
 					+ sourceCommits[bIdx].name() + "found:" + "\n  "
 					+ base.name() + "\n  " + base2.name());
 		}
+		return openTree(base.getTree());
+	}
+
+	/**
+	 * Open an iterator over a tree.
+	 * 
+	 * @param treeId
+	 *            the tree to scan; must be a tree (not a treeish).
+	 * @return an iterator for the tree.
+	 * @throws IncorrectObjectTypeException
+	 *             the input object is not a tree.
+	 * @throws IOException
+	 *             the tree object is not found or cannot be read.
+	 */
+	protected AbstractTreeIterator openTree(final AnyObjectId treeId)
+			throws IncorrectObjectTypeException, IOException {
 		final WindowCursor curs = new WindowCursor();
 		try {
-			return new CanonicalTreeParser(null, db, base.getTree(), curs);
+			return new CanonicalTreeParser(null, db, treeId, curs);
 		} finally {
 			curs.release();
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
index 9807644..5d4447c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
@@ -102,7 +102,7 @@ InCoreMerger(final Repository local) {
 		@Override
 		protected boolean mergeImpl() throws IOException {
 			tw.reset();
-			tw.addTree(mergeBase(0, 1));
+			tw.addTree(mergeBase());
 			tw.addTree(sourceTrees[0]);
 			tw.addTree(sourceTrees[1]);
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMerger.java b/org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMerger.java
index 9d1621d..6f041c1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMerger.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMerger.java
@@ -40,11 +40,16 @@
 import java.io.IOException;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.revwalk.RevTree;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
 
 /** A merge of 2 trees, using a common base ancestor tree. */
 public abstract class ThreeWayMerger extends Merger {
+	private RevTree baseTree;
+
 	/**
 	 * Create a new merge instance for a repository.
 	 * 
@@ -56,6 +61,29 @@ protected ThreeWayMerger(final Repository local) {
 	}
 
 	/**
+	 * Set the common ancestor tree.
+	 * 
+	 * @param id
+	 *            common base treeish; null to automatically compute the common
+	 *            base from the input commits during
+	 *            {@link #merge(AnyObjectId, AnyObjectId)}.
+	 * @throws IncorrectObjectTypeException
+	 *             the object is not a treeish.
+	 * @throws MissingObjectException
+	 *             the object does not exist.
+	 * @throws IOException
+	 *             the object could not be read.
+	 */
+	public void setBase(final AnyObjectId id) throws MissingObjectException,
+			IncorrectObjectTypeException, IOException {
+		if (id != null) {
+			baseTree = walk.parseTree(id);
+		} else {
+			baseTree = null;
+		}
+	}
+
+	/**
 	 * Merge together two tree-ish objects.
 	 * <p>
 	 * Any tree-ish may be supplied as inputs. Commits and/or tags pointing at
@@ -86,4 +114,17 @@ public boolean merge(final AnyObjectId[] tips) throws IOException {
 			return false;
 		return super.merge(tips);
 	}
+
+	/**
+	 * Create an iterator to walk the merge base.
+	 * 
+	 * @return an iterator over the caller-specified merge base, or the natural
+	 *         merge base of the two input commits.
+	 * @throws IOException
+	 */
+	protected AbstractTreeIterator mergeBase() throws IOException {
+		if (baseTree != null)
+			return openTree(baseTree);
+		return mergeBase(0, 1);
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index 7f89cff..ec1cf10 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -91,7 +91,7 @@ public CanonicalTreeParser() {
 	 *             a loose object or pack file could not be read.
 	 */
 	public CanonicalTreeParser(final byte[] prefix, final Repository repo,
-			final ObjectId treeId, final WindowCursor curs)
+			final AnyObjectId treeId, final WindowCursor curs)
 			throws IncorrectObjectTypeException, IOException {
 		super(prefix);
 		reset(repo, treeId, curs);
-- 
1.6.2.1.471.g682837
