From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/12] Use FileMode.MISSING when a file is added or deleted rather than null
Date: Fri, 12 Dec 2008 14:05:56 -0800
Message-ID: <1229119558-1293-11-git-send-email-spearce@spearce.org>
References: <1229119558-1293-1-git-send-email-spearce@spearce.org>
 <1229119558-1293-2-git-send-email-spearce@spearce.org>
 <1229119558-1293-3-git-send-email-spearce@spearce.org>
 <1229119558-1293-4-git-send-email-spearce@spearce.org>
 <1229119558-1293-5-git-send-email-spearce@spearce.org>
 <1229119558-1293-6-git-send-email-spearce@spearce.org>
 <1229119558-1293-7-git-send-email-spearce@spearce.org>
 <1229119558-1293-8-git-send-email-spearce@spearce.org>
 <1229119558-1293-9-git-send-email-spearce@spearce.org>
 <1229119558-1293-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:08:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGBE-0004x0-Rx
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbYLLWGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbYLLWGU
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:20 -0500
Received: from george.spearce.org ([209.20.77.23]:50688 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbYLLWGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:04 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 44AA23821F; Fri, 12 Dec 2008 22:06:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7CB8A38194;
	Fri, 12 Dec 2008 22:06:01 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102959>

Null is better used to indicate "no mode information at all" in the
patch, while FileMode.MISSING is already commonly used within the
TreeWalk code to mean "this path doesn't exist in this tree".  In
the context of a patch to create or delete a file, MISSING makes a
lot more sense for the application to work with.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/FileHeaderTest.java |    4 ++--
 .../tst/org/spearce/jgit/patch/PatchTest.java      |    1 +
 .../src/org/spearce/jgit/patch/FileHeader.java     |    2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
index 36c528e..69e06ab 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
@@ -153,7 +153,7 @@ public void testParseUnicodeName_NewFile() {
 		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
 		assertTrue(fh.hasMetaDataChanges());
 
-		assertNull(fh.getOldMode());
+		assertSame(FileMode.MISSING, fh.getOldMode());
 		assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
 
 		assertEquals("0000000", fh.getOldId().name());
@@ -179,7 +179,7 @@ public void testParseUnicodeName_DeleteFile() {
 		assertTrue(fh.hasMetaDataChanges());
 
 		assertSame(FileMode.REGULAR_FILE, fh.getOldMode());
-		assertNull(fh.getNewMode());
+		assertSame(FileMode.MISSING, fh.getNewMode());
 
 		assertEquals("7898192", fh.getOldId().name());
 		assertEquals("0000000", fh.getNewId().name());
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index 13eab5f..2c617d3 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -160,6 +160,7 @@ public void testParse_NoBinary() throws IOException {
 			assertNotNull(fh.getOldId());
 			assertNotNull(fh.getNewId());
 			assertEquals("0000000", fh.getOldId().name());
+			assertSame(FileMode.MISSING, fh.getOldMode());
 			assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
 			assertTrue(fh.getNewName().startsWith(
 					"org.spearce.egit.ui/icons/toolbar/"));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index f93129d..48d7623 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -386,9 +386,11 @@ int parseGitHeaders(int ptr, final int end) {
 
 			} else if (match(buf, ptr, DELETED_FILE_MODE) >= 0) {
 				oldMode = parseFileMode(ptr + DELETED_FILE_MODE.length, eol);
+				newMode = FileMode.MISSING;
 				changeType = ChangeType.DELETE;
 
 			} else if (match(buf, ptr, NEW_FILE_MODE) >= 0) {
+				oldMode = FileMode.MISSING;
 				newMode = parseFileMode(ptr + NEW_FILE_MODE.length, eol);
 				changeType = ChangeType.ADD;
 
-- 
1.6.1.rc2.306.ge5d5e
