From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/5] Add HunkHeader to represent a single hunk of a file within a patch
Date: Wed, 10 Dec 2008 20:58:42 -0800
Message-ID: <1228971522-28764-6-git-send-email-spearce@spearce.org>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org>
 <1228971522-28764-2-git-send-email-spearce@spearce.org>
 <1228971522-28764-3-git-send-email-spearce@spearce.org>
 <1228971522-28764-4-git-send-email-spearce@spearce.org>
 <1228971522-28764-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 06:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAdf9-0002D6-KY
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 06:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbYLKE67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 23:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754339AbYLKE65
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 23:58:57 -0500
Received: from george.spearce.org ([209.20.77.23]:51662 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbYLKE6u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 23:58:50 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4F2B238200; Thu, 11 Dec 2008 04:58:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0F37338211;
	Thu, 11 Dec 2008 04:58:45 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228971522-28764-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102780>

The hunk header parses the lines of the hunk, counting up the body
to ensure it matches with the header line.  We store the hunks on
on the FileHeader, providing public access to them after a patch
has been parsed.

If the line counts in the body differ from the header we don't make
that an immediate error.  This permits a future implementation of
something like "git apply --recount", where the hunk headers can be
recomputed based on the actual hunk contents after a human has done
manual editing.  We may also need to parse a corrupt patch and show
it in a visual tool for a human to repair, so aborting with any sort
of exception isn't useful.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/FileHeaderTest.java |    6 +-
 .../tst/org/spearce/jgit/patch/PatchTest.java      |   60 ++++++-
 .../src/org/spearce/jgit/patch/FileHeader.java     |   22 +++
 .../src/org/spearce/jgit/patch/HunkHeader.java     |  185 ++++++++++++++++++++
 .../src/org/spearce/jgit/patch/Patch.java          |   54 ++++++-
 5 files changed, 323 insertions(+), 4 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
index 1d87bc0..4094a5c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
@@ -44,7 +44,10 @@
 
 public class FileHeaderTest extends TestCase {
 	public void testParseGitFileName_Empty() {
-		assertEquals(-1, data("").parseGitFileName(0));
+		final FileHeader fh = data("");
+		assertEquals(-1, fh.parseGitFileName(0));
+		assertNotNull(fh.getHunks());
+		assertTrue(fh.getHunks().isEmpty());
 	}
 
 	public void testParseGitFileName_NoLF() {
@@ -233,6 +236,7 @@ public void testParseRename100_OldStyle() {
 
 		assertEquals(100, fh.getScore());
 	}
+
 	public void testParseCopy100() {
 		final FileHeader fh = data("diff --git a/a b/ c/\\303\\205ngstr\\303\\266m\n"
 				+ "similarity index 100%\n"
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index f389d89..8ddaadc 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -72,11 +72,69 @@ assertEquals(
 		assertEquals("34ce04a", fRepositoryConfigTest.getNewId().name());
 		assertSame(FileMode.REGULAR_FILE, fRepositoryConfigTest.getOldMode());
 		assertSame(FileMode.REGULAR_FILE, fRepositoryConfigTest.getNewMode());
+		assertEquals(1, fRepositoryConfigTest.getHunks().size());
+		{
+			final HunkHeader h = fRepositoryConfigTest.getHunks().get(0);
+			assertEquals(921, h.startOffset);
+			assertEquals(109, h.getOldStartLine());
+			assertEquals(4, h.getOldLineCount());
+			assertEquals(109, h.getNewStartLine());
+			assertEquals(11, h.getNewLineCount());
+
+			assertEquals(4, h.getLinesContext());
+			assertEquals(7, h.getLinesAdded());
+			assertEquals(0, h.getLinesDeleted());
+
+			assertEquals(1490, h.endOffset);
+		}
 
 		assertEquals("45c2f8a", fRepositoryConfig.getOldId().name());
 		assertEquals("3291bba", fRepositoryConfig.getNewId().name());
 		assertSame(FileMode.REGULAR_FILE, fRepositoryConfig.getOldMode());
 		assertSame(FileMode.REGULAR_FILE, fRepositoryConfig.getNewMode());
+		assertEquals(3, fRepositoryConfig.getHunks().size());
+		{
+			final HunkHeader h = fRepositoryConfig.getHunks().get(0);
+			assertEquals(1803, h.startOffset);
+			assertEquals(236, h.getOldStartLine());
+			assertEquals(9, h.getOldLineCount());
+			assertEquals(236, h.getNewStartLine());
+			assertEquals(9, h.getNewLineCount());
+
+			assertEquals(7, h.getLinesContext());
+			assertEquals(2, h.getLinesAdded());
+			assertEquals(2, h.getLinesDeleted());
+
+			assertEquals(2434, h.endOffset);
+		}
+		{
+			final HunkHeader h = fRepositoryConfig.getHunks().get(1);
+			assertEquals(2434, h.startOffset);
+			assertEquals(300, h.getOldStartLine());
+			assertEquals(7, h.getOldLineCount());
+			assertEquals(300, h.getNewStartLine());
+			assertEquals(7, h.getNewLineCount());
+
+			assertEquals(6, h.getLinesContext());
+			assertEquals(1, h.getLinesAdded());
+			assertEquals(1, h.getLinesDeleted());
+
+			assertEquals(2816, h.endOffset);
+		}
+		{
+			final HunkHeader h = fRepositoryConfig.getHunks().get(2);
+			assertEquals(2816, h.startOffset);
+			assertEquals(954, h.getOldStartLine());
+			assertEquals(7, h.getOldLineCount());
+			assertEquals(954, h.getNewStartLine());
+			assertEquals(7, h.getNewLineCount());
+
+			assertEquals(6, h.getLinesContext());
+			assertEquals(1, h.getLinesAdded());
+			assertEquals(1, h.getLinesDeleted());
+
+			assertEquals(3035, h.endOffset);
+		}
 	}
 
 	private Patch parseTestPatchFile() throws IOException {
@@ -84,7 +142,7 @@ private Patch parseTestPatchFile() throws IOException {
 		final InputStream in = getClass().getResourceAsStream(patchFile);
 		if (in == null) {
 			fail("No " + patchFile + " test vector");
-			return null; // Never happens 
+			return null; // Never happens
 		}
 		try {
 			final Patch p = new Patch();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index f57a0ff..b49cb7b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -43,6 +43,10 @@
 import static org.spearce.jgit.util.RawParseUtils.nextLF;
 import static org.spearce.jgit.util.RawParseUtils.parseBase10;
 
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.List;
+
 import org.spearce.jgit.lib.AbbreviatedObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
@@ -136,6 +140,9 @@
 	/** ObjectId listed on the index line for the new (post-image) */
 	private AbbreviatedObjectId newId;
 
+	/** The hunks of this file */
+	private List<HunkHeader> hunks;
+
 	FileHeader(final byte[] b, final int offset) {
 		buf = b;
 		startOffset = offset;
@@ -222,6 +229,21 @@ public AbbreviatedObjectId getNewId() {
 		return newId;
 	}
 
+	/** @return hunks altering this file; in order of appearance in patch */
+	public List<HunkHeader> getHunks() {
+		if (hunks == null)
+			return Collections.emptyList();
+		return hunks;
+	}
+
+	void addHunk(final HunkHeader h) {
+		if (h.getFileHeader() != this)
+			throw new IllegalArgumentException("Hunk belongs to another file");
+		if (hunks == null)
+			hunks = new ArrayList<HunkHeader>();
+		hunks.add(h);
+	}
+
 	/**
 	 * Parse a "diff --git" or "diff --cc" line.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
new file mode 100644
index 0000000..fc606c3
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -0,0 +1,185 @@
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
+package org.spearce.jgit.patch;
+
+import static org.spearce.jgit.util.RawParseUtils.match;
+import static org.spearce.jgit.util.RawParseUtils.nextLF;
+import static org.spearce.jgit.util.RawParseUtils.parseBase10;
+
+import org.spearce.jgit.util.MutableInteger;
+
+/** Hunk header describing the layout of a single block of lines */
+public class HunkHeader {
+	private final FileHeader file;
+
+	/** Offset within {@link #file}.buf to the "@@ -" line. */
+	final int startOffset;
+
+	/** Position 1 past the end of this hunk within {@link #file}'s buf. */
+	int endOffset;
+
+	/** First line number in the pre-image file where the hunk starts */
+	int oldStartLine;
+
+	/** Total number of pre-image lines this hunk covers (context + deleted) */
+	int oldLineCount;
+
+	/** First line number in the post-image file where the hunk starts */
+	int newStartLine;
+
+	/** Total number of post-image lines this hunk covers (context + inserted) */
+	int newLineCount;
+
+	/** Total number of lines of context appearing in this hunk */
+	int nContext;
+
+	/** Number of lines removed by this hunk */
+	int nDeleted;
+
+	/** Number of lines added by this hunk */
+	int nAdded;
+
+	HunkHeader(final FileHeader fh, final int offset) {
+		file = fh;
+		startOffset = offset;
+	}
+
+	/** @return header for the file this hunk applies to */
+	public FileHeader getFileHeader() {
+		return file;
+	}
+
+	/** @return first line number in the pre-image file where the hunk starts */
+	public int getOldStartLine() {
+		return oldStartLine;
+	}
+
+	/** @return total number of pre-image lines this hunk covers */
+	public int getOldLineCount() {
+		return oldLineCount;
+	}
+
+	/** @return first line number in the post-image file where the hunk starts */
+	public int getNewStartLine() {
+		return newStartLine;
+	}
+
+	/** @return Total number of post-image lines this hunk covers */
+	public int getNewLineCount() {
+		return newLineCount;
+	}
+
+	/** @return total number of lines of context appearing in this hunk */
+	public int getLinesContext() {
+		return nContext;
+	}
+
+	/** @return number of lines removed by this hunk */
+	public int getLinesDeleted() {
+		return nDeleted;
+	}
+
+	/** @return number of lines added by this hunk */
+	public int getLinesAdded() {
+		return nAdded;
+	}
+
+	void parseHeader() {
+		// Parse "@@ -236,9 +236,9 @@ protected boolean"
+		//
+		final byte[] buf = file.buf;
+		final MutableInteger ptr = new MutableInteger();
+		ptr.value = nextLF(buf, startOffset, ' ');
+		oldStartLine = -parseBase10(buf, ptr.value, ptr);
+		oldLineCount = parseBase10(buf, ptr.value + 1, ptr);
+
+		newStartLine = parseBase10(buf, ptr.value + 1, ptr);
+		newLineCount = parseBase10(buf, ptr.value + 1, ptr);
+	}
+
+	int parseBody() {
+		final byte[] buf = file.buf;
+		final int sz = buf.length;
+		int c = nextLF(buf, startOffset), last = c;
+
+		nDeleted = 0;
+		nAdded = 0;
+
+		SCAN: for (; c < sz; last = c, c = nextLF(buf, c)) {
+			switch (buf[c]) {
+			case ' ':
+			case '\n':
+				nContext++;
+				continue;
+
+			case '-':
+				nDeleted++;
+				continue;
+
+			case '+':
+				nAdded++;
+				continue;
+
+			case '\\': // Matches "\ No newline at end of file"
+				continue;
+
+			default:
+				break SCAN;
+			}
+		}
+
+		if (last < sz && nContext + nDeleted - 1 == oldLineCount
+				&& nContext + nAdded == newLineCount
+				&& match(buf, last, Patch.SIG_FOOTER) >= 0) {
+			// This is an extremely common occurrence of "corruption".
+			// Users add footers with their signatures after this mark,
+			// and git diff adds the git executable version number.
+			// Let it slide; the hunk otherwise looked sound.
+			//
+			nDeleted--;
+			return last;
+		}
+
+		if (nContext + nDeleted != oldLineCount
+				|| nContext + nAdded != newLineCount) {
+			// TODO report on truncated hunk
+		}
+
+		return c;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 30d12a5..165058d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -57,6 +57,8 @@
 
 	private static final byte[] DIFF_CC = encodeASCII("diff --cc ");
 
+	static final byte[] SIG_FOOTER = encodeASCII("-- \n");
+
 	/** The files, in the order they were parsed out of the input. */
 	private final List<FileHeader> files;
 
@@ -131,6 +133,17 @@ public void parse(final byte[] buf, int ptr, final int end) {
 	private int parseFile(final byte[] buf, int c) {
 		final int sz = buf.length;
 		while (c < sz) {
+			if (match(buf, c, HUNK_HDR) >= 0) {
+				// If we find a disconnected hunk header we might
+				// have missed a file header previously. The hunk
+				// isn't valid without knowing where it comes from.
+				//
+
+				// TODO handle a disconnected hunk fragment
+				c = nextLF(buf, c);
+				continue;
+			}
+
 			// Valid git style patch?
 			//
 			if (match(buf, c, DIFF_GIT) >= 0)
@@ -180,7 +193,7 @@ private int parseDiffGit(final byte[] buf, final int startOffset) {
 			return skipFile(buf, startOffset);
 
 		ptr = fh.parseGitHeaders(ptr);
-		// TODO parse hunks
+		ptr = parseHunks(fh, buf, ptr);
 		fh.endOffset = ptr;
 		addFile(fh);
 		return ptr;
@@ -202,7 +215,7 @@ private int parseDiffCC(final byte[] buf, final int startOffset) {
 	private int parseTraditionalPatch(final byte[] buf, final int startOffset) {
 		final FileHeader fh = new FileHeader(buf, startOffset);
 		int ptr = fh.parseTraditionalHeaders(startOffset);
-		// TODO parse hunks
+		ptr = parseHunks(fh, buf, ptr);
 		fh.endOffset = ptr;
 		addFile(fh);
 		return ptr;
@@ -214,4 +227,41 @@ private static int skipFile(final byte[] buf, int ptr) {
 			ptr = nextLF(buf, ptr);
 		return ptr;
 	}
+
+	private int parseHunks(final FileHeader fh, final byte[] buf, int c) {
+		final int sz = buf.length;
+		while (c < sz) {
+			// If we see a file header at this point, we have all of the
+			// hunks for our current file. We should stop and report back
+			// with this position so it can be parsed again later.
+			//
+			if (match(buf, c, DIFF_GIT) >= 0)
+				return c;
+			if (match(buf, c, DIFF_CC) >= 0)
+				return c;
+			if (match(buf, c, OLD_NAME) >= 0)
+				return c;
+			if (match(buf, c, NEW_NAME) >= 0)
+				return c;
+
+			if (match(buf, c, HUNK_HDR) >= 0) {
+				final HunkHeader h = new HunkHeader(fh, c);
+				h.parseHeader();
+				c = h.parseBody();
+				h.endOffset = c;
+				fh.addHunk(h);
+				if (c < sz && buf[c] != '@' && buf[c] != 'd'
+						&& match(buf, c, SIG_FOOTER) < 0) {
+					// TODO report on noise between hunks, might be an error
+				}
+				continue;
+			}
+
+			// Skip this line and move to the next. Its probably garbage
+			// after the last hunk of a file.
+			//
+			c = nextLF(buf, c);
+		}
+		return c;
+	}
 }
-- 
1.6.1.rc2.299.gead4c
