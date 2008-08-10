From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 09/11] Expose idBuffer,idOffset in AbstractTreeIterator to applications
Date: Sun, 10 Aug 2008 01:46:24 -0700
Message-ID: <1218357986-19671-10-git-send-email-spearce@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org>
 <1218357986-19671-2-git-send-email-spearce@spearce.org>
 <1218357986-19671-3-git-send-email-spearce@spearce.org>
 <1218357986-19671-4-git-send-email-spearce@spearce.org>
 <1218357986-19671-5-git-send-email-spearce@spearce.org>
 <1218357986-19671-6-git-send-email-spearce@spearce.org>
 <1218357986-19671-7-git-send-email-spearce@spearce.org>
 <1218357986-19671-8-git-send-email-spearce@spearce.org>
 <1218357986-19671-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6b6-00020G-Ta
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbYHJIqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYHJIqs
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:48 -0400
Received: from george.spearce.org ([209.20.77.23]:51266 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbYHJIqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id EDDA03838B; Sun, 10 Aug 2008 08:46:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4AE9B38375;
	Sun, 10 Aug 2008 08:46:32 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
In-Reply-To: <1218357986-19671-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91821>

Application code needs to be able to efficiently copy an id from
an iterator's current position to some buffer, such as in the
index file or a tree object, or any other data structure.  Doing
a conversion to ObjectId and then back again to the raw byte form
is less efficient than just copying the bytes between two arrays.

So these methods must be public for performance reasons, even if
it makes the object API slightly more obtuse.  Besides we still
have getEntryObjectId should applications prefer that approach
and they don't need the performance.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/AbstractTreeIterator.java        |    4 ++--
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |    4 ++--
 .../spearce/jgit/treewalk/EmptyTreeIterator.java   |    4 ++--
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index cf67836..6d7159c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -321,7 +321,7 @@ public abstract class AbstractTreeIterator {
 	 * @return byte array the implementation stores object IDs within.
 	 * @see #getEntryObjectId()
 	 */
-	protected abstract byte[] idBuffer();
+	public abstract byte[] idBuffer();
 
 	/**
 	 * Get the position within {@link #idBuffer()} of this entry's ObjectId.
@@ -329,7 +329,7 @@ public abstract class AbstractTreeIterator {
 	 * @return offset into the array returned by {@link #idBuffer()} where the
 	 *         ObjectId must be copied out of.
 	 */
-	protected abstract int idOffset();
+	public abstract int idOffset();
 
 	/**
 	 * Create a new iterator for the current entry's subtree.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index 56bcab0..55942ed 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -112,12 +112,12 @@ public class CanonicalTreeParser extends AbstractTreeIterator {
 	}
 
 	@Override
-	protected byte[] idBuffer() {
+	public byte[] idBuffer() {
 		return raw;
 	}
 
 	@Override
-	protected int idOffset() {
+	public int idOffset() {
 		return rawPtr - Constants.OBJECT_ID_LENGTH;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
index 73557bc..09d2bde 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/EmptyTreeIterator.java
@@ -69,12 +69,12 @@ public class EmptyTreeIterator extends AbstractTreeIterator {
 	}
 
 	@Override
-	protected byte[] idBuffer() {
+	public byte[] idBuffer() {
 		return zeroid;
 	}
 
 	@Override
-	protected int idOffset() {
+	public int idOffset() {
 		return 0;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index 05d9282..4ac711b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -131,7 +131,7 @@ public abstract class WorkingTreeIterator extends AbstractTreeIterator {
 	}
 
 	@Override
-	protected byte[] idBuffer() {
+	public byte[] idBuffer() {
 		if (contentIdFromPtr == ptr - 1)
 			return contentId;
 		if (entries == EOF)
@@ -229,7 +229,7 @@ public abstract class WorkingTreeIterator extends AbstractTreeIterator {
 	}
 
 	@Override
-	protected int idOffset() {
+	public int idOffset() {
 		return 0;
 	}
 
-- 
1.6.0.rc2.219.g1250ab
