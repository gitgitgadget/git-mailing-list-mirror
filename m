From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 15/15 v2] Treat "diff --combined" the same as "diff
	--cc"
Date: Fri, 12 Dec 2008 15:18:15 -0800
Message-ID: <20081212231815.GT32487@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org> <1229049981-14152-15-git-send-email-spearce@spearce.org> <1229049981-14152-16-git-send-email-spearce@spearce.org> <200812130011.37854.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 00:19:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBHII-0003fz-5X
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 00:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbYLLXSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 18:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYLLXSR
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 18:18:17 -0500
Received: from george.spearce.org ([209.20.77.23]:47068 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbYLLXSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 18:18:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 92FD438200; Fri, 12 Dec 2008 23:18:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200812130011.37854.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102966>

According to the git diff manual page these two formats
share the same file structure, so we can parse them with
the same function.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
  > 
  > The source for CombinedFileHeader would be nice. 

  Dammit, that wasn't added until 12/12 of the final series.
  A new 12/12 v2 will be sent in a minute.
   
  > Btw, I moved the patches to the test-rsrc directory to make it possible
  > to run the unit tests throuh maven.
  
  Oh.

 .../src/org/spearce/jgit/patch/Patch.java          |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index e1e79b7..9ae2635 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -57,6 +57,8 @@
 
 	private static final byte[] DIFF_CC = encodeASCII("diff --cc ");
 
+	private static final byte[] DIFF_COMBINED = encodeASCII("diff --combined ");
+
 	private static final byte[][] BIN_HEADERS = new byte[][] {
 			encodeASCII("Binary files "), encodeASCII("Files "), };
 
@@ -177,7 +179,9 @@ private int parseFile(final byte[] buf, int c, final int end) {
 			if (match(buf, c, DIFF_GIT) >= 0)
 				return parseDiffGit(buf, c, end);
 			if (match(buf, c, DIFF_CC) >= 0)
-				return parseDiffCC(buf, c, end);
+				return parseDiffCombined(DIFF_CC, buf, c, end);
+			if (match(buf, c, DIFF_COMBINED) >= 0)
+				return parseDiffCombined(DIFF_COMBINED, buf, c, end);
 
 			// Junk between files? Leading junk? Traditional
 			// (non-git generated) patch?
@@ -227,9 +231,10 @@ private int parseDiffGit(final byte[] buf, final int start, final int end) {
 		return ptr;
 	}
 
-	private int parseDiffCC(final byte[] buf, final int start, final int end) {
+	private int parseDiffCombined(final byte[] hdr, final byte[] buf,
+			final int start, final int end) {
 		final FileHeader fh = new FileHeader(buf, start);
-		int ptr = fh.parseGitFileName(start + DIFF_CC.length, end);
+		int ptr = fh.parseGitFileName(start + hdr.length, end);
 		if (ptr < 0)
 			return skipFile(buf, start, end);
 
@@ -269,6 +274,8 @@ private int parseHunks(final FileHeader fh, int c, final int end) {
 				break;
 			if (match(buf, c, DIFF_CC) >= 0)
 				break;
+			if (match(buf, c, DIFF_COMBINED) >= 0)
+				break;
 			if (match(buf, c, OLD_NAME) >= 0)
 				break;
 			if (match(buf, c, NEW_NAME) >= 0)
-- 
1.6.1.rc2.306.ge5d5e


-- 
Shawn.
