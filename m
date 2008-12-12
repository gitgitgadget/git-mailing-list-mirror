From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/15] Set empty patches with no Git metadata to PatchType.BINARY
Date: Thu, 11 Dec 2008 18:46:13 -0800
Message-ID: <1229049981-14152-8-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
 <1229049981-14152-3-git-send-email-spearce@spearce.org>
 <1229049981-14152-4-git-send-email-spearce@spearce.org>
 <1229049981-14152-5-git-send-email-spearce@spearce.org>
 <1229049981-14152-6-git-send-email-spearce@spearce.org>
 <1229049981-14152-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy50-00057A-Es
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226AbYLLCqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757276AbYLLCql
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:41 -0500
Received: from george.spearce.org ([209.20.77.23]:41581 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252AbYLLCq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:29 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id C85FA3821F; Fri, 12 Dec 2008 02:46:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1D70638222;
	Fri, 12 Dec 2008 02:46:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102876>

If a patch has no Git specific metadata and it has no hunks then
it is very likely a binary patch with a "Binary files ... differ"
warning message in a different language, or the message has been
mangled by an editor.  We should consider such patches to be the
same as a binary patch, as there is nothing here to perform an
action on.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/FileHeaderTest.java |   18 ++++++++++++++++++
 .../tst/org/spearce/jgit/patch/PatchTest.java      |    2 ++
 .../src/org/spearce/jgit/patch/FileHeader.java     |    5 +++++
 .../src/org/spearce/jgit/patch/Patch.java          |   18 ++++++++++++++----
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
index d8696a9..4c2140a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
@@ -48,6 +48,7 @@ public void testParseGitFileName_Empty() {
 		assertEquals(-1, fh.parseGitFileName(0));
 		assertNotNull(fh.getHunks());
 		assertTrue(fh.getHunks().isEmpty());
+		assertFalse(fh.hasMetaDataChanges());
 	}
 
 	public void testParseGitFileName_NoLF() {
@@ -68,6 +69,7 @@ public void testParseGitFileName_Foo() {
 		assertEquals(gitLine(name).length(), fh.parseGitFileName(0));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
+		assertFalse(fh.hasMetaDataChanges());
 	}
 
 	public void testParseGitFileName_FailFooBar() {
@@ -75,6 +77,7 @@ public void testParseGitFileName_FailFooBar() {
 		assertTrue(fh.parseGitFileName(0) > 0);
 		assertNull(fh.getOldName());
 		assertNull(fh.getNewName());
+		assertFalse(fh.hasMetaDataChanges());
 	}
 
 	public void testParseGitFileName_FooSpBar() {
@@ -83,6 +86,7 @@ public void testParseGitFileName_FooSpBar() {
 		assertEquals(gitLine(name).length(), fh.parseGitFileName(0));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
+		assertFalse(fh.hasMetaDataChanges());
 	}
 
 	public void testParseGitFileName_DqFooTabBar() {
@@ -92,6 +96,7 @@ public void testParseGitFileName_DqFooTabBar() {
 		assertEquals(dqGitLine(dqName).length(), fh.parseGitFileName(0));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
+		assertFalse(fh.hasMetaDataChanges());
 	}
 
 	public void testParseGitFileName_DqFooSpLfNulBar() {
@@ -101,6 +106,7 @@ public void testParseGitFileName_DqFooSpLfNulBar() {
 		assertEquals(dqGitLine(dqName).length(), fh.parseGitFileName(0));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
+		assertFalse(fh.hasMetaDataChanges());
 	}
 
 	public void testParseGitFileName_SrcFooC() {
@@ -109,6 +115,7 @@ public void testParseGitFileName_SrcFooC() {
 		assertEquals(gitLine(name).length(), fh.parseGitFileName(0));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
+		assertFalse(fh.hasMetaDataChanges());
 	}
 
 	public void testParseGitFileName_SrcFooCNonStandardPrefix() {
@@ -118,6 +125,7 @@ public void testParseGitFileName_SrcFooCNonStandardPrefix() {
 		assertEquals(header.length(), fh.parseGitFileName(0));
 		assertEquals(name, fh.getOldName());
 		assertSame(fh.getOldName(), fh.getNewName());
+		assertFalse(fh.hasMetaDataChanges());
 	}
 
 	public void testParseUnicodeName_NewFile() {
@@ -135,6 +143,7 @@ public void testParseUnicodeName_NewFile() {
 
 		assertSame(FileHeader.ChangeType.ADD, fh.getChangeType());
 		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
+		assertTrue(fh.hasMetaDataChanges());
 
 		assertNull(fh.getOldMode());
 		assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
@@ -159,6 +168,7 @@ public void testParseUnicodeName_DeleteFile() {
 
 		assertSame(FileHeader.ChangeType.DELETE, fh.getChangeType());
 		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
+		assertTrue(fh.hasMetaDataChanges());
 
 		assertSame(FileMode.REGULAR_FILE, fh.getOldMode());
 		assertNull(fh.getNewMode());
@@ -177,6 +187,7 @@ public void testParseModeChange() {
 
 		assertSame(FileHeader.ChangeType.MODIFY, fh.getChangeType());
 		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
+		assertTrue(fh.hasMetaDataChanges());
 
 		assertNull(fh.getOldId());
 		assertNull(fh.getNewId());
@@ -204,6 +215,7 @@ public void testParseRename100_NewStyle() {
 
 		assertSame(FileHeader.ChangeType.RENAME, fh.getChangeType());
 		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
+		assertTrue(fh.hasMetaDataChanges());
 
 		assertNull(fh.getOldId());
 		assertNull(fh.getNewId());
@@ -232,6 +244,7 @@ public void testParseRename100_OldStyle() {
 
 		assertSame(FileHeader.ChangeType.RENAME, fh.getChangeType());
 		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
+		assertTrue(fh.hasMetaDataChanges());
 
 		assertNull(fh.getOldId());
 		assertNull(fh.getNewId());
@@ -260,6 +273,7 @@ public void testParseCopy100() {
 
 		assertSame(FileHeader.ChangeType.COPY, fh.getChangeType());
 		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
+		assertTrue(fh.hasMetaDataChanges());
 
 		assertNull(fh.getOldId());
 		assertNull(fh.getNewId());
@@ -282,6 +296,7 @@ public void testParseFullIndexLine_WithMode() {
 
 		assertSame(FileMode.REGULAR_FILE, fh.getOldMode());
 		assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
+		assertFalse(fh.hasMetaDataChanges());
 
 		assertNotNull(fh.getOldId());
 		assertNotNull(fh.getNewId());
@@ -302,6 +317,7 @@ public void testParseFullIndexLine_NoMode() {
 
 		assertEquals("a", fh.getOldName());
 		assertEquals("a", fh.getNewName());
+		assertFalse(fh.hasMetaDataChanges());
 
 		assertNull(fh.getOldMode());
 		assertNull(fh.getNewMode());
@@ -330,6 +346,7 @@ public void testParseAbbrIndexLine_WithMode() {
 
 		assertSame(FileMode.REGULAR_FILE, fh.getOldMode());
 		assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
+		assertFalse(fh.hasMetaDataChanges());
 
 		assertNotNull(fh.getOldId());
 		assertNotNull(fh.getNewId());
@@ -358,6 +375,7 @@ public void testParseAbbrIndexLine_NoMode() {
 
 		assertNull(fh.getOldMode());
 		assertNull(fh.getNewMode());
+		assertFalse(fh.hasMetaDataChanges());
 
 		assertNotNull(fh.getOldId());
 		assertNotNull(fh.getNewId());
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index 833bf5d..bf37063 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -156,12 +156,14 @@ assertTrue(fh.getNewName().startsWith(
 					"org.spearce.egit.ui/icons/toolbar/"));
 			assertSame(FileHeader.PatchType.BINARY, fh.getPatchType());
 			assertTrue(fh.getHunks().isEmpty());
+			assertTrue(fh.hasMetaDataChanges());
 		}
 
 		final FileHeader fh = p.getFiles().get(4);
 		assertEquals("org.spearce.egit.ui/plugin.xml", fh.getNewName());
 		assertSame(FileHeader.ChangeType.MODIFY, fh.getChangeType());
 		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
+		assertFalse(fh.hasMetaDataChanges());
 		assertEquals("ee8a5a0", fh.getNewId().name());
 		assertEquals(1, fh.getHunks().size());
 		assertEquals(272, fh.getHunks().get(0).getOldStartLine());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index 4bb6b7e..bf8d23a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -250,6 +250,11 @@ public PatchType getPatchType() {
 		return patchType;
 	}
 
+	/** @return true if this patch modifies metadata about a file */
+	public boolean hasMetaDataChanges() {
+		return changeType != ChangeType.MODIFY || newMode != oldMode;
+	}
+
 	/** @return hunks altering this file; in order of appearance in patch */
 	public List<HunkHeader> getHunks() {
 		if (hunks == null)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 6e9ae77..c940a00 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -245,13 +245,13 @@ private int parseHunks(final FileHeader fh, final byte[] buf, int c) {
 			// with this position so it can be parsed again later.
 			//
 			if (match(buf, c, DIFF_GIT) >= 0)
-				return c;
+				break;
 			if (match(buf, c, DIFF_CC) >= 0)
-				return c;
+				break;
 			if (match(buf, c, OLD_NAME) >= 0)
-				return c;
+				break;
 			if (match(buf, c, NEW_NAME) >= 0)
-				return c;
+				break;
 
 			if (match(buf, c, HUNK_HDR) >= 0) {
 				final HunkHeader h = new HunkHeader(fh, c);
@@ -281,6 +281,16 @@ private int parseHunks(final FileHeader fh, final byte[] buf, int c) {
 			//
 			c = eol;
 		}
+
+		if (fh.getHunks().isEmpty()
+				&& fh.getPatchType() == FileHeader.PatchType.UNIFIED
+				&& !fh.hasMetaDataChanges()) {
+			// Hmm, an empty patch? If there is no metadata here we
+			// really have a binary patch that we didn't notice above.
+			//
+			fh.patchType = FileHeader.PatchType.BINARY;
+		}
+
 		return c;
 	}
 
-- 
1.6.1.rc2.306.ge5d5e
