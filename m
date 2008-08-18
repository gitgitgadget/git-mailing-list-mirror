From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/14] Make all AbstractTreeIterator implementations bi-directional
Date: Mon, 18 Aug 2008 16:53:18 -0700
Message-ID: <1219103602-32222-11-git-send-email-spearce@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
 <1219103602-32222-3-git-send-email-spearce@spearce.org>
 <1219103602-32222-4-git-send-email-spearce@spearce.org>
 <1219103602-32222-5-git-send-email-spearce@spearce.org>
 <1219103602-32222-6-git-send-email-spearce@spearce.org>
 <1219103602-32222-7-git-send-email-spearce@spearce.org>
 <1219103602-32222-8-git-send-email-spearce@spearce.org>
 <1219103602-32222-9-git-send-email-spearce@spearce.org>
 <1219103602-32222-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZ7-0006i3-Ss
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbYHRXxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbYHRXxq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:46 -0400
Received: from george.spearce.org ([209.20.77.23]:45146 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbYHRXxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id EC93E38376; Mon, 18 Aug 2008 23:53:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A133B38379;
	Mon, 18 Aug 2008 23:53:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92778>

To support scanning ahead and then rewinding back to our prior
location we need to allow all tree iterators to be moved both
forward and backwards through their entries.  The next(int)
API replaces the simple next() by supplying the amount that
the iterator needs to move forward. A corresponding back(int)
method supplies the opposite direction of travel.

Some iterators like WorkingTreeIterator can efficiently move
foward and backwards any step because they have a direct 1:1
mapping between positions of the iterator and an array index.
Others like CanonicalTreeParser must scan through their input
buffer, but can try to reduce the work needed on larger steps
as they move past the undesired entries.  DirCacheIterator is
a challenge because it needs to match each entry up onto the
DirCacheTrees available at this level.

This API (and its implements) is really meant for peeking at
the next entry (or two) forward to see if there is a name (but
not mode) match during a TreeWalk.  This is to help TreeWalk
catch a directory/file mode conflict and report it, despite
the directory and file variants of a name appearing at two
very different positions in the trees.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/dircache/DirCacheIteratorTest.java        |    2 +-
 .../jgit/treewalk/CanonicalTreeParserTest.java     |  261 ++++++++++++++++++++
 .../jgit/dircache/DirCacheBuildIterator.java       |    2 +-
 .../spearce/jgit/dircache/DirCacheIterator.java    |   27 ++-
 .../jgit/treewalk/AbstractTreeIterator.java        |   38 +++-
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |   68 +++++-
 .../spearce/jgit/treewalk/EmptyTreeIterator.java   |    7 +-
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |    2 +-
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |   10 +-
 9 files changed, 398 insertions(+), 19 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
index 51b3c5a..047c989 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
@@ -78,7 +78,7 @@ public void testNoSubtree_NoTreeWalk() throws Exception {
 
 		final DirCacheIterator i = new DirCacheIterator(dc);
 		int pathIdx = 0;
-		for (; !i.eof(); i.next()) {
+		for (; !i.eof(); i.next(1)) {
 			assertEquals(pathIdx, i.ptr);
 			assertSame(ents[pathIdx], i.getDirCacheEntry());
 			pathIdx++;
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java
new file mode 100644
index 0000000..fd92844
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java
@@ -0,0 +1,261 @@
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
+import java.io.ByteArrayOutputStream;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.util.RawParseUtils;
+
+public class CanonicalTreeParserTest extends TestCase {
+	private final CanonicalTreeParser ctp = new CanonicalTreeParser();
+
+	private final FileMode m644 = FileMode.REGULAR_FILE;
+
+	private final FileMode mt = FileMode.TREE;
+
+	private final ObjectId hash_a = ObjectId
+			.fromString("6b9c715d21d5486e59083fb6071566aa6ecd4d42");
+
+	private final ObjectId hash_foo = ObjectId
+			.fromString("a213e8e25bb2442326e86cbfb9ef56319f482869");
+
+	private final ObjectId hash_sometree = ObjectId
+			.fromString("daf4bdb0d7bb24319810fe0e73aa317663448c93");
+
+	private byte[] tree1;
+
+	private byte[] tree2;
+
+	private byte[] tree3;
+
+	public void setUp() throws Exception {
+		super.setUp();
+
+		tree1 = mkree(entry(m644, "a", hash_a));
+		tree2 = mkree(entry(m644, "a", hash_a), entry(m644, "foo", hash_foo));
+		tree3 = mkree(entry(m644, "a", hash_a), entry(mt, "b_sometree",
+				hash_sometree), entry(m644, "foo", hash_foo));
+	}
+
+	private static byte[] mkree(final byte[]... data) throws Exception {
+		final ByteArrayOutputStream out = new ByteArrayOutputStream();
+		for (final byte[] e : data)
+			out.write(e);
+		return out.toByteArray();
+	}
+
+	private static byte[] entry(final FileMode mode, final String name,
+			final ObjectId id) throws Exception {
+		final ByteArrayOutputStream out = new ByteArrayOutputStream();
+		mode.copyTo(out);
+		out.write(' ');
+		out.write(Constants.encode(name));
+		out.write(0);
+		id.copyRawTo(out);
+		return out.toByteArray();
+	}
+
+	private String path() {
+		return RawParseUtils.decode(Constants.CHARSET, ctp.path,
+				ctp.pathOffset, ctp.pathLen);
+	}
+
+	public void testEmptyTree_AtEOF() throws Exception {
+		ctp.reset(new byte[0]);
+		assertTrue(ctp.eof());
+	}
+
+	public void testOneEntry_Forward() throws Exception {
+		ctp.reset(tree1);
+
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("a", path());
+		assertEquals(hash_a, ctp.getEntryObjectId());
+
+		ctp.next(1);
+		assertTrue(ctp.eof());
+	}
+
+	public void testTwoEntries_ForwardOneAtATime() throws Exception {
+		ctp.reset(tree2);
+
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("a", path());
+		assertEquals(hash_a, ctp.getEntryObjectId());
+
+		ctp.next(1);
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("foo", path());
+		assertEquals(hash_foo, ctp.getEntryObjectId());
+
+		ctp.next(1);
+		assertTrue(ctp.eof());
+	}
+
+	public void testOneEntry_Seek1IsEOF() throws Exception {
+		ctp.reset(tree1);
+		ctp.next(1);
+		assertTrue(ctp.eof());
+	}
+
+	public void testTwoEntries_Seek2IsEOF() throws Exception {
+		ctp.reset(tree2);
+		ctp.next(2);
+		assertTrue(ctp.eof());
+	}
+
+	public void testThreeEntries_Seek3IsEOF() throws Exception {
+		ctp.reset(tree3);
+		ctp.next(3);
+		assertTrue(ctp.eof());
+	}
+
+	public void testThreeEntries_Seek2() throws Exception {
+		ctp.reset(tree3);
+
+		ctp.next(2);
+		assertFalse(ctp.eof());
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("foo", path());
+		assertEquals(hash_foo, ctp.getEntryObjectId());
+
+		ctp.next(1);
+		assertTrue(ctp.eof());
+	}
+
+	public void testOneEntry_Backwards() throws Exception {
+		ctp.reset(tree1);
+		ctp.next(1);
+		assertTrue(ctp.eof());
+
+		ctp.back(1);
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("a", path());
+		assertEquals(hash_a, ctp.getEntryObjectId());
+	}
+
+	public void testTwoEntries_BackwardsOneAtATime() throws Exception {
+		ctp.reset(tree2);
+		ctp.next(2);
+		assertTrue(ctp.eof());
+
+		ctp.back(1);
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("foo", path());
+		assertEquals(hash_foo, ctp.getEntryObjectId());
+
+		ctp.back(1);
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("a", path());
+		assertEquals(hash_a, ctp.getEntryObjectId());
+	}
+
+	public void testTwoEntries_BackwardsTwo() throws Exception {
+		ctp.reset(tree2);
+		ctp.next(2);
+		assertTrue(ctp.eof());
+
+		ctp.back(2);
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("a", path());
+		assertEquals(hash_a, ctp.getEntryObjectId());
+
+		ctp.next(1);
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("foo", path());
+		assertEquals(hash_foo, ctp.getEntryObjectId());
+
+		ctp.next(1);
+		assertTrue(ctp.eof());
+	}
+
+	public void testThreeEntries_BackwardsTwo() throws Exception {
+		ctp.reset(tree3);
+		ctp.next(3);
+		assertTrue(ctp.eof());
+
+		ctp.back(2);
+		assertFalse(ctp.eof());
+		assertEquals(mt.getBits(), ctp.mode);
+		assertEquals("b_sometree", path());
+		assertEquals(hash_sometree, ctp.getEntryObjectId());
+
+		ctp.next(1);
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("foo", path());
+		assertEquals(hash_foo, ctp.getEntryObjectId());
+
+		ctp.next(1);
+		assertTrue(ctp.eof());
+	}
+
+	public void testBackwards_ConfusingPathName() throws Exception {
+		final String aVeryConfusingName = "confusing 644 entry 755 and others";
+		ctp.reset(mkree(entry(m644, "a", hash_a), entry(mt, aVeryConfusingName,
+				hash_sometree), entry(m644, "foo", hash_foo)));
+		ctp.next(3);
+		assertTrue(ctp.eof());
+
+		ctp.back(2);
+		assertFalse(ctp.eof());
+		assertEquals(mt.getBits(), ctp.mode);
+		assertEquals(aVeryConfusingName, path());
+		assertEquals(hash_sometree, ctp.getEntryObjectId());
+
+		ctp.back(1);
+		assertFalse(ctp.eof());
+		assertEquals(m644.getBits(), ctp.mode);
+		assertEquals("a", path());
+		assertEquals(hash_a, ctp.getEntryObjectId());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
index aaec4fc..234ffd2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
@@ -112,7 +112,7 @@ public void skip() throws CorruptObjectException {
 			builder.keep(ptr, currentSubtree.getEntrySpan());
 		else
 			builder.add(currentEntry);
-		next();
+		next(1);
 	}
 
 	@Override
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
index 248ae1e..84cefa5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
@@ -144,13 +144,28 @@ public boolean eof() {
 	}
 
 	@Override
-	public void next() {
-		if (currentSubtree != null)
-			ptr += currentSubtree.getEntrySpan();
-		else
-			ptr++;
-		if (!eof())
+	public void next(int delta) {
+		while (--delta >= 0) {
+			if (currentSubtree != null)
+				ptr += currentSubtree.getEntrySpan();
+			else
+				ptr++;
+			if (eof())
+				break;
+			parseEntry();
+		}
+	}
+
+	@Override
+	public void back(int delta) {
+		while (--delta >= 0) {
+			if (currentSubtree != null)
+				nextSubtreePos--;
+			ptr--;
 			parseEntry();
+			if (currentSubtree != null)
+				ptr -= currentSubtree.getEntrySpan() - 1;
+		}
 	}
 
 	private void parseEntry() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 208adc7..8ec506c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -349,7 +349,34 @@ public abstract AbstractTreeIterator createSubtreeIterator(Repository repo)
 	public abstract boolean eof();
 
 	/**
-	 * Advance to the next tree entry, populating this iterator with its data.
+	 * Move to next entry, populating this iterator with the entry data.
+	 * <p>
+	 * The delta indicates how many moves forward should occur. The most common
+	 * delta is 1 to move to the next entry.
+	 * <p>
+	 * Implementations must populate the following members:
+	 * <ul>
+	 * <li>{@link #mode}</li>
+	 * <li>{@link #path} (from {@link #pathOffset} to {@link #pathLen})</li>
+	 * <li>{@link #pathLen}</li>
+	 * </ul>
+	 * as well as any implementation dependent information necessary to
+	 * accurately return data from {@link #idBuffer()} and {@link #idOffset()}
+	 * when demanded.
+	 * 
+	 * @param delta
+	 *            number of entries to move the iterator by. Must be a positive,
+	 *            non-zero integer.
+	 * @throws CorruptObjectException
+	 *             the tree is invalid.
+	 */
+	public abstract void next(int delta) throws CorruptObjectException;
+
+	/**
+	 * Move to prior entry, populating this iterator with the entry data.
+	 * <p>
+	 * The delta indicates how many moves backward should occur.The most common
+	 * delta is 1 to move to the prior entry.
 	 * <p>
 	 * Implementations must populate the following members:
 	 * <ul>
@@ -361,15 +388,18 @@ public abstract AbstractTreeIterator createSubtreeIterator(Repository repo)
 	 * accurately return data from {@link #idBuffer()} and {@link #idOffset()}
 	 * when demanded.
 	 * 
+	 * @param delta
+	 *            number of entries to move the iterator by. Must be a positive,
+	 *            non-zero integer.
 	 * @throws CorruptObjectException
 	 *             the tree is invalid.
 	 */
-	public abstract void next() throws CorruptObjectException;
+	public abstract void back(int delta) throws CorruptObjectException;
 
 	/**
 	 * Advance to the next tree entry, populating this iterator with its data.
 	 * <p>
-	 * This method behaves like {@link #next()} but is called by
+	 * This method behaves like <code>seek(1)</code> but is called by
 	 * {@link TreeWalk} only if a {@link TreeFilter} was used and ruled out the
 	 * current entry from the results. In such cases this tree iterator may
 	 * perform special behavior.
@@ -378,7 +408,7 @@ public abstract AbstractTreeIterator createSubtreeIterator(Repository repo)
 	 *             the tree is invalid.
 	 */
 	public void skip() throws CorruptObjectException {
-		next();
+		next(1);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index ebcc787..111d03b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -39,7 +39,6 @@
 
 import java.io.IOException;
 
-import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.Constants;
@@ -131,12 +130,75 @@ public boolean eof() {
 		return currPtr == raw.length;
 	}
 
-	public void next() throws CorruptObjectException {
-		currPtr = nextPtr;
+	@Override
+	public void next(int delta) {
+		if (delta == 1) {
+			// Moving forward one is the most common case.
+			//
+			currPtr = nextPtr;
+			if (!eof())
+				parseEntry();
+			return;
+		}
+
+		// Fast skip over records, then parse the last one.
+		//
+		final int end = raw.length;
+		int ptr = nextPtr;
+		while (--delta > 0 && ptr != end) {
+			while (raw[ptr] != 0)
+				ptr++;
+			ptr += Constants.OBJECT_ID_LENGTH + 1;
+		}
+		if (delta != 0)
+			throw new ArrayIndexOutOfBoundsException(delta);
+		currPtr = ptr;
 		if (!eof())
 			parseEntry();
 	}
 
+	@Override
+	public void back(int delta) {
+		int ptr = currPtr;
+		while (--delta >= 0) {
+			if (ptr == 0)
+				throw new ArrayIndexOutOfBoundsException(delta);
+
+			// Rewind back beyond the id and the null byte. Find the
+			// last space, this _might_ be the split between the mode
+			// and the path. Most paths in most trees do not contain a
+			// space so this prunes our search more quickly.
+			//
+			ptr -= Constants.OBJECT_ID_LENGTH;
+			while (raw[--ptr] != ' ')
+				/* nothing */;
+			if (--ptr < Constants.OBJECT_ID_LENGTH) {
+				if (delta != 0)
+					throw new ArrayIndexOutOfBoundsException(delta);
+				ptr = 0;
+				break;
+			}
+
+			// Locate a position that matches "\0.{20}[0-7]" such that
+			// the ptr will rest on the [0-7]. This must be the first
+			// byte of the mode. This search works because the path in
+			// the prior record must have a non-zero length and must not
+			// contain a null byte.
+			//
+			for (int n;; ptr = n) {
+				n = ptr - 1;
+				final byte b = raw[n];
+				if ('0' <= b && b <= '7')
+					continue;
+				if (raw[n - Constants.OBJECT_ID_LENGTH] != 0)
+					continue;
+				break;
+			}
+		}
+		currPtr = ptr;
+		parseEntry();
+	}
+
 	private void parseEntry() {
 		int ptr = currPtr;
 		byte c = raw[ptr++];
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
index c5dc4ad..232e3b1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
@@ -84,7 +84,12 @@ public boolean eof() {
 	}
 
 	@Override
-	public void next() throws CorruptObjectException {
+	public void next(final int delta) throws CorruptObjectException {
+		// Do nothing.
+	}
+
+	@Override
+	public void back(final int delta) throws CorruptObjectException {
 		// Do nothing.
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 3bdef22..10cdebd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -651,7 +651,7 @@ private void popEntriesEqual() throws CorruptObjectException {
 		for (int i = 0; i < trees.length; i++) {
 			final AbstractTreeIterator t = trees[i];
 			if (t.matches == ch) {
-				t.next();
+				t.next(1);
 				t.matches = null;
 			}
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index e81ff4a..41fd47b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -236,12 +236,18 @@ public boolean eof() {
 	}
 
 	@Override
-	public void next() throws CorruptObjectException {
-		ptr++;
+	public void next(final int delta) throws CorruptObjectException {
+		ptr += delta;
 		if (!eof())
 			parseEntry();
 	}
 
+	@Override
+	public void back(final int delta) throws CorruptObjectException {
+		ptr -= delta;
+		parseEntry();
+	}
+
 	private void parseEntry() {
 		final Entry e = entries[ptr];
 		mode = e.getMode().getBits();
-- 
1.6.0.87.g2858d
