From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/10] Make ObjectEntry's position field private
Date: Mon, 23 Jun 2008 22:10:00 -0400
Message-ID: <1214273408-70793-3-git-send-email-spearce@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
 <1214273408-70793-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy0U-0005iO-5Q
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbYFXCK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbYFXCK1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49719 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbYFXCK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxz1-0001MB-O3; Mon, 23 Jun 2008 22:10:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 8A66F20FBC9; Mon, 23 Jun 2008 22:10:21 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id EDC5D20FBCC;
	Mon, 23 Jun 2008 22:10:08 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214273408-70793-2-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85970>

PackWriter calls this getOffset() and hides the field as a private
field as part of its related ObjectToPack class.  We do that here
as part of ObjectEntry's API so we can later replace that part of
ObjectToPack by inheriting from ObjectEntry.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |   11 ++++++-----
 .../org/spearce/jgit/transport/ObjectEntry.java    |   12 ++++++++++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index e182cfc..19a4b7b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -281,8 +281,9 @@ public class IndexPack {
 	}
 
 	private void resolveDeltas(final ObjectEntry oe) throws IOException {
-		if (baseById.containsKey(oe) || baseByPos.containsKey(new Long(oe.pos)))
-			resolveDeltas(oe.pos, Constants.OBJ_BAD, null, oe);
+		if (baseById.containsKey(oe)
+				|| baseByPos.containsKey(new Long(oe.getOffset())))
+			resolveDeltas(oe.getOffset(), Constants.OBJ_BAD, null, oe);
 	}
 
 	private void resolveDeltas(final long pos, int type, byte[] data,
@@ -381,7 +382,7 @@ public class IndexPack {
 			writeWhole(def, typeCode, data);
 			end = packOut.getFilePointer();
 
-			resolveChildDeltas(oe.pos, typeCode, data, oe);
+			resolveChildDeltas(oe.getOffset(), typeCode, data, oe);
 			if (progress.isCancelled())
 				throw new IOException("Download cancelled during indexing");
 		}
@@ -458,9 +459,9 @@ public class IndexPack {
 			}
 			for (int i = 0; i < entryCount; i++) {
 				final ObjectEntry oe = entries[i];
-				if (oe.pos >>> 1 > Integer.MAX_VALUE)
+				if (oe.getOffset() >>> 1 > Integer.MAX_VALUE)
 					throw new IOException("Pack too large for index version 1");
-				NB.encodeInt32(rawoe, 0, (int) oe.pos);
+				NB.encodeInt32(rawoe, 0, (int) oe.getOffset());
 				oe.copyRawTo(rawoe, 4);
 				os.write(rawoe);
 				d.update(rawoe);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java
index 58d2eb2..10a8f4d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java
@@ -42,10 +42,18 @@ import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.ObjectId;
 
 class ObjectEntry extends ObjectId {
-	final long pos;
+	private long offset;
 
 	ObjectEntry(final long headerOffset, final AnyObjectId id) {
 		super(id);
-		pos = headerOffset;
+		offset = headerOffset;
+	}
+
+	/**
+	 * @return offset in pack when object has been already written, or -1 if it
+	 *         has not been written yet
+	 */
+	long getOffset() {
+		return offset;
 	}
 }
-- 
1.5.6.74.g8a5e
