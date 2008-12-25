From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/23] Change walker based fetch to use TreeWalk's MutableObjectId accessor
Date: Wed, 24 Dec 2008 18:11:01 -0800
Message-ID: <1230171079-17156-6-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
 <1230171079-17156-4-git-send-email-spearce@spearce.org>
 <1230171079-17156-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjI-00029A-6S
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbYLYCLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbYLYCL2
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:28 -0500
Received: from george.spearce.org ([209.20.77.23]:59414 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYLYCLX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:23 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id AA3DB38262; Thu, 25 Dec 2008 02:11:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 799703821F;
	Thu, 25 Dec 2008 02:11:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103876>

Fetch time is usually dominated by network traffic, but while marking
objects reachable locally we can still benefit from the reduction in
object allocations this variant of getObjectId offers.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/WalkFetchConnection.java        |   29 +++++++++++--------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 91c5ea8..6300f10 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -59,6 +59,7 @@
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.MutableObjectId;
 import org.spearce.jgit.lib.ObjectChecker;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.PackIndex;
@@ -152,6 +153,8 @@
 	 */
 	private final Set<String> packsConsidered;
 
+	private final MutableObjectId idBuffer = new MutableObjectId();
+
 	/**
 	 * Errors received while trying to obtain an object.
 	 * <p>
@@ -300,16 +303,17 @@ private void processTree(final RevObject obj) throws TransportException {
 
 				switch (sType) {
 				case Constants.OBJ_BLOB:
-				case Constants.OBJ_TREE: {
-					final ObjectId sId = treeWalk.getObjectId(0);
-					needs(revWalk.lookupAny(sId, sType));
+				case Constants.OBJ_TREE:
+					treeWalk.getObjectId(idBuffer, 0);
+					needs(revWalk.lookupAny(idBuffer, sType));
 					continue;
-				}
+
 				default:
 					if (FileMode.GITLINK.equals(mode))
 						continue;
+					treeWalk.getObjectId(idBuffer, 0);
 					throw new CorruptObjectException("Invalid mode " + mode
-							+ " for " + treeWalk.getObjectId(0).name() + " "
+							+ " for " + idBuffer.name() + " "
 							+ treeWalk.getPathString() + " in "
 							+ obj.getId().name() + ".");
 				}
@@ -722,14 +726,14 @@ private void markTreeComplete(final RevTree tree) throws IOException {
 			final int sType = mode.getObjectType();
 
 			switch (sType) {
-			case Constants.OBJ_BLOB: {
-				final ObjectId sid = treeWalk.getObjectId(0);
-				revWalk.lookupAny(sid, sType).add(COMPLETE);
+			case Constants.OBJ_BLOB:
+				treeWalk.getObjectId(idBuffer, 0);
+				revWalk.lookupAny(idBuffer, sType).add(COMPLETE);
 				continue;
-			}
+
 			case Constants.OBJ_TREE: {
-				final ObjectId sid = treeWalk.getObjectId(0);
-				final RevObject o = revWalk.lookupAny(sid, sType);
+				treeWalk.getObjectId(idBuffer, 0);
+				final RevObject o = revWalk.lookupAny(idBuffer, sType);
 				if (!o.has(COMPLETE)) {
 					o.add(COMPLETE);
 					treeWalk.enterSubtree();
@@ -739,8 +743,9 @@ private void markTreeComplete(final RevTree tree) throws IOException {
 			default:
 				if (FileMode.GITLINK.equals(mode))
 					continue;
+				treeWalk.getObjectId(idBuffer, 0);
 				throw new CorruptObjectException("Invalid mode " + mode
-						+ " for " + treeWalk.getObjectId(0).name() + " "
+						+ " for " + idBuffer.name() + " "
 						+ treeWalk.getPathString() + " in " + tree.name() + ".");
 			}
 		}
-- 
1.6.1.rc4.301.g5497a
