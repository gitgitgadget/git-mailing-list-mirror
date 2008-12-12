From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/15] Always use the FileHeader buffer during Patch.parseHunks
Date: Thu, 11 Dec 2008 18:46:14 -0800
Message-ID: <1229049981-14152-9-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
 <1229049981-14152-3-git-send-email-spearce@spearce.org>
 <1229049981-14152-4-git-send-email-spearce@spearce.org>
 <1229049981-14152-5-git-send-email-spearce@spearce.org>
 <1229049981-14152-6-git-send-email-spearce@spearce.org>
 <1229049981-14152-7-git-send-email-spearce@spearce.org>
 <1229049981-14152-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy4z-00057A-Ly
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393AbYLLCqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757195AbYLLCqi
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:38 -0500
Received: from george.spearce.org ([209.20.77.23]:41584 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757256AbYLLCq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:29 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 445C338210; Fri, 12 Dec 2008 02:46:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 71FC138210;
	Fri, 12 Dec 2008 02:46:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102870>

This ensures that if the code is ever refactored in the future to
permit different entry path into parseHunks that we won't read the
wrong buffer and potentially setup an invalid FileHeader.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/patch/Patch.java          |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index c940a00..164ad96 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -202,7 +202,7 @@ private int parseDiffGit(final byte[] buf, final int startOffset) {
 			return skipFile(buf, startOffset);
 
 		ptr = fh.parseGitHeaders(ptr);
-		ptr = parseHunks(fh, buf, ptr);
+		ptr = parseHunks(fh, ptr);
 		fh.endOffset = ptr;
 		addFile(fh);
 		return ptr;
@@ -224,7 +224,7 @@ private int parseDiffCC(final byte[] buf, final int startOffset) {
 	private int parseTraditionalPatch(final byte[] buf, final int startOffset) {
 		final FileHeader fh = new FileHeader(buf, startOffset);
 		int ptr = fh.parseTraditionalHeaders(startOffset);
-		ptr = parseHunks(fh, buf, ptr);
+		ptr = parseHunks(fh, ptr);
 		fh.endOffset = ptr;
 		addFile(fh);
 		return ptr;
@@ -237,7 +237,8 @@ private static int skipFile(final byte[] buf, int ptr) {
 		return ptr;
 	}
 
-	private int parseHunks(final FileHeader fh, final byte[] buf, int c) {
+	private int parseHunks(final FileHeader fh, int c) {
+		final byte[] buf = fh.buf;
 		final int sz = buf.length;
 		while (c < sz) {
 			// If we see a file header at this point, we have all of the
-- 
1.6.1.rc2.306.ge5d5e
