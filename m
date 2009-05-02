From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/6] Teach FileHeader, HunkHeader how to create an EditList
Date: Fri,  1 May 2009 19:08:46 -0700
Message-ID: <1241230127-28279-6-git-send-email-spearce@spearce.org>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org>
 <1241230127-28279-2-git-send-email-spearce@spearce.org>
 <1241230127-28279-3-git-send-email-spearce@spearce.org>
 <1241230127-28279-4-git-send-email-spearce@spearce.org>
 <1241230127-28279-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 02 04:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M04fv-0003zI-TT
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 04:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbZEBCJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 22:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbZEBCJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 22:09:28 -0400
Received: from george.spearce.org ([209.20.77.23]:48677 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbZEBCJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 22:09:13 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E739F3807D; Sat,  2 May 2009 02:09:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4AE0C38081;
	Sat,  2 May 2009 02:08:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
In-Reply-To: <1241230127-28279-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118124>

The EditList type along with its member Edit instances can be very
useful when mining a patch for information about the change it is
trying to represent to the content.  This can be useful to create a
modified version of the patch, such as with larger or smaller number
of context lines.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/patch/testEditList_Types.patch    |   24 +++++
 .../tst/org/spearce/jgit/patch/EditListTest.java   |   95 ++++++++++++++++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |    9 ++
 .../src/org/spearce/jgit/patch/HunkHeader.java     |   48 ++++++++++
 4 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/testEditList_Types.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/EditListTest.java

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/testEditList_Types.patch b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/testEditList_Types.patch
new file mode 100644
index 0000000..e5363eb
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/testEditList_Types.patch
@@ -0,0 +1,24 @@
+diff --git a/X b/X
+index a3648a1..2d44096 100644
+--- a/X
++++ b/X
+@@ -2,2 +2,3 @@ a
+ b
++c
+ d
+@@ -16,4 +17,2 @@ p
+ q
+-r
+-s
+ t
+@@ -22,4 +21,8 @@ v
+ w
+-x
+-y
++0
++1
++2
++3
++4
++5
+ z
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/EditListTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/EditListTest.java
new file mode 100644
index 0000000..452f661
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/EditListTest.java
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) 2009, Google Inc.
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
+import org.spearce.jgit.diff.Edit;
+import org.spearce.jgit.diff.EditList;
+
+public class EditListTest extends TestCase {
+	public void testHunkHeader() throws IOException {
+		final Patch p = parseTestPatchFile("testGetText_BothISO88591.patch");
+		final FileHeader fh = p.getFiles().get(0);
+
+		final EditList list0 = fh.getHunks().get(0).toEditList();
+		assertEquals(1, list0.size());
+		assertEquals(new Edit(4 - 1, 5 - 1, 4 - 1, 5 - 1), list0.get(0));
+
+		final EditList list1 = fh.getHunks().get(1).toEditList();
+		assertEquals(1, list1.size());
+		assertEquals(new Edit(16 - 1, 17 - 1, 16 - 1, 17 - 1), list1.get(0));
+	}
+
+	public void testFileHeader() throws IOException {
+		final Patch p = parseTestPatchFile("testGetText_BothISO88591.patch");
+		final FileHeader fh = p.getFiles().get(0);
+		final EditList e = fh.toEditList();
+		assertEquals(2, e.size());
+		assertEquals(new Edit(4 - 1, 5 - 1, 4 - 1, 5 - 1), e.get(0));
+		assertEquals(new Edit(16 - 1, 17 - 1, 16 - 1, 17 - 1), e.get(1));
+	}
+
+	public void testTypes() throws IOException {
+		final Patch p = parseTestPatchFile("testEditList_Types.patch");
+		final FileHeader fh = p.getFiles().get(0);
+		final EditList e = fh.toEditList();
+		assertEquals(3, e.size());
+		assertEquals(new Edit(3 - 1, 3 - 1, 3 - 1, 4 - 1), e.get(0));
+		assertEquals(new Edit(17 - 1, 19 - 1, 18 - 1, 18 - 1), e.get(1));
+		assertEquals(new Edit(23 - 1, 25 - 1, 22 - 1, 28 - 1), e.get(2));
+	}
+
+	private Patch parseTestPatchFile(final String patchFile) throws IOException {
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
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index 7d341d8..c64f742 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -52,6 +52,7 @@
 import java.util.Collections;
 import java.util.List;
 
+import org.spearce.jgit.diff.EditList;
 import org.spearce.jgit.lib.AbbreviatedObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
@@ -423,6 +424,14 @@ public BinaryHunk getReverseBinaryHunk() {
 		return reverseBinaryHunk;
 	}
 
+	/** @return a list describing the content edits performed on this file. */
+	public EditList toEditList() {
+		final EditList r = new EditList();
+		for (final HunkHeader hunk : hunks)
+			r.addAll(hunk.toEditList());
+		return r;
+	}
+
 	/**
 	 * Parse a "diff --git" or "diff --cc" line.
 	 *
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index e9c55e3..af128ab 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -44,6 +44,8 @@
 import java.io.IOException;
 import java.io.OutputStream;
 
+import org.spearce.jgit.diff.Edit;
+import org.spearce.jgit.diff.EditList;
 import org.spearce.jgit.lib.AbbreviatedObjectId;
 import org.spearce.jgit.util.MutableInteger;
 
@@ -161,6 +163,52 @@ public int getLinesContext() {
 		return nContext;
 	}
 
+	/** @return a list describing the content edits performed within the hunk. */
+	public EditList toEditList() {
+		final EditList r = new EditList();
+		final byte[] buf = file.buf;
+		int c = nextLF(buf, startOffset);
+		int oLine = old.startLine;
+		int nLine = newStartLine;
+		Edit in = null;
+
+		SCAN: for (; c < endOffset; c = nextLF(buf, c)) {
+			switch (buf[c]) {
+			case ' ':
+			case '\n':
+				in = null;
+				oLine++;
+				nLine++;
+				continue;
+
+			case '-':
+				if (in == null) {
+					in = new Edit(oLine - 1, nLine - 1);
+					r.add(in);
+				}
+				oLine++;
+				in.extendA();
+				continue;
+
+			case '+':
+				if (in == null) {
+					in = new Edit(oLine - 1, nLine - 1);
+					r.add(in);
+				}
+				nLine++;
+				in.extendB();
+				continue;
+
+			case '\\': // Matches "\ No newline at end of file"
+				continue;
+
+			default:
+				break SCAN;
+			}
+		}
+		return r;
+	}
+
 	void parseHeader() {
 		// Parse "@@ -236,9 +236,9 @@ protected boolean"
 		//
-- 
1.6.3.rc3.212.g8c698
