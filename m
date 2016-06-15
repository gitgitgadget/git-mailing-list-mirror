From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 6/7] Add tests for PacketLineOut
Date: Thu,  4 Jun 2009 14:44:02 -0700
Message-ID: <1244151843-26954-7-git-send-email-spearce@spearce.org>
References: <1244151843-26954-1-git-send-email-spearce@spearce.org>
 <1244151843-26954-2-git-send-email-spearce@spearce.org>
 <1244151843-26954-3-git-send-email-spearce@spearce.org>
 <1244151843-26954-4-git-send-email-spearce@spearce.org>
 <1244151843-26954-5-git-send-email-spearce@spearce.org>
 <1244151843-26954-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:45:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKkJ-0001OL-NN
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbZFDVoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 17:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754651AbZFDVoU
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:44:20 -0400
Received: from george.spearce.org ([209.20.77.23]:35377 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbZFDVoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 17:44:07 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3814E3821F; Thu,  4 Jun 2009 21:44:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 88BE8381D1;
	Thu,  4 Jun 2009 21:44:05 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.1.333.g3ebba7
In-Reply-To: <1244151843-26954-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120721>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/PacketLineOutTest.java  |  175 ++++++++++++++++++++
 1 files changed, 175 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/PacketLineOutTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PacketLineOutTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PacketLineOutTest.java
new file mode 100644
index 0000000..de0f222
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PacketLineOutTest.java
@@ -0,0 +1,175 @@
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
+public class PacketLineOutTest extends TestCase {
+	private ByteArrayOutputStream rawOut;
+
+	private PacketLineOut out;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		rawOut = new ByteArrayOutputStream();
+		out = new PacketLineOut(rawOut);
+	}
+
+	// writeString
+
+	public void testWriteString1() throws IOException {
+		out.writeString("a");
+		out.writeString("bc");
+		assertBuffer("0005a0006bc");
+	}
+
+	public void testWriteString2() throws IOException {
+		out.writeString("a\n");
+		out.writeString("bc\n");
+		assertBuffer("0006a\n0007bc\n");
+	}
+
+	public void testWriteString3() throws IOException {
+		out.writeString("");
+		assertBuffer("0004");
+	}
+
+	// end
+
+	public void testWriteEnd() throws IOException {
+		final int[] flushCnt = new int[1];
+		final OutputStream mockout = new OutputStream() {
+			@Override
+			public void write(int arg0) throws IOException {
+				rawOut.write(arg0);
+			}
+
+			@Override
+			public void flush() throws IOException {
+				flushCnt[0]++;
+			}
+		};
+
+		new PacketLineOut(mockout).end();
+		assertBuffer("0000");
+		assertEquals(1, flushCnt[0]);
+	}
+
+	// writePacket
+
+	public void testWritePacket1() throws IOException {
+		out.writePacket(new byte[] { 'a' });
+		assertBuffer("0005a");
+	}
+
+	public void testWritePacket2() throws IOException {
+		out.writePacket(new byte[] { 'a', 'b', 'c', 'd' });
+		assertBuffer("0008abcd");
+	}
+
+	public void testWritePacket3() throws IOException {
+		final int buflen = SideBandOutputStream.MAX_BUF
+				- SideBandOutputStream.HDR_SIZE;
+		final byte[] buf = new byte[buflen];
+		for (int i = 0; i < buf.length; i++) {
+			buf[i] = (byte) i;
+		}
+		out.writePacket(buf);
+		out.flush();
+
+		final byte[] act = rawOut.toByteArray();
+		final String explen = Integer.toString(buf.length + 4, 16);
+		assertEquals(4 + buf.length, act.length);
+		assertEquals(new String(act, 0, 4, "UTF-8"), explen);
+		for (int i = 0, j = 4; i < buf.length; i++, j++) {
+			assertEquals(buf[i], act[j]);
+		}
+	}
+
+	// writeChannelPacket
+
+	public void testWriteChannelPacket1() throws IOException {
+		out.writeChannelPacket(1, new byte[] { 'a' }, 0, 1);
+		assertBuffer("0006\001a");
+	}
+
+	public void testWriteChannelPacket2() throws IOException {
+		out.writeChannelPacket(2, new byte[] { 'b' }, 0, 1);
+		assertBuffer("0006\002b");
+	}
+
+	public void testWriteChannelPacket3() throws IOException {
+		out.writeChannelPacket(3, new byte[] { 'c' }, 0, 1);
+		assertBuffer("0006\003c");
+	}
+
+	// flush
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
+		new PacketLineOut(mockout).flush();
+		assertEquals(1, flushCnt[0]);
+	}
+
+	private void assertBuffer(final String exp) throws IOException {
+		assertEquals(exp, new String(rawOut.toByteArray(),
+				Constants.CHARACTER_ENCODING));
+	}
+}
-- 
1.6.3.1.333.g3ebba7
