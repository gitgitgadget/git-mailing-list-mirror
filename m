From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 15/23] Don't unpack delta chains while converting delta to whole object
Date: Wed, 24 Dec 2008 18:11:11 -0800
Message-ID: <1230171079-17156-16-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:14:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjT-00029A-9F
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbYLYCMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbYLYCML
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:12:11 -0500
Received: from george.spearce.org ([209.20.77.23]:59414 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbYLYCLa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:30 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5E1F238210; Thu, 25 Dec 2008 02:11:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9070D38269;
	Thu, 25 Dec 2008 02:11:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-15-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103885>

If an object is currently a delta but we need to convert it into
a whole object we shouldn't be chasing the delta chain to get its
real type code.  We had the type code at the time we made the list
of objects to pack; so we save it in the ObjectToPack structure.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |   28 ++++++++++++++-----
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 88b2b1f..a0823c7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -705,14 +705,14 @@ private void writeObject(final ObjectToPack otp) throws IOException {
 	private void writeWholeObject(final ObjectToPack otp) throws IOException {
 		if (otp.hasReuseLoader()) {
 			final PackedObjectLoader loader = otp.getReuseLoader();
-			writeObjectHeader(loader.getType(), loader.getSize());
+			writeObjectHeader(otp.getType(), loader.getSize());
 			loader.copyRawData(out, buf);
 			otp.disposeLoader();
 		} else {
 			final ObjectLoader loader = db.openObject(windowCursor, otp);
 			final DeflaterOutputStream deflaterOut = new DeflaterOutputStream(
 					out, deflater);
-			writeObjectHeader(loader.getType(), loader.getSize());
+			writeObjectHeader(otp.getType(), loader.getSize());
 			deflaterOut.write(loader.getCachedBytes());
 			deflaterOut.finish();
 			deflater.reset();
@@ -833,7 +833,7 @@ public void addObject(final RevObject object)
 			return;
 		}
 
-		final ObjectToPack otp = new ObjectToPack(object);
+		final ObjectToPack otp = new ObjectToPack(object, object.getType());
 		try {
 			objectsLists[object.getType()].add(otp);
 		} catch (ArrayIndexOutOfBoundsException x) {
@@ -858,7 +858,8 @@ public void addObject(final RevObject object)
 
 		private PackedObjectLoader reuseLoader;
 
-		private int deltaDepth;
+		/** Low bits contain the objectType; higher bits the deltaDepth */
+		private int flags;
 
 		private boolean wantWrite;
 
@@ -868,9 +869,12 @@ public void addObject(final RevObject object)
 		 *
 		 * @param src
 		 *            object id of object for packing
+		 * @param type
+		 *            real type code of the object, not its in-pack type.
 		 */
-		ObjectToPack(AnyObjectId src) {
+		ObjectToPack(AnyObjectId src, final int type) {
 			super(src);
+			flags |= type;
 		}
 
 		/**
@@ -946,15 +950,23 @@ void disposeLoader() {
 			this.reuseLoader = null;
 		}
 
+		int getType() {
+			return flags & 0x7;
+		}
+
 		int getDeltaDepth() {
-			return deltaDepth;
+			return flags >>> 3;
 		}
 
 		void updateDeltaDepth() {
+			final int d;
 			if (deltaBase instanceof ObjectToPack)
-				deltaDepth = ((ObjectToPack) deltaBase).deltaDepth + 1;
+				d = ((ObjectToPack) deltaBase).getDeltaDepth() + 1;
 			else if (deltaBase != null)
-				deltaDepth = 1;
+				d = 1;
+			else
+				d = 0;
+			flags = (d << 3) | getType();
 		}
 
 		boolean wantWrite() {
-- 
1.6.1.rc4.301.g5497a
