From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/23] Allow TreeWalk callers to pass a MutableObjectId to get the current id
Date: Wed, 24 Dec 2008 18:10:59 -0800
Message-ID: <1230171079-17156-4-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjG-00029A-RY
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbYLYCLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYLYCL1
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:27 -0500
Received: from george.spearce.org ([209.20.77.23]:59409 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbYLYCLX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:23 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id E4B8138239; Thu, 25 Dec 2008 02:11:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E509738197;
	Thu, 25 Dec 2008 02:11:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103873>

This avoids a memory allocation associated with getting the entry
object for each name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   28 +++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 26544b5..38a726b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -46,6 +46,7 @@
 import org.spearce.jgit.errors.StopWalkException;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.MutableObjectId;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revwalk.RevTree;
@@ -513,7 +514,8 @@ public FileMode getFileMode(final int nth) {
 	 * <p>
 	 * Using this method to compare ObjectId values between trees of this walker
 	 * is very inefficient. Applications should try to use
-	 * {@link #idEqual(int, int)} whenever possible.
+	 * {@link #idEqual(int, int)} or {@link #getObjectId(MutableObjectId, int)}
+	 * whenever possible.
 	 * <p>
 	 * Every tree supplies an object id, even if the tree does not contain the
 	 * current entry. In the latter case {@link ObjectId#zeroId()} is returned.
@@ -521,6 +523,7 @@ public FileMode getFileMode(final int nth) {
 	 * @param nth
 	 *            tree to obtain the object identifier from.
 	 * @return object identifier for the current tree entry.
+	 * @see #getObjectId(MutableObjectId, int)
 	 * @see #idEqual(int, int)
 	 */
 	public ObjectId getObjectId(final int nth) {
@@ -530,6 +533,29 @@ public ObjectId getObjectId(final int nth) {
 	}
 
 	/**
+	 * Obtain the ObjectId for the current entry.
+	 * <p>
+	 * Every tree supplies an object id, even if the tree does not contain the
+	 * current entry. In the latter case {@link ObjectId#zeroId()} is supplied.
+	 * <p>
+	 * Applications should try to use {@link #idEqual(int, int)} when possible
+	 * as it avoids conversion overheads.
+	 * 
+	 * @param out
+	 *            buffer to copy the object id into.
+	 * @param nth
+	 *            tree to obtain the object identifier from.
+	 * @see #idEqual(int, int)
+	 */
+	public void getObjectId(final MutableObjectId out, final int nth) {
+		final AbstractTreeIterator t = trees[nth];
+		if (t.matches == currentHead)
+			out.fromRaw(t.idBuffer(), t.idOffset());
+		else
+			out.clear();
+	}
+
+	/**
 	 * Compare two tree's current ObjectId values for equality.
 	 * 
 	 * @param nthA
-- 
1.6.1.rc4.301.g5497a
