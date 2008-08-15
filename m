From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH] Silently permit invalid ObjectIds during RefUpdate
Date: Fri, 15 Aug 2008 10:44:46 -0700
Message-ID: <1218822286-4069-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 19:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU3N2-0004Rq-FA
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 19:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbYHORos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 13:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbYHORos
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 13:44:48 -0400
Received: from george.spearce.org ([209.20.77.23]:35778 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999AbYHORor (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 13:44:47 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3629238376; Fri, 15 Aug 2008 17:44:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B8C8A38265;
	Fri, 15 Aug 2008 17:44:46 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc3.250.g8dd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92498>

If we try to parse objects which don't exist it may be because
we are trying to force deletion of a ref exactly because the
object the ref currently refers to has been pruned from the
object database already.  Rather than fail with an exception
we should still permit the removal.

This also fixes the breakage in the unit tests introduced by
Charles' 5a318367 "Refactor of RefUpdate force ...".  One of
the unit tests for RefUpdate is using a bad ObjectId as the
new value for the ref, and uses forceUpdate to hammer it into
the ref database anyway, even though it is not valid as the
object does not exist.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 858ba46..ca77b75 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -40,6 +40,7 @@
 import java.io.File;
 import java.io.IOException;
 
+import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.Ref.Storage;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevObject;
@@ -345,8 +346,8 @@ private Result updateImpl(final RevWalk walk, final Store store)
 			if (oldValue == null)
 				return store.store(lock, Result.NEW);
 
-			newObj = walk.parseAny(newValue);
-			oldObj = walk.parseAny(oldValue);
+			newObj = safeParse(walk, newValue);
+			oldObj = safeParse(walk, oldValue);
 			if (newObj == oldObj)
 				return Result.NO_CHANGE;
 
@@ -363,6 +364,20 @@ private Result updateImpl(final RevWalk walk, final Store store)
 		}
 	}
 
+	private static RevObject safeParse(final RevWalk rw, final AnyObjectId id)
+			throws IOException {
+		try {
+			return rw.parseAny(id);
+		} catch (MissingObjectException e) {
+			// We can expect some objects to be missing, like if we are
+			// trying to force a deletion of a branch and the object it
+			// points to has been pruned from the database due to freak
+			// corruption accidents (it happens with 'git new-work-dir').
+			//
+			return null;
+		}
+	}
+
 	private Result updateStore(final LockFile lock, final Result status)
 			throws IOException {
 		lock.setNeedStatInformation(true);
-- 
1.6.0.rc3.250.g8dd0
