From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 12/15] Correctly handle hunk headers such as "@@ -0,0 +1 @@"
Date: Thu, 11 Dec 2008 18:46:18 -0800
Message-ID: <1229049981-14152-13-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy53-00057A-Cl
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757527AbYLLCrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757513AbYLLCq7
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:59 -0500
Received: from george.spearce.org ([209.20.77.23]:41600 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbYLLCqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:34 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4065638210; Fri, 12 Dec 2008 02:46:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F186738262;
	Fri, 12 Dec 2008 02:46:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-12-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102873>

Sometimes these are created for single line file creations.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/patch/HunkHeader.java     |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index 4fd9bae..c3bd642 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -126,10 +126,20 @@ void parseHeader(final int end) {
 		final MutableInteger ptr = new MutableInteger();
 		ptr.value = nextLF(buf, startOffset, ' ');
 		oldStartLine = -parseBase10(buf, ptr.value, ptr);
-		oldLineCount = parseBase10(buf, ptr.value + 1, ptr);
+		if (buf[ptr.value] == ',')
+			oldLineCount = parseBase10(buf, ptr.value + 1, ptr);
+		else {
+			oldLineCount = oldStartLine;
+			oldStartLine = 0;
+		}
 
 		newStartLine = parseBase10(buf, ptr.value + 1, ptr);
-		newLineCount = parseBase10(buf, ptr.value + 1, ptr);
+		if (buf[ptr.value] == ',')
+			newLineCount = parseBase10(buf, ptr.value + 1, ptr);
+		else {
+			newLineCount = newStartLine;
+			newStartLine = 0;
+		}
 	}
 
 	int parseBody(final Patch script, final int end) {
-- 
1.6.1.rc2.306.ge5d5e
