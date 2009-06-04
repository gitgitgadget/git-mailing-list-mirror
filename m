From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 7/7] Add tests for SideBandOutputStream
Date: Thu,  4 Jun 2009 14:44:03 -0700
Message-ID: <1244151843-26954-8-git-send-email-spearce@spearce.org>
References: <1244151843-26954-1-git-send-email-spearce@spearce.org>
 <1244151843-26954-2-git-send-email-spearce@spearce.org>
 <1244151843-26954-3-git-send-email-spearce@spearce.org>
 <1244151843-26954-4-git-send-email-spearce@spearce.org>
 <1244151843-26954-5-git-send-email-spearce@spearce.org>
 <1244151843-26954-6-git-send-email-spearce@spearce.org>
 <1244151843-26954-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:45:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKkK-0001OL-EJ
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbZFDVoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 17:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbZFDVoX
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:44:23 -0400
Received: from george.spearce.org ([209.20.77.23]:35365 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbZFDVoI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 17:44:08 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 046D9381D1; Thu,  4 Jun 2009 21:44:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D464538215;
	Thu,  4 Jun 2009 21:44:05 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.1.333.g3ebba7
In-Reply-To: <1244151843-26954-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120722>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/SideBandOutputStreamTest.java   |  146 ++++++++++++++++++++
 1 files changed, 146 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/SideBandOutputStreamTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/SideBandOutputStreamTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/SideBandOutputStreamTest.java
new file mode 100644
index 0000000..59e55dc
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/SideBandOutputStreamTest.java
@@ -0,0 +1,146 @@
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
+package org.spearce.jgit.transport;
+
+import java.io.ByteArrayOutputStream;
+import java.io.IOException;
+import java.io.OutputStream;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+
+// Note, test vectors created with:
+//
+// perl -e 'printf "%4.4x%s\n", 4+length($ARGV[0]),$ARGV[0]'
+
+public class SideBandOutputStreamTest extends TestCase {
+	private ByteArrayOutputStream rawOut;
+
+	private PacketLineOut pckOut;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		rawOut = new ByteArrayOutputStream();
+		pckOut = new PacketLineOut(rawOut);
+	}
+
+	public void testWrite_CH_DATA() throws IOException {
+		final SideBandOutputStream out;
+		out = new SideBandOutputStream(SideBandOutputStream.CH_DATA, pckOut);
+		out.write(new byte[] { 'a', 'b', 'c' });
+		assertBuffer("0008\001abc");
+	}
+
+	public void testWrite_CH_PROGRESS() throws IOException {
+		final SideBandOutputStream out;
+		out = new SideBandOutputStream(SideBandOutputStream.CH_PROGRESS, pckOut);
+		out.write(new byte[] { 'a', 'b', 'c' });
+		assertBuffer("0008\002abc");
+	}
+
+	public void testWrite_CH_ERROR() throws IOException {
+		final SideBandOutputStream out;
+		out = new SideBandOutputStream(SideBandOutputStream.CH_ERROR, pckOut);
+		out.write(new byte[] { 'a', 'b', 'c' });
+		assertBuffer("0008\003abc");
+	}
+
+	public void testWrite_Small() throws IOException {
+		final SideBandOutputStream out;
+		out = new SideBandOutputStream(SideBandOutputStream.CH_DATA, pckOut);
+		out.write('a');
+		out.write('b');
+		out.write('c');
+		assertBuffer("0006\001a0006\001b0006\001c");
+	}
+
+	public void testWrite_Large() throws IOException {
+		final int buflen = SideBandOutputStream.MAX_BUF
+				- SideBandOutputStream.HDR_SIZE;
+		final byte[] buf = new byte[buflen];
+		for (int i = 0; i < buf.length; i++) {
+			buf[i] = (byte) i;
+		}
+
+		final SideBandOutputStream out;
+		out = new SideBandOutputStream(SideBandOutputStream.CH_DATA, pckOut);
+		out.write(buf);
+
+		final byte[] act = rawOut.toByteArray();
+		final String explen = Integer.toString(buf.length + 5, 16);
+		assertEquals(5 + buf.length, act.length);
+		assertEquals(new String(act, 0, 4, "UTF-8"), explen);
+		assertEquals(1, act[4]);
+		for (int i = 0, j = 5; i < buf.length; i++, j++) {
+			assertEquals(buf[i], act[j]);
+		}
+	}
+
+	public void testFlush() throws IOException {
+		final int[] flushCnt = new int[1];
+		final OutputStream mockout = new OutputStream() {
+			@Override
+			public void write(int arg0) throws IOException {
+				fail("should not write");
+			}
+
+			@Override
+			public void flush() throws IOException {
+				flushCnt[0]++;
+			}
+		};
+
+		new SideBandOutputStream(SideBandOutputStream.CH_DATA,
+				new PacketLineOut(mockout)).flush();
+		assertEquals(0, flushCnt[0]);
+
+		new SideBandOutputStream(SideBandOutputStream.CH_ERROR,
+				new PacketLineOut(mockout)).flush();
+		assertEquals(1, flushCnt[0]);
+
+		new SideBandOutputStream(SideBandOutputStream.CH_PROGRESS,
+				new PacketLineOut(mockout)).flush();
+		assertEquals(2, flushCnt[0]);
+	}
+
+	private void assertBuffer(final String exp) throws IOException {
+		assertEquals(exp, new String(rawOut.toByteArray(),
+				Constants.CHARACTER_ENCODING));
+	}
+}
-- 
1.6.3.1.333.g3ebba7
