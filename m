From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/14] Micro-optimize AbstractTreeIterator.pathCompare
Date: Mon, 18 Aug 2008 16:53:15 -0700
Message-ID: <1219103602-32222-8-git-send-email-spearce@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
 <1219103602-32222-3-git-send-email-spearce@spearce.org>
 <1219103602-32222-4-git-send-email-spearce@spearce.org>
 <1219103602-32222-5-git-send-email-spearce@spearce.org>
 <1219103602-32222-6-git-send-email-spearce@spearce.org>
 <1219103602-32222-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZ6-0006i3-Bm
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbYHRXxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbYHRXxk
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:40 -0400
Received: from george.spearce.org ([209.20.77.23]:45152 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbYHRXx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3A9B13838B; Mon, 18 Aug 2008 23:53:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D03E73837C;
	Mon, 18 Aug 2008 23:53:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92773>

We were doing far too much work in pathCompare to handle
cases that just cannot ever happen, such as if the paths
were the same length but had different "last path char"
and then somehow had different lengths.

We also had the JVM doing a lot of comparsion ops just
to return -1/0/1 when really we can get away with the
non-zero result returned to the caller.  Issuing just
the subtraction and one comparsion to 0 is much quicker,
JIT or not.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/AbstractTreeIterator.java        |   44 ++-----------------
 1 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index bd75d2d..31257b5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -243,45 +243,11 @@ int pathCompare(final AbstractTreeIterator p, final int pMode) {
 				return cmp;
 		}
 
-		if (cPos < aLen) {
-			final int aj = a[cPos] & 0xff;
-			final int lastb = lastPathChar(pMode);
-			if (aj < lastb)
-				return -1;
-			else if (aj > lastb)
-				return 1;
-			else if (cPos == aLen - 1)
-				return 0;
-			else
-				return -1;
-		}
-
-		if (cPos < bLen) {
-			final int bk = b[cPos] & 0xff;
-			final int lasta = lastPathChar(mode);
-			if (lasta < bk)
-				return -1;
-			else if (lasta > bk)
-				return 1;
-			else if (cPos == bLen - 1)
-				return 0;
-			else
-				return 1;
-		}
-
-		final int lasta = lastPathChar(mode);
-		final int lastb = lastPathChar(pMode);
-		if (lasta < lastb)
-			return -1;
-		else if (lasta > lastb)
-			return 1;
-
-		if (aLen == bLen)
-			return 0;
-		else if (aLen < bLen)
-			return -1;
-		else
-			return 1;
+		if (cPos < aLen)
+			return (a[cPos] & 0xff) - lastPathChar(pMode);
+		if (cPos < bLen)
+			return lastPathChar(mode) - (b[cPos] & 0xff);
+		return lastPathChar(mode) - lastPathChar(pMode);
 	}
 
 	private static int lastPathChar(final int mode) {
-- 
1.6.0.87.g2858d
