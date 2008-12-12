From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 14/15] Abstract the hunk header testing into a method
Date: Thu, 11 Dec 2008 18:46:20 -0800
Message-ID: <1229049981-14152-15-git-send-email-spearce@spearce.org>
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
 <1229049981-14152-12-git-send-email-spearce@spearce.org>
 <1229049981-14152-13-git-send-email-spearce@spearce.org>
 <1229049981-14152-14-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:49:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy54-00057A-T0
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343AbYLLCrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757420AbYLLCrH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:47:07 -0500
Received: from george.spearce.org ([209.20.77.23]:41606 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757320AbYLLCqg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:36 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id E322438211; Fri, 12 Dec 2008 02:46:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9716238221;
	Fri, 12 Dec 2008 02:46:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-14-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102880>

This way we can test for "@@@ -" and "@@@@@@@ -" for combined
diffs in octopus merges.  We use the same scan test for the
basic two-way case, as the format is identical but has less
marker characters.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/patch/FileHeader.java     |   36 +++++++++++++++++--
 .../src/org/spearce/jgit/patch/Patch.java          |    8 ++--
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index a58e978..5fe2acf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -87,8 +87,6 @@
 
 	static final byte[] NEW_NAME = encodeASCII("+++ ");
 
-	static final byte[] HUNK_HDR = encodeASCII("@@ -");
-
 	/** General type of change a single file-level patch describes. */
 	public static enum ChangeType {
 		/** Add a new file to the project */
@@ -358,7 +356,7 @@ int parseGitFileName(int ptr, final int end) {
 	int parseGitHeaders(int ptr, final int end) {
 		while (ptr < end) {
 			final int eol = nextLF(buf, ptr);
-			if (match(buf, ptr, HUNK_HDR) >= 0) {
+			if (isHunkHdr(buf, ptr, eol) >= 1) {
 				// First hunk header; break out and parse them later.
 				break;
 
@@ -432,7 +430,7 @@ int parseGitHeaders(int ptr, final int end) {
 	int parseTraditionalHeaders(int ptr, final int end) {
 		while (ptr < end) {
 			final int eol = nextLF(buf, ptr);
-			if (match(buf, ptr, HUNK_HDR) >= 0) {
+			if (isHunkHdr(buf, ptr, eol) >= 1) {
 				// First hunk header; break out and parse them later.
 				break;
 
@@ -519,4 +517,34 @@ private boolean eq(int aPtr, int aEnd, int bPtr, int bEnd) {
 		}
 		return true;
 	}
+
+	/**
+	 * Determine if this is a patch hunk header.
+	 * 
+	 * @param buf
+	 *            the buffer to scan
+	 * @param start
+	 *            first position in the buffer to evaluate
+	 * @param end
+	 *            last position to consider; usually the end of the buffer (
+	 *            <code>buf.length</code>) or the first position on the next
+	 *            line. This is only used to avoid very long runs of '@' from
+	 *            killing the scan loop.
+	 * @return the number of "ancestor revisions" in the hunk header. A
+	 *         traditional two-way diff ("@@ -...") returns 1; a combined diff
+	 *         for a 3 way-merge returns 3. If this is not a hunk header, 0 is
+	 *         returned instead.
+	 */
+	static int isHunkHdr(final byte[] buf, final int start, final int end) {
+		int ptr = start;
+		while (ptr < end && buf[ptr] == '@')
+			ptr++;
+		if (ptr - start < 2)
+			return 0;
+		if (ptr == end || buf[ptr++] != ' ')
+			return 0;
+		if (ptr == end || buf[ptr++] != '-')
+			return 0;
+		return (ptr - 3) - start;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 9aca22d..e1e79b7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -38,7 +38,7 @@
 package org.spearce.jgit.patch;
 
 import static org.spearce.jgit.lib.Constants.encodeASCII;
-import static org.spearce.jgit.patch.FileHeader.HUNK_HDR;
+import static org.spearce.jgit.patch.FileHeader.isHunkHdr;
 import static org.spearce.jgit.patch.FileHeader.NEW_NAME;
 import static org.spearce.jgit.patch.FileHeader.OLD_NAME;
 import static org.spearce.jgit.util.RawParseUtils.match;
@@ -162,7 +162,7 @@ public void parse(final byte[] buf, int ptr, final int end) {
 
 	private int parseFile(final byte[] buf, int c, final int end) {
 		while (c < end) {
-			if (match(buf, c, HUNK_HDR) >= 0) {
+			if (isHunkHdr(buf, c, end) >= 1) {
 				// If we find a disconnected hunk header we might
 				// have missed a file header previously. The hunk
 				// isn't valid without knowing where it comes from.
@@ -205,7 +205,7 @@ private int parseFile(final byte[] buf, int c, final int end) {
 				final int f = nextLF(buf, n);
 				if (f >= end)
 					return end;
-				if (match(buf, f, HUNK_HDR) >= 0)
+				if (isHunkHdr(buf, f, end) == 1)
 					return parseTraditionalPatch(buf, c, end);
 			}
 
@@ -274,7 +274,7 @@ private int parseHunks(final FileHeader fh, int c, final int end) {
 			if (match(buf, c, NEW_NAME) >= 0)
 				break;
 
-			if (match(buf, c, HUNK_HDR) >= 0) {
+			if (isHunkHdr(buf, c, end) == 1) {
 				final HunkHeader h = new HunkHeader(fh, c);
 				h.parseHeader(end);
 				c = h.parseBody(this, end);
-- 
1.6.1.rc2.306.ge5d5e
