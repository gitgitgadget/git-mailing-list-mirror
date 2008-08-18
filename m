From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/14] Refactor AbstractTreeIterator.pathCompare to force another mode
Date: Mon, 18 Aug 2008 16:53:14 -0700
Message-ID: <1219103602-32222-7-git-send-email-spearce@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
 <1219103602-32222-3-git-send-email-spearce@spearce.org>
 <1219103602-32222-4-git-send-email-spearce@spearce.org>
 <1219103602-32222-5-git-send-email-spearce@spearce.org>
 <1219103602-32222-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZ5-0006i3-0S
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbYHRXxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753719AbYHRXxg
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:36 -0400
Received: from george.spearce.org ([209.20.77.23]:45149 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbYHRXx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E0B3E3838F; Mon, 18 Aug 2008 23:53:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8C2203837B;
	Mon, 18 Aug 2008 23:53:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92772>

When handling D/F (directory/file) conflicts we need to pretend that one
of the two iterators has the other "type" of mode so we can search for
possible matches.  Rather than editing the mode instance member we now
overload pathCompare to accept the 2nd iterator's mode as an argument.

We can now force a tree entry to compare as a normal file by passing
in a mode of 0, or we can force a file entry to compare as a tree by
passing in FileMode.TREE.getBits().

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/AbstractTreeIterator.java        |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 232204a..bd75d2d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -227,6 +227,10 @@ protected void growPath(final int len) {
 	 *         p's entry sorts first.
 	 */
 	public int pathCompare(final AbstractTreeIterator p) {
+		return pathCompare(p, p.mode);
+	}
+
+	int pathCompare(final AbstractTreeIterator p, final int pMode) {
 		final byte[] a = path;
 		final byte[] b = p.path;
 		final int aLen = pathLen;
@@ -241,7 +245,7 @@ public int pathCompare(final AbstractTreeIterator p) {
 
 		if (cPos < aLen) {
 			final int aj = a[cPos] & 0xff;
-			final int lastb = p.lastPathChar();
+			final int lastb = lastPathChar(pMode);
 			if (aj < lastb)
 				return -1;
 			else if (aj > lastb)
@@ -254,7 +258,7 @@ else if (cPos == aLen - 1)
 
 		if (cPos < bLen) {
 			final int bk = b[cPos] & 0xff;
-			final int lasta = lastPathChar();
+			final int lasta = lastPathChar(mode);
 			if (lasta < bk)
 				return -1;
 			else if (lasta > bk)
@@ -265,8 +269,8 @@ else if (cPos == bLen - 1)
 				return 1;
 		}
 
-		final int lasta = lastPathChar();
-		final int lastb = p.lastPathChar();
+		final int lasta = lastPathChar(mode);
+		final int lastb = lastPathChar(pMode);
 		if (lasta < lastb)
 			return -1;
 		else if (lasta > lastb)
@@ -280,7 +284,7 @@ else if (aLen < bLen)
 			return 1;
 	}
 
-	private int lastPathChar() {
+	private static int lastPathChar(final int mode) {
 		return FileMode.TREE.equals(mode) ? '/' : '\0';
 	}
 
-- 
1.6.0.87.g2858d
