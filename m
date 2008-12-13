From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Add getPatchText functions to obtain the plain-text version of a patch
Date: Fri, 12 Dec 2008 18:42:26 -0800
Message-ID: <1229136146-15359-2-git-send-email-spearce@spearce.org>
References: <1229136146-15359-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 03:43:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBKTq-0002m4-Ux
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 03:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbYLMCma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 21:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754486AbYLMCma
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 21:42:30 -0500
Received: from george.spearce.org ([209.20.77.23]:38319 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbYLMCm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 21:42:28 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id CB66938210; Sat, 13 Dec 2008 02:42:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DE74638200;
	Sat, 13 Dec 2008 02:42:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229136146-15359-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102981>

The conversion from byte[] to String is performed one line at a time,
in case the patch is a character encoding conversion patch for the
file.  For simplicity we currently assume UTF-8 still as the default
encoding for any content, but eventually we should support using the
.gitattributes encoding property when performing this conversion.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/patch/BinaryHunk.java     |    8 ++
 .../src/org/spearce/jgit/patch/FileHeader.java     |    6 ++
 .../src/org/spearce/jgit/patch/HunkHeader.java     |    7 ++
 .../src/org/spearce/jgit/patch/PatchUtil.java      |   79 ++++++++++++++++++++
 4 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/PatchUtil.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java b/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
index f43a1b9..f4e2ee3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
@@ -42,6 +42,8 @@
 import static org.spearce.jgit.util.RawParseUtils.nextLF;
 import static org.spearce.jgit.util.RawParseUtils.parseBase10;
 
+import org.spearce.jgit.lib.Constants;
+
 /** Part of a "GIT binary patch" to describe the pre-image or post-image */
 public class BinaryHunk {
 	private static final byte[] LITERAL = encodeASCII("literal ");
@@ -96,6 +98,12 @@ public int getEndOffset() {
 		return endOffset;
 	}
 
+	/** @return text of this patch file's script; best-effort decoded */
+	public String getHunkText() {
+		return PatchUtil.decode(Constants.CHARSET, getBuffer(),
+				getStartOffset(), getEndOffset());
+	}
+
 	/** @return type of this binary hunk */
 	public Type getType() {
 		return type;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index 7c3a45a..0110f4a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -188,6 +188,12 @@ public int getEndOffset() {
 		return endOffset;
 	}
 
+	/** @return text of this patch file's script; best-effort decoded */
+	public String getScriptText() {
+		return PatchUtil.decode(Constants.CHARSET, getBuffer(),
+				getStartOffset(), getEndOffset());
+	}
+
 	/**
 	 * Get the old name associated with this file.
 	 * <p>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index 12c670d..5a3b590 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -42,6 +42,7 @@
 import static org.spearce.jgit.util.RawParseUtils.parseBase10;
 
 import org.spearce.jgit.lib.AbbreviatedObjectId;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.util.MutableInteger;
 
 /** Hunk header describing the layout of a single block of lines */
@@ -138,6 +139,12 @@ public int getEndOffset() {
 		return endOffset;
 	}
 
+	/** @return text of this patch file's script; best-effort decoded */
+	public String getHunkText() {
+		return PatchUtil.decode(Constants.CHARSET, getBuffer(),
+				getStartOffset(), getEndOffset());
+	}
+
 	/** @return information about the old image mentioned in this hunk. */
 	public OldImage getOldImage() {
 		return old;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/PatchUtil.java b/org.spearce.jgit/src/org/spearce/jgit/patch/PatchUtil.java
new file mode 100644
index 0000000..89136c0
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/PatchUtil.java
@@ -0,0 +1,79 @@
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
+import java.nio.charset.Charset;
+
+import org.spearce.jgit.util.RawParseUtils;
+
+/** Patch related utility functions. */
+public class PatchUtil {
+	/**
+	 * Decode a region of a buffer one line at a time.
+	 * <p>
+	 * Unlike {@link RawParseUtils#decode(Charset, byte[], int, int)} this
+	 * method reads the input one line at a time and decodes each line
+	 * individually. This permits a decoding of a file converting from
+	 * ISO-8859-1 to UTF-8 encoding (for example), as each line in the patch
+	 * script will be in one encoding or the other.
+	 * 
+	 * @param cs
+	 *            preferred character set to use when decoding the buffer.
+	 * @param buf
+	 *            buffer to pull the raw bytes from.
+	 * @param ptr
+	 *            first position to read.
+	 * @param end
+	 *            one position past the last position to read.
+	 * @return a string representation of the region, decoded per-line.
+	 */
+	public static String decode(final Charset cs, final byte[] buf, int ptr,
+			final int end) {
+		final StringBuilder r = new StringBuilder(end - ptr);
+		while (ptr < end) {
+			final int eol = Math.min(end, RawParseUtils.nextLF(buf, ptr));
+			r.append(RawParseUtils.decode(cs, buf, ptr, eol));
+			ptr = eol;
+		}
+		return r.toString();
+	}
+
+	private PatchUtil() {
+		// No instances
+	}
+}
-- 
1.6.1.rc2.306.ge5d5e
