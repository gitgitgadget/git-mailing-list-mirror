From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Fix RawParseUtils to match on the end of the buffer
Date: Thu, 15 Jan 2009 09:02:54 -0800
Message-ID: <1232038974-19638-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:04:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNVdo-0002Jv-11
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 18:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547AbZAORDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 12:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321AbZAORC7
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 12:02:59 -0500
Received: from george.spearce.org ([209.20.77.23]:54030 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbZAORC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 12:02:58 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id EB6ED38211; Thu, 15 Jan 2009 17:02:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5A42538210;
	Thu, 15 Jan 2009 17:02:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.233.g5b4a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105856>

When we were matching exactly on the end of the buffer the match
method was failing because it incorrectly tested for >= on the
buffer length.  We only needed to test for > the buffer length.

JUnit tests for the match function are included to test for this
condition, and others.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/util/RawParseUtils_MatchTest.java |   69 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |    4 +-
 2 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_MatchTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_MatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_MatchTest.java
new file mode 100644
index 0000000..32270b7
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_MatchTest.java
@@ -0,0 +1,69 @@
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
+package org.spearce.jgit.util;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+
+public class RawParseUtils_MatchTest extends TestCase {
+	public void testMatch_Equal() {
+		final byte[] src = Constants.encodeASCII(" differ\n");
+		final byte[] dst = Constants.encodeASCII("foo differ\n");
+		assertTrue(RawParseUtils.match(dst, 3, src) == 3 + src.length);
+	}
+
+	public void testMatch_NotEqual() {
+		final byte[] src = Constants.encodeASCII(" differ\n");
+		final byte[] dst = Constants.encodeASCII("a differ\n");
+		assertTrue(RawParseUtils.match(dst, 2, src) < 0);
+	}
+
+	public void testMatch_Prefix() {
+		final byte[] src = Constants.encodeASCII("author ");
+		final byte[] dst = Constants.encodeASCII("author A. U. Thor");
+		assertTrue(RawParseUtils.match(dst, 0, src) == src.length);
+		assertTrue(RawParseUtils.match(dst, 1, src) < 0);
+	}
+
+	public void testMatch_TooSmall() {
+		final byte[] src = Constants.encodeASCII("author ");
+		final byte[] dst = Constants.encodeASCII("author autho");
+		assertTrue(RawParseUtils.match(dst, src.length + 1, src) < 0);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index a6a50bb..758e7af 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -71,10 +71,10 @@
 	 *            first position within b, this should match src[0].
 	 * @param src
 	 *            the buffer to test for equality with b.
-	 * @return ptr += src.length if b[ptr..src.length] == src; else -1.
+	 * @return ptr + src.length if b[ptr..src.length] == src; else -1.
 	 */
 	public static final int match(final byte[] b, int ptr, final byte[] src) {
-		if (ptr + src.length >= b.length)
+		if (ptr + src.length > b.length)
 			return -1;
 		for (int i = 0; i < src.length; i++, ptr++)
 			if (b[ptr] != src[i])
-- 
1.6.1.233.g5b4a8
