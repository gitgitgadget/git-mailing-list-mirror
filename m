From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/12] Add a test for delta binary patch parsing and fix a bug in it
Date: Fri, 12 Dec 2008 14:05:57 -0800
Message-ID: <1229119558-1293-12-git-send-email-spearce@spearce.org>
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
 <1229119558-1293-11-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:08:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGBG-0004x0-Qb
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbYLLWG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754912AbYLLWG2
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:28 -0500
Received: from george.spearce.org ([209.20.77.23]:50671 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbYLLWGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:04 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id D54FA38211; Fri, 12 Dec 2008 22:06:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C793038210;
	Fri, 12 Dec 2008 22:06:01 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102958>

We had the wrong header code in this case, so we didn't parse
the length correctly for delta style binary hunks.  Without a
test case for it we never noticed the problem.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/PatchTest.java      |   39 +++++++++++++++++++-
 .../jgit/patch/testParse_GitBinaryDelta.patch      |   21 +++++++++++
 ...nary.patch => testParse_GitBinaryLiteral.patch} |    0
 .../src/org/spearce/jgit/patch/BinaryHunk.java     |    2 +-
 4 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinaryDelta.patch
 rename org.spearce.jgit.test/tst/org/spearce/jgit/patch/{testParse_GitBinary.patch => testParse_GitBinaryLiteral.patch} (100%)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index 2c617d3..8309951 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -184,7 +184,7 @@ assertTrue(fh.getNewName().startsWith(
 		assertEquals(272, fh.getHunks().get(0).getOldImage().getStartLine());
 	}
 
-	public void testParse_GitBinary() throws IOException {
+	public void testParse_GitBinaryLiteral() throws IOException {
 		final Patch p = parseTestPatchFile();
 		final int[] binsizes = { 359, 393, 372, 404 };
 		assertEquals(5, p.getFiles().size());
@@ -229,6 +229,43 @@ assertTrue(fh.getNewName().startsWith(
 		assertEquals(272, fh.getHunks().get(0).getOldImage().getStartLine());
 	}
 
+	public void testParse_GitBinaryDelta() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		assertTrue(p.getErrors().isEmpty());
+
+		final FileHeader fh = p.getFiles().get(0);
+		assertTrue(fh.getNewName().startsWith("zero.bin"));
+		assertSame(FileHeader.ChangeType.MODIFY, fh.getChangeType());
+		assertSame(FileHeader.PatchType.GIT_BINARY, fh.getPatchType());
+		assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
+
+		assertNotNull(fh.getOldId());
+		assertNotNull(fh.getNewId());
+		assertEquals("08e7df176454f3ee5eeda13efa0adaa54828dfd8", fh.getOldId()
+				.name());
+		assertEquals("d70d8710b6d32ff844af0ee7c247e4b4b051867f", fh.getNewId()
+				.name());
+
+		assertTrue(fh.getHunks().isEmpty());
+		assertFalse(fh.hasMetaDataChanges());
+
+		final BinaryHunk fwd = fh.getForwardBinaryHunk();
+		final BinaryHunk rev = fh.getReverseBinaryHunk();
+		assertNotNull(fwd);
+		assertNotNull(rev);
+		assertEquals(12, fwd.getSize());
+		assertEquals(11, rev.getSize());
+
+		assertSame(fh, fwd.getFileHeader());
+		assertSame(fh, rev.getFileHeader());
+
+		assertSame(BinaryHunk.Type.DELTA_DEFLATED, fwd.getType());
+		assertSame(BinaryHunk.Type.DELTA_DEFLATED, rev.getType());
+
+		assertEquals(496, fh.endOffset);
+	}
+
 	public void testParse_FixNoNewline() throws IOException {
 		final Patch p = parseTestPatchFile();
 		assertEquals(1, p.getFiles().size());
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinaryDelta.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinaryDelta.patch
new file mode 100644
index 0000000..5b2c9c6
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinaryDelta.patch
@@ -0,0 +1,21 @@
+From 7e49721ad0efdec3a81e20bc58e385ea5d2b87b7 Mon Sep 17 00:00:00 2001
+From: Shawn O. Pearce <sop@google.com>
+Date: Fri, 12 Dec 2008 12:45:17 -0800
+Subject: [PATCH] make zero have a 3
+
+---
+ zero.bin |  Bin 4096 -> 4096 bytes
+ 1 files changed, 0 insertions(+), 0 deletions(-)
+
+diff --git a/zero.bin b/zero.bin
+index 08e7df176454f3ee5eeda13efa0adaa54828dfd8..d70d8710b6d32ff844af0ee7c247e4b4b051867f 100644
+GIT binary patch
+delta 12
+TcmZorXi%6C%4ociaTPxR8IA+R
+
+delta 11
+ScmZorXi(Uguz-JJK>`37u>@iO
+
+-- 
+1.6.1.rc2.306.ge5d5e
+
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinary.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinaryLiteral.patch
similarity index 100%
rename from org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinary.patch
rename to org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinaryLiteral.patch
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java b/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
index 3e07ec4..92eab86 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
@@ -100,7 +100,7 @@ int parseHunk(int ptr, final int end) {
 
 		} else if (match(buf, ptr, DELTA) >= 0) {
 			type = Type.DELTA_DEFLATED;
-			length = parseBase10(buf, ptr + LITERAL.length, null);
+			length = parseBase10(buf, ptr + DELTA.length, null);
 
 		} else {
 			// Not a valid binary hunk. Signal to the caller that
-- 
1.6.1.rc2.306.ge5d5e
