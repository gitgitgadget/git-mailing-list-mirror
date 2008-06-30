From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Paper bag fix IndexPack thin pack completion support
Date: Sun, 29 Jun 2008 21:25:38 -0400
Message-ID: <20080630012538.GK11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 03:27:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD8Ag-0001iG-Fn
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 03:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbYF3BZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 21:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbYF3BZm
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 21:25:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48732 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbYF3BZl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 21:25:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KD892-0002Rb-Eu; Sun, 29 Jun 2008 21:25:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 72FE020FBAE; Sun, 29 Jun 2008 21:25:38 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86856>

We must write the whole object at the end of the file, not in the
middle of the file on top of some delta (or other) whole object.
Writing in the middle of the file causes subtle corruption as we
cannot unpack a delta.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is a serious data corruption in IndexPack.  It was introduced
 by me in "Compute packed object entry CRC32 data during IndexPack",
 which is presently in `pu` as 4b8e1c0c.  It would be best if we
 squash this into the commit.

 .../src/org/spearce/jgit/transport/IndexPack.java  |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index b35cec3..24a0577 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -407,10 +407,10 @@ public class IndexPack {
 			final PackedObjectInfo oe;
 
 			crc.reset();
+			packOut.seek(end);
 			writeWhole(def, typeCode, data);
 			oe = new PackedObjectInfo(end, (int) crc.getValue(), baseId);
 			entries[entryCount++] = oe;
-			packOut.seek(end);
 			end = packOut.getFilePointer();
 
 			resolveChildDeltas(oe.getOffset(), typeCode, data, oe);
-- 
1.5.6.74.g8a5e

-- 
Shawn.
