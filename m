From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH] Fixed the test testUpdateRefLockFailureLocked broken on the Windows platform
Date: Tue, 23 Jun 2009 16:01:35 +0400
Message-ID: <1245758495-2212-1-git-send-email-constantine.plotnikov@gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 14:08:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ4ng-00071u-9t
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 14:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbZFWMIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 08:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbZFWMIV
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 08:08:21 -0400
Received: from mail.intellij.net ([213.182.181.98]:58347 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZFWMIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 08:08:20 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2009 08:08:19 EDT
Received: (qmail 17503 invoked by uid 89); 23 Jun 2009 12:01:36 -0000
Received: by simscan 1.1.0 ppid: 17449, pid: 17495, t: 0.0039s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 23 Jun 2009 12:01:36 -0000
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122084>

On Windows the lock is aquired in the test testUpdateRefLockFailureLocked
(RefUpdateTest) for the file but it never released. This causes test
failure during resource cleanup, since locked file could not be deleted
on Windows. This commits adds unlock operation in the finally block,
so there is no more cleanup problem.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 6b1975a..b14f19a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -255,12 +255,16 @@ public void testUpdateRefLockFailureLocked() throws IOException {
 		RefUpdate updateRef = db.updateRef("refs/heads/master");
 		updateRef.setNewObjectId(pid);
 		LockFile lockFile1 = new LockFile(new File(db.getDirectory(),"refs/heads/master"));
-		assertTrue(lockFile1.lock()); // precondition to test
-		Result update = updateRef.update();
-		assertEquals(Result.LOCK_FAILURE, update);
-		assertEquals(opid, db.resolve("refs/heads/master"));
-		LockFile lockFile2 = new LockFile(new File(db.getDirectory(),"refs/heads/master"));
-		assertFalse(lockFile2.lock()); // was locked, still is
+		try {
+			assertTrue(lockFile1.lock()); // precondition to test
+			Result update = updateRef.update();
+			assertEquals(Result.LOCK_FAILURE, update);
+			assertEquals(opid, db.resolve("refs/heads/master"));
+			LockFile lockFile2 = new LockFile(new File(db.getDirectory(),"refs/heads/master"));
+			assertFalse(lockFile2.lock()); // was locked, still is
+		} finally {
+			lockFile1.unlock();
+		}
 	}
 
 	/**
-- 
1.6.1.2
