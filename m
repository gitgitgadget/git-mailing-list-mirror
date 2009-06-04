From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/7] Add tests for PacketLineIn
Date: Thu,  4 Jun 2009 14:44:01 -0700
Message-ID: <1244151843-26954-6-git-send-email-spearce@spearce.org>
References: <1244151843-26954-1-git-send-email-spearce@spearce.org>
 <1244151843-26954-2-git-send-email-spearce@spearce.org>
 <1244151843-26954-3-git-send-email-spearce@spearce.org>
 <1244151843-26954-4-git-send-email-spearce@spearce.org>
 <1244151843-26954-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:45:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKkJ-0001OL-0b
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455AbZFDVoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 17:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbZFDVoR
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:44:17 -0400
Received: from george.spearce.org ([209.20.77.23]:35374 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbZFDVoG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 17:44:06 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7037438200; Thu,  4 Jun 2009 21:44:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 383923821F;
	Thu,  4 Jun 2009 21:44:05 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.1.333.g3ebba7
In-Reply-To: <1244151843-26954-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120719>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/PacketLineInTest.java   |  262 ++++++++++++++++++++
 1 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/PacketLineInTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PacketLineInTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PacketLineInTest.java
new file mode 100644
index 0000000..b9ab50e
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PacketLineInTest.java
@@ -0,0 +1,262 @@
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
+import java.io.ByteArrayInputStream;
+import java.io.IOException;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.MutableObjectId;
+import org.spearce.jgit.lib.ObjectId;
+
+// Note, test vectors created with:
+//
+// perl -e 'printf "%4.4x%s\n", 4+length($ARGV[0]),$ARGV[0]'
+
+public class PacketLineInTest extends TestCase {
+	private ByteArrayInputStream rawIn;
+
+	private PacketLineIn in;
+
+	// readString
+
+	public void testReadString1() throws IOException {
+		init("0006a\n0007bc\n");
+		assertEquals("a", in.readString());
+		assertEquals("bc", in.readString());
+		assertEOF();
+	}
+
+	public void testReadString2() throws IOException {
+		init("0032want fcfcfb1fd94829c1a1704f894fc111d14770d34e\n");
+		final String act = in.readString();
+		assertEquals("want fcfcfb1fd94829c1a1704f894fc111d14770d34e", act);
+		assertEOF();
+	}
+
+	public void testReadString4() throws IOException {
+		init("0005a0006bc");
+		assertEquals("a", in.readString());
+		assertEquals("bc", in.readString());
+		assertEOF();
+	}
+
+	public void testReadString5() throws IOException {
+		// accept both upper and lower case
+		init("000Fhi i am a s");
+		assertEquals("hi i am a s", in.readString());
+		assertEOF();
+
+		init("000fhi i am a s");
+		assertEquals("hi i am a s", in.readString());
+		assertEOF();
+	}
+
+	public void testReadString_LenHELO() {
+		init("HELO");
+		try {
+			in.readString();
+			fail("incorrectly accepted invalid packet header");
+		} catch (IOException e) {
+			assertEquals("Invalid packet line header: HELO", e.getMessage());
+		}
+	}
+
+	public void testReadString_Len0001() {
+		init("0001");
+		try {
+			in.readString();
+			fail("incorrectly accepted invalid packet header");
+		} catch (IOException e) {
+			assertEquals("Invalid packet line header: 0001", e.getMessage());
+		}
+	}
+
+	public void testReadString_Len0002() {
+		init("0002");
+		try {
+			in.readString();
+			fail("incorrectly accepted invalid packet header");
+		} catch (IOException e) {
+			assertEquals("Invalid packet line header: 0002", e.getMessage());
+		}
+	}
+
+	public void testReadString_Len0003() {
+		init("0003");
+		try {
+			in.readString();
+			fail("incorrectly accepted invalid packet header");
+		} catch (IOException e) {
+			assertEquals("Invalid packet line header: 0003", e.getMessage());
+		}
+	}
+
+	public void testReadString_Len0004() throws IOException {
+		init("0004");
+		final String act = in.readString();
+		assertEquals("", act);
+		assertNotSame(PacketLineIn.END, act);
+		assertEOF();
+	}
+
+	public void testReadString_End() throws IOException {
+		init("0000");
+		assertSame(PacketLineIn.END, in.readString());
+		assertEOF();
+	}
+
+	// readStringNoLF
+
+	public void testReadStringRaw1() throws IOException {
+		init("0005a0006bc");
+		assertEquals("a", in.readStringRaw());
+		assertEquals("bc", in.readStringRaw());
+		assertEOF();
+	}
+
+	public void testReadStringRaw2() throws IOException {
+		init("0031want fcfcfb1fd94829c1a1704f894fc111d14770d34e");
+		final String act = in.readStringRaw();
+		assertEquals("want fcfcfb1fd94829c1a1704f894fc111d14770d34e", act);
+		assertEOF();
+	}
+
+	public void testReadStringRaw3() throws IOException {
+		init("0004");
+		final String act = in.readStringRaw();
+		assertEquals("", act);
+		assertNotSame(PacketLineIn.END, act);
+		assertEOF();
+	}
+
+	public void testReadStringRaw_End() throws IOException {
+		init("0000");
+		assertSame(PacketLineIn.END, in.readStringRaw());
+		assertEOF();
+	}
+
+	public void testReadStringRaw4() {
+		init("HELO");
+		try {
+			in.readStringRaw();
+			fail("incorrectly accepted invalid packet header");
+		} catch (IOException e) {
+			assertEquals("Invalid packet line header: HELO", e.getMessage());
+		}
+	}
+
+	// readACK
+
+	public void testReadACK_NAK() throws IOException {
+		final ObjectId expid = ObjectId
+				.fromString("fcfcfb1fd94829c1a1704f894fc111d14770d34e");
+		final MutableObjectId actid = new MutableObjectId();
+		actid.fromString(expid.name());
+
+		init("0008NAK\n");
+		assertSame(PacketLineIn.AckNackResult.NAK, in.readACK(actid));
+		assertTrue(actid.equals(expid));
+		assertEOF();
+	}
+
+	public void testReadACK_ACK1() throws IOException {
+		final ObjectId expid = ObjectId
+				.fromString("fcfcfb1fd94829c1a1704f894fc111d14770d34e");
+		final MutableObjectId actid = new MutableObjectId();
+
+		init("0031ACK fcfcfb1fd94829c1a1704f894fc111d14770d34e\n");
+		assertSame(PacketLineIn.AckNackResult.ACK, in.readACK(actid));
+		assertTrue(actid.equals(expid));
+		assertEOF();
+	}
+
+	public void testReadACK_ACKcontinue1() throws IOException {
+		final ObjectId expid = ObjectId
+				.fromString("fcfcfb1fd94829c1a1704f894fc111d14770d34e");
+		final MutableObjectId actid = new MutableObjectId();
+
+		init("003aACK fcfcfb1fd94829c1a1704f894fc111d14770d34e continue\n");
+		assertSame(PacketLineIn.AckNackResult.ACK_CONTINUE, in.readACK(actid));
+		assertTrue(actid.equals(expid));
+		assertEOF();
+	}
+
+	public void testReadACK_Invalid1() {
+		init("HELO");
+		try {
+			in.readACK(new MutableObjectId());
+			fail("incorrectly accepted invalid packet header");
+		} catch (IOException e) {
+			assertEquals("Invalid packet line header: HELO", e.getMessage());
+		}
+	}
+
+	public void testReadACK_Invalid2() {
+		init("0009HELO\n");
+		try {
+			in.readACK(new MutableObjectId());
+			fail("incorrectly accepted invalid ACK/NAK");
+		} catch (IOException e) {
+			assertEquals("Expected ACK/NAK, got: HELO", e.getMessage());
+		}
+	}
+
+	public void testReadACK_Invalid3() {
+		init("0000");
+		try {
+			in.readACK(new MutableObjectId());
+			fail("incorrectly accepted no ACK/NAK");
+		} catch (IOException e) {
+			assertEquals("Expected ACK/NAK, found EOF", e.getMessage());
+		}
+	}
+
+	// test support
+
+	private void init(final String msg) {
+		rawIn = new ByteArrayInputStream(Constants.encodeASCII(msg));
+		in = new PacketLineIn(rawIn);
+	}
+
+	private void assertEOF() {
+		assertEquals(-1, rawIn.read());
+	}
+}
-- 
1.6.3.1.333.g3ebba7
