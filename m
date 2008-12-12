From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 15/15] Treat "diff --combined" the same as "diff --cc"
Date: Thu, 11 Dec 2008 18:46:21 -0800
Message-ID: <1229049981-14152-16-git-send-email-spearce@spearce.org>
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
 <1229049981-14152-15-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy55-00057A-KW
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbYLLCrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757553AbYLLCrI
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:47:08 -0500
Received: from george.spearce.org ([209.20.77.23]:41608 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757343AbYLLCqh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:37 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7C8CA38210; Fri, 12 Dec 2008 02:46:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E8F9738200;
	Fri, 12 Dec 2008 02:46:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-15-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102878>

According to the git diff manual page these two formats
share the same file structure, so we can parse them with
the same function.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/patch/Patch.java          |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index e1e79b7..77ae02f 100644
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
-		final FileHeader fh = new FileHeader(buf, start);
-		int ptr = fh.parseGitFileName(start + DIFF_CC.length, end);
+	private int parseDiffCombined(final byte[] hdr, final byte[] buf,
+			final int start, final int end) {
+		final CombinedFileHeader fh = new CombinedFileHeader(buf, start);
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
