From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Fix the UnpackedObjectCache hash function to prevent overflow
Date: Tue, 30 Sep 2008 00:47:50 -0700
Message-ID: <1222760871-58768-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 09:49:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkZyz-0003MS-TT
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 09:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbYI3Hrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 03:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbYI3Hry
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 03:47:54 -0400
Received: from george.spearce.org ([209.20.77.23]:49747 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbYI3Hrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 03:47:53 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2EA4838268; Tue, 30 Sep 2008 07:47:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 36D7438268;
	Tue, 30 Sep 2008 07:47:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.463.g7f0eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97071>

Sometimes we got negative array indexes inside of the cache due
to WindowedFile.hash having a negative value assigned by the JVM.
We now use only the lower 8 bits as the cache is fixed to at most
256 entries.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/UnpackedObjectCache.java  |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
index 03cf674..ee6a680 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
@@ -48,9 +48,9 @@
 
 	private static int hash(final WindowedFile pack, final long position) {
 		int h = pack.hash + (int) position;
-		h += h >> 16;
-		h += h >> 8;
-		return h % CACHE_SZ;
+		h += h >>> 16;
+		h += h >>> 8;
+		return h & (CACHE_SZ - 1);
 	}
 
 	private static int maxByteCount;
-- 
1.6.0.2.463.g7f0eb
