From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 12/12] Add support for parsing "diff --cc" style patches
Date: Fri, 12 Dec 2008 14:05:58 -0800
Message-ID: <1229119558-1293-13-git-send-email-spearce@spearce.org>
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
 <1229119558-1293-12-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:08:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGBF-0004x0-Je
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbYLLWG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbYLLWGZ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:25 -0500
Received: from george.spearce.org ([209.20.77.23]:50674 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973AbYLLWGG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:06 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id E5CA638210; Fri, 12 Dec 2008 22:06:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 196CC38200;
	Fri, 12 Dec 2008 22:06:02 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-12-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102955>

Even though the diff --cc format used by Git is only meant to be
read by humans, JGit needs to be able to parse these to get the
patch metadata so it can be shown in a user interface to facilitate
code review processes.

Patches are parsed into the specialized CombinedFileHeader and
CombinedHunkHeader classes, where the old image information is
augmented with additional fields for the arbitrary number of parents
that can appear in such patches.  These cost more in terms of memory,
but "diff --cc" style patches tend to occur very infrequently as
they only occur during a merge conflict resolution.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/patch/PatchCcErrorTest.java   |   97 +++++++++
 .../tst/org/spearce/jgit/patch/PatchCcTest.java    |  200 ++++++++++++++++++
 .../jgit/patch/testError_CcTruncatedOld.patch      |   24 +++
 .../jgit/patch/testParse_CcDeleteFile.patch        |   12 +
 .../spearce/jgit/patch/testParse_CcNewFile.patch   |   14 ++
 .../spearce/jgit/patch/testParse_OneFileCc.patch   |   27 +++
 .../org/spearce/jgit/patch/CombinedFileHeader.java |  213 ++++++++++++++++++++
 .../org/spearce/jgit/patch/CombinedHunkHeader.java |  191 ++++++++++++++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |   56 +++---
 .../src/org/spearce/jgit/patch/HunkHeader.java     |    2 +-
 .../src/org/spearce/jgit/patch/Patch.java          |    7 +-
 11 files changed, 814 insertions(+), 29 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcErrorTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_CcTruncatedOld.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcDeleteFile.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcNewFile.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_OneFileCc.patch
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/CombinedFileHeader.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcErrorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcErrorTest.java
new file mode 100644
index 0000000..a2f3a19
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcErrorTest.java
@@ -0,0 +1,97 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.patch;
+
+import java.io.IOException;
+import java.io.InputStream;
+
+import junit.framework.TestCase;
+
+public class PatchCcErrorTest extends TestCase {
+	public void testError_CcTruncatedOld() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		assertEquals(3, p.getErrors().size());
+		{
+			final FormatError e = p.getErrors().get(0);
+			assertSame(FormatError.Severity.ERROR, e.getSeverity());
+			assertEquals(
+					"Truncated hunk, at least 1 lines is missing for ancestor 1",
+					e.getMessage());
+			assertEquals(346, e.getOffset());
+			assertTrue(e.getLineText().startsWith(
+					"@@@ -55,12 -163,13 +163,15 @@@ public "));
+		}
+		{
+			final FormatError e = p.getErrors().get(1);
+			assertSame(FormatError.Severity.ERROR, e.getSeverity());
+			assertEquals(
+					"Truncated hunk, at least 2 lines is missing for ancestor 2",
+					e.getMessage());
+			assertEquals(346, e.getOffset());
+			assertTrue(e.getLineText().startsWith(
+					"@@@ -55,12 -163,13 +163,15 @@@ public "));
+		}
+		{
+			final FormatError e = p.getErrors().get(2);
+			assertSame(FormatError.Severity.ERROR, e.getSeverity());
+			assertEquals("Truncated hunk, at least 3 new lines is missing", e
+					.getMessage());
+			assertEquals(346, e.getOffset());
+			assertTrue(e.getLineText().startsWith(
+					"@@@ -55,12 -163,13 +163,15 @@@ public "));
+		}
+	}
+
+	private Patch parseTestPatchFile() throws IOException {
+		final String patchFile = getName() + ".patch";
+		final InputStream in = getClass().getResourceAsStream(patchFile);
+		if (in == null) {
+			fail("No " + patchFile + " test vector");
+			return null; // Never happens
+		}
+		try {
+			final Patch p = new Patch();
+			p.parse(in);
+			return p;
+		} finally {
+			in.close();
+		}
+	}
+
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcTest.java
new file mode 100644
index 0000000..9e8650b
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchCcTest.java
@@ -0,0 +1,200 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.patch;
+
+import java.io.IOException;
+import java.io.InputStream;
+
+import org.spearce.jgit.lib.FileMode;
+
+import junit.framework.TestCase;
+
+public class PatchCcTest extends TestCase {
+	public void testParse_OneFileCc() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		assertTrue(p.getErrors().isEmpty());
+
+		final CombinedFileHeader cfh = (CombinedFileHeader) p.getFiles().get(0);
+
+		assertEquals("org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java",
+				cfh.getNewName());
+		assertEquals(cfh.getNewName(), cfh.getOldName());
+
+		assertEquals(98, cfh.startOffset);
+
+		assertEquals(2, cfh.getParentCount());
+		assertSame(cfh.getOldId(0), cfh.getOldId());
+		assertEquals("169356b", cfh.getOldId(0).name());
+		assertEquals("dd8c317", cfh.getOldId(1).name());
+		assertEquals("fd85931", cfh.getNewId().name());
+
+		assertSame(cfh.getOldMode(0), cfh.getOldMode());
+		assertSame(FileMode.REGULAR_FILE, cfh.getOldMode(0));
+		assertSame(FileMode.REGULAR_FILE, cfh.getOldMode(1));
+		assertSame(FileMode.EXECUTABLE_FILE, cfh.getNewMode());
+		assertSame(FileHeader.ChangeType.MODIFY, cfh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, cfh.getPatchType());
+
+		assertEquals(1, cfh.getHunks().size());
+		{
+			final CombinedHunkHeader h = cfh.getHunks().get(0);
+
+			assertSame(cfh, h.getFileHeader());
+			assertEquals(346, h.startOffset);
+			assertEquals(764, h.endOffset);
+
+			assertSame(h.getOldImage(0), h.getOldImage());
+			assertSame(cfh.getOldId(0), h.getOldImage(0).getId());
+			assertSame(cfh.getOldId(1), h.getOldImage(1).getId());
+
+			assertEquals(55, h.getOldImage(0).getStartLine());
+			assertEquals(12, h.getOldImage(0).getLineCount());
+			assertEquals(3, h.getOldImage(0).getLinesAdded());
+			assertEquals(0, h.getOldImage(0).getLinesDeleted());
+
+			assertEquals(163, h.getOldImage(1).getStartLine());
+			assertEquals(13, h.getOldImage(1).getLineCount());
+			assertEquals(2, h.getOldImage(1).getLinesAdded());
+			assertEquals(0, h.getOldImage(1).getLinesDeleted());
+
+			assertEquals(163, h.getNewStartLine());
+			assertEquals(15, h.getNewLineCount());
+
+			assertEquals(10, h.getLinesContext());
+		}
+	}
+
+	public void testParse_CcNewFile() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		assertTrue(p.getErrors().isEmpty());
+
+		final CombinedFileHeader cfh = (CombinedFileHeader) p.getFiles().get(0);
+
+		assertSame(FileHeader.DEV_NULL, cfh.getOldName());
+		assertEquals("d", cfh.getNewName());
+
+		assertEquals(187, cfh.startOffset);
+
+		assertEquals(2, cfh.getParentCount());
+		assertSame(cfh.getOldId(0), cfh.getOldId());
+		assertEquals("0000000", cfh.getOldId(0).name());
+		assertEquals("0000000", cfh.getOldId(1).name());
+		assertEquals("4bcfe98", cfh.getNewId().name());
+
+		assertSame(cfh.getOldMode(0), cfh.getOldMode());
+		assertSame(FileMode.MISSING, cfh.getOldMode(0));
+		assertSame(FileMode.MISSING, cfh.getOldMode(1));
+		assertSame(FileMode.REGULAR_FILE, cfh.getNewMode());
+		assertSame(FileHeader.ChangeType.ADD, cfh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, cfh.getPatchType());
+
+		assertEquals(1, cfh.getHunks().size());
+		{
+			final CombinedHunkHeader h = cfh.getHunks().get(0);
+
+			assertSame(cfh, h.getFileHeader());
+			assertEquals(273, h.startOffset);
+			assertEquals(300, h.endOffset);
+
+			assertSame(h.getOldImage(0), h.getOldImage());
+			assertSame(cfh.getOldId(0), h.getOldImage(0).getId());
+			assertSame(cfh.getOldId(1), h.getOldImage(1).getId());
+
+			assertEquals(1, h.getOldImage(0).getStartLine());
+			assertEquals(0, h.getOldImage(0).getLineCount());
+			assertEquals(1, h.getOldImage(0).getLinesAdded());
+			assertEquals(0, h.getOldImage(0).getLinesDeleted());
+
+			assertEquals(1, h.getOldImage(1).getStartLine());
+			assertEquals(0, h.getOldImage(1).getLineCount());
+			assertEquals(1, h.getOldImage(1).getLinesAdded());
+			assertEquals(0, h.getOldImage(1).getLinesDeleted());
+
+			assertEquals(1, h.getNewStartLine());
+			assertEquals(1, h.getNewLineCount());
+
+			assertEquals(0, h.getLinesContext());
+		}
+	}
+
+	public void testParse_CcDeleteFile() throws IOException {
+		final Patch p = parseTestPatchFile();
+		assertEquals(1, p.getFiles().size());
+		assertTrue(p.getErrors().isEmpty());
+
+		final CombinedFileHeader cfh = (CombinedFileHeader) p.getFiles().get(0);
+
+		assertEquals("a", cfh.getOldName());
+		assertSame(FileHeader.DEV_NULL, cfh.getNewName());
+
+		assertEquals(187, cfh.startOffset);
+
+		assertEquals(2, cfh.getParentCount());
+		assertSame(cfh.getOldId(0), cfh.getOldId());
+		assertEquals("7898192", cfh.getOldId(0).name());
+		assertEquals("2e65efe", cfh.getOldId(1).name());
+		assertEquals("0000000", cfh.getNewId().name());
+
+		assertSame(cfh.getOldMode(0), cfh.getOldMode());
+		assertSame(FileMode.REGULAR_FILE, cfh.getOldMode(0));
+		assertSame(FileMode.REGULAR_FILE, cfh.getOldMode(1));
+		assertSame(FileMode.MISSING, cfh.getNewMode());
+		assertSame(FileHeader.ChangeType.DELETE, cfh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, cfh.getPatchType());
+
+		assertTrue(cfh.getHunks().isEmpty());
+	}
+
+	private Patch parseTestPatchFile() throws IOException {
+		final String patchFile = getName() + ".patch";
+		final InputStream in = getClass().getResourceAsStream(patchFile);
+		if (in == null) {
+			fail("No " + patchFile + " test vector");
+			return null; // Never happens
+		}
+		try {
+			final Patch p = new Patch();
+			p.parse(in);
+			return p;
+		} finally {
+			in.close();
+		}
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_CcTruncatedOld.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_CcTruncatedOld.patch
new file mode 100644
index 0000000..1bbcfb5
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testError_CcTruncatedOld.patch
@@ -0,0 +1,24 @@
+commit 1a56639bbea8e8cbfbe5da87746de97f9217ce9b
+Date:   Tue May 13 00:43:56 2008 +0200
+      ...
+
+diff --cc org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+index 169356b,dd8c317..fd85931
+mode 100644,100644..100755
+--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
++++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+@@@ -55,12 -163,13 +163,15 @@@ public class UIText extends NLS 
+  
+  	/** */
+  	public static String ResourceHistory_toggleCommentWrap;
++ 
+  	/** */
+ +	/** */
+  	public static String ResourceHistory_toggleRevDetail;
+  	/** */
+  	public static String ResourceHistory_toggleRevComment;
+  	/** */
+  	public static String ResourceHistory_toggleTooltips;
+  
+
+commit 1a56639bbea8e8cbfbe5da87746de97f9217ce9b
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcDeleteFile.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcDeleteFile.patch
new file mode 100644
index 0000000..2654e09
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcDeleteFile.patch
@@ -0,0 +1,12 @@
+commit 740709ece2412856c0c3eabd4dc4a4cf115b0de6
+Merge: 5c19b43... 13a2c0d...
+Author: Shawn O. Pearce <sop@google.com>
+Date:   Fri Dec 12 13:26:52 2008 -0800
+
+    Merge branch 'b' into d
+
+diff --cc a
+index 7898192,2e65efe..0000000
+deleted file mode 100644,100644
+--- a/a
++++ /dev/null
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcNewFile.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcNewFile.patch
new file mode 100644
index 0000000..1a9b7b0
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_CcNewFile.patch
@@ -0,0 +1,14 @@
+commit 6cb8160a4717d51fd3cc0baf721946daa60cf921
+Merge: 5c19b43... 13a2c0d...
+Author: Shawn O. Pearce <sop@google.com>
+Date:   Fri Dec 12 13:26:52 2008 -0800
+
+    Merge branch 'b' into d
+
+diff --cc d
+index 0000000,0000000..4bcfe98
+new file mode 100644
+--- /dev/null
++++ b/d
+@@@ -1,0 -1,0 +1,1 @@@
+++d
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_OneFileCc.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_OneFileCc.patch
new file mode 100644
index 0000000..c096b33
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_OneFileCc.patch
@@ -0,0 +1,27 @@
+commit 1a56639bbea8e8cbfbe5da87746de97f9217ce9b
+Date:   Tue May 13 00:43:56 2008 +0200
+      ...
+
+diff --cc org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+index 169356b,dd8c317..fd85931
+mode 100644,100644..100755
+--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
++++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+@@@ -55,12 -163,13 +163,15 @@@ public class UIText extends NLS 
+  
+  	/** */
+  	public static String ResourceHistory_toggleCommentWrap;
++ 
+  	/** */
+ +	public static String ResourceHistory_toggleCommentFill;
+ +	/** */
+  	public static String ResourceHistory_toggleRevDetail;
++ 
+  	/** */
+  	public static String ResourceHistory_toggleRevComment;
++ 
+  	/** */
+  	public static String ResourceHistory_toggleTooltips;
+  
+
+commit 1a56639bbea8e8cbfbe5da87746de97f9217ce9b
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedFileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedFileHeader.java
new file mode 100644
index 0000000..7171600
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedFileHeader.java
@@ -0,0 +1,213 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.patch;
+
+import static org.spearce.jgit.lib.Constants.encodeASCII;
+import static org.spearce.jgit.util.RawParseUtils.match;
+import static org.spearce.jgit.util.RawParseUtils.nextLF;
+
+import java.util.ArrayList;
+import java.util.List;
+
+import org.spearce.jgit.lib.AbbreviatedObjectId;
+import org.spearce.jgit.lib.FileMode;
+
+/**
+ * A file in the Git "diff --cc" or "diff --combined" format.
+ * <p>
+ * A combined diff shows an n-way comparison between two or more ancestors and
+ * the final revision. Its primary function is to perform code reviews on a
+ * merge which introduces changes not in any ancestor.
+ */
+public class CombinedFileHeader extends FileHeader {
+	private static final byte[] MODE = encodeASCII("mode ");
+
+	private AbbreviatedObjectId[] oldIds;
+
+	private FileMode[] oldModes;
+
+	CombinedFileHeader(final byte[] b, final int offset) {
+		super(b, offset);
+	}
+
+	@Override
+	@SuppressWarnings("unchecked")
+	public List<? extends CombinedHunkHeader> getHunks() {
+		return (List<CombinedHunkHeader>) super.getHunks();
+	}
+
+	/** @return number of ancestor revisions mentioned in this diff. */
+	@Override
+	public int getParentCount() {
+		return oldIds.length;
+	}
+
+	/** @return get the file mode of the first parent. */
+	@Override
+	public FileMode getOldMode() {
+		return getOldMode(0);
+	}
+
+	/**
+	 * Get the file mode of the nth ancestor
+	 * 
+	 * @param nthParent
+	 *            the ancestor to get the mode of
+	 * @return the mode of the requested ancestor.
+	 */
+	public FileMode getOldMode(final int nthParent) {
+		return oldModes[nthParent];
+	}
+
+	/** @return get the object id of the first parent. */
+	@Override
+	public AbbreviatedObjectId getOldId() {
+		return getOldId(0);
+	}
+
+	/**
+	 * Get the ObjectId of the nth ancestor
+	 * 
+	 * @param nthParent
+	 *            the ancestor to get the object id of
+	 * @return the id of the requested ancestor.
+	 */
+	public AbbreviatedObjectId getOldId(final int nthParent) {
+		return oldIds[nthParent];
+	}
+
+	int parseGitHeaders(int ptr, final int end) {
+		while (ptr < end) {
+			final int eol = nextLF(buf, ptr);
+			if (isHunkHdr(buf, ptr, end) >= 1) {
+				// First hunk header; break out and parse them later.
+				break;
+
+			} else if (match(buf, ptr, OLD_NAME) >= 0) {
+				parseOldName(ptr, eol);
+
+			} else if (match(buf, ptr, NEW_NAME) >= 0) {
+				parseNewName(ptr, eol);
+
+			} else if (match(buf, ptr, INDEX) >= 0) {
+				parseIndexLine(ptr + INDEX.length, eol);
+
+			} else if (match(buf, ptr, MODE) >= 0) {
+				parseModeLine(ptr + MODE.length, eol);
+
+			} else if (match(buf, ptr, NEW_FILE_MODE) >= 0) {
+				parseNewFileMode(ptr, eol);
+
+			} else if (match(buf, ptr, DELETED_FILE_MODE) >= 0) {
+				parseDeletedFileMode(ptr + DELETED_FILE_MODE.length, eol);
+
+			} else {
+				// Probably an empty patch (stat dirty).
+				break;
+			}
+
+			ptr = eol;
+		}
+		return ptr;
+	}
+
+	@Override
+	protected void parseIndexLine(int ptr, final int eol) {
+		// "index $asha1,$bsha1..$csha1"
+		//
+		final List<AbbreviatedObjectId> ids = new ArrayList<AbbreviatedObjectId>();
+		while (ptr < eol) {
+			final int comma = nextLF(buf, ptr, ',');
+			if (eol <= comma)
+				break;
+			ids.add(AbbreviatedObjectId.fromString(buf, ptr, comma - 1));
+			ptr = comma;
+		}
+
+		oldIds = new AbbreviatedObjectId[ids.size() + 1];
+		ids.toArray(oldIds);
+		final int dot2 = nextLF(buf, ptr, '.');
+		oldIds[ids.size()] = AbbreviatedObjectId.fromString(buf, ptr, dot2 - 1);
+		newId = AbbreviatedObjectId.fromString(buf, dot2 + 1, eol - 1);
+		oldModes = new FileMode[oldIds.length];
+	}
+
+	@Override
+	protected void parseNewFileMode(final int ptr, final int eol) {
+		for (int i = 0; i < oldModes.length; i++)
+			oldModes[i] = FileMode.MISSING;
+		super.parseNewFileMode(ptr, eol);
+	}
+
+	@Override
+	HunkHeader newHunkHeader(final int offset) {
+		return new CombinedHunkHeader(this, offset);
+	}
+
+	private void parseModeLine(int ptr, final int eol) {
+		// "mode $amode,$bmode..$cmode"
+		//
+		int n = 0;
+		while (ptr < eol) {
+			final int comma = nextLF(buf, ptr, ',');
+			if (eol <= comma)
+				break;
+			oldModes[n++] = parseFileMode(ptr, comma);
+			ptr = comma;
+		}
+		final int dot2 = nextLF(buf, ptr, '.');
+		oldModes[n] = parseFileMode(ptr, dot2);
+		newMode = parseFileMode(dot2 + 1, eol);
+	}
+
+	private void parseDeletedFileMode(int ptr, final int eol) {
+		// "deleted file mode $amode,$bmode"
+		//
+		changeType = ChangeType.DELETE;
+		int n = 0;
+		while (ptr < eol) {
+			final int comma = nextLF(buf, ptr, ',');
+			if (eol <= comma)
+				break;
+			oldModes[n++] = parseFileMode(ptr, comma);
+			ptr = comma;
+		}
+		oldModes[n] = parseFileMode(ptr, eol);
+		newMode = FileMode.MISSING;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.java
new file mode 100644
index 0000000..bebeafa
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.java
@@ -0,0 +1,191 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.patch;
+
+import static org.spearce.jgit.util.RawParseUtils.nextLF;
+import static org.spearce.jgit.util.RawParseUtils.parseBase10;
+
+import org.spearce.jgit.lib.AbbreviatedObjectId;
+import org.spearce.jgit.util.MutableInteger;
+
+/** Hunk header for a hunk appearing in a "diff --cc" style patch. */
+public class CombinedHunkHeader extends HunkHeader {
+	private static abstract class CombinedOldImage extends OldImage {
+		int nContext;
+	}
+
+	private CombinedOldImage[] old;
+
+	CombinedHunkHeader(final CombinedFileHeader fh, final int offset) {
+		super(fh, offset, null);
+		old = new CombinedOldImage[fh.getParentCount()];
+		for (int i = 0; i < old.length; i++) {
+			final int imagePos = i;
+			old[i] = new CombinedOldImage() {
+				@Override
+				public AbbreviatedObjectId getId() {
+					return fh.getOldId(imagePos);
+				}
+			};
+		}
+	}
+
+	@Override
+	public CombinedFileHeader getFileHeader() {
+		return (CombinedFileHeader) super.getFileHeader();
+	}
+
+	@Override
+	public OldImage getOldImage() {
+		return getOldImage(0);
+	}
+
+	/**
+	 * Get the OldImage data related to the nth ancestor
+	 * 
+	 * @param nthParent
+	 *            the ancestor to get the old image data of
+	 * @return image data of the requested ancestor.
+	 */
+	public OldImage getOldImage(final int nthParent) {
+		return old[nthParent];
+	}
+
+	@Override
+	void parseHeader(final int end) {
+		// Parse "@@@ -55,12 -163,13 +163,15 @@@ protected boolean"
+		//
+		final byte[] buf = file.buf;
+		final MutableInteger ptr = new MutableInteger();
+		ptr.value = nextLF(buf, startOffset, ' ');
+
+		for (int n = 0; n < old.length; n++) {
+			old[n].startLine = -parseBase10(buf, ptr.value, ptr);
+			if (buf[ptr.value] == ',')
+				old[n].lineCount = parseBase10(buf, ptr.value + 1, ptr);
+			else
+				old[n].lineCount = 1;
+		}
+
+		newStartLine = parseBase10(buf, ptr.value + 1, ptr);
+		if (buf[ptr.value] == ',')
+			newLineCount = parseBase10(buf, ptr.value + 1, ptr);
+		else
+			newLineCount = 1;
+	}
+
+	@Override
+	int parseBody(final Patch script, final int end) {
+		final byte[] buf = file.buf;
+		int c = nextLF(buf, startOffset);
+
+		for (final CombinedOldImage o : old) {
+			o.nDeleted = 0;
+			o.nAdded = 0;
+			o.nContext = 0;
+		}
+		nContext = 0;
+		int nAdded = 0;
+
+		SCAN: for (int eol; c < end; c = eol) {
+			eol = nextLF(buf, c);
+
+			if (eol - c < old.length + 1) {
+				// Line isn't long enough to mention the state of each
+				// ancestor. It must be the end of the hunk.
+				break SCAN;
+			}
+
+			switch (buf[c]) {
+			case ' ':
+			case '-':
+			case '+':
+				break;
+
+			default:
+				// Line can't possibly be part of this hunk; the first
+				// ancestor information isn't recognizable.
+				//
+				break SCAN;
+			}
+
+			int localcontext = 0;
+			for (int ancestor = 0; ancestor < old.length; ancestor++) {
+				switch (buf[c + ancestor]) {
+				case ' ':
+					localcontext++;
+					old[ancestor].nContext++;
+					continue;
+
+				case '-':
+					old[ancestor].nDeleted++;
+					continue;
+
+				case '+':
+					old[ancestor].nAdded++;
+					nAdded++;
+					continue;
+
+				default:
+					break SCAN;
+				}
+			}
+			if (localcontext == old.length)
+				nContext++;
+		}
+
+		for (int ancestor = 0; ancestor < old.length; ancestor++) {
+			final CombinedOldImage o = old[ancestor];
+			final int cmp = o.nContext + o.nDeleted;
+			if (cmp < o.lineCount) {
+				final int missingCnt = o.lineCount - cmp;
+				script.error(buf, startOffset, "Truncated hunk, at least "
+						+ missingCnt + " lines is missing for ancestor "
+						+ (ancestor + 1));
+			}
+		}
+
+		if (nContext + nAdded < newLineCount) {
+			final int missingCount = newLineCount - (nContext + nAdded);
+			script.error(buf, startOffset, "Truncated hunk, at least "
+					+ missingCount + " new lines is missing");
+		}
+
+		return c;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index 48d7623..79e4b0a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -61,9 +61,9 @@
 
 	private static final byte[] NEW_MODE = encodeASCII("new mode ");
 
-	private static final byte[] DELETED_FILE_MODE = encodeASCII("deleted file mode ");
+	protected static final byte[] DELETED_FILE_MODE = encodeASCII("deleted file mode ");
 
-	private static final byte[] NEW_FILE_MODE = encodeASCII("new file mode ");
+	protected static final byte[] NEW_FILE_MODE = encodeASCII("new file mode ");
 
 	private static final byte[] COPY_FROM = encodeASCII("copy from ");
 
@@ -81,7 +81,7 @@
 
 	private static final byte[] DISSIMILARITY_INDEX = encodeASCII("dissimilarity index ");
 
-	private static final byte[] INDEX = encodeASCII("index ");
+	protected static final byte[] INDEX = encodeASCII("index ");
 
 	static final byte[] OLD_NAME = encodeASCII("--- ");
 
@@ -136,10 +136,10 @@
 	private FileMode oldMode;
 
 	/** New mode of the file, if described by the patch, else null. */
-	private FileMode newMode;
+	protected FileMode newMode;
 
 	/** General type of change indicated by the patch. */
-	private ChangeType changeType;
+	protected ChangeType changeType;
 
 	/** Similarity score if {@link #changeType} is a copy or rename. */
 	private int score;
@@ -148,7 +148,7 @@
 	private AbbreviatedObjectId oldId;
 
 	/** ObjectId listed on the index line for the new (post-image) */
-	private AbbreviatedObjectId newId;
+	protected AbbreviatedObjectId newId;
 
 	/** Type of patch used to modify this file */
 	PatchType patchType;
@@ -264,7 +264,7 @@ public boolean hasMetaDataChanges() {
 	}
 
 	/** @return hunks altering this file; in order of appearance in patch */
-	public List<HunkHeader> getHunks() {
+	public List<? extends HunkHeader> getHunks() {
 		if (hunks == null)
 			return Collections.emptyList();
 		return hunks;
@@ -369,14 +369,10 @@ int parseGitHeaders(int ptr, final int end) {
 				break;
 
 			} else if (match(buf, ptr, OLD_NAME) >= 0) {
-				oldName = p1(parseName(oldName, ptr + OLD_NAME.length, eol));
-				if (oldName == DEV_NULL)
-					changeType = ChangeType.ADD;
+				parseOldName(ptr, eol);
 
 			} else if (match(buf, ptr, NEW_NAME) >= 0) {
-				newName = p1(parseName(newName, ptr + NEW_NAME.length, eol));
-				if (newName == DEV_NULL)
-					changeType = ChangeType.DELETE;
+				parseNewName(ptr, eol);
 
 			} else if (match(buf, ptr, OLD_MODE) >= 0) {
 				oldMode = parseFileMode(ptr + OLD_MODE.length, eol);
@@ -390,9 +386,7 @@ int parseGitHeaders(int ptr, final int end) {
 				changeType = ChangeType.DELETE;
 
 			} else if (match(buf, ptr, NEW_FILE_MODE) >= 0) {
-				oldMode = FileMode.MISSING;
-				newMode = parseFileMode(ptr + NEW_FILE_MODE.length, eol);
-				changeType = ChangeType.ADD;
+				parseNewFileMode(ptr, eol);
 
 			} else if (match(buf, ptr, COPY_FROM) >= 0) {
 				oldName = parseName(oldName, ptr + COPY_FROM.length, eol);
@@ -437,6 +431,24 @@ int parseGitHeaders(int ptr, final int end) {
 		return ptr;
 	}
 
+	protected void parseOldName(int ptr, final int eol) {
+		oldName = p1(parseName(oldName, ptr + OLD_NAME.length, eol));
+		if (oldName == DEV_NULL)
+			changeType = ChangeType.ADD;
+	}
+
+	protected void parseNewName(int ptr, final int eol) {
+		newName = p1(parseName(newName, ptr + NEW_NAME.length, eol));
+		if (newName == DEV_NULL)
+			changeType = ChangeType.DELETE;
+	}
+
+	protected void parseNewFileMode(int ptr, final int eol) {
+		oldMode = FileMode.MISSING;
+		newMode = parseFileMode(ptr + NEW_FILE_MODE.length, eol);
+		changeType = ChangeType.ADD;
+	}
+
 	int parseTraditionalHeaders(int ptr, final int end) {
 		while (ptr < end) {
 			final int eol = nextLF(buf, ptr);
@@ -445,14 +457,10 @@ int parseTraditionalHeaders(int ptr, final int end) {
 				break;
 
 			} else if (match(buf, ptr, OLD_NAME) >= 0) {
-				oldName = p1(parseName(oldName, ptr + OLD_NAME.length, eol));
-				if (oldName == DEV_NULL)
-					changeType = ChangeType.ADD;
+				parseOldName(ptr, eol);
 
 			} else if (match(buf, ptr, NEW_NAME) >= 0) {
-				newName = p1(parseName(newName, ptr + NEW_NAME.length, eol));
-				if (newName == DEV_NULL)
-					changeType = ChangeType.DELETE;
+				parseNewName(ptr, eol);
 
 			} else {
 				// Possibly an empty patch.
@@ -494,7 +502,7 @@ private static String p1(final String r) {
 		return s > 0 ? r.substring(s + 1) : r;
 	}
 
-	private FileMode parseFileMode(int ptr, final int end) {
+	protected FileMode parseFileMode(int ptr, final int end) {
 		int tmp = 0;
 		while (ptr < end - 1) {
 			tmp <<= 3;
@@ -503,7 +511,7 @@ private FileMode parseFileMode(int ptr, final int end) {
 		return FileMode.fromBits(tmp);
 	}
 
-	private void parseIndexLine(int ptr, final int end) {
+	protected void parseIndexLine(int ptr, final int end) {
 		// "index $asha1..$bsha1[ $mode]" where $asha1 and $bsha1
 		// can be unique abbreviations
 		//
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index f543aed..fc149ac 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -84,7 +84,7 @@ public int getLinesAdded() {
 		public abstract AbbreviatedObjectId getId();
 	}
 
-	private final FileHeader file;
+	final FileHeader file;
 
 	/** Offset within {@link #file}.buf to the "@@ -" line. */
 	final int startOffset;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 51f1fe5..f23ba69 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -94,7 +94,7 @@ public void addFile(final FileHeader fh) {
 	}
 
 	/** @return list of files described in the patch, in occurrence order. */
-	public List<FileHeader> getFiles() {
+	public List<? extends FileHeader> getFiles() {
 		return files;
 	}
 
@@ -238,9 +238,8 @@ private int parseDiffCombined(final byte[] hdr, final byte[] buf,
 		if (ptr < 0)
 			return skipFile(buf, start, end);
 
-		// TODO Support parsing diff --cc headers
-		// TODO parse diff --cc hunks
-		warn(buf, start, "diff --cc format not supported");
+		ptr = fh.parseGitHeaders(ptr, end);
+		ptr = parseHunks(fh, ptr, end);
 		fh.endOffset = ptr;
 		addFile(fh);
 		return ptr;
-- 
1.6.1.rc2.306.ge5d5e
