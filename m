From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/15] Fix Patch.parse to honor the end point passed in
Date: Thu, 11 Dec 2008 18:46:17 -0800
Message-ID: <1229049981-14152-12-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
 <1229049981-14152-3-git-send-email-spearce@spearce.org>
 <1229049981-14152-4-git-send-email-spearce@spearce.org>
 <1229049981-14152-5-git-send-email-spearce@spearce.org>
 <1229049981-14152-6-git-send-email-spearce@spearce.org>
 <1229049981-14152-7-git-send-email-spearce@spearce.org>
 <1229049981-14152-8-git-send-email-spearce@spearce.org>
 <1229049981-14152-9-git-send-email-spearce@spearce.org>
 <1229049981-14152-10-git-send-email-spearce@spearce.org>
 <1229049981-14152-11-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy51-00057A-Tw
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375AbYLLCqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757420AbYLLCqv
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:51 -0500
Received: from george.spearce.org ([209.20.77.23]:41597 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757283AbYLLCqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:34 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id C3D6F3821F; Fri, 12 Dec 2008 02:46:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9F02538194;
	Fri, 12 Dec 2008 02:46:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102875>

Otherwise we may over-read the patch script and identify trailer
data as part of a patch when it was requested that we ignore it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/FileHeaderTest.java |   46 +++++++-----
 .../src/org/spearce/jgit/patch/BinaryHunk.java     |    5 +-
 .../src/org/spearce/jgit/patch/FileHeader.java     |   16 ++--
 .../src/org/spearce/jgit/patch/HunkHeader.java     |    9 +--
 .../src/org/spearce/jgit/patch/Patch.java          |   73 ++++++++++----------
 5 files changed, 77 insertions(+), 72 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
index 4c2140a..36c528e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
@@ -45,28 +45,32 @@
 public class FileHeaderTest extends TestCase {
 	public void testParseGitFileName_Empty() {
 		final FileHeader fh = data("");
-		assertEquals(-1, fh.parseGitFileName(0));
+		assertEquals(-1, fh.parseGitFileName(0, fh.buf.length));
 		assertNotNull(fh.getHunks());
 		assertTrue(fh.getHunks().isEmpty());
 		assertFalse(fh.hasMetaDataChanges());
 	}
 
 	public void testParseGitFileName_NoLF() {
-		assertEquals(-1, data("a/ b/").parseGitFileName(0));
+		final FileHeader fh = data("a/ b/");
+		assertEquals(-1, fh.parseGitFileName(0, fh.buf.length));
 	}
 
 	public void testParseGitFileName_NoSecondLine() {
-		assertEquals(-1, data("\n").parseGitFileName(0));
+		final FileHeader fh = data("\n");
+		assertEquals(-1, fh.parseGitFileName(0, fh.buf.length));
 	}
 
 	public void testParseGitFileName_EmptyHeader() {
-		assertEquals(1, data("\n\n").parseGitFileName(0));
+		final FileHeader fh = data("\n\n");
+		assertEquals(1, fh.parseGitFileName(0, fh.buf.length));
 	}
 
 	public void testParseGitFileName_Foo() {
 		final String name = "foo";
 		final FileHeader fh = header(name);
-		assertEquals(gitLine(name).length(), fh.parseGitFileName(0));
+		assertEquals(gitLine(name).length(), fh.parseGitFileName(0,
+				fh.buf.length));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
 		assertFalse(fh.hasMetaDataChanges());
@@ -74,7 +78,7 @@ public void testParseGitFileName_Foo() {
 
 	public void testParseGitFileName_FailFooBar() {
 		final FileHeader fh = data("a/foo b/bar\n-");
-		assertTrue(fh.parseGitFileName(0) > 0);
+		assertTrue(fh.parseGitFileName(0, fh.buf.length) > 0);
 		assertNull(fh.getOldName());
 		assertNull(fh.getNewName());
 		assertFalse(fh.hasMetaDataChanges());
@@ -83,7 +87,8 @@ public void testParseGitFileName_FailFooBar() {
 	public void testParseGitFileName_FooSpBar() {
 		final String name = "foo bar";
 		final FileHeader fh = header(name);
-		assertEquals(gitLine(name).length(), fh.parseGitFileName(0));
+		assertEquals(gitLine(name).length(), fh.parseGitFileName(0,
+				fh.buf.length));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
 		assertFalse(fh.hasMetaDataChanges());
@@ -93,7 +98,8 @@ public void testParseGitFileName_DqFooTabBar() {
 		final String name = "foo\tbar";
 		final String dqName = "foo\\tbar";
 		final FileHeader fh = dqHeader(dqName);
-		assertEquals(dqGitLine(dqName).length(), fh.parseGitFileName(0));
+		assertEquals(dqGitLine(dqName).length(), fh.parseGitFileName(0,
+				fh.buf.length));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
 		assertFalse(fh.hasMetaDataChanges());
@@ -103,7 +109,8 @@ public void testParseGitFileName_DqFooSpLfNulBar() {
 		final String name = "foo \n\0bar";
 		final String dqName = "foo \\n\\0bar";
 		final FileHeader fh = dqHeader(dqName);
-		assertEquals(dqGitLine(dqName).length(), fh.parseGitFileName(0));
+		assertEquals(dqGitLine(dqName).length(), fh.parseGitFileName(0,
+				fh.buf.length));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
 		assertFalse(fh.hasMetaDataChanges());
@@ -112,7 +119,8 @@ public void testParseGitFileName_DqFooSpLfNulBar() {
 	public void testParseGitFileName_SrcFooC() {
 		final String name = "src/foo/bar/argh/code.c";
 		final FileHeader fh = header(name);
-		assertEquals(gitLine(name).length(), fh.parseGitFileName(0));
+		assertEquals(gitLine(name).length(), fh.parseGitFileName(0,
+				fh.buf.length));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
 		assertFalse(fh.hasMetaDataChanges());
@@ -122,7 +130,7 @@ public void testParseGitFileName_SrcFooCNonStandardPrefix() {
 		final String name = "src/foo/bar/argh/code.c";
 		final String header = "project-v-1.0/" + name + " mydev/" + name + "\n";
 		final FileHeader fh = data(header + "-");
-		assertEquals(header.length(), fh.parseGitFileName(0));
+		assertEquals(header.length(), fh.parseGitFileName(0, fh.buf.length));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
 		assertFalse(fh.hasMetaDataChanges());
@@ -202,12 +210,12 @@ public void testParseRename100_NewStyle() {
 				+ "similarity index 100%\n"
 				+ "rename from a\n"
 				+ "rename to \" c/\\303\\205ngstr\\303\\266m\"\n");
-		int ptr = fh.parseGitFileName(0);
+		int ptr = fh.parseGitFileName(0, fh.buf.length);
 		assertTrue(ptr > 0);
 		assertNull(fh.getOldName()); // can't parse names on a rename
 		assertNull(fh.getNewName());
 
-		ptr = fh.parseGitHeaders(ptr);
+		ptr = fh.parseGitHeaders(ptr, fh.buf.length);
 		assertTrue(ptr > 0);
 
 		assertEquals("a", fh.getOldName());
@@ -231,12 +239,12 @@ public void testParseRename100_OldStyle() {
 				+ "similarity index 100%\n"
 				+ "rename old a\n"
 				+ "rename new \" c/\\303\\205ngstr\\303\\266m\"\n");
-		int ptr = fh.parseGitFileName(0);
+		int ptr = fh.parseGitFileName(0, fh.buf.length);
 		assertTrue(ptr > 0);
 		assertNull(fh.getOldName()); // can't parse names on a rename
 		assertNull(fh.getNewName());
 
-		ptr = fh.parseGitHeaders(ptr);
+		ptr = fh.parseGitHeaders(ptr, fh.buf.length);
 		assertTrue(ptr > 0);
 
 		assertEquals("a", fh.getOldName());
@@ -260,12 +268,12 @@ public void testParseCopy100() {
 				+ "similarity index 100%\n"
 				+ "copy from a\n"
 				+ "copy to \" c/\\303\\205ngstr\\303\\266m\"\n");
-		int ptr = fh.parseGitFileName(0);
+		int ptr = fh.parseGitFileName(0, fh.buf.length);
 		assertTrue(ptr > 0);
 		assertNull(fh.getOldName()); // can't parse names on a copy
 		assertNull(fh.getNewName());
 
-		ptr = fh.parseGitHeaders(ptr);
+		ptr = fh.parseGitHeaders(ptr, fh.buf.length);
 		assertTrue(ptr > 0);
 
 		assertEquals("a", fh.getOldName());
@@ -391,9 +399,9 @@ public void testParseAbbrIndexLine_NoMode() {
 	}
 
 	private static void assertParse(final FileHeader fh) {
-		int ptr = fh.parseGitFileName(0);
+		int ptr = fh.parseGitFileName(0, fh.buf.length);
 		assertTrue(ptr > 0);
-		ptr = fh.parseGitHeaders(ptr);
+		ptr = fh.parseGitHeaders(ptr, fh.buf.length);
 		assertTrue(ptr > 0);
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java b/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
index ce35286..3e07ec4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
@@ -91,7 +91,7 @@ public int getSize() {
 		return length;
 	}
 
-	int parseHunk(int ptr) {
+	int parseHunk(int ptr, final int end) {
 		final byte[] buf = file.buf;
 
 		if (match(buf, ptr, LITERAL) >= 0) {
@@ -115,8 +115,7 @@ int parseHunk(int ptr) {
 		// encoded information in this hunk. To save time we don't do a
 		// validation of the binary data at this point.
 		//
-		final int sz = buf.length;
-		while (ptr < sz) {
+		while (ptr < end) {
 			final boolean empty = buf[ptr] == '\n';
 			ptr = nextLF(buf, ptr);
 			if (empty)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index a6ff4a6..a58e978 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -291,12 +291,14 @@ public BinaryHunk getReverseBinaryHunk() {
 	 * 
 	 * @param ptr
 	 *            first character after the "diff --git " or "diff --cc " part.
+	 * @param end
+	 *            one past the last position to parse.
 	 * @return first character after the LF at the end of the line; -1 on error.
 	 */
-	int parseGitFileName(int ptr) {
+	int parseGitFileName(int ptr, final int end) {
 		final int eol = nextLF(buf, ptr);
 		final int bol = ptr;
-		if (eol >= buf.length) {
+		if (eol >= end) {
 			return -1;
 		}
 
@@ -353,9 +355,8 @@ int parseGitFileName(int ptr) {
 		return eol;
 	}
 
-	int parseGitHeaders(int ptr) {
-		final int sz = buf.length;
-		while (ptr < sz) {
+	int parseGitHeaders(int ptr, final int end) {
+		while (ptr < end) {
 			final int eol = nextLF(buf, ptr);
 			if (match(buf, ptr, HUNK_HDR) >= 0) {
 				// First hunk header; break out and parse them later.
@@ -428,9 +429,8 @@ int parseGitHeaders(int ptr) {
 		return ptr;
 	}
 
-	int parseTraditionalHeaders(int ptr) {
-		final int sz = buf.length;
-		while (ptr < sz) {
+	int parseTraditionalHeaders(int ptr, final int end) {
+		while (ptr < end) {
 			final int eol = nextLF(buf, ptr);
 			if (match(buf, ptr, HUNK_HDR) >= 0) {
 				// First hunk header; break out and parse them later.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index 20dd6e2..4fd9bae 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -119,7 +119,7 @@ public int getLinesAdded() {
 		return nAdded;
 	}
 
-	void parseHeader() {
+	void parseHeader(final int end) {
 		// Parse "@@ -236,9 +236,9 @@ protected boolean"
 		//
 		final byte[] buf = file.buf;
@@ -132,15 +132,14 @@ void parseHeader() {
 		newLineCount = parseBase10(buf, ptr.value + 1, ptr);
 	}
 
-	int parseBody(final Patch script) {
+	int parseBody(final Patch script, final int end) {
 		final byte[] buf = file.buf;
-		final int sz = buf.length;
 		int c = nextLF(buf, startOffset), last = c;
 
 		nDeleted = 0;
 		nAdded = 0;
 
-		SCAN: for (; c < sz; last = c, c = nextLF(buf, c)) {
+		SCAN: for (; c < end; last = c, c = nextLF(buf, c)) {
 			switch (buf[c]) {
 			case ' ':
 			case '\n':
@@ -163,7 +162,7 @@ int parseBody(final Patch script) {
 			}
 		}
 
-		if (last < sz && nContext + nDeleted - 1 == oldLineCount
+		if (last < end && nContext + nDeleted - 1 == oldLineCount
 				&& nContext + nAdded == newLineCount
 				&& match(buf, last, Patch.SIG_FOOTER) >= 0) {
 			// This is an extremely common occurrence of "corruption".
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 5cc208c..9aca22d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -157,12 +157,11 @@ public void parse(final InputStream is) throws IOException {
 	 */
 	public void parse(final byte[] buf, int ptr, final int end) {
 		while (ptr < end)
-			ptr = parseFile(buf, ptr);
+			ptr = parseFile(buf, ptr, end);
 	}
 
-	private int parseFile(final byte[] buf, int c) {
-		final int sz = buf.length;
-		while (c < sz) {
+	private int parseFile(final byte[] buf, int c, final int end) {
+		while (c < end) {
 			if (match(buf, c, HUNK_HDR) >= 0) {
 				// If we find a disconnected hunk header we might
 				// have missed a file header previously. The hunk
@@ -176,19 +175,19 @@ private int parseFile(final byte[] buf, int c) {
 			// Valid git style patch?
 			//
 			if (match(buf, c, DIFF_GIT) >= 0)
-				return parseDiffGit(buf, c);
+				return parseDiffGit(buf, c, end);
 			if (match(buf, c, DIFF_CC) >= 0)
-				return parseDiffCC(buf, c);
+				return parseDiffCC(buf, c, end);
 
 			// Junk between files? Leading junk? Traditional
 			// (non-git generated) patch?
 			//
 			final int n = nextLF(buf, c);
-			if (n >= sz) {
+			if (n >= end) {
 				// Patches cannot be only one line long. This must be
 				// trailing junk that we should ignore.
 				//
-				return sz;
+				return end;
 			}
 
 			if (n - c < 6) {
@@ -204,10 +203,10 @@ private int parseFile(final byte[] buf, int c) {
 				// a "@@ -0,0" smelling line next. We only check the "@@ -".
 				//
 				final int f = nextLF(buf, n);
-				if (f >= sz)
-					return sz;
+				if (f >= end)
+					return end;
 				if (match(buf, f, HUNK_HDR) >= 0)
-					return parseTraditionalPatch(buf, c);
+					return parseTraditionalPatch(buf, c, end);
 			}
 
 			c = n;
@@ -215,53 +214,53 @@ private int parseFile(final byte[] buf, int c) {
 		return c;
 	}
 
-	private int parseDiffGit(final byte[] buf, final int startOffset) {
-		final FileHeader fh = new FileHeader(buf, startOffset);
-		int ptr = fh.parseGitFileName(startOffset + DIFF_GIT.length);
+	private int parseDiffGit(final byte[] buf, final int start, final int end) {
+		final FileHeader fh = new FileHeader(buf, start);
+		int ptr = fh.parseGitFileName(start + DIFF_GIT.length, end);
 		if (ptr < 0)
-			return skipFile(buf, startOffset);
+			return skipFile(buf, start, end);
 
-		ptr = fh.parseGitHeaders(ptr);
-		ptr = parseHunks(fh, ptr);
+		ptr = fh.parseGitHeaders(ptr, end);
+		ptr = parseHunks(fh, ptr, end);
 		fh.endOffset = ptr;
 		addFile(fh);
 		return ptr;
 	}
 
-	private int parseDiffCC(final byte[] buf, final int startOffset) {
-		final FileHeader fh = new FileHeader(buf, startOffset);
-		int ptr = fh.parseGitFileName(startOffset + DIFF_CC.length);
+	private int parseDiffCC(final byte[] buf, final int start, final int end) {
+		final FileHeader fh = new FileHeader(buf, start);
+		int ptr = fh.parseGitFileName(start + DIFF_CC.length, end);
 		if (ptr < 0)
-			return skipFile(buf, startOffset);
+			return skipFile(buf, start, end);
 
 		// TODO Support parsing diff --cc headers
 		// TODO parse diff --cc hunks
-		warn(buf, startOffset, "diff --cc format not supported");
+		warn(buf, start, "diff --cc format not supported");
 		fh.endOffset = ptr;
 		addFile(fh);
 		return ptr;
 	}
 
-	private int parseTraditionalPatch(final byte[] buf, final int startOffset) {
-		final FileHeader fh = new FileHeader(buf, startOffset);
-		int ptr = fh.parseTraditionalHeaders(startOffset);
-		ptr = parseHunks(fh, ptr);
+	private int parseTraditionalPatch(final byte[] buf, final int start,
+			final int end) {
+		final FileHeader fh = new FileHeader(buf, start);
+		int ptr = fh.parseTraditionalHeaders(start, end);
+		ptr = parseHunks(fh, ptr, end);
 		fh.endOffset = ptr;
 		addFile(fh);
 		return ptr;
 	}
 
-	private static int skipFile(final byte[] buf, int ptr) {
+	private static int skipFile(final byte[] buf, int ptr, final int end) {
 		ptr = nextLF(buf, ptr);
 		if (match(buf, ptr, OLD_NAME) >= 0)
 			ptr = nextLF(buf, ptr);
 		return ptr;
 	}
 
-	private int parseHunks(final FileHeader fh, int c) {
+	private int parseHunks(final FileHeader fh, int c, final int end) {
 		final byte[] buf = fh.buf;
-		final int sz = buf.length;
-		while (c < sz) {
+		while (c < end) {
 			// If we see a file header at this point, we have all of the
 			// hunks for our current file. We should stop and report back
 			// with this position so it can be parsed again later.
@@ -277,11 +276,11 @@ private int parseHunks(final FileHeader fh, int c) {
 
 			if (match(buf, c, HUNK_HDR) >= 0) {
 				final HunkHeader h = new HunkHeader(fh, c);
-				h.parseHeader();
-				c = h.parseBody(this);
+				h.parseHeader(end);
+				c = h.parseBody(this, end);
 				h.endOffset = c;
 				fh.addHunk(h);
-				if (c < sz && buf[c] != '@' && buf[c] != 'd'
+				if (c < end && buf[c] != '@' && buf[c] != 'd'
 						&& match(buf, c, SIG_FOOTER) < 0) {
 					warn(buf, c, "Unexpected hunk trailer");
 				}
@@ -291,7 +290,7 @@ private int parseHunks(final FileHeader fh, int c) {
 			final int eol = nextLF(buf, c);
 			if (fh.getHunks().isEmpty() && match(buf, c, GIT_BINARY) >= 0) {
 				fh.patchType = FileHeader.PatchType.GIT_BINARY;
-				return parseGitBinary(fh, eol);
+				return parseGitBinary(fh, eol, end);
 			}
 
 			if (fh.getHunks().isEmpty() && BIN_TRAILER.length < eol - c
@@ -321,9 +320,9 @@ private int parseHunks(final FileHeader fh, int c) {
 		return c;
 	}
 
-	private int parseGitBinary(final FileHeader fh, int c) {
+	private int parseGitBinary(final FileHeader fh, int c, final int end) {
 		final BinaryHunk postImage = new BinaryHunk(fh, c);
-		final int nEnd = postImage.parseHunk(c);
+		final int nEnd = postImage.parseHunk(c, end);
 		if (nEnd < 0) {
 			// Not a binary hunk.
 			//
@@ -335,7 +334,7 @@ private int parseGitBinary(final FileHeader fh, int c) {
 		fh.forwardBinaryHunk = postImage;
 
 		final BinaryHunk preImage = new BinaryHunk(fh, c);
-		final int oEnd = preImage.parseHunk(c);
+		final int oEnd = preImage.parseHunk(c, end);
 		if (oEnd >= 0) {
 			c = oEnd;
 			preImage.endOffset = c;
-- 
1.6.1.rc2.306.ge5d5e
