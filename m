From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH (RESEND) 1/3] Allow RefUpdate.setExpectedOldObjectId to accept RevCommit
Date: Tue,  1 Sep 2009 16:16:48 -0700
Message-ID: <1251847010-9992-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <sop@google.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 01:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Micaz-0003vt-KN
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 01:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbZIAXQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 19:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755362AbZIAXQt
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 19:16:49 -0400
Received: from george.spearce.org ([209.20.77.23]:40833 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353AbZIAXQs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 19:16:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3DD7D381FD; Tue,  1 Sep 2009 23:16:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 703C1381FD;
	Tue,  1 Sep 2009 23:16:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.1.341.gf2a44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127565>

RevCommit overrides .equals() such that it only implements a
reference equality test.  If the expected old ObjectId was set
by the application to a RevCommit instance, it would always fail,
resulting in LOCK_FAILURE.  Instead use AnyObject.equals() to compare
the value, ignoring the possibly overloaded equals in RevCommit.

Signed-off-by: Shawn O. Pearce <sop@google.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |   52 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefUpdate.java        |    2 +-
 2 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 800c0a4..a8ccf43 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -45,6 +45,7 @@
 
 import org.spearce.jgit.lib.RefUpdate.Result;
 import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevWalk;
 
 public class RefUpdateTest extends RepositoryTestCase {
 
@@ -397,6 +398,57 @@ public void testUpdateRefLockFailureWrongOldValue() throws IOException {
 	}
 
 	/**
+	 * Try modify a ref forward, fast forward, checking old value first
+	 *
+	 * @throws IOException
+	 */
+	public void testUpdateRefForwardWithCheck1() throws IOException {
+		ObjectId ppid = db.resolve("refs/heads/master^");
+		ObjectId pid = db.resolve("refs/heads/master");
+
+		RefUpdate updateRef = db.updateRef("refs/heads/master");
+		updateRef.setNewObjectId(ppid);
+		updateRef.setForceUpdate(true);
+		Result update = updateRef.update();
+		assertEquals(Result.FORCED, update);
+		assertEquals(ppid, db.resolve("refs/heads/master"));
+
+		// real test
+		RefUpdate updateRef2 = db.updateRef("refs/heads/master");
+		updateRef2.setExpectedOldObjectId(ppid);
+		updateRef2.setNewObjectId(pid);
+		Result update2 = updateRef2.update();
+		assertEquals(Result.FAST_FORWARD, update2);
+		assertEquals(pid, db.resolve("refs/heads/master"));
+	}
+
+	/**
+	 * Try modify a ref forward, fast forward, checking old commit first
+	 *
+	 * @throws IOException
+	 */
+	public void testUpdateRefForwardWithCheck2() throws IOException {
+		ObjectId ppid = db.resolve("refs/heads/master^");
+		ObjectId pid = db.resolve("refs/heads/master");
+
+		RefUpdate updateRef = db.updateRef("refs/heads/master");
+		updateRef.setNewObjectId(ppid);
+		updateRef.setForceUpdate(true);
+		Result update = updateRef.update();
+		assertEquals(Result.FORCED, update);
+		assertEquals(ppid, db.resolve("refs/heads/master"));
+
+		// real test
+		RevCommit old = new RevWalk(db).parseCommit(ppid);
+		RefUpdate updateRef2 = db.updateRef("refs/heads/master");
+		updateRef2.setExpectedOldObjectId(old);
+		updateRef2.setNewObjectId(pid);
+		Result update2 = updateRef2.update();
+		assertEquals(Result.FAST_FORWARD, update2);
+		assertEquals(pid, db.resolve("refs/heads/master"));
+	}
+
+	/**
 	 * Try modify a ref that is locked
 	 *
 	 * @throws IOException
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 69399ec..8dffed2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -466,7 +466,7 @@ private Result updateImpl(final RevWalk walk, final Store store)
 			if (expValue != null) {
 				final ObjectId o;
 				o = oldValue != null ? oldValue : ObjectId.zeroId();
-				if (!expValue.equals(o))
+				if (!AnyObjectId.equals(expValue, o))
 					return Result.LOCK_FAILURE;
 			}
 			if (oldValue == null)
-- 
1.6.4.1.341.gf2a44
