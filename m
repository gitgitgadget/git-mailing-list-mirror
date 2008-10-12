From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 4/4] Intelligent parsing of ambiguously encoded meta data.
Date: Mon, 13 Oct 2008 00:51:00 +0200
Message-ID: <1223851860-13068-5-git-send-email-robin.rosenberg@dewire.com>
References: <1223851860-13068-1-git-send-email-robin.rosenberg@dewire.com>
 <1223851860-13068-2-git-send-email-robin.rosenberg@dewire.com>
 <1223851860-13068-3-git-send-email-robin.rosenberg@dewire.com>
 <1223851860-13068-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Oct 13 00:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp9pQ-0001tC-W9
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 00:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbYJLWxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 18:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104AbYJLWxK
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 18:53:10 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19069 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbYJLWxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 18:53:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7E8508026D0;
	Mon, 13 Oct 2008 00:53:05 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aFNh1caM5Fu7; Mon, 13 Oct 2008 00:52:53 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 508BFA149A1;
	Mon, 13 Oct 2008 00:52:18 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223851860-13068-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98065>

We cannot trust meta data to be encoded in any particular way, so we try
different encodings. First we try UTF-8, which is the only sane encoding
for non-local data, even when used in regions where eight bit legacy
encodings are common. The chance of mistakenly parsing non-UTF-8 data
as valid UTF-8 is varies from extremely low (western encodings) to low
for most other encodings. If the data does not look like UTF-8, we try the
suggested encoding. If that fails we try the user locale and finally, if
that fails we try ISO-8859-1, which cannot fail.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../spearce/jgit/revwalk/RevCommitParseTest.java   |  119 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   63 ++++++++++-
 2 files changed, 179 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
index 3d9d42d..805e29e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
@@ -37,6 +37,8 @@
 
 package org.spearce.jgit.revwalk;
 
+import java.io.ByteArrayOutputStream;
+
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.RepositoryTestCase;
@@ -130,6 +132,123 @@ public void testParse_WeirdHeaderOnlyCommit() throws Exception {
 		assertEquals("", c.getShortMessage());
 	}
 
+	public void testParse_implicit_UTF8_encoded() throws Exception {
+		final ByteArrayOutputStream b = new ByteArrayOutputStream();
+		b.write("tree 9788669ad918b6fcce64af8882fc9a81cb6aba67\n".getBytes("UTF-8"));
+		b.write("author F\u00f6r fattare <a_u_thor@example.com> 1218123387 +0700\n".getBytes("UTF-8"));
+		b.write("committer C O. Miter <c@example.com> 1218123390 -0500\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("Sm\u00f6rg\u00e5sbord\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("\u304d\u308c\u3044\n".getBytes("UTF-8"));
+		final RevCommit c;
+		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67")); // bogus id
+		c.parseCanonical(new RevWalk(db), b.toByteArray());
+
+		assertEquals("F\u00f6r fattare", c.getAuthorIdent().getName());
+		assertEquals("Sm\u00f6rg\u00e5sbord", c.getShortMessage());
+		assertEquals("Sm\u00f6rg\u00e5sbord\n\n\u304d\u308c\u3044\n", c.getFullMessage());
+	}
+
+	public void testParse_implicit_mixed_encoded() throws Exception {
+		final ByteArrayOutputStream b = new ByteArrayOutputStream();
+		b.write("tree 9788669ad918b6fcce64af8882fc9a81cb6aba67\n".getBytes("UTF-8"));
+		b.write("author F\u00f6r fattare <a_u_thor@example.com> 1218123387 +0700\n".getBytes("ISO-8859-1"));
+		b.write("committer C O. Miter <c@example.com> 1218123390 -0500\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("Sm\u00f6rg\u00e5sbord\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("\u304d\u308c\u3044\n".getBytes("UTF-8"));
+		final RevCommit c;
+		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67")); // bogus id
+		c.parseCanonical(new RevWalk(db), b.toByteArray());
+
+		assertEquals("F\u00f6r fattare", c.getAuthorIdent().getName());
+		assertEquals("Sm\u00f6rg\u00e5sbord", c.getShortMessage());
+		assertEquals("Sm\u00f6rg\u00e5sbord\n\n\u304d\u308c\u3044\n", c.getFullMessage());
+	}
+
+	/**
+	 * Test parsing of a commit whose encoding is given and works.
+	 *
+	 * @throws Exception
+	 */
+	public void testParse_explicit_encoded() throws Exception {
+		final ByteArrayOutputStream b = new ByteArrayOutputStream();
+		b.write("tree 9788669ad918b6fcce64af8882fc9a81cb6aba67\n".getBytes("EUC-JP"));
+		b.write("author F\u00f6r fattare <a_u_thor@example.com> 1218123387 +0700\n".getBytes("EUC-JP"));
+		b.write("committer C O. Miter <c@example.com> 1218123390 -0500\n".getBytes("EUC-JP"));
+		b.write("encoding euc_JP\n".getBytes("EUC-JP"));
+		b.write("\n".getBytes("EUC-JP"));
+		b.write("\u304d\u308c\u3044\n".getBytes("EUC-JP"));
+		b.write("\n".getBytes("EUC-JP"));
+		b.write("Hi\n".getBytes("EUC-JP"));
+		final RevCommit c;
+		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67")); // bogus id
+		c.parseCanonical(new RevWalk(db), b.toByteArray());
+
+		assertEquals("F\u00f6r fattare", c.getAuthorIdent().getName());
+		assertEquals("\u304d\u308c\u3044", c.getShortMessage());
+		assertEquals("\u304d\u308c\u3044\n\nHi\n", c.getFullMessage());
+	}
+
+	/**
+	 * This is a twisted case, but show what we expect here. We can revise the
+	 * expectations provided this case is updated.
+	 *
+	 * What happens here is that an encoding us given, but data is not encoded
+	 * that way (and we can detect it), so we try other encodings.
+	 *
+	 * @throws Exception
+	 */
+	public void testParse_explicit_bad_encoded() throws Exception {
+		final ByteArrayOutputStream b = new ByteArrayOutputStream();
+		b.write("tree 9788669ad918b6fcce64af8882fc9a81cb6aba67\n".getBytes("UTF-8"));
+		b.write("author F\u00f6r fattare <a_u_thor@example.com> 1218123387 +0700\n".getBytes("ISO-8859-1"));
+		b.write("committer C O. Miter <c@example.com> 1218123390 -0500\n".getBytes("UTF-8"));
+		b.write("encoding EUC-JP\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("\u304d\u308c\u3044\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("Hi\n".getBytes("UTF-8"));
+		final RevCommit c;
+		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67")); // bogus id
+		c.parseCanonical(new RevWalk(db), b.toByteArray());
+
+		assertEquals("F\u00f6r fattare", c.getAuthorIdent().getName());
+		assertEquals("\u304d\u308c\u3044", c.getShortMessage());
+		assertEquals("\u304d\u308c\u3044\n\nHi\n", c.getFullMessage());
+	}
+
+	/**
+	 * This is a twisted case too, but show what we expect here. We can revise the
+	 * expectations provided this case is updated.
+	 *
+	 * What happens here is that an encoding us given, but data is not encoded
+	 * that way (and we can detect it), so we try other encodings. Here data could
+	 * actually be decoded in the stated encoding, but we overide using UTF-8.
+	 *
+	 * @throws Exception
+	 */
+	public void testParse_explicit_bad_encoded2() throws Exception {
+		final ByteArrayOutputStream b = new ByteArrayOutputStream();
+		b.write("tree 9788669ad918b6fcce64af8882fc9a81cb6aba67\n".getBytes("UTF-8"));
+		b.write("author F\u00f6r fattare <a_u_thor@example.com> 1218123387 +0700\n".getBytes("UTF-8"));
+		b.write("committer C O. Miter <c@example.com> 1218123390 -0500\n".getBytes("UTF-8"));
+		b.write("encoding ISO-8859-1\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("\u304d\u308c\u3044\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("Hi\n".getBytes("UTF-8"));
+		final RevCommit c;
+		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67")); // bogus id
+		c.parseCanonical(new RevWalk(db), b.toByteArray());
+
+		assertEquals("F\u00f6r fattare", c.getAuthorIdent().getName());
+		assertEquals("\u304d\u308c\u3044", c.getShortMessage());
+		assertEquals("\u304d\u308c\u3044\n\nHi\n", c.getFullMessage());
+	}
+
 	public void testParse_NoMessage() throws Exception {
 		final String msg = "";
 		final RevCommit c = create(msg);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index a31734b..7c16394 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -42,7 +42,10 @@
 import static org.spearce.jgit.lib.ObjectChecker.encoding;
 
 import java.nio.ByteBuffer;
+import java.nio.charset.CharacterCodingException;
 import java.nio.charset.Charset;
+import java.nio.charset.CharsetDecoder;
+import java.nio.charset.CodingErrorAction;
 import java.util.Arrays;
 
 import org.spearce.jgit.lib.Constants;
@@ -376,7 +379,10 @@ public static PersonIdent parsePersonIdent(final byte[] raw, final int nameB) {
 	}
 
 	/**
-	 * Decode a region of the buffer under the specified character set.
+	 * Decode a region of the buffer under the specified character set if possible.
+	 *
+	 * If the byte stream cannot be decoded that way, the platform default is tried
+	 * and if that too fails, the fail-safe ISO-8859-1 encoding is tried.
 	 * 
 	 * @param cs
 	 *            character set to use when decoding the buffer.
@@ -393,12 +399,63 @@ public static PersonIdent parsePersonIdent(final byte[] raw, final int nameB) {
 	public static String decode(final Charset cs, final byte[] buffer,
 			final int start, final int end) {
 		final ByteBuffer b = ByteBuffer.wrap(buffer, start, end - start);
-		return cs.decode(b).toString();
+		b.mark();
+		for (int i = 0;; ++i) {
+			try {
+				Charset charset;
+				switch (i) {
+				case 0:
+					/*
+					 * Try our built-in favorite. The assumption here is that
+					 * decoding will fail if the data is not actually encoded
+					 * using that encoder.
+					 */
+					charset = Constants.CHARSET;
+					break;
+				case 1:
+					/*
+					 * Try the suggested encoding, it might be right since it
+					 * was provided
+					 */
+					if (cs.equals(Constants.CHARSET))
+						continue;
+					b.reset();
+					charset = cs;
+					break;
+				case 2:
+					/*
+					 * Try the default character set. A small group of people
+					 * might actually use the same (or very similar) locale.
+					 */
+					charset = Charset.defaultCharset();
+					if (charset.equals(Constants.CHARSET))
+						continue;
+					if (charset.equals(cs))
+						continue;
+					b.reset();
+					break;
+				default:
+					/*
+					 * This one is to make sure we do no fail. Data may look
+					 * funny but there is nothing we can do here withou much
+					 * more advanced guessing.
+					 */
+					b.reset();
+					charset = Charset.forName("ISO-8859-1");
+				}
+				CharsetDecoder d = charset.newDecoder();
+				d.onMalformedInput(CodingErrorAction.REPORT);
+				d.onUnmappableCharacter(CodingErrorAction.REPORT);
+				return d.decode(b).toString();
+			} catch (CharacterCodingException e1) {
+				continue;
+			}
+		}
 	}
 
 	/**
 	 * Locate the position of the commit message body.
-	 * 
+	 *
 	 * @param b
 	 *            buffer to scan.
 	 * @param ptr
-- 
1.6.0.2.308.gef4a
