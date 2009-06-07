From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Fix CanonicalTreeParser.back to parse all trees correctly
Date: Sun,  7 Jun 2009 15:01:56 -0700
Message-ID: <1244412116-13294-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 00:02:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQRX-0001it-Oq
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 00:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbZFGWB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 18:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbZFGWB4
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 18:01:56 -0400
Received: from george.spearce.org ([209.20.77.23]:51627 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbZFGWBz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 18:01:55 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C95E7381D6; Sun,  7 Jun 2009 22:01:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D6262381D6;
	Sun,  7 Jun 2009 22:01:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.322.g117de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121012>

The back(int delta) method needs to walk backwards delta entries in
the tree we are iterating.  Unfortunately, despite my attempts to do
so, there is no reliable way to parse a canonical tree in reverse.

New test cases testBackwords_Prebuilts1 and testBackwords_Prebuilts2
show trees where the parser silently fails and jumps over an entry
it should not have skipped.  These came from real world trees that
caused NameConflictTreeWalk to get stuck in an infinite loop.

The only reliable way to parse a canonical tree backwards is to
actually do a parse from the beginning, and keeping track of the N
prior positions in the tree, until we reach the current position,
and then use the 0th index from that temporary N position buffer.

Most of the time, we only need to walk a parser back 1 entry, to
examine the last path name it produced, before deciding we don't
need to handle a D/F conflict, and walk the parser forward again.

This is typical because most Git trees do not have a potential D/F
conflict looming during a NameConflictTreeWalk, as it is rare that
tree entries have the same leading base name such that a directory
could appear between two files.  Usually stepping back just one
entry is sufficient to detemine a D/F conflict can't happen, and
the parser runs forward again.  So we optimize for this delta = 1
case by saving a prevPtr field.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I should have listened to Dscho.  Last fall during GitTogether '08
 he argued you can't walk a tree backwards.  He was right.  :-)

 .../jgit/treewalk/CanonicalTreeParserTest.java     |   78 ++++++++++++++++++-
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |   74 +++++++++---------
 2 files changed, 110 insertions(+), 42 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java
index ed3478c..8ab2fc9 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/CanonicalTreeParserTest.java
@@ -71,13 +71,13 @@
 	public void setUp() throws Exception {
 		super.setUp();
 
-		tree1 = mkree(entry(m644, "a", hash_a));
-		tree2 = mkree(entry(m644, "a", hash_a), entry(m644, "foo", hash_foo));
-		tree3 = mkree(entry(m644, "a", hash_a), entry(mt, "b_sometree",
+		tree1 = mktree(entry(m644, "a", hash_a));
+		tree2 = mktree(entry(m644, "a", hash_a), entry(m644, "foo", hash_foo));
+		tree3 = mktree(entry(m644, "a", hash_a), entry(mt, "b_sometree",
 				hash_sometree), entry(m644, "foo", hash_foo));
 	}
 
-	private static byte[] mkree(final byte[]... data) throws Exception {
+	private static byte[] mktree(final byte[]... data) throws Exception {
 		final ByteArrayOutputStream out = new ByteArrayOutputStream();
 		for (final byte[] e : data)
 			out.write(e);
@@ -247,7 +247,7 @@ public void testThreeEntries_BackwardsTwo() throws Exception {
 
 	public void testBackwards_ConfusingPathName() throws Exception {
 		final String aVeryConfusingName = "confusing 644 entry 755 and others";
-		ctp.reset(mkree(entry(m644, "a", hash_a), entry(mt, aVeryConfusingName,
+		ctp.reset(mktree(entry(m644, "a", hash_a), entry(mt, aVeryConfusingName,
 				hash_sometree), entry(m644, "foo", hash_foo)));
 		ctp.next(3);
 		assertTrue(ctp.eof());
@@ -265,6 +265,74 @@ public void testBackwards_ConfusingPathName() throws Exception {
 		assertEquals(hash_a, ctp.getEntryObjectId());
 	}
 
+	public void testBackwords_Prebuilts1() throws Exception {
+		// What is interesting about this test is the ObjectId for the
+		// "darwin-x86" path entry ends in an octal digit (37 == '7').
+		// Thus when scanning backwards we could over scan and consume
+		// part of the SHA-1, and miss the path terminator.
+		//
+		final ObjectId common = ObjectId
+				.fromString("af7bf97cb9bce3f60f1d651a0ef862e9447dd8bc");
+		final ObjectId darwinx86 = ObjectId
+				.fromString("e927f7398240f78face99e1a738dac54ef738e37");
+		final ObjectId linuxx86 = ObjectId
+				.fromString("ac08dd97120c7cb7d06e98cd5b152011183baf21");
+		final ObjectId windows = ObjectId
+				.fromString("6c4c64c221a022bb973165192cca4812033479df");
+
+		ctp.reset(mktree(entry(mt, "common", common), entry(mt, "darwin-x86",
+				darwinx86), entry(mt, "linux-x86", linuxx86), entry(mt,
+				"windows", windows)));
+		ctp.next(3);
+		assertEquals("windows", ctp.getEntryPathString());
+		assertSame(mt, ctp.getEntryFileMode());
+		assertEquals(windows, ctp.getEntryObjectId());
+
+		ctp.back(1);
+		assertEquals("linux-x86", ctp.getEntryPathString());
+		assertSame(mt, ctp.getEntryFileMode());
+		assertEquals(linuxx86, ctp.getEntryObjectId());
+
+		ctp.next(1);
+		assertEquals("windows", ctp.getEntryPathString());
+		assertSame(mt, ctp.getEntryFileMode());
+		assertEquals(windows, ctp.getEntryObjectId());
+	}
+
+	public void testBackwords_Prebuilts2() throws Exception {
+		// What is interesting about this test is the ObjectId for the
+		// "darwin-x86" path entry ends in an octal digit (37 == '7').
+		// Thus when scanning backwards we could over scan and consume
+		// part of the SHA-1, and miss the path terminator.
+		//
+		final ObjectId common = ObjectId
+				.fromString("af7bf97cb9bce3f60f1d651a0ef862e9447dd8bc");
+		final ObjectId darwinx86 = ObjectId
+				.fromString("0000000000000000000000000000000000000037");
+		final ObjectId linuxx86 = ObjectId
+				.fromString("ac08dd97120c7cb7d06e98cd5b152011183baf21");
+		final ObjectId windows = ObjectId
+				.fromString("6c4c64c221a022bb973165192cca4812033479df");
+
+		ctp.reset(mktree(entry(mt, "common", common), entry(mt, "darwin-x86",
+				darwinx86), entry(mt, "linux-x86", linuxx86), entry(mt,
+				"windows", windows)));
+		ctp.next(3);
+		assertEquals("windows", ctp.getEntryPathString());
+		assertSame(mt, ctp.getEntryFileMode());
+		assertEquals(windows, ctp.getEntryObjectId());
+
+		ctp.back(1);
+		assertEquals("linux-x86", ctp.getEntryPathString());
+		assertSame(mt, ctp.getEntryFileMode());
+		assertEquals(linuxx86, ctp.getEntryObjectId());
+
+		ctp.next(1);
+		assertEquals("windows", ctp.getEntryPathString());
+		assertSame(mt, ctp.getEntryFileMode());
+		assertEquals(windows, ctp.getEntryObjectId());
+	}
+
 	public void testFreakingHugePathName() throws Exception {
 		final int n = AbstractTreeIterator.DEFAULT_PATH_SIZE * 4;
 		final StringBuilder b = new StringBuilder(n);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index ec1cf10..47c3a77 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -38,6 +38,7 @@
 package org.spearce.jgit.treewalk;
 
 import java.io.IOException;
+import java.util.Arrays;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
@@ -56,15 +57,18 @@
 
 	private byte[] raw;
 
+	/** First offset within {@link #raw} of the prior entry. */
+	private int prevPtr;
+
 	/** First offset within {@link #raw} of the current entry's data. */
 	private int currPtr;
 
-	/** Offset one past the current entry (first byte of next entry. */
+	/** Offset one past the current entry (first byte of next entry). */
 	private int nextPtr;
 
 	/** Create a new parser. */
 	public CanonicalTreeParser() {
-		raw = EMPTY;
+		reset(EMPTY);
 	}
 
 	/**
@@ -109,6 +113,7 @@ private CanonicalTreeParser(final CanonicalTreeParser p) {
 	 */
 	public void reset(final byte[] treeData) {
 		raw = treeData;
+		prevPtr = -1;
 		currPtr = 0;
 		if (!eof())
 			parseEntry();
@@ -265,6 +270,7 @@ public void next(int delta) {
 		if (delta == 1) {
 			// Moving forward one is the most common case.
 			//
+			prevPtr = currPtr;
 			currPtr = nextPtr;
 			if (!eof())
 				parseEntry();
@@ -276,6 +282,7 @@ public void next(int delta) {
 		final int end = raw.length;
 		int ptr = nextPtr;
 		while (--delta > 0 && ptr != end) {
+			prevPtr = ptr;
 			while (raw[ptr] != 0)
 				ptr++;
 			ptr += Constants.OBJECT_ID_LENGTH + 1;
@@ -289,44 +296,37 @@ public void next(int delta) {
 
 	@Override
 	public void back(int delta) {
-		int ptr = currPtr;
-		while (--delta >= 0) {
-			if (ptr == 0)
-				throw new ArrayIndexOutOfBoundsException(delta);
-
-			// Rewind back beyond the id and the null byte. Find the
-			// last space, this _might_ be the split between the mode
-			// and the path. Most paths in most trees do not contain a
-			// space so this prunes our search more quickly.
+		if (delta == 1 && 0 <= prevPtr) {
+			// Moving back one is common in NameTreeWalk, as the average tree
+			// won't have D/F type conflicts to study.
 			//
-			ptr -= Constants.OBJECT_ID_LENGTH;
-			while (raw[--ptr] != ' ') {
-				/* nothing */
-			}
-			if (--ptr < Constants.OBJECT_ID_LENGTH) {
-				if (delta != 0)
-					throw new ArrayIndexOutOfBoundsException(delta);
-				ptr = 0;
-				break;
-			}
+			currPtr = prevPtr;
+			prevPtr = -1;
+			if (!eof())
+				parseEntry();
+			return;
+		} else if (delta <= 0)
+			throw new ArrayIndexOutOfBoundsException(delta);
 
-			// Locate a position that matches "\0.{20}[0-7]" such that
-			// the ptr will rest on the [0-7]. This must be the first
-			// byte of the mode. This search works because the path in
-			// the prior record must have a non-zero length and must not
-			// contain a null byte.
-			//
-			for (int n;; ptr = n) {
-				n = ptr - 1;
-				final byte b = raw[n];
-				if ('0' <= b && b <= '7')
-					continue;
-				if (raw[n - Constants.OBJECT_ID_LENGTH] != 0)
-					continue;
-				break;
-			}
+		// Fast skip through the records, from the beginning of the tree.
+		// There is no reliable way to read the tree backwards, so we must
+		// parse all over again from the beginning. We hold the last "delta"
+		// positions in a buffer, so we can find the correct position later.
+		//
+		final int[] trace = new int[delta + 1];
+		Arrays.fill(trace, -1);
+		int ptr = 0;
+		while (ptr != currPtr) {
+			System.arraycopy(trace, 1, trace, 0, delta);
+			trace[delta] = ptr;
+			while (raw[ptr] != 0)
+				ptr++;
+			ptr += Constants.OBJECT_ID_LENGTH + 1;
 		}
-		currPtr = ptr;
+		if (trace[1] == -1)
+			throw new ArrayIndexOutOfBoundsException(delta);
+		prevPtr = trace[0];
+		currPtr = trace[1];
 		parseEntry();
 	}
 
-- 
1.6.3.2.322.g117de
