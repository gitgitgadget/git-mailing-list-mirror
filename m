From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/12] Add tests for ObjectWalk
Date: Tue, 17 Mar 2009 18:40:49 -0700
Message-ID: <1237340451-31562-11-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
 <1237340451-31562-2-git-send-email-spearce@spearce.org>
 <1237340451-31562-3-git-send-email-spearce@spearce.org>
 <1237340451-31562-4-git-send-email-spearce@spearce.org>
 <1237340451-31562-5-git-send-email-spearce@spearce.org>
 <1237340451-31562-6-git-send-email-spearce@spearce.org>
 <1237340451-31562-7-git-send-email-spearce@spearce.org>
 <1237340451-31562-8-git-send-email-spearce@spearce.org>
 <1237340451-31562-9-git-send-email-spearce@spearce.org>
 <1237340451-31562-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpS-00052N-91
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbZCRBli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756818AbZCRBlg
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:36 -0400
Received: from george.spearce.org ([209.20.77.23]:56677 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756732AbZCRBlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:41:31 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C7D1D38268; Wed, 18 Mar 2009 01:41:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 02CF038269;
	Wed, 18 Mar 2009 01:40:54 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113559>

This covers most of the common operations in an ObjectWalk, such
as culling off a common base and any trees reachable from that
common base.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/ObjectWalkTest.java   |  190 ++++++++++++++++++++
 .../org/spearce/jgit/revwalk/RevWalkTestCase.java  |   64 +++++++-
 2 files changed, 251 insertions(+), 3 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/ObjectWalkTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/ObjectWalkTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/ObjectWalkTest.java
new file mode 100644
index 0000000..86f4277
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/ObjectWalkTest.java
@@ -0,0 +1,190 @@
+/*
+ * Copyright (C) 2009, Google Inc.
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
+package org.spearce.jgit.revwalk;
+
+public class ObjectWalkTest extends RevWalkTestCase {
+	protected ObjectWalk objw;
+
+	protected RevWalk createRevWalk() {
+		return objw = new ObjectWalk(db);
+	}
+
+	public void testNoCommits() throws Exception {
+		assertNull(objw.next());
+		assertNull(objw.nextObject());
+	}
+
+	public void testTwoCommitsEmptyTree() throws Exception {
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		markStart(b);
+
+		assertCommit(b, objw.next());
+		assertCommit(a, objw.next());
+		assertNull(objw.next());
+
+		assertSame(emptyTree, objw.nextObject());
+		assertNull(objw.nextObject());
+	}
+
+	public void testOneCommitOneTreeTwoBlob() throws Exception {
+		final RevBlob f0 = blob("0");
+		final RevBlob f1 = blob("1");
+		final RevTree t = tree(file("0", f0), file("1", f1), file("2", f1));
+		final RevCommit a = commit(t);
+		markStart(a);
+
+		assertCommit(a, objw.next());
+		assertNull(objw.next());
+
+		assertSame(t, objw.nextObject());
+		assertSame(f0, objw.nextObject());
+		assertSame(f1, objw.nextObject());
+		assertNull(objw.nextObject());
+	}
+
+	public void testTwoCommitTwoTreeTwoBlob() throws Exception {
+		final RevBlob f0 = blob("0");
+		final RevBlob f1 = blob("1");
+		final RevBlob f2 = blob("0v2");
+		final RevTree ta = tree(file("0", f0), file("1", f1), file("2", f1));
+		final RevTree tb = tree(file("0", f2), file("1", f1), file("2", f1));
+		final RevCommit a = commit(ta);
+		final RevCommit b = commit(tb, a);
+		markStart(b);
+
+		assertCommit(b, objw.next());
+		assertCommit(a, objw.next());
+		assertNull(objw.next());
+
+		assertSame(tb, objw.nextObject());
+		assertSame(f2, objw.nextObject());
+		assertSame(f1, objw.nextObject());
+
+		assertSame(ta, objw.nextObject());
+		assertSame(f0, objw.nextObject());
+
+		assertNull(objw.nextObject());
+	}
+
+	public void testTwoCommitDeepTree1() throws Exception {
+		final RevBlob f0 = blob("0");
+		final RevBlob f1 = blob("0v2");
+		final RevTree ta = tree(file("a/b/0", f0));
+		final RevTree tb = tree(file("a/b/1", f1));
+		final RevCommit a = commit(ta);
+		final RevCommit b = commit(tb, a);
+		markStart(b);
+
+		assertCommit(b, objw.next());
+		assertCommit(a, objw.next());
+		assertNull(objw.next());
+
+		assertSame(tb, objw.nextObject());
+		assertSame(get(tb, "a"), objw.nextObject());
+		assertSame(get(tb, "a/b"), objw.nextObject());
+		assertSame(f1, objw.nextObject());
+
+		assertSame(ta, objw.nextObject());
+		assertSame(get(ta, "a"), objw.nextObject());
+		assertSame(get(ta, "a/b"), objw.nextObject());
+		assertSame(f0, objw.nextObject());
+
+		assertNull(objw.nextObject());
+	}
+
+	public void testTwoCommitDeepTree2() throws Exception {
+		final RevBlob f1 = blob("1");
+		final RevTree ta = tree(file("a/b/0", f1), file("a/c/q", f1));
+		final RevTree tb = tree(file("a/b/1", f1), file("a/c/q", f1));
+		final RevCommit a = commit(ta);
+		final RevCommit b = commit(tb, a);
+		markStart(b);
+
+		assertCommit(b, objw.next());
+		assertCommit(a, objw.next());
+		assertNull(objw.next());
+
+		assertSame(tb, objw.nextObject());
+		assertSame(get(tb, "a"), objw.nextObject());
+		assertSame(get(tb, "a/b"), objw.nextObject());
+		assertSame(f1, objw.nextObject());
+		assertSame(get(tb, "a/c"), objw.nextObject());
+
+		assertSame(ta, objw.nextObject());
+		assertSame(get(ta, "a"), objw.nextObject());
+		assertSame(get(ta, "a/b"), objw.nextObject());
+
+		assertNull(objw.nextObject());
+	}
+
+	public void testCull() throws Exception {
+		final RevBlob f1 = blob("1");
+		final RevBlob f2 = blob("2");
+		final RevBlob f3 = blob("3");
+		final RevBlob f4 = blob("4");
+
+		final RevTree ta = tree(file("a/1", f1), file("c/3", f3));
+		final RevCommit a = commit(ta);
+
+		final RevTree tb = tree(file("a/1", f2), file("c/3", f3));
+		final RevCommit b1 = commit(tb, a);
+		final RevCommit b2 = commit(tb, b1);
+
+		final RevTree tc = tree(file("a/1", f4));
+		final RevCommit c1 = commit(tc, a);
+		final RevCommit c2 = commit(tc, c1);
+
+		markStart(b2);
+		markUninteresting(c2);
+
+		assertCommit(b2, objw.next());
+		assertCommit(b1, objw.next());
+		assertNull(objw.next());
+
+		assertTrue(a.has(RevFlag.UNINTERESTING));
+		assertTrue(ta.has(RevFlag.UNINTERESTING));
+		assertTrue(f1.has(RevFlag.UNINTERESTING));
+		assertTrue(f3.has(RevFlag.UNINTERESTING));
+
+		assertSame(tb, objw.nextObject());
+		assertSame(get(tb, "a"), objw.nextObject());
+		assertSame(f2, objw.nextObject());
+		assertNull(objw.nextObject());
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
index 501aa13..0a1e7b8 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
@@ -37,15 +37,23 @@
 
 package org.spearce.jgit.revwalk;
 
+import java.util.Collections;
 import java.util.Date;
 
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheBuilder;
+import org.spearce.jgit.dircache.DirCacheEntry;
 import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ObjectWriter;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.RepositoryTestCase;
 import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.lib.Tree;
+import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.filter.PathFilterGroup;
 
 /** Support for tests of the {@link RevWalk} class. */
 public abstract class RevWalkTestCase extends RepositoryTestCase {
@@ -60,11 +68,15 @@
 	public void setUp() throws Exception {
 		super.setUp();
 		ow = new ObjectWriter(db);
-		rw = new RevWalk(db);
+		rw = createRevWalk();
 		emptyTree = rw.parseTree(ow.writeTree(new Tree(db)));
 		nowTick = 1236977987000L;
 	}
 
+	protected RevWalk createRevWalk() {
+		return new RevWalk(db);
+	}
+
 	protected void tick(final int secDelta) {
 		nowTick += secDelta * 1000L;
 	}
@@ -74,15 +86,61 @@ protected RevBlob blob(final String content) throws Exception {
 				.getBytes(Constants.CHARACTER_ENCODING)));
 	}
 
+	protected DirCacheEntry file(final String path, final RevBlob blob)
+			throws Exception {
+		final DirCacheEntry e = new DirCacheEntry(path);
+		e.setFileMode(FileMode.REGULAR_FILE);
+		e.setObjectId(blob);
+		return e;
+	}
+
+	protected RevTree tree(final DirCacheEntry... entries) throws Exception {
+		final DirCache dc = DirCache.newInCore();
+		final DirCacheBuilder b = dc.builder();
+		for (final DirCacheEntry e : entries)
+			b.add(e);
+		b.finish();
+		return rw.lookupTree(dc.writeTree(ow));
+	}
+
+	protected RevObject get(final RevTree tree, final String path)
+			throws Exception {
+		final TreeWalk tw = new TreeWalk(db);
+		tw.setFilter(PathFilterGroup.createFromStrings(Collections
+				.singleton(path)));
+		tw.reset(tree);
+		while (tw.next()) {
+			if (tw.isSubtree() && !path.equals(tw.getPathString())) {
+				tw.enterSubtree();
+				continue;
+			}
+			final ObjectId entid = tw.getObjectId(0);
+			final FileMode entmode = tw.getFileMode(0);
+			return rw.lookupAny(entid, entmode.getObjectType());
+		}
+		fail("Can't find " + path + " in tree " + tree.name());
+		return null; // never reached.
+	}
+
 	protected RevCommit commit(final RevCommit... parents) throws Exception {
-		return commit(1, parents);
+		return commit(1, emptyTree, parents);
+	}
+
+	protected RevCommit commit(final RevTree tree, final RevCommit... parents)
+			throws Exception {
+		return commit(1, tree, parents);
 	}
 
 	protected RevCommit commit(final int secDelta, final RevCommit... parents)
 			throws Exception {
+		return commit(secDelta, emptyTree, parents);
+	}
+
+	protected RevCommit commit(final int secDelta, final RevTree tree,
+			final RevCommit... parents) throws Exception {
 		tick(secDelta);
 		final Commit c = new Commit(db);
-		c.setTreeId(emptyTree);
+		c.setTreeId(tree);
 		c.setParentIds(parents);
 		c.setAuthor(new PersonIdent(jauthor, new Date(nowTick)));
 		c.setCommitter(new PersonIdent(jcommitter, new Date(nowTick)));
-- 
1.6.2.1.286.g8173
