From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/14] Optimize path comparsion within subtrees during TreeWalk
Date: Mon, 18 Aug 2008 16:53:16 -0700
Message-ID: <1219103602-32222-9-git-send-email-spearce@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
 <1219103602-32222-3-git-send-email-spearce@spearce.org>
 <1219103602-32222-4-git-send-email-spearce@spearce.org>
 <1219103602-32222-5-git-send-email-spearce@spearce.org>
 <1219103602-32222-6-git-send-email-spearce@spearce.org>
 <1219103602-32222-7-git-send-email-spearce@spearce.org>
 <1219103602-32222-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZ5-0006i3-Li
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbYHRXxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753535AbYHRXxi
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:38 -0400
Received: from george.spearce.org ([209.20.77.23]:45155 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbYHRXx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 819673837C; Mon, 18 Aug 2008 23:53:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1BFD338389;
	Mon, 18 Aug 2008 23:53:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92774>

If we are comparing two entries whose parents both match the same
tree iterator we know the path up through pathOffset must all
be identical, as the parents can only match if their paths up to
pathOffset were equal and they were both trees.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/AbstractTreeIterator.java        |   22 +++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 31257b5..e6aa338 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -237,7 +237,13 @@ int pathCompare(final AbstractTreeIterator p, final int pMode) {
 		final int bLen = p.pathLen;
 		int cPos;
 
-		for (cPos = 0; cPos < aLen && cPos < bLen; cPos++) {
+		// Its common when we are a subtree for both parents to match;
+		// when this happens everything in path[0..cPos] is known to
+		// be equal and does not require evaluation again.
+		//
+		cPos = alreadyMatch(this, p);
+
+		for (; cPos < aLen && cPos < bLen; cPos++) {
 			final int cmp = (a[cPos] & 0xff) - (b[cPos] & 0xff);
 			if (cmp != 0)
 				return cmp;
@@ -250,6 +256,20 @@ int pathCompare(final AbstractTreeIterator p, final int pMode) {
 		return lastPathChar(mode) - lastPathChar(pMode);
 	}
 
+	private static int alreadyMatch(AbstractTreeIterator a,
+			AbstractTreeIterator b) {
+		for (;;) {
+			final AbstractTreeIterator ap = a.parent;
+			final AbstractTreeIterator bp = b.parent;
+			if (ap == null || bp == null)
+				return 0;
+			if (ap.matches == bp.matches)
+				return a.pathOffset;
+			a = ap;
+			b = bp;
+		}
+	}
+
 	private static int lastPathChar(final int mode) {
 		return FileMode.TREE.equals(mode) ? '/' : '\0';
 	}
-- 
1.6.0.87.g2858d
