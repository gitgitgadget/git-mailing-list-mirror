From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/15] Add tests for TemporaryBuffer
Date: Thu, 11 Dec 2008 18:46:08 -0800
Message-ID: <1229049981-14152-3-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy4w-00057A-OD
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbYLLCqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757275AbYLLCqd
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:33 -0500
Received: from george.spearce.org ([209.20.77.23]:41572 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757195AbYLLCqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:25 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 71FBE38260; Fri, 12 Dec 2008 02:46:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5B55238210;
	Fri, 12 Dec 2008 02:46:22 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102867>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/util/TemporaryBufferTest.java |  374 ++++++++++++++++++++
 .../tst/org/spearce/jgit/util/TestRng.java         |   61 ++++
 .../src/org/spearce/jgit/util/TemporaryBuffer.java |    4 +-
 3 files changed, 437 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/TemporaryBufferTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/TestRng.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/TemporaryBufferTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/TemporaryBufferTest.java
new file mode 100644
index 0000000..e532d98
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/TemporaryBufferTest.java
@@ -0,0 +1,374 @@
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
+package org.spearce.jgit.util;
+
+import java.io.ByteArrayInputStream;
+import java.io.ByteArrayOutputStream;
+import java.io.IOException;
+import java.util.Arrays;
+
+import junit.framework.TestCase;
+
+public class TemporaryBufferTest extends TestCase {
+	public void testEmpty() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		try {
+			b.close();
+			assertEquals(0, b.length());
+			final byte[] r = b.toByteArray();
+			assertNotNull(r);
+			assertEquals(0, r.length);
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testOneByte() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		final byte test = (byte) new TestRng(getName()).nextInt();
+		try {
+			b.write(test);
+			b.close();
+			assertEquals(1, b.length());
+			{
+				final byte[] r = b.toByteArray();
+				assertNotNull(r);
+				assertEquals(1, r.length);
+				assertEquals(test, r[0]);
+			}
+			{
+				final ByteArrayOutputStream o = new ByteArrayOutputStream();
+				b.writeTo(o, null);
+				o.close();
+				final byte[] r = o.toByteArray();
+				assertEquals(1, r.length);
+				assertEquals(test, r[0]);
+			}
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testOneBlock_BulkWrite() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		final byte[] test = new TestRng(getName())
+				.nextBytes(TemporaryBuffer.Block.SZ);
+		try {
+			b.write(test, 0, 2);
+			b.write(test, 2, 4);
+			b.write(test, 6, test.length - 6 - 2);
+			b.write(test, test.length - 2, 2);
+			b.close();
+			assertEquals(test.length, b.length());
+			{
+				final byte[] r = b.toByteArray();
+				assertNotNull(r);
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+			{
+				final ByteArrayOutputStream o = new ByteArrayOutputStream();
+				b.writeTo(o, null);
+				o.close();
+				final byte[] r = o.toByteArray();
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testOneBlockAndHalf_BulkWrite() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		final byte[] test = new TestRng(getName())
+				.nextBytes(TemporaryBuffer.Block.SZ * 3 / 2);
+		try {
+			b.write(test, 0, 2);
+			b.write(test, 2, 4);
+			b.write(test, 6, test.length - 6 - 2);
+			b.write(test, test.length - 2, 2);
+			b.close();
+			assertEquals(test.length, b.length());
+			{
+				final byte[] r = b.toByteArray();
+				assertNotNull(r);
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+			{
+				final ByteArrayOutputStream o = new ByteArrayOutputStream();
+				b.writeTo(o, null);
+				o.close();
+				final byte[] r = o.toByteArray();
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testOneBlockAndHalf_SingleWrite() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		final byte[] test = new TestRng(getName())
+				.nextBytes(TemporaryBuffer.Block.SZ * 3 / 2);
+		try {
+			for (int i = 0; i < test.length; i++)
+				b.write(test[i]);
+			b.close();
+			assertEquals(test.length, b.length());
+			{
+				final byte[] r = b.toByteArray();
+				assertNotNull(r);
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+			{
+				final ByteArrayOutputStream o = new ByteArrayOutputStream();
+				b.writeTo(o, null);
+				o.close();
+				final byte[] r = o.toByteArray();
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testOneBlockAndHalf_Copy() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		final byte[] test = new TestRng(getName())
+				.nextBytes(TemporaryBuffer.Block.SZ * 3 / 2);
+		try {
+			final ByteArrayInputStream in = new ByteArrayInputStream(test);
+			b.write(in.read());
+			b.copy(in);
+			b.close();
+			assertEquals(test.length, b.length());
+			{
+				final byte[] r = b.toByteArray();
+				assertNotNull(r);
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+			{
+				final ByteArrayOutputStream o = new ByteArrayOutputStream();
+				b.writeTo(o, null);
+				o.close();
+				final byte[] r = o.toByteArray();
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testLarge_SingleWrite() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		final byte[] test = new TestRng(getName())
+				.nextBytes(TemporaryBuffer.DEFAULT_IN_CORE_LIMIT * 3);
+		try {
+			b.write(test);
+			b.close();
+			assertEquals(test.length, b.length());
+			{
+				final byte[] r = b.toByteArray();
+				assertNotNull(r);
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+			{
+				final ByteArrayOutputStream o = new ByteArrayOutputStream();
+				b.writeTo(o, null);
+				o.close();
+				final byte[] r = o.toByteArray();
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testInCoreLimit_SwitchOnAppendByte() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		final byte[] test = new TestRng(getName())
+				.nextBytes(TemporaryBuffer.DEFAULT_IN_CORE_LIMIT + 1);
+		try {
+			b.write(test, 0, test.length - 1);
+			b.write(test[test.length - 1]);
+			b.close();
+			assertEquals(test.length, b.length());
+			{
+				final byte[] r = b.toByteArray();
+				assertNotNull(r);
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+			{
+				final ByteArrayOutputStream o = new ByteArrayOutputStream();
+				b.writeTo(o, null);
+				o.close();
+				final byte[] r = o.toByteArray();
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testInCoreLimit_SwitchBeforeAppendByte() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		final byte[] test = new TestRng(getName())
+				.nextBytes(TemporaryBuffer.DEFAULT_IN_CORE_LIMIT * 3);
+		try {
+			b.write(test, 0, test.length - 1);
+			b.write(test[test.length - 1]);
+			b.close();
+			assertEquals(test.length, b.length());
+			{
+				final byte[] r = b.toByteArray();
+				assertNotNull(r);
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+			{
+				final ByteArrayOutputStream o = new ByteArrayOutputStream();
+				b.writeTo(o, null);
+				o.close();
+				final byte[] r = o.toByteArray();
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testInCoreLimit_SwitchOnCopy() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		final byte[] test = new TestRng(getName())
+				.nextBytes(TemporaryBuffer.DEFAULT_IN_CORE_LIMIT * 2);
+		try {
+			final ByteArrayInputStream in = new ByteArrayInputStream(test,
+					TemporaryBuffer.DEFAULT_IN_CORE_LIMIT, test.length
+							- TemporaryBuffer.DEFAULT_IN_CORE_LIMIT);
+			b.write(test, 0, TemporaryBuffer.DEFAULT_IN_CORE_LIMIT);
+			b.copy(in);
+			b.close();
+			assertEquals(test.length, b.length());
+			{
+				final byte[] r = b.toByteArray();
+				assertNotNull(r);
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+			{
+				final ByteArrayOutputStream o = new ByteArrayOutputStream();
+				b.writeTo(o, null);
+				o.close();
+				final byte[] r = o.toByteArray();
+				assertEquals(test.length, r.length);
+				assertTrue(Arrays.equals(test, r));
+			}
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testDestroyWhileOpen() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		try {
+			b.write(new TestRng(getName())
+					.nextBytes(TemporaryBuffer.DEFAULT_IN_CORE_LIMIT * 2));
+		} finally {
+			b.destroy();
+		}
+	}
+
+	public void testRandomWrites() throws IOException {
+		final TemporaryBuffer b = new TemporaryBuffer();
+		final TestRng rng = new TestRng(getName());
+		final int max = TemporaryBuffer.DEFAULT_IN_CORE_LIMIT * 2;
+		final byte[] expect = new byte[max];
+		try {
+			int written = 0;
+			boolean onebyte = true;
+			while (written < max) {
+				if (onebyte) {
+					final byte v = (byte) rng.nextInt();
+					b.write(v);
+					expect[written++] = v;
+				} else {
+					final int len = Math
+							.min(rng.nextInt() & 127, max - written);
+					final byte[] tmp = rng.nextBytes(len);
+					b.write(tmp, 0, len);
+					System.arraycopy(tmp, 0, expect, written, len);
+					written += len;
+				}
+				onebyte = !onebyte;
+			}
+			assertEquals(expect.length, written);
+			b.close();
+
+			assertEquals(expect.length, b.length());
+			{
+				final byte[] r = b.toByteArray();
+				assertNotNull(r);
+				assertEquals(expect.length, r.length);
+				assertTrue(Arrays.equals(expect, r));
+			}
+			{
+				final ByteArrayOutputStream o = new ByteArrayOutputStream();
+				b.writeTo(o, null);
+				o.close();
+				final byte[] r = o.toByteArray();
+				assertEquals(expect.length, r.length);
+				assertTrue(Arrays.equals(expect, r));
+			}
+		} finally {
+			b.destroy();
+		}
+	}
+
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/TestRng.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/TestRng.java
new file mode 100644
index 0000000..d74a534
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/TestRng.java
@@ -0,0 +1,61 @@
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
+package org.spearce.jgit.util;
+
+/** Toy RNG to ensure we get predictable numbers during unit tests. */
+public class TestRng {
+	private int next;
+
+	public TestRng(final String seed) {
+		next = 0;
+		for (int i = 0; i < seed.length(); i++)
+			next = next * 11 + seed.charAt(i);
+	}
+
+	public byte[] nextBytes(final int cnt) {
+		final byte[] r = new byte[cnt];
+		for (int i = 0; i < cnt; i++)
+			r[i] = (byte) nextInt();
+		return r;
+	}
+
+	public int nextInt() {
+		next = next * 1103515245 + 12345;
+		return next;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
index 8f91246..6267fb5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
@@ -60,7 +60,7 @@
  * after this stream has been properly closed by {@link #close()}.
  */
 public class TemporaryBuffer extends OutputStream {
-	private static final int DEFAULT_IN_CORE_LIMIT = 1024 * 1024;
+	static final int DEFAULT_IN_CORE_LIMIT = 1024 * 1024;
 
 	/** Chain of data, if we are still completely in-core; otherwise null. */
 	private ArrayList<Block> blocks;
@@ -297,7 +297,7 @@ public void destroy() {
 		}
 	}
 
-	private static class Block {
+	static class Block {
 		static final int SZ = 8 * 1024;
 
 		final byte[] buffer = new byte[SZ];
-- 
1.6.1.rc2.306.ge5d5e
