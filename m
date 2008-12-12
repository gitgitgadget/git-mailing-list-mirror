From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/15] Define FileHeader.PatchType to report the style of patch used
Date: Thu, 11 Dec 2008 18:46:11 -0800
Message-ID: <1229049981-14152-6-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
 <1229049981-14152-3-git-send-email-spearce@spearce.org>
 <1229049981-14152-4-git-send-email-spearce@spearce.org>
 <1229049981-14152-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy4y-00057A-6w
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346AbYLLCql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757290AbYLLCqf
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:35 -0500
Received: from george.spearce.org ([209.20.77.23]:41581 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757230AbYLLCq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:27 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id E102C38268; Fri, 12 Dec 2008 02:46:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7091A38200;
	Fri, 12 Dec 2008 02:46:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102879>

Patches in a Git world come in at least three flavors:

  * Traditional unified patch
  * Binary patch with no data ("Binary files a/a and b/a differ")
  * Git binary patch with forward and reverse deltas

The PatchType indicates which of these flavors a given FileHeader
is looking at.  Right now we assume UNIFIED by default as that is
the most common form used.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/FileHeaderTest.java |    6 +++++
 .../tst/org/spearce/jgit/patch/PatchTest.java      |    4 +++
 .../src/org/spearce/jgit/patch/FileHeader.java     |   21 ++++++++++++++++++++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
index 4094a5c..d8696a9 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/FileHeaderTest.java
@@ -134,6 +134,7 @@ public void testParseUnicodeName_NewFile() {
 		assertEquals("\u00c5ngstr\u00f6m", fh.getNewName());
 
 		assertSame(FileHeader.ChangeType.ADD, fh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
 
 		assertNull(fh.getOldMode());
 		assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
@@ -157,6 +158,7 @@ public void testParseUnicodeName_DeleteFile() {
 		assertSame(FileHeader.DEV_NULL, fh.getNewName());
 
 		assertSame(FileHeader.ChangeType.DELETE, fh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
 
 		assertSame(FileMode.REGULAR_FILE, fh.getOldMode());
 		assertNull(fh.getNewMode());
@@ -174,6 +176,7 @@ public void testParseModeChange() {
 		assertEquals("a b", fh.getNewName());
 
 		assertSame(FileHeader.ChangeType.MODIFY, fh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
 
 		assertNull(fh.getOldId());
 		assertNull(fh.getNewId());
@@ -200,6 +203,7 @@ public void testParseRename100_NewStyle() {
 		assertEquals(" c/\u00c5ngstr\u00f6m", fh.getNewName());
 
 		assertSame(FileHeader.ChangeType.RENAME, fh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
 
 		assertNull(fh.getOldId());
 		assertNull(fh.getNewId());
@@ -227,6 +231,7 @@ public void testParseRename100_OldStyle() {
 		assertEquals(" c/\u00c5ngstr\u00f6m", fh.getNewName());
 
 		assertSame(FileHeader.ChangeType.RENAME, fh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
 
 		assertNull(fh.getOldId());
 		assertNull(fh.getNewId());
@@ -254,6 +259,7 @@ public void testParseCopy100() {
 		assertEquals(" c/\u00c5ngstr\u00f6m", fh.getNewName());
 
 		assertSame(FileHeader.ChangeType.COPY, fh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
 
 		assertNull(fh.getOldId());
 		assertNull(fh.getNewId());
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index 8ddaadc..3afe0a1 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -70,6 +70,8 @@ assertEquals(
 
 		assertEquals("da7e704", fRepositoryConfigTest.getOldId().name());
 		assertEquals("34ce04a", fRepositoryConfigTest.getNewId().name());
+		assertSame(FileHeader.PatchType.UNIFIED, fRepositoryConfigTest
+				.getPatchType());
 		assertSame(FileMode.REGULAR_FILE, fRepositoryConfigTest.getOldMode());
 		assertSame(FileMode.REGULAR_FILE, fRepositoryConfigTest.getNewMode());
 		assertEquals(1, fRepositoryConfigTest.getHunks().size());
@@ -90,6 +92,8 @@ assertEquals(
 
 		assertEquals("45c2f8a", fRepositoryConfig.getOldId().name());
 		assertEquals("3291bba", fRepositoryConfig.getNewId().name());
+		assertSame(FileHeader.PatchType.UNIFIED, fRepositoryConfig
+				.getPatchType());
 		assertSame(FileMode.REGULAR_FILE, fRepositoryConfig.getOldMode());
 		assertSame(FileMode.REGULAR_FILE, fRepositoryConfig.getNewMode());
 		assertEquals(3, fRepositoryConfig.getHunks().size());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index b49cb7b..5ff7cb7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -107,6 +107,18 @@
 		COPY;
 	}
 
+	/** Type of patch used by this file. */
+	public static enum PatchType {
+		/** A traditional unified diff style patch of a text file. */
+		UNIFIED,
+
+		/** An empty patch with a message "Binary files ... differ" */
+		BINARY,
+
+		/** A Git binary patch, holding pre and post image deltas */
+		GIT_BINARY;
+	}
+
 	/** Buffer holding the patch data for this file. */
 	final byte[] buf;
 
@@ -140,6 +152,9 @@
 	/** ObjectId listed on the index line for the new (post-image) */
 	private AbbreviatedObjectId newId;
 
+	/** Type of patch used to modify this file */
+	private PatchType patchType;
+
 	/** The hunks of this file */
 	private List<HunkHeader> hunks;
 
@@ -147,6 +162,7 @@ FileHeader(final byte[] b, final int offset) {
 		buf = b;
 		startOffset = offset;
 		changeType = ChangeType.MODIFY; // unless otherwise designated
+		patchType = PatchType.UNIFIED;
 	}
 
 	/**
@@ -229,6 +245,11 @@ public AbbreviatedObjectId getNewId() {
 		return newId;
 	}
 
+	/** @return style of patch used to modify this file */
+	public PatchType getPatchType() {
+		return patchType;
+	}
+
 	/** @return hunks altering this file; in order of appearance in patch */
 	public List<HunkHeader> getHunks() {
 		if (hunks == null)
-- 
1.6.1.rc2.306.ge5d5e
