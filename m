From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/21] Use PackedObjectInfo as a base class for PackWriter's ObjectToPack
Date: Sun, 29 Jun 2008 03:59:13 -0400
Message-ID: <1214726371-93520-4-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:01:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrqj-00005Q-KS
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbYF2IAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbYF2IAd
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36730 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYF2H7t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 03:59:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrp2-0004Lx-FH; Sun, 29 Jun 2008 03:59:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id CF1EB20FBAE; Sun, 29 Jun 2008 03:59:44 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 43E4520FBCB;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-3-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86762>

The ObjectId and offset portions of PackedObjectInfo are also
needed by ObjectToPack.  By sharing the same base class with
IndexPack we can later abstract the index writing function out
and use it inside of both IndexPack and PackWriter.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |   28 +++-----------------
 1 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index cec2ab0..ccc6cfe 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -56,6 +56,7 @@ import org.spearce.jgit.revwalk.ObjectWalk;
 import org.spearce.jgit.revwalk.RevFlag;
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevSort;
+import org.spearce.jgit.transport.PackedObjectInfo;
 import org.spearce.jgit.util.CountingOutputStream;
 import org.spearce.jgit.util.NB;
 
@@ -617,7 +618,7 @@ public class PackWriter {
 
 		assert !otp.isWritten();
 
-		otp.markWritten(countingOut.getCount());
+		otp.setOffset(countingOut.getCount());
 		if (otp.isDeltaRepresentation())
 			writeDeltaObject(otp);
 		else
@@ -762,13 +763,11 @@ public class PackWriter {
 	 * pack-file and object status.
 	 *
 	 */
-	static class ObjectToPack extends ObjectId {
+	static class ObjectToPack extends PackedObjectInfo {
 		private ObjectId deltaBase;
 
 		private PackedObjectLoader reuseLoader;
 
-		private long offset = -1;
-
 		private int deltaDepth;
 
 		private boolean wantWrite;
@@ -838,26 +837,7 @@ public class PackWriter {
 		 * @return true if object is already written; false otherwise.
 		 */
 		boolean isWritten() {
-			return offset != -1;
-		}
-
-		/**
-		 * @return offset in pack when object has been already written, or -1 if
-		 *         it has not been written yet
-		 */
-		long getOffset() {
-			return offset;
-		}
-
-		/**
-		 * Mark object as written. This information is used to achieve
-		 * delta-base precedence in a pack file.
-		 *
-		 * @param offset
-		 *            offset where written object starts
-		 */
-		void markWritten(long offset) {
-			this.offset = offset;
+			return getOffset() != 0;
 		}
 
 		PackedObjectLoader getReuseLoader() {
-- 
1.5.6.74.g8a5e
