From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/4] Simplify and micro-optimize WorkingTreeIterator.ENTRY_CMP
Date: Thu, 21 Aug 2008 13:57:35 -0700
Message-ID: <1219352258-15431-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:58:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHEy-0002Z3-Px
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488AbYHUU5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbYHUU5k
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:57:40 -0400
Received: from george.spearce.org ([209.20.77.23]:41815 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbYHUU5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:57:40 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5405438378; Thu, 21 Aug 2008 20:57:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A4C8E38368;
	Thu, 21 Aug 2008 20:57:38 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.112.g9c75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93205>

We already did this simplification work to AbstractTreeIterator's
pathCompare method, and this is based upon that same structure.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |   44 ++-----------------
 1 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index c6664f5..6fce150 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -297,45 +297,11 @@ public int compare(final Entry o1, final Entry o2) {
 					return cmp;
 			}
 
-			if (cPos < aLen) {
-				final int aj = a[cPos] & 0xff;
-				final int lastb = lastPathChar(o2);
-				if (aj < lastb)
-					return -1;
-				else if (aj > lastb)
-					return 1;
-				else if (cPos == aLen - 1)
-					return 0;
-				else
-					return -1;
-			}
-
-			if (cPos < bLen) {
-				final int bk = b[cPos] & 0xff;
-				final int lasta = lastPathChar(o1);
-				if (lasta < bk)
-					return -1;
-				else if (lasta > bk)
-					return 1;
-				else if (cPos == bLen - 1)
-					return 0;
-				else
-					return 1;
-			}
-
-			final int lasta = lastPathChar(o1);
-			final int lastb = lastPathChar(o2);
-			if (lasta < lastb)
-				return -1;
-			else if (lasta > lastb)
-				return 1;
-
-			if (aLen == bLen)
-				return 0;
-			else if (aLen < bLen)
-				return -1;
-			else
-				return 1;
+			if (cPos < aLen)
+				return (a[cPos] & 0xff) - lastPathChar(o2);
+			if (cPos < bLen)
+				return lastPathChar(o1) - (b[cPos] & 0xff);
+			return lastPathChar(o1) - lastPathChar(o2);
 		}
 	};
 
-- 
1.6.0.112.g9c75
