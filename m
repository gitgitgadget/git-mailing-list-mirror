From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/12] Refactor the old/pre-image data in HunkHeader to support >1 ancestor
Date: Fri, 12 Dec 2008 14:05:51 -0800
Message-ID: <1229119558-1293-6-git-send-email-spearce@spearce.org>
References: <1229119558-1293-1-git-send-email-spearce@spearce.org>
 <1229119558-1293-2-git-send-email-spearce@spearce.org>
 <1229119558-1293-3-git-send-email-spearce@spearce.org>
 <1229119558-1293-4-git-send-email-spearce@spearce.org>
 <1229119558-1293-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:08:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGBA-0004x0-Lr
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbYLLWGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbYLLWGM
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:12 -0500
Received: from george.spearce.org ([209.20.77.23]:50674 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbYLLWGC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:02 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 528EE38221; Fri, 12 Dec 2008 22:06:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0272838210;
	Fri, 12 Dec 2008 22:05:59 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102954>

The "diff --cc" format uses more than one ancestor in each hunk,
so we need to expand the hunk header information in a way that
allows access to the data for each ancestor.  This change moves
the information relative to the old/pre-image ancestor in a 2-way
patch into an OldImage object.  In a 2-way patch we only have
one OldImage, but in a "diff --cc" patch we will have more than
one of these available in each hunk.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/patch/EGitPatchHistoryTest.java   |    4 +-
 .../tst/org/spearce/jgit/patch/PatchTest.java      |   36 +++---
 .../src/org/spearce/jgit/patch/HunkHeader.java     |  124 ++++++++++++--------
 3 files changed, 95 insertions(+), 69 deletions(-)

diff --git a/org.spearce.jgit.test/exttst/org/spearce/jgit/patch/EGitPatchHistoryTest.java b/org.spearce.jgit.test/exttst/org/spearce/jgit/patch/EGitPatchHistoryTest.java
index d0c2632..b170dc2 100644
--- a/org.spearce.jgit.test/exttst/org/spearce/jgit/patch/EGitPatchHistoryTest.java
+++ b/org.spearce.jgit.test/exttst/org/spearce/jgit/patch/EGitPatchHistoryTest.java
@@ -110,8 +110,8 @@ void onCommit(String cid, byte[] buf) {
 				assertNotNull("No " + nid, s);
 				int added = 0, deleted = 0;
 				for (final HunkHeader h : fh.getHunks()) {
-					added += h.getLinesAdded();
-					deleted += h.getLinesDeleted();
+					added += h.getOldImage().getLinesAdded();
+					deleted += h.getOldImage().getLinesDeleted();
 				}
 
 				if (s.added == added) {
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index ebd23b4..4eceeb5 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -82,14 +82,14 @@ assertSame(FileHeader.PatchType.UNIFIED, fRepositoryConfigTest
 			final HunkHeader h = fRepositoryConfigTest.getHunks().get(0);
 			assertSame(fRepositoryConfigTest, h.getFileHeader());
 			assertEquals(921, h.startOffset);
-			assertEquals(109, h.getOldStartLine());
-			assertEquals(4, h.getOldLineCount());
+			assertEquals(109, h.getOldImage().getStartLine());
+			assertEquals(4, h.getOldImage().getLineCount());
 			assertEquals(109, h.getNewStartLine());
 			assertEquals(11, h.getNewLineCount());
 
 			assertEquals(4, h.getLinesContext());
-			assertEquals(7, h.getLinesAdded());
-			assertEquals(0, h.getLinesDeleted());
+			assertEquals(7, h.getOldImage().getLinesAdded());
+			assertEquals(0, h.getOldImage().getLinesDeleted());
 
 			assertEquals(1490, h.endOffset);
 		}
@@ -105,42 +105,42 @@ assertSame(FileHeader.PatchType.UNIFIED, fRepositoryConfig
 			final HunkHeader h = fRepositoryConfig.getHunks().get(0);
 			assertSame(fRepositoryConfig, h.getFileHeader());
 			assertEquals(1803, h.startOffset);
-			assertEquals(236, h.getOldStartLine());
-			assertEquals(9, h.getOldLineCount());
+			assertEquals(236, h.getOldImage().getStartLine());
+			assertEquals(9, h.getOldImage().getLineCount());
 			assertEquals(236, h.getNewStartLine());
 			assertEquals(9, h.getNewLineCount());
 
 			assertEquals(7, h.getLinesContext());
-			assertEquals(2, h.getLinesAdded());
-			assertEquals(2, h.getLinesDeleted());
+			assertEquals(2, h.getOldImage().getLinesAdded());
+			assertEquals(2, h.getOldImage().getLinesDeleted());
 
 			assertEquals(2434, h.endOffset);
 		}
 		{
 			final HunkHeader h = fRepositoryConfig.getHunks().get(1);
 			assertEquals(2434, h.startOffset);
-			assertEquals(300, h.getOldStartLine());
-			assertEquals(7, h.getOldLineCount());
+			assertEquals(300, h.getOldImage().getStartLine());
+			assertEquals(7, h.getOldImage().getLineCount());
 			assertEquals(300, h.getNewStartLine());
 			assertEquals(7, h.getNewLineCount());
 
 			assertEquals(6, h.getLinesContext());
-			assertEquals(1, h.getLinesAdded());
-			assertEquals(1, h.getLinesDeleted());
+			assertEquals(1, h.getOldImage().getLinesAdded());
+			assertEquals(1, h.getOldImage().getLinesDeleted());
 
 			assertEquals(2816, h.endOffset);
 		}
 		{
 			final HunkHeader h = fRepositoryConfig.getHunks().get(2);
 			assertEquals(2816, h.startOffset);
-			assertEquals(954, h.getOldStartLine());
-			assertEquals(7, h.getOldLineCount());
+			assertEquals(954, h.getOldImage().getStartLine());
+			assertEquals(7, h.getOldImage().getLineCount());
 			assertEquals(954, h.getNewStartLine());
 			assertEquals(7, h.getNewLineCount());
 
 			assertEquals(6, h.getLinesContext());
-			assertEquals(1, h.getLinesAdded());
-			assertEquals(1, h.getLinesDeleted());
+			assertEquals(1, h.getOldImage().getLinesAdded());
+			assertEquals(1, h.getOldImage().getLinesDeleted());
 
 			assertEquals(3035, h.endOffset);
 		}
@@ -177,7 +177,7 @@ assertTrue(fh.getNewName().startsWith(
 		assertNull(fh.getForwardBinaryHunk());
 		assertNull(fh.getReverseBinaryHunk());
 		assertEquals(1, fh.getHunks().size());
-		assertEquals(272, fh.getHunks().get(0).getOldStartLine());
+		assertEquals(272, fh.getHunks().get(0).getOldImage().getStartLine());
 	}
 
 	public void testParse_GitBinary() throws IOException {
@@ -222,7 +222,7 @@ assertTrue(fh.getNewName().startsWith(
 		assertNull(fh.getForwardBinaryHunk());
 		assertNull(fh.getReverseBinaryHunk());
 		assertEquals(1, fh.getHunks().size());
-		assertEquals(272, fh.getHunks().get(0).getOldStartLine());
+		assertEquals(272, fh.getHunks().get(0).getOldImage().getStartLine());
 	}
 
 	private Patch parseTestPatchFile() throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index c3bd642..842519e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -41,10 +41,49 @@
 import static org.spearce.jgit.util.RawParseUtils.nextLF;
 import static org.spearce.jgit.util.RawParseUtils.parseBase10;
 
+import org.spearce.jgit.lib.AbbreviatedObjectId;
 import org.spearce.jgit.util.MutableInteger;
 
 /** Hunk header describing the layout of a single block of lines */
 public class HunkHeader {
+	/** Details about an old image of the file. */
+	public abstract static class OldImage {
+		/** First line number the hunk starts on in this file. */
+		int startLine;
+
+		/** Total number of lines this hunk covers in this file. */
+		int lineCount;
+
+		/** Number of lines deleted by the post-image from this file. */
+		int nDeleted;
+
+		/** Number of lines added by the post-image not in this file. */
+		int nAdded;
+
+		/** @return first line number the hunk starts on in this file. */
+		public int getStartLine() {
+			return startLine;
+		}
+
+		/** @return total number of lines this hunk covers in this file. */
+		public int getLineCount() {
+			return lineCount;
+		}
+
+		/** @return number of lines deleted by the post-image from this file. */
+		public int getLinesDeleted() {
+			return nDeleted;
+		}
+
+		/** @return number of lines added by the post-image not in this file. */
+		public int getLinesAdded() {
+			return nAdded;
+		}
+
+		/** @return object id of the pre-image file. */
+		public abstract AbbreviatedObjectId getId();
+	}
+
 	private final FileHeader file;
 
 	/** Offset within {@link #file}.buf to the "@@ -" line. */
@@ -53,11 +92,7 @@
 	/** Position 1 past the end of this hunk within {@link #file}'s buf. */
 	int endOffset;
 
-	/** First line number in the pre-image file where the hunk starts */
-	int oldStartLine;
-
-	/** Total number of pre-image lines this hunk covers (context + deleted) */
-	int oldLineCount;
+	private final OldImage old;
 
 	/** First line number in the post-image file where the hunk starts */
 	int newStartLine;
@@ -68,15 +103,19 @@
 	/** Total number of lines of context appearing in this hunk */
 	int nContext;
 
-	/** Number of lines removed by this hunk */
-	int nDeleted;
-
-	/** Number of lines added by this hunk */
-	int nAdded;
-
 	HunkHeader(final FileHeader fh, final int offset) {
+		this(fh, offset, new OldImage() {
+			@Override
+			public AbbreviatedObjectId getId() {
+				return fh.getOldId();
+			}
+		});
+	}
+
+	HunkHeader(final FileHeader fh, final int offset, final OldImage oi) {
 		file = fh;
 		startOffset = offset;
+		old = oi;
 	}
 
 	/** @return header for the file this hunk applies to */
@@ -84,14 +123,9 @@ public FileHeader getFileHeader() {
 		return file;
 	}
 
-	/** @return first line number in the pre-image file where the hunk starts */
-	public int getOldStartLine() {
-		return oldStartLine;
-	}
-
-	/** @return total number of pre-image lines this hunk covers */
-	public int getOldLineCount() {
-		return oldLineCount;
+	/** @return information about the old image mentioned in this hunk. */
+	public OldImage getOldImage() {
+		return old;
 	}
 
 	/** @return first line number in the post-image file where the hunk starts */
@@ -109,28 +143,18 @@ public int getLinesContext() {
 		return nContext;
 	}
 
-	/** @return number of lines removed by this hunk */
-	public int getLinesDeleted() {
-		return nDeleted;
-	}
-
-	/** @return number of lines added by this hunk */
-	public int getLinesAdded() {
-		return nAdded;
-	}
-
 	void parseHeader(final int end) {
 		// Parse "@@ -236,9 +236,9 @@ protected boolean"
 		//
 		final byte[] buf = file.buf;
 		final MutableInteger ptr = new MutableInteger();
 		ptr.value = nextLF(buf, startOffset, ' ');
-		oldStartLine = -parseBase10(buf, ptr.value, ptr);
+		old.startLine = -parseBase10(buf, ptr.value, ptr);
 		if (buf[ptr.value] == ',')
-			oldLineCount = parseBase10(buf, ptr.value + 1, ptr);
+			old.lineCount = parseBase10(buf, ptr.value + 1, ptr);
 		else {
-			oldLineCount = oldStartLine;
-			oldStartLine = 0;
+			old.lineCount = old.startLine;
+			old.startLine = 0;
 		}
 
 		newStartLine = parseBase10(buf, ptr.value + 1, ptr);
@@ -146,8 +170,8 @@ int parseBody(final Patch script, final int end) {
 		final byte[] buf = file.buf;
 		int c = nextLF(buf, startOffset), last = c;
 
-		nDeleted = 0;
-		nAdded = 0;
+		old.nDeleted = 0;
+		old.nAdded = 0;
 
 		SCAN: for (; c < end; last = c, c = nextLF(buf, c)) {
 			switch (buf[c]) {
@@ -157,11 +181,11 @@ int parseBody(final Patch script, final int end) {
 				continue;
 
 			case '-':
-				nDeleted++;
+				old.nDeleted++;
 				continue;
 
 			case '+':
-				nAdded++;
+				old.nAdded++;
 				continue;
 
 			case '\\': // Matches "\ No newline at end of file"
@@ -172,33 +196,35 @@ int parseBody(final Patch script, final int end) {
 			}
 		}
 
-		if (last < end && nContext + nDeleted - 1 == oldLineCount
-				&& nContext + nAdded == newLineCount
+		if (last < end && nContext + old.nDeleted - 1 == old.lineCount
+				&& nContext + old.nAdded == newLineCount
 				&& match(buf, last, Patch.SIG_FOOTER) >= 0) {
 			// This is an extremely common occurrence of "corruption".
 			// Users add footers with their signatures after this mark,
 			// and git diff adds the git executable version number.
 			// Let it slide; the hunk otherwise looked sound.
 			//
-			nDeleted--;
+			old.nDeleted--;
 			return last;
 		}
 
-		if (nContext + nDeleted < oldLineCount) {
-			final int missingCount = oldLineCount - (nContext + nDeleted);
+		if (nContext + old.nDeleted < old.lineCount) {
+			final int missingCount = old.lineCount - (nContext + old.nDeleted);
 			script.error(buf, startOffset, "Truncated hunk, at least "
 					+ missingCount + " old lines is missing");
 
-		} else if (nContext + nAdded < newLineCount) {
-			final int missingCount = newLineCount - (nContext + nAdded);
+		} else if (nContext + old.nAdded < newLineCount) {
+			final int missingCount = newLineCount - (nContext + old.nAdded);
 			script.error(buf, startOffset, "Truncated hunk, at least "
 					+ missingCount + " new lines is missing");
 
-		} else if (nContext + nDeleted > oldLineCount
-				|| nContext + nAdded > newLineCount) {
-			script.warn(buf, startOffset, "Hunk header " + oldLineCount + ":"
-					+ newLineCount + " does not match body line count of "
-					+ (nContext + nDeleted) + ":" + (nContext + nAdded));
+		} else if (nContext + old.nDeleted > old.lineCount
+				|| nContext + old.nAdded > newLineCount) {
+			final String oldcnt = old.lineCount + ":" + newLineCount;
+			final String newcnt = (nContext + old.nDeleted) + ":"
+					+ (nContext + old.nAdded);
+			script.warn(buf, startOffset, "Hunk header " + oldcnt
+					+ " does not match body line count of " + newcnt);
 		}
 
 		return c;
-- 
1.6.1.rc2.306.ge5d5e
