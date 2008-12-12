From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/12] Allow a stray LF at the end of a hunk
Date: Fri, 12 Dec 2008 14:05:53 -0800
Message-ID: <1229119558-1293-8-git-send-email-spearce@spearce.org>
References: <1229119558-1293-1-git-send-email-spearce@spearce.org>
 <1229119558-1293-2-git-send-email-spearce@spearce.org>
 <1229119558-1293-3-git-send-email-spearce@spearce.org>
 <1229119558-1293-4-git-send-email-spearce@spearce.org>
 <1229119558-1293-5-git-send-email-spearce@spearce.org>
 <1229119558-1293-6-git-send-email-spearce@spearce.org>
 <1229119558-1293-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGBD-0004x0-48
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbYLLWGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbYLLWGR
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:17 -0500
Received: from george.spearce.org ([209.20.77.23]:50680 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbYLLWGD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:03 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 08F9438260; Fri, 12 Dec 2008 22:06:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 979B538200;
	Fri, 12 Dec 2008 22:06:00 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102957>

If a hunk ends and is followed by a stray LF its not worth creating
a warning for.  A single extra blank line isn't all that interesting
relative to the other sorts of data we might find at the end of a
patch hunk.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/patch/Patch.java          |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 05d034d..51f1fe5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -287,9 +287,16 @@ private int parseHunks(final FileHeader fh, int c, final int end) {
 				c = h.parseBody(this, end);
 				h.endOffset = c;
 				fh.addHunk(h);
-				if (c < end && buf[c] != '@' && buf[c] != 'd'
-						&& match(buf, c, SIG_FOOTER) < 0) {
-					warn(buf, c, "Unexpected hunk trailer");
+				if (c < end) {
+					switch (buf[c]) {
+					case '@':
+					case 'd':
+					case '\n':
+						break;
+					default:
+						if (match(buf, c, SIG_FOOTER) < 0)
+							warn(buf, c, "Unexpected hunk trailer");
+					}
 				}
 				continue;
 			}
-- 
1.6.1.rc2.306.ge5d5e
