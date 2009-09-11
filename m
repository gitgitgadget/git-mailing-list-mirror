From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/3] Disallow creating invalid DirCacheEntry records
Date: Fri, 11 Sep 2009 12:58:47 -0700
Message-ID: <1252699129-6961-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <sop@google.com>,
	"Adam W. Hawks" <awhawks@writeme.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 21:59:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmCGo-0001tD-Ti
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 21:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbZIKT6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 15:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756068AbZIKT6t
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 15:58:49 -0400
Received: from george.spearce.org ([209.20.77.23]:53645 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbZIKT6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 15:58:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6656F38200; Fri, 11 Sep 2009 19:58:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2ED5538153;
	Fri, 11 Sep 2009 19:58:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.rc0.164.g5f6b0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128214>

A dircache record must not use a path string like "/a" or "a//b"
as this results in a tree entry being written with a zero length
name component in the record.  C git does not support an empty name,
and neither does any modern filesystem.

A record also must not have a stage outside of the standard 0-3
value range, as there are only 2 bits of space available in the
on-disk format of the record to store the stage information.
Any other values would be truncated into this space, storing a
different value than the caller expected.

If an application tries to create a DirCache record with either of
these wrong values, we abort with an IllegalArgumentException.

Signed-off-by: Shawn O. Pearce <sop@google.com>
CC: Adam W. Hawks <awhawks@writeme.com>
---
 .../spearce/jgit/dircache/DirCacheEntryTest.java   |  115 ++++++++++++++++++++
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |   55 +++++++++-
 2 files changed, 169 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheEntryTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheEntryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheEntryTest.java
new file mode 100644
index 0000000..a6ff5a8
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheEntryTest.java
@@ -0,0 +1,115 @@
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
+package org.spearce.jgit.dircache;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+
+public class DirCacheEntryTest extends TestCase {
+	public void testIsValidPath() {
+		assertTrue(isValidPath("a"));
+		assertTrue(isValidPath("a/b"));
+		assertTrue(isValidPath("ab/cd/ef"));
+
+		assertFalse(isValidPath(""));
+		assertFalse(isValidPath("/a"));
+		assertFalse(isValidPath("a//b"));
+		assertFalse(isValidPath("ab/cd//ef"));
+		assertFalse(isValidPath("a/"));
+		assertFalse(isValidPath("ab/cd/ef/"));
+		assertFalse(isValidPath("a\u0000b"));
+	}
+
+	private static boolean isValidPath(final String path) {
+		return DirCacheEntry.isValidPath(Constants.encode(path));
+	}
+
+	public void testCreate_ByStringPath() {
+		assertEquals("a", new DirCacheEntry("a").getPathString());
+		assertEquals("a/b", new DirCacheEntry("a/b").getPathString());
+
+		try {
+			new DirCacheEntry("/a");
+			fail("Incorrectly created DirCacheEntry");
+		} catch (IllegalArgumentException err) {
+			assertEquals("Invalid path: /a", err.getMessage());
+		}
+	}
+
+	public void testCreate_ByStringPathAndStage() {
+		DirCacheEntry e;
+
+		e = new DirCacheEntry("a", 0);
+		assertEquals("a", e.getPathString());
+		assertEquals(0, e.getStage());
+
+		e = new DirCacheEntry("a/b", 1);
+		assertEquals("a/b", e.getPathString());
+		assertEquals(1, e.getStage());
+
+		e = new DirCacheEntry("a/c", 2);
+		assertEquals("a/c", e.getPathString());
+		assertEquals(2, e.getStage());
+
+		e = new DirCacheEntry("a/d", 3);
+		assertEquals("a/d", e.getPathString());
+		assertEquals(3, e.getStage());
+
+		try {
+			new DirCacheEntry("/a", 1);
+			fail("Incorrectly created DirCacheEntry");
+		} catch (IllegalArgumentException err) {
+			assertEquals("Invalid path: /a", err.getMessage());
+		}
+
+		try {
+			new DirCacheEntry("a", -11);
+			fail("Incorrectly created DirCacheEntry");
+		} catch (IllegalArgumentException err) {
+			assertEquals("Invalid stage -11 for path a", err.getMessage());
+		}
+
+		try {
+			new DirCacheEntry("a", 4);
+			fail("Incorrectly created DirCacheEntry");
+		} catch (IllegalArgumentException err) {
+			assertEquals("Invalid stage 4 for path a", err.getMessage());
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index 47b1cc5..d7abd6e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -166,6 +166,10 @@
 	 *
 	 * @param newPath
 	 *            name of the cache entry.
+	 * @throws IllegalArgumentException
+	 *             If the path starts or ends with "/", or contains "//" either
+	 *             "\0". These sequences are not permitted in a git tree object
+	 *             or DirCache file.
 	 */
 	public DirCacheEntry(final String newPath) {
 		this(Constants.encode(newPath));
@@ -178,6 +182,11 @@ public DirCacheEntry(final String newPath) {
 	 *            name of the cache entry.
 	 * @param stage
 	 *            the stage index of the new entry.
+	 * @throws IllegalArgumentException
+	 *             If the path starts or ends with "/", or contains "//" either
+	 *             "\0". These sequences are not permitted in a git tree object
+	 *             or DirCache file.  Or if {@code stage} is outside of the
+	 *             range 0..3, inclusive.
 	 */
 	public DirCacheEntry(final String newPath, final int stage) {
 		this(Constants.encode(newPath), stage);
@@ -188,6 +197,10 @@ public DirCacheEntry(final String newPath, final int stage) {
 	 *
 	 * @param newPath
 	 *            name of the cache entry, in the standard encoding.
+	 * @throws IllegalArgumentException
+	 *             If the path starts or ends with "/", or contains "//" either
+	 *             "\0". These sequences are not permitted in a git tree object
+	 *             or DirCache file.
 	 */
 	public DirCacheEntry(final byte[] newPath) {
 		this(newPath, STAGE_0);
@@ -200,8 +213,20 @@ public DirCacheEntry(final byte[] newPath) {
 	 *            name of the cache entry, in the standard encoding.
 	 * @param stage
 	 *            the stage index of the new entry.
+	 * @throws IllegalArgumentException
+	 *             If the path starts or ends with "/", or contains "//" either
+	 *             "\0". These sequences are not permitted in a git tree object
+	 *             or DirCache file.  Or if {@code stage} is outside of the
+	 *             range 0..3, inclusive.
 	 */
 	public DirCacheEntry(final byte[] newPath, final int stage) {
+		if (!isValidPath(newPath))
+			throw new IllegalArgumentException("Invalid path: "
+					+ toString(newPath));
+		if (stage < 0 || 3 < stage)
+			throw new IllegalArgumentException("Invalid stage " + stage
+					+ " for path " + toString(newPath));
+
 		info = new byte[INFO_LEN];
 		infoOffset = 0;
 		path = newPath;
@@ -461,7 +486,7 @@ public void setObjectIdFromRaw(final byte[] bs, final int p) {
 	 *         returned string.
 	 */
 	public String getPathString() {
-		return Constants.CHARSET.decode(ByteBuffer.wrap(path)).toString();
+		return toString(path);
 	}
 
 	/**
@@ -492,4 +517,32 @@ private void encodeTS(final int pIdx, final long when) {
 		NB.encodeInt32(info, base, (int) (when / 1000));
 		NB.encodeInt32(info, base + 4, ((int) (when % 1000)) * 1000000);
 	}
+
+	private static String toString(final byte[] path) {
+		return Constants.CHARSET.decode(ByteBuffer.wrap(path)).toString();
+	}
+
+	static boolean isValidPath(final byte[] path) {
+		if (path.length == 0)
+			return false; // empty path is not permitted.
+
+		boolean componentHasChars = false;
+		for (final byte c : path) {
+			switch (c) {
+			case 0:
+				return false; // NUL is never allowed within the path.
+
+			case '/':
+				if (componentHasChars)
+					componentHasChars = false;
+				else
+					return false;
+				break;
+
+			default:
+				componentHasChars = true;
+			}
+		}
+		return componentHasChars;
+	}
 }
-- 
1.6.5.rc0.164.g5f6b0
