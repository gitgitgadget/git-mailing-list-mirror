From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/12] Add test cases for parsing "\ No newline at end of file" style patches
Date: Fri, 12 Dec 2008 14:05:55 -0800
Message-ID: <1229119558-1293-10-git-send-email-spearce@spearce.org>
References: <1229119558-1293-1-git-send-email-spearce@spearce.org>
 <1229119558-1293-2-git-send-email-spearce@spearce.org>
 <1229119558-1293-3-git-send-email-spearce@spearce.org>
 <1229119558-1293-4-git-send-email-spearce@spearce.org>
 <1229119558-1293-5-git-send-email-spearce@spearce.org>
 <1229119558-1293-6-git-send-email-spearce@spearce.org>
 <1229119558-1293-7-git-send-email-spearce@spearce.org>
 <1229119558-1293-8-git-send-email-spearce@spearce.org>
 <1229119558-1293-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:08:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGBC-0004x0-Cj
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbYLLWGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbYLLWGQ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:16 -0500
Received: from george.spearce.org ([209.20.77.23]:50685 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbYLLWGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:04 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id CEB7738215; Fri, 12 Dec 2008 22:06:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2F42A3821F;
	Fri, 12 Dec 2008 22:06:01 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102952>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/PatchTest.java      |   68 ++++++++++++++++++++
 .../jgit/patch/testParse_AddNoNewline.patch        |   20 ++++++
 .../jgit/patch/testParse_FixNoNewline.patch        |   20 ++++++
 3 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_AddNoNewline.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_FixNoNewline.patch

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index c81356b..13eab5f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -228,6 +228,74 @@ assertTrue(fh.getNewName().startsWith(
 		assertEquals(272, fh.getHunks().get(0).getOldImage().getStartLine());
 	}
 
+	public void testParse_FixNoNewline() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		assertTrue(p.getErrors().isEmpty());
+
+		final FileHeader f = p.getFiles().get(0);
+
+		assertEquals("a", f.getNewName());
+		assertEquals(252, f.startOffset);
+
+		assertEquals("2e65efe", f.getOldId().name());
+		assertEquals("f2ad6c7", f.getNewId().name());
+		assertSame(FileHeader.PatchType.UNIFIED, f.getPatchType());
+		assertSame(FileMode.REGULAR_FILE, f.getOldMode());
+		assertSame(FileMode.REGULAR_FILE, f.getNewMode());
+		assertEquals(1, f.getHunks().size());
+		{
+			final HunkHeader h = f.getHunks().get(0);
+			assertSame(f, h.getFileHeader());
+			assertEquals(317, h.startOffset);
+			assertEquals(1, h.getOldImage().getStartLine());
+			assertEquals(1, h.getOldImage().getLineCount());
+			assertEquals(1, h.getNewStartLine());
+			assertEquals(1, h.getNewLineCount());
+
+			assertEquals(0, h.getLinesContext());
+			assertEquals(1, h.getOldImage().getLinesAdded());
+			assertEquals(1, h.getOldImage().getLinesDeleted());
+			assertSame(f.getOldId(), h.getOldImage().getId());
+
+			assertEquals(363, h.endOffset);
+		}
+	}
+
+	public void testParse_AddNoNewline() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		assertTrue(p.getErrors().isEmpty());
+
+		final FileHeader f = p.getFiles().get(0);
+
+		assertEquals("a", f.getNewName());
+		assertEquals(256, f.startOffset);
+
+		assertEquals("f2ad6c7", f.getOldId().name());
+		assertEquals("c59d9b6", f.getNewId().name());
+		assertSame(FileHeader.PatchType.UNIFIED, f.getPatchType());
+		assertSame(FileMode.REGULAR_FILE, f.getOldMode());
+		assertSame(FileMode.REGULAR_FILE, f.getNewMode());
+		assertEquals(1, f.getHunks().size());
+		{
+			final HunkHeader h = f.getHunks().get(0);
+			assertSame(f, h.getFileHeader());
+			assertEquals(321, h.startOffset);
+			assertEquals(1, h.getOldImage().getStartLine());
+			assertEquals(1, h.getOldImage().getLineCount());
+			assertEquals(1, h.getNewStartLine());
+			assertEquals(1, h.getNewLineCount());
+
+			assertEquals(0, h.getLinesContext());
+			assertEquals(1, h.getOldImage().getLinesAdded());
+			assertEquals(1, h.getOldImage().getLinesDeleted());
+			assertSame(f.getOldId(), h.getOldImage().getId());
+
+			assertEquals(367, h.endOffset);
+		}
+	}
+
 	private Patch parseTestPatchFile() throws IOException {
 		final String patchFile = getName() + ".patch";
 		final InputStream in = getClass().getResourceAsStream(patchFile);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_AddNoNewline.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_AddNoNewline.patch
new file mode 100644
index 0000000..3060952
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_AddNoNewline.patch
@@ -0,0 +1,20 @@
+From ca4719a4b2d93a469f61d1ddfb3e39ecbabfcd69 Mon Sep 17 00:00:00 2001
+From: Shawn O. Pearce <sop@google.com>
+Date: Fri, 12 Dec 2008 12:35:14 -0800
+Subject: [PATCH] introduce no lf again
+
+---
+ a |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/a b/a
+index f2ad6c7..c59d9b6 100644
+--- a/a
++++ b/a
+@@ -1 +1 @@
+-c
++d
+\ No newline at end of file
+-- 
+1.6.1.rc2.306.ge5d5e
+
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_FixNoNewline.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_FixNoNewline.patch
new file mode 100644
index 0000000..e8af2e7
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_FixNoNewline.patch
@@ -0,0 +1,20 @@
+From 1beb3ec1fe68ff18b0287396096442e12c34787a Mon Sep 17 00:00:00 2001
+From: Shawn O. Pearce <sop@google.com>
+Date: Fri, 12 Dec 2008 12:29:45 -0800
+Subject: [PATCH] make c and add lf
+
+---
+ a |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/a b/a
+index 2e65efe..f2ad6c7 100644
+--- a/a
++++ b/a
+@@ -1 +1 @@
+-a
+\ No newline at end of file
++c
+-- 
+1.6.1.rc2.306.ge5d5e
+
-- 
1.6.1.rc2.306.ge5d5e
