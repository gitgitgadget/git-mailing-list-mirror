From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/23] Switch ObjectWalk to use the new MutableObjectId form in TreeWalk
Date: Wed, 24 Dec 2008 18:11:00 -0800
Message-ID: <1230171079-17156-5-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
 <1230171079-17156-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjH-00029A-Gv
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYLYCLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbYLYCL2
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:28 -0500
Received: from george.spearce.org ([209.20.77.23]:59412 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbYLYCLX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:23 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4A5DD38260; Thu, 25 Dec 2008 02:11:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 336BB38211;
	Thu, 25 Dec 2008 02:11:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103866>

RevWalk already has an idBuffer field available, which is used by
the commit and tree parsers to hold an id they need to probe for
in the hash table.  We should be using that buffer during tree
entry iteration as it avoids object allocation.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index 69a20aa..454cb4a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -251,7 +251,8 @@ public RevObject nextObject() throws MissingObjectException,
 
 			switch (sType) {
 			case Constants.OBJ_BLOB: {
-				final RevObject o = lookupAny(treeWalk.getObjectId(0), sType);
+				treeWalk.getObjectId(idBuffer, 0);
+				final RevObject o = lookupAny(idBuffer, sType);
 				if ((o.flags & SEEN) != 0)
 					continue;
 				o.flags |= SEEN;
@@ -262,7 +263,8 @@ public RevObject nextObject() throws MissingObjectException,
 				return o;
 			}
 			case Constants.OBJ_TREE: {
-				final RevObject o = lookupAny(treeWalk.getObjectId(0), sType);
+				treeWalk.getObjectId(idBuffer, 0);
+				final RevObject o = lookupAny(idBuffer, sType);
 				if ((o.flags & SEEN) != 0)
 					continue;
 				o.flags |= SEEN;
@@ -276,8 +278,9 @@ public RevObject nextObject() throws MissingObjectException,
 			default:
 				if (FileMode.GITLINK.equals(mode))
 					continue;
+				treeWalk.getObjectId(idBuffer, 0);
 				throw new CorruptObjectException("Invalid mode " + mode
-						+ " for " + treeWalk.getObjectId(0).name() + " "
+						+ " for " + idBuffer.name() + " "
 						+ treeWalk.getPathString() + " in " + currentTree + ".");
 			}
 		}
@@ -390,13 +393,13 @@ private void markTreeUninteresting(final RevTree tree)
 
 			switch (sType) {
 			case Constants.OBJ_BLOB: {
-				final ObjectId sid = treeWalk.getObjectId(0);
-				lookupAny(sid, sType).flags |= UNINTERESTING;
+				treeWalk.getObjectId(idBuffer, 0);
+				lookupAny(idBuffer, sType).flags |= UNINTERESTING;
 				continue;
 			}
 			case Constants.OBJ_TREE: {
-				final ObjectId sid = treeWalk.getObjectId(0);
-				final RevObject subtree = lookupAny(sid, sType);
+				treeWalk.getObjectId(idBuffer, 0);
+				final RevObject subtree = lookupAny(idBuffer, sType);
 				if ((subtree.flags & UNINTERESTING) == 0) {
 					subtree.flags |= UNINTERESTING;
 					treeWalk.enterSubtree();
@@ -406,8 +409,9 @@ private void markTreeUninteresting(final RevTree tree)
 			default:
 				if (FileMode.GITLINK.equals(mode))
 					continue;
+				treeWalk.getObjectId(idBuffer, 0);
 				throw new CorruptObjectException("Invalid mode " + mode
-						+ " for " + treeWalk.getObjectId(0).name() + " "
+						+ " for " + idBuffer.name() + " "
 						+ treeWalk.getPathString() + " in " + tree + ".");
 			}
 		}
-- 
1.6.1.rc4.301.g5497a
