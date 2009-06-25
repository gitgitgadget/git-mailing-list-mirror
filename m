From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH] Fixed RefUpdateTest.tryRenameWhenLocked() family of tests
Date: Thu, 25 Jun 2009 17:38:07 +0400
Message-ID: <1245937087-5144-1-git-send-email-constantine.plotnikov@gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 15:38:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJp9s-0003Bs-66
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 15:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbZFYNiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 09:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbZFYNiU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 09:38:20 -0400
Received: from mail.intellij.net ([213.182.181.98]:43975 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbZFYNiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 09:38:18 -0400
Received: (qmail 12234 invoked by uid 89); 25 Jun 2009 13:38:07 -0000
Received: by simscan 1.1.0 ppid: 12191, pid: 12226, t: 0.0055s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 25 Jun 2009 13:38:07 -0000
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122212>

If file is left locked after the test, the cleanup does
not work on Windows since locked files cannot be deleted. 
The patch adds unlock for the aquired lock, so the cleanup 
now works.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
This is a second time the problem occurs. Please release all locks
that are being acquired, otherwise the tests will fail on Windows.
 
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |   51 +++++++++++---------
 1 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 83eb4ed..ec00fac 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -463,29 +463,34 @@ assertTrue("internal check, we have a log", new File(db.getDirectory(),
 				"logs/" + fromName).exists());
 
 		// "someone" has branch X locked
-		assertTrue(new LockFile(new File(db.getDirectory(), toLock)).lock());
-
-		// Now this is our test
-		RefRename renameRef = db.renameRef(fromName, toName);
-		Result result = renameRef.rename();
-		assertEquals(Result.LOCK_FAILURE, result);
-
-		// Check that the involved refs are the same despite the failure
-		assertExists(false, toName);
-		if (!toLock.equals(toName))
-			assertExists(false, toName + ".lock");
-		assertExists(true, toLock + ".lock");
-		if (!toLock.equals(fromName))
-			assertExists(false, "logs/" + fromName + ".lock");
-		assertExists(false, "logs/" + toName + ".lock");
-		assertEquals(oldHeadId, db.resolve(Constants.HEAD));
-		assertEquals(oldfromId, db.resolve(fromName));
-		assertNull(db.resolve(toName));
-		assertEquals(oldFromLog.toString(), db.getReflogReader(fromName)
-				.getReverseEntries().toString());
-		if (oldHeadId != null)
-			assertEquals(oldHeadLog, db.getReflogReader(Constants.HEAD)
-					.getReverseEntries());
+		LockFile lockFile = new LockFile(new File(db.getDirectory(), toLock));
+		try {
+			assertTrue(lockFile.lock());
+
+			// Now this is our test
+			RefRename renameRef = db.renameRef(fromName, toName);
+			Result result = renameRef.rename();
+			assertEquals(Result.LOCK_FAILURE, result);
+	
+			// Check that the involved refs are the same despite the failure
+			assertExists(false, toName);
+			if (!toLock.equals(toName))
+				assertExists(false, toName + ".lock");
+			assertExists(true, toLock + ".lock");
+			if (!toLock.equals(fromName))
+				assertExists(false, "logs/" + fromName + ".lock");
+			assertExists(false, "logs/" + toName + ".lock");
+			assertEquals(oldHeadId, db.resolve(Constants.HEAD));
+			assertEquals(oldfromId, db.resolve(fromName));
+			assertNull(db.resolve(toName));
+			assertEquals(oldFromLog.toString(), db.getReflogReader(fromName)
+					.getReverseEntries().toString());
+			if (oldHeadId != null)
+				assertEquals(oldHeadLog, db.getReflogReader(Constants.HEAD)
+						.getReverseEntries());
+		} finally {
+			lockFile.unlock();
+		}
 	}
 
 	private void assertExists(boolean positive, String toName) {
-- 
1.6.1.2
