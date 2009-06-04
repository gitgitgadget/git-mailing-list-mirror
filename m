From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/7] Move PacketLineIn hex parsing to RawParseUtils
Date: Thu,  4 Jun 2009 14:43:59 -0700
Message-ID: <1244151843-26954-4-git-send-email-spearce@spearce.org>
References: <1244151843-26954-1-git-send-email-spearce@spearce.org>
 <1244151843-26954-2-git-send-email-spearce@spearce.org>
 <1244151843-26954-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKkH-0001OL-J7
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbZFDVoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 17:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbZFDVoL
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:44:11 -0400
Received: from george.spearce.org ([209.20.77.23]:35368 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177AbZFDVoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 17:44:04 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D6651381FF; Thu,  4 Jun 2009 21:44:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7565D381FE;
	Thu,  4 Jun 2009 21:44:04 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.1.333.g3ebba7
In-Reply-To: <1244151843-26954-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120717>

This way we can reuse the same declaration buffer, and accept
uppercase digits as well as lowercase digits.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/PacketLineIn.java   |   26 ++---------------
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   30 ++++++++++++++++++++
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java
index 92c7009..8d2cd18 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java
@@ -40,7 +40,6 @@
 
 import java.io.IOException;
 import java.io.InputStream;
-import java.util.Arrays;
 
 import org.spearce.jgit.errors.PackProtocolException;
 import org.spearce.jgit.lib.Constants;
@@ -51,16 +50,6 @@
 
 class PacketLineIn {
 	static final String END = new String("") /* must not string pool */;
-	private static final byte fromhex[];
-
-	static {
-		fromhex = new byte['f' + 1];
-		Arrays.fill(fromhex, (byte) -1);
-		for (char i = '0'; i <= '9'; i++)
-			fromhex[i] = (byte) (i - '0');
-		for (char i = 'a'; i <= 'f'; i++)
-			fromhex[i] = (byte) ((i - 'a') + 10);
-	}
 
 	static enum AckNackResult {
 		/** NAK */
@@ -127,22 +116,13 @@ String readStringRaw() throws IOException {
 		return RawParseUtils.decode(Constants.CHARSET, raw, 0, len);
 	}
 
-
 	int readLength() throws IOException {
 		NB.readFully(in, lenbuffer, 0, 4);
 		try {
-			int r = fromhex[lenbuffer[0]] << 4;
-
-			r |= fromhex[lenbuffer[1]];
-			r <<= 4;
-
-			r |= fromhex[lenbuffer[2]];
-			r <<= 4;
-
-			r |= fromhex[lenbuffer[3]];
-			if (r < 0)
+			final int len = RawParseUtils.parseHexInt16(lenbuffer, 0);
+			if (len != 0 && len < 4)
 				throw new ArrayIndexOutOfBoundsException();
-			return r;
+			return len;
 		} catch (ArrayIndexOutOfBoundsException err) {
 			throw new IOException("Invalid packet line header: "
 					+ (char) lenbuffer[0] + (char) lenbuffer[1]
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 0554acb..5fb3d27 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -255,6 +255,36 @@ public static final long parseLongBase10(final byte[] b, int ptr,
 	}
 
 	/**
+	 * Parse 4 character base 16 (hex) formatted string to unsigned integer.
+	 * <p>
+	 * The number is read in network byte order, that is, most significant
+	 * nybble first.
+	 *
+	 * @param bs
+	 *            buffer to parse digits from; positions {@code [p, p+4)} will
+	 *            be parsed.
+	 * @param p
+	 *            first position within the buffer to parse.
+	 * @return the integer value.
+	 * @throws ArrayIndexOutOfBoundsException
+	 *             if the string is not hex formatted.
+	 */
+	public static final int parseHexInt16(final byte[] bs, final int p) {
+		int r = digits16[bs[p]] << 4;
+
+		r |= digits16[bs[p + 1]];
+		r <<= 4;
+
+		r |= digits16[bs[p + 2]];
+		r <<= 4;
+
+		r |= digits16[bs[p + 3]];
+		if (r < 0)
+			throw new ArrayIndexOutOfBoundsException();
+		return r;
+	}
+
+	/**
 	 * Parse 8 character base 16 (hex) formatted string to unsigned integer.
 	 * <p>
 	 * The number is read in network byte order, that is, most significant
-- 
1.6.3.1.333.g3ebba7
