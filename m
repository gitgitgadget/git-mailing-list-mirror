From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 20/23] Move "wantWrite" field of ObjectToPack into the flags field
Date: Wed, 24 Dec 2008 18:11:16 -0800
Message-ID: <1230171079-17156-21-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
 <1230171079-17156-4-git-send-email-spearce@spearce.org>
 <1230171079-17156-5-git-send-email-spearce@spearce.org>
 <1230171079-17156-6-git-send-email-spearce@spearce.org>
 <1230171079-17156-7-git-send-email-spearce@spearce.org>
 <1230171079-17156-8-git-send-email-spearce@spearce.org>
 <1230171079-17156-9-git-send-email-spearce@spearce.org>
 <1230171079-17156-10-git-send-email-spearce@spearce.org>
 <1230171079-17156-11-git-send-email-spearce@spearce.org>
 <1230171079-17156-12-git-send-email-spearce@spearce.org>
 <1230171079-17156-13-git-send-email-spearce@spearce.org>
 <1230171079-17156-14-git-send-email-spearce@spearce.org>
 <1230171079-17156-15-git-send-email-spearce@spearce.org>
 <1230171079-17156-16-git-send-email-spearce@spearce.org>
 <1230171079-17156-17-git-send-email-spearce@spearce.org>
 <1230171079-17156-18-git-send-email-spearce@spearce.org>
 <1230171079-17156-19-git-send-email-spearce@spearce.org>
 <1230171079-17156-20-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjP-00029A-5v
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbYLYCL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbYLYCL4
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:56 -0500
Received: from george.spearce.org ([209.20.77.23]:59414 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbYLYCLb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:31 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4839838210; Thu, 25 Dec 2008 02:11:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 59FD438221;
	Thu, 25 Dec 2008 02:11:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-20-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103882>

This reduces the ObjectToPack structure by 4 bytes, saving us 4 MB
on the linux kernel repository.  Its only a single bit value, so
keeping it in a full boolean is rather wasteful given how many of
these objects we need in to pack a large project.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |   23 ++++++++++++-------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 50d06c2..3ef9154 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -859,11 +859,16 @@ public void addObject(final RevObject object)
 
 		private PackedObjectLoader reuseLoader;
 
-		/** Low bits contain the objectType; higher bits the deltaDepth */
+		/**
+		 * Bit field, from bit 0 to bit 31:
+		 * <ul>
+		 * <li>1 bit: wantWrite</li>
+		 * <li>3 bits: type</li>
+		 * <li>28 bits: deltaDepth</li>
+		 * </ul>
+		 */
 		private int flags;
 
-		private boolean wantWrite;
-
 		/**
 		 * Construct object for specified object id. <br/> By default object is
 		 * marked as not written and non-delta packed (as a whole object).
@@ -875,7 +880,7 @@ public void addObject(final RevObject object)
 		 */
 		ObjectToPack(AnyObjectId src, final int type) {
 			super(src);
-			flags |= type;
+			flags |= type << 1;
 		}
 
 		/**
@@ -952,11 +957,11 @@ void disposeLoader() {
 		}
 
 		int getType() {
-			return flags & 0x7;
+			return (flags>>1) & 0x7;
 		}
 
 		int getDeltaDepth() {
-			return flags >>> 3;
+			return flags >>> 4;
 		}
 
 		void updateDeltaDepth() {
@@ -967,15 +972,15 @@ else if (deltaBase != null)
 				d = 1;
 			else
 				d = 0;
-			flags = (d << 3) | getType();
+			flags = (d << 4) | flags & 0x15;
 		}
 
 		boolean wantWrite() {
-			return wantWrite;
+			return (flags & 1) == 1;
 		}
 
 		void markWantWrite() {
-			this.wantWrite = true;
+			flags |= 1;
 		}
 	}
 }
-- 
1.6.1.rc4.301.g5497a
