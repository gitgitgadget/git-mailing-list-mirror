From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/15] Test for non-git binary files and mark them as PatchType.BINARY
Date: Thu, 11 Dec 2008 18:46:12 -0800
Message-ID: <1229049981-14152-7-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
 <1229049981-14152-3-git-send-email-spearce@spearce.org>
 <1229049981-14152-4-git-send-email-spearce@spearce.org>
 <1229049981-14152-5-git-send-email-spearce@spearce.org>
 <1229049981-14152-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy4y-00057A-Ua
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370AbYLLCqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757318AbYLLCqg
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:36 -0500
Received: from george.spearce.org ([209.20.77.23]:41584 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757233AbYLLCq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:28 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id F199538260; Fri, 12 Dec 2008 02:46:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B9F013821F;
	Fri, 12 Dec 2008 02:46:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102877>

By marking non-git binary patches as binary callers can examine
the patch type to determine if there is meaningful content on
this particular file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/PatchTest.java      |   26 ++++++
 .../spearce/jgit/patch/testParse_NoBinary.patch    |   83 ++++++++++++++++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |    2 +-
 .../src/org/spearce/jgit/patch/Patch.java          |   26 ++++++-
 4 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_NoBinary.patch

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index 3afe0a1..833bf5d 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -141,6 +141,32 @@ assertSame(FileHeader.PatchType.UNIFIED, fRepositoryConfig
 		}
 	}
 
+	public void testParse_NoBinary() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(5, p.getFiles().size());
+
+		for (int i = 0; i < 4; i++) {
+			final FileHeader fh = p.getFiles().get(i);
+			assertSame(FileHeader.ChangeType.ADD, fh.getChangeType());
+			assertNotNull(fh.getOldId());
+			assertNotNull(fh.getNewId());
+			assertEquals("0000000", fh.getOldId().name());
+			assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
+			assertTrue(fh.getNewName().startsWith(
+					"org.spearce.egit.ui/icons/toolbar/"));
+			assertSame(FileHeader.PatchType.BINARY, fh.getPatchType());
+			assertTrue(fh.getHunks().isEmpty());
+		}
+
+		final FileHeader fh = p.getFiles().get(4);
+		assertEquals("org.spearce.egit.ui/plugin.xml", fh.getNewName());
+		assertSame(FileHeader.ChangeType.MODIFY, fh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
+		assertEquals("ee8a5a0", fh.getNewId().name());
+		assertEquals(1, fh.getHunks().size());
+		assertEquals(272, fh.getHunks().get(0).getOldStartLine());
+	}
+
 	private Patch parseTestPatchFile() throws IOException {
 		final String patchFile = getName() + ".patch";
 		final InputStream in = getClass().getResourceAsStream(patchFile);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_NoBinary.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_NoBinary.patch
new file mode 100644
index 0000000..684b13c
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_NoBinary.patch
@@ -0,0 +1,83 @@
+From 8363f12135a7d0ff0b5fea7d5a35d294c0479518 Mon Sep 17 00:00:00 2001
+From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
+Date: Tue, 23 Sep 2008 22:19:19 +0200
+Subject: [PATCH] Push and fetch icons for the toolbar
+
+Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
+Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
+---
+ org.spearce.egit.ui/icons/toolbar/fetchd.png |  Bin 0 -> 359 bytes
+ org.spearce.egit.ui/icons/toolbar/fetche.png |  Bin 0 -> 393 bytes
+ org.spearce.egit.ui/icons/toolbar/pushd.png  |  Bin 0 -> 372 bytes
+ org.spearce.egit.ui/icons/toolbar/pushe.png  |  Bin 0 -> 404 bytes
+ org.spearce.egit.ui/plugin.xml               |   32 ++++++++++++++-----------
+ 5 files changed, 18 insertions(+), 14 deletions(-)
+ create mode 100644 org.spearce.egit.ui/icons/toolbar/fetchd.png
+ create mode 100644 org.spearce.egit.ui/icons/toolbar/fetche.png
+ create mode 100644 org.spearce.egit.ui/icons/toolbar/pushd.png
+ create mode 100644 org.spearce.egit.ui/icons/toolbar/pushe.png
+
+diff --git a/org.spearce.egit.ui/icons/toolbar/fetchd.png b/org.spearce.egit.ui/icons/toolbar/fetchd.png
+new file mode 100644
+index 0000000..4433c54
+Binary files /dev/null and b/org.spearce.egit.ui/icons/toolbar/fetchd.png differ
+diff --git a/org.spearce.egit.ui/icons/toolbar/fetche.png b/org.spearce.egit.ui/icons/toolbar/fetche.png
+new file mode 100644
+index 0000000..0ffeb41
+Binary files /dev/null and b/org.spearce.egit.ui/icons/toolbar/fetche.png differ
+diff --git a/org.spearce.egit.ui/icons/toolbar/pushd.png b/org.spearce.egit.ui/icons/toolbar/pushd.png
+new file mode 100644
+index 0000000..22c3f7b
+Binary files /dev/null and b/org.spearce.egit.ui/icons/toolbar/pushd.png differ
+diff --git a/org.spearce.egit.ui/icons/toolbar/pushe.png b/org.spearce.egit.ui/icons/toolbar/pushe.png
+new file mode 100644
+index 0000000..1f99f0a
+Binary files /dev/null and b/org.spearce.egit.ui/icons/toolbar/pushe.png differ
+diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
+index 7c98688..ee8a5a0 100644
+--- a/org.spearce.egit.ui/plugin.xml
++++ b/org.spearce.egit.ui/plugin.xml
+@@ -272,22 +272,26 @@
+         </separator>
+ 	    </menu>
+ 		<action
+-		       class="org.spearce.egit.ui.internal.actions.FetchAction"
+-		       id="org.spearce.egit.ui.actionfetch"
+-		       label="%FetchAction_label"
+-		       style="push"
+-		       menubarPath="org.spearce.egit.ui.gitmenu/repo"
+-		       toolbarPath="org.spearce.egit.ui"
+-		       tooltip="%FetchAction_tooltip">
++        class="org.spearce.egit.ui.internal.actions.FetchAction"
++        disabledIcon="icons/toolbar/fetchd.png"
++        icon="icons/toolbar/fetche.png"
++        id="org.spearce.egit.ui.actionfetch"
++        label="%FetchAction_label"
++        menubarPath="org.spearce.egit.ui.gitmenu/repo"
++        style="push"
++        toolbarPath="org.spearce.egit.ui"
++        tooltip="%FetchAction_tooltip">
+ 		</action>
+ 		<action
+-		       class="org.spearce.egit.ui.internal.actions.PushAction"
+-		       id="org.spearce.egit.ui.actionpush"
+-		       label="%PushAction_label"
+-		       style="push"
+-		       menubarPath="org.spearce.egit.ui.gitmenu/repo"
+-		       toolbarPath="org.spearce.egit.ui"
+-		       tooltip="%PushAction_tooltip">
++        class="org.spearce.egit.ui.internal.actions.PushAction"
++        disabledIcon="icons/toolbar/pushd.png"
++        icon="icons/toolbar/pushe.png"
++        id="org.spearce.egit.ui.actionpush"
++        label="%PushAction_label"
++        menubarPath="org.spearce.egit.ui.gitmenu/repo"
++        style="push"
++        toolbarPath="org.spearce.egit.ui"
++        tooltip="%PushAction_tooltip">
+ 		</action>
+ 		<action
+ 		       class="org.spearce.egit.ui.internal.actions.BranchAction"
+-- 
+1.6.1.rc2.306.ge5d5e
+
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index 5ff7cb7..4bb6b7e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -153,7 +153,7 @@
 	private AbbreviatedObjectId newId;
 
 	/** Type of patch used to modify this file */
-	private PatchType patchType;
+	PatchType patchType;
 
 	/** The hunks of this file */
 	private List<HunkHeader> hunks;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index d59635a..6e9ae77 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -57,6 +57,11 @@
 
 	private static final byte[] DIFF_CC = encodeASCII("diff --cc ");
 
+	private static final byte[][] BIN_HEADERS = new byte[][] {
+			encodeASCII("Binary files "), encodeASCII("Files "), };
+
+	private static final byte[] BIN_TRAILER = encodeASCII(" differ\n");
+
 	static final byte[] SIG_FOOTER = encodeASCII("-- \n");
 
 	/** The files, in the order they were parsed out of the input. */
@@ -261,11 +266,30 @@ private int parseHunks(final FileHeader fh, final byte[] buf, int c) {
 				continue;
 			}
 
+			final int eol = nextLF(buf, c);
+			if (fh.getHunks().isEmpty() && BIN_TRAILER.length < eol - c
+					&& match(buf, eol - BIN_TRAILER.length, BIN_TRAILER) >= 0
+					&& matchAny(buf, c, BIN_HEADERS)) {
+				// The patch is a binary file diff, with no deltas.
+				//
+				fh.patchType = FileHeader.PatchType.BINARY;
+				return eol;
+			}
+
 			// Skip this line and move to the next. Its probably garbage
 			// after the last hunk of a file.
 			//
-			c = nextLF(buf, c);
+			c = eol;
 		}
 		return c;
 	}
+
+	private static boolean matchAny(final byte[] buf, final int c,
+			final byte[][] srcs) {
+		for (final byte[] s : srcs) {
+			if (match(buf, c, s) >= 0)
+				return true;
+		}
+		return false;
+	}
 }
-- 
1.6.1.rc2.306.ge5d5e
