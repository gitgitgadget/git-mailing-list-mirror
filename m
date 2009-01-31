From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2] Add getTaggerIdent, getShortMessage, getFullMessage to
	RevTag
Date: Fri, 30 Jan 2009 16:56:01 -0800
Message-ID: <20090131005601.GH26880@spearce.org>
References: <1233117316-3291-1-git-send-email-spearce@spearce.org> <200901282110.48899.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 01:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT4Av-0000Uy-Ky
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 01:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbZAaA4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 19:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbZAaA4F
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 19:56:05 -0500
Received: from george.spearce.org ([209.20.77.23]:35672 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbZAaA4D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 19:56:03 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3424C38210; Sat, 31 Jan 2009 00:56:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200901282110.48899.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107893>

These methods make the RevTag API more like the RevCommit API, such
that it is more consistent for applications to access the "fields"
of a tag object in the same way that they access the fields of any
commit object.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
  > Where are the unit tests?

  New test file included.

  > I'm kind of surprised you did not optimized skipping past the object header,
  > like the parents are skipped when parsing commits.

  Also included.  Otherwise unmodified from v1.

 .../org/spearce/jgit/revwalk/RevTagParseTest.java  |  350 ++++++++++++++++++++
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |    2 +-
 .../src/org/spearce/jgit/revwalk/RevTag.java       |   74 ++++-
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   51 +++-
 4 files changed, 473 insertions(+), 4 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevTagParseTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevTagParseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevTagParseTest.java
new file mode 100644
index 0000000..82680f3
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevTagParseTest.java
@@ -0,0 +1,350 @@
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
+package org.spearce.jgit.revwalk;
+
+import java.io.ByteArrayOutputStream;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PersonIdent;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class RevTagParseTest extends RepositoryTestCase {
+	public void testTagBlob() throws Exception {
+		testOneType(Constants.OBJ_BLOB);
+	}
+
+	public void testTagTree() throws Exception {
+		testOneType(Constants.OBJ_TREE);
+	}
+
+	public void testTagCommit() throws Exception {
+		testOneType(Constants.OBJ_COMMIT);
+	}
+
+	public void testTagTag() throws Exception {
+		testOneType(Constants.OBJ_TAG);
+	}
+
+	private void testOneType(final int typeCode) throws Exception {
+		final ObjectId id = id("9788669ad918b6fcce64af8882fc9a81cb6aba67");
+		final StringBuilder b = new StringBuilder();
+		b.append("object " + id.name() + "\n");
+		b.append("type " + Constants.typeString(typeCode) + "\n");
+		b.append("tag v1.2.3.4.5\n");
+		b.append("tagger A U. Thor <a_u_thor@example.com> 1218123387 +0700\n");
+		b.append("\n");
+
+		final RevWalk rw = new RevWalk(db);
+		final RevTag c;
+
+		c = new RevTag(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		assertNull(c.getObject());
+		assertNull(c.getName());
+
+		c.parseCanonical(rw, b.toString().getBytes("UTF-8"));
+		assertNotNull(c.getObject());
+		assertEquals(id, c.getObject().getId());
+		assertSame(rw.lookupAny(id, typeCode), c.getObject());
+	}
+
+	public void testParseAllFields() throws Exception {
+		final ObjectId treeId = id("9788669ad918b6fcce64af8882fc9a81cb6aba67");
+		final String name = "v1.2.3.4.5";
+		final String taggerName = "A U. Thor";
+		final String taggerEmail = "a_u_thor@example.com";
+		final int taggerTime = 1218123387;
+
+		final StringBuilder body = new StringBuilder();
+
+		body.append("object ");
+		body.append(treeId.name());
+		body.append("\n");
+
+		body.append("type tree\n");
+
+		body.append("tag ");
+		body.append(name);
+		body.append("\n");
+
+		body.append("tagger ");
+		body.append(taggerName);
+		body.append(" <");
+		body.append(taggerEmail);
+		body.append("> ");
+		body.append(taggerTime);
+		body.append(" +0700\n");
+
+		body.append("\n");
+
+		final RevWalk rw = new RevWalk(db);
+		final RevTag c;
+
+		c = new RevTag(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		assertNull(c.getObject());
+		assertNull(c.getName());
+
+		c.parseCanonical(rw, body.toString().getBytes("UTF-8"));
+		assertNotNull(c.getObject());
+		assertEquals(treeId, c.getObject().getId());
+		assertSame(rw.lookupTree(treeId), c.getObject());
+
+		assertNotNull(c.getName());
+		assertEquals(name, c.getName());
+		assertEquals("", c.getFullMessage());
+
+		final PersonIdent cTagger = c.getTaggerIdent();
+		assertNotNull(cTagger);
+		assertEquals(taggerName, cTagger.getName());
+		assertEquals(taggerEmail, cTagger.getEmailAddress());
+	}
+
+	private RevTag create(final String msg) throws Exception {
+		final StringBuilder b = new StringBuilder();
+		b.append("object 9788669ad918b6fcce64af8882fc9a81cb6aba67\n");
+		b.append("type tree\n");
+		b.append("tag v1.2.3.4.5\n");
+		b.append("tagger A U. Thor <a_u_thor@example.com> 1218123387 +0700\n");
+		b.append("\n");
+		b.append(msg);
+
+		final RevTag c;
+		c = new RevTag(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		c.parseCanonical(new RevWalk(db), b.toString().getBytes("UTF-8"));
+		return c;
+	}
+
+	public void testParse_implicit_UTF8_encoded() throws Exception {
+		final ByteArrayOutputStream b = new ByteArrayOutputStream();
+		b.write("object 9788669ad918b6fcce64af8882fc9a81cb6aba67\n"
+				.getBytes("UTF-8"));
+		b.write("type tree\n".getBytes("UTF-8"));
+		b.write("tag v1.2.3.4.5\n".getBytes("UTF-8"));
+
+		b
+				.write("tagger F\u00f6r fattare <a_u_thor@example.com> 1218123387 +0700\n"
+						.getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("Sm\u00f6rg\u00e5sbord\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("\u304d\u308c\u3044\n".getBytes("UTF-8"));
+		final RevTag c;
+		c = new RevTag(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		c.parseCanonical(new RevWalk(db), b.toByteArray());
+
+		assertEquals("F\u00f6r fattare", c.getTaggerIdent().getName());
+		assertEquals("Sm\u00f6rg\u00e5sbord", c.getShortMessage());
+		assertEquals("Sm\u00f6rg\u00e5sbord\n\n\u304d\u308c\u3044\n", c
+				.getFullMessage());
+	}
+
+	public void testParse_implicit_mixed_encoded() throws Exception {
+		final ByteArrayOutputStream b = new ByteArrayOutputStream();
+		b.write("object 9788669ad918b6fcce64af8882fc9a81cb6aba67\n"
+				.getBytes("UTF-8"));
+		b.write("type tree\n".getBytes("UTF-8"));
+		b.write("tag v1.2.3.4.5\n".getBytes("UTF-8"));
+		b
+				.write("tagger F\u00f6r fattare <a_u_thor@example.com> 1218123387 +0700\n"
+						.getBytes("ISO-8859-1"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("Sm\u00f6rg\u00e5sbord\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("\u304d\u308c\u3044\n".getBytes("UTF-8"));
+		final RevTag c;
+		c = new RevTag(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		c.parseCanonical(new RevWalk(db), b.toByteArray());
+
+		assertEquals("F\u00f6r fattare", c.getTaggerIdent().getName());
+		assertEquals("Sm\u00f6rg\u00e5sbord", c.getShortMessage());
+		assertEquals("Sm\u00f6rg\u00e5sbord\n\n\u304d\u308c\u3044\n", c
+				.getFullMessage());
+	}
+
+	/**
+	 * Test parsing of a commit whose encoding is given and works.
+	 * 
+	 * @throws Exception
+	 */
+	public void testParse_explicit_encoded() throws Exception {
+		final ByteArrayOutputStream b = new ByteArrayOutputStream();
+		b.write("object 9788669ad918b6fcce64af8882fc9a81cb6aba67\n"
+				.getBytes("EUC-JP"));
+		b.write("type tree\n".getBytes("EUC-JP"));
+		b.write("tag v1.2.3.4.5\n".getBytes("EUC-JP"));
+		b
+				.write("tagger F\u00f6r fattare <a_u_thor@example.com> 1218123387 +0700\n"
+						.getBytes("EUC-JP"));
+		b.write("encoding euc_JP\n".getBytes("EUC-JP"));
+		b.write("\n".getBytes("EUC-JP"));
+		b.write("\u304d\u308c\u3044\n".getBytes("EUC-JP"));
+		b.write("\n".getBytes("EUC-JP"));
+		b.write("Hi\n".getBytes("EUC-JP"));
+		final RevTag c;
+		c = new RevTag(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		c.parseCanonical(new RevWalk(db), b.toByteArray());
+
+		assertEquals("F\u00f6r fattare", c.getTaggerIdent().getName());
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
+		b.write("object 9788669ad918b6fcce64af8882fc9a81cb6aba67\n"
+				.getBytes("UTF-8"));
+		b.write("type tree\n".getBytes("UTF-8"));
+		b.write("tag v1.2.3.4.5\n".getBytes("UTF-8"));
+		b
+				.write("tagger F\u00f6r fattare <a_u_thor@example.com> 1218123387 +0700\n"
+						.getBytes("ISO-8859-1"));
+		b.write("encoding EUC-JP\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("\u304d\u308c\u3044\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("Hi\n".getBytes("UTF-8"));
+		final RevTag c;
+		c = new RevTag(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		c.parseCanonical(new RevWalk(db), b.toByteArray());
+
+		assertEquals("F\u00f6r fattare", c.getTaggerIdent().getName());
+		assertEquals("\u304d\u308c\u3044", c.getShortMessage());
+		assertEquals("\u304d\u308c\u3044\n\nHi\n", c.getFullMessage());
+	}
+
+	/**
+	 * This is a twisted case too, but show what we expect here. We can revise
+	 * the expectations provided this case is updated.
+	 * 
+	 * What happens here is that an encoding us given, but data is not encoded
+	 * that way (and we can detect it), so we try other encodings. Here data
+	 * could actually be decoded in the stated encoding, but we override using
+	 * UTF-8.
+	 * 
+	 * @throws Exception
+	 */
+	public void testParse_explicit_bad_encoded2() throws Exception {
+		final ByteArrayOutputStream b = new ByteArrayOutputStream();
+		b.write("object 9788669ad918b6fcce64af8882fc9a81cb6aba67\n"
+				.getBytes("UTF-8"));
+		b.write("type tree\n".getBytes("UTF-8"));
+		b.write("tag v1.2.3.4.5\n".getBytes("UTF-8"));
+		b
+				.write("tagger F\u00f6r fattare <a_u_thor@example.com> 1218123387 +0700\n"
+						.getBytes("UTF-8"));
+		b.write("encoding ISO-8859-1\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("\u304d\u308c\u3044\n".getBytes("UTF-8"));
+		b.write("\n".getBytes("UTF-8"));
+		b.write("Hi\n".getBytes("UTF-8"));
+		final RevTag c;
+		c = new RevTag(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		c.parseCanonical(new RevWalk(db), b.toByteArray());
+
+		assertEquals("F\u00f6r fattare", c.getTaggerIdent().getName());
+		assertEquals("\u304d\u308c\u3044", c.getShortMessage());
+		assertEquals("\u304d\u308c\u3044\n\nHi\n", c.getFullMessage());
+	}
+
+	public void testParse_NoMessage() throws Exception {
+		final String msg = "";
+		final RevTag c = create(msg);
+		assertEquals(msg, c.getFullMessage());
+		assertEquals(msg, c.getShortMessage());
+	}
+
+	public void testParse_OnlyLFMessage() throws Exception {
+		final RevTag c = create("\n");
+		assertEquals("\n", c.getFullMessage());
+		assertEquals("", c.getShortMessage());
+	}
+
+	public void testParse_ShortLineOnlyNoLF() throws Exception {
+		final String shortMsg = "This is a short message.";
+		final RevTag c = create(shortMsg);
+		assertEquals(shortMsg, c.getFullMessage());
+		assertEquals(shortMsg, c.getShortMessage());
+	}
+
+	public void testParse_ShortLineOnlyEndLF() throws Exception {
+		final String shortMsg = "This is a short message.";
+		final String fullMsg = shortMsg + "\n";
+		final RevTag c = create(fullMsg);
+		assertEquals(fullMsg, c.getFullMessage());
+		assertEquals(shortMsg, c.getShortMessage());
+	}
+
+	public void testParse_ShortLineOnlyEmbeddedLF() throws Exception {
+		final String fullMsg = "This is a\nshort message.";
+		final String shortMsg = fullMsg.replace('\n', ' ');
+		final RevTag c = create(fullMsg);
+		assertEquals(fullMsg, c.getFullMessage());
+		assertEquals(shortMsg, c.getShortMessage());
+	}
+
+	public void testParse_ShortLineOnlyEmbeddedAndEndingLF() throws Exception {
+		final String fullMsg = "This is a\nshort message.\n";
+		final String shortMsg = "This is a short message.";
+		final RevTag c = create(fullMsg);
+		assertEquals(fullMsg, c.getFullMessage());
+		assertEquals(shortMsg, c.getShortMessage());
+	}
+
+	public void testParse_GitStyleMessage() throws Exception {
+		final String shortMsg = "This fixes a bug.";
+		final String body = "We do it with magic and pixie dust and stuff.\n"
+				+ "\n" + "Signed-off-by: A U. Thor <author@example.com>\n";
+		final String fullMsg = shortMsg + "\n" + "\n" + body;
+		final RevTag c = create(fullMsg);
+		assertEquals(fullMsg, c.getFullMessage());
+		assertEquals(shortMsg, c.getShortMessage());
+	}
+
+	private static ObjectId id(final String str) {
+		return ObjectId.fromString(str);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index 7454d8e..de11c39 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -367,7 +367,7 @@ public final String getShortMessage() {
 		return str;
 	}
 
-	private static boolean hasLF(final byte[] r, int b, final int e) {
+	static boolean hasLF(final byte[] r, int b, final int e) {
 		while (b < e)
 			if (r[b++] == '\n')
 				return true;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index 77a55cd..82f0009 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -38,6 +38,7 @@
 package org.spearce.jgit.revwalk;
 
 import java.io.IOException;
+import java.nio.charset.Charset;
 
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
@@ -45,6 +46,7 @@
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectLoader;
+import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.util.MutableInteger;
 import org.spearce.jgit.util.RawParseUtils;
@@ -100,7 +102,77 @@ void parseCanonical(final RevWalk walk, final byte[] rawTag)
 	public int getType() {
 		return Constants.OBJ_TAG;
 	}
-	
+
+	/**
+	 * Parse the tagger identity from the raw buffer.
+	 * <p>
+	 * This method parses and returns the content of the tagger line, after
+	 * taking the tag's character set into account and decoding the tagger
+	 * name and email address. This method is fairly expensive and produces a
+	 * new PersonIdent instance on each invocation. Callers should invoke this
+	 * method only if they are certain they will be outputting the result, and
+	 * should cache the return value for as long as necessary to use all
+	 * information from it.
+	 * 
+	 * @return identity of the tagger (name, email) and the time the tag
+	 *         was made by the tagger; null if no tagger line was found.
+	 */
+	public final PersonIdent getTaggerIdent() {
+		final byte[] raw = buffer;
+		final int nameB = RawParseUtils.tagger(raw, 0);
+		if (nameB < 0)
+			return null;
+		return RawParseUtils.parsePersonIdent(raw, nameB);
+	}
+
+	/**
+	 * Parse the complete tag message and decode it to a string.
+	 * <p>
+	 * This method parses and returns the message portion of the tag buffer,
+	 * after taking the tag's character set into account and decoding the buffer
+	 * using that character set. This method is a fairly expensive operation and
+	 * produces a new string on each invocation.
+	 * 
+	 * @return decoded tag message as a string. Never null.
+	 */
+	public final String getFullMessage() {
+		final byte[] raw = buffer;
+		final int msgB = RawParseUtils.tagMessage(raw, 0);
+		if (msgB < 0)
+			return "";
+		final Charset enc = RawParseUtils.parseEncoding(raw);
+		return RawParseUtils.decode(enc, raw, msgB, raw.length);
+	}
+
+	/**
+	 * Parse the tag message and return the first "line" of it.
+	 * <p>
+	 * The first line is everything up to the first pair of LFs. This is the
+	 * "oneline" format, suitable for output in a single line display.
+	 * <p>
+	 * This method parses and returns the message portion of the tag buffer,
+	 * after taking the tag's character set into account and decoding the buffer
+	 * using that character set. This method is a fairly expensive operation and
+	 * produces a new string on each invocation.
+	 * 
+	 * @return decoded tag message as a string. Never null. The returned string
+	 *         does not contain any LFs, even if the first paragraph spanned
+	 *         multiple lines. Embedded LFs are converted to spaces.
+	 */
+	public final String getShortMessage() {
+		final byte[] raw = buffer;
+		final int msgB = RawParseUtils.tagMessage(raw, 0);
+		if (msgB < 0)
+			return "";
+
+		final Charset enc = RawParseUtils.parseEncoding(raw);
+		final int msgE = RawParseUtils.endOfParagraph(raw, msgB);
+		String str = RawParseUtils.decode(enc, raw, msgB, msgE);
+		if (RevCommit.hasLF(raw, msgB, msgE))
+			str = str.replace('\n', ' ');
+		return str;
+	}
+
 	/**
 	 * Parse this tag buffer for display.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 758e7af..1b8bf94 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -40,6 +40,7 @@
 import static org.spearce.jgit.lib.ObjectChecker.author;
 import static org.spearce.jgit.lib.ObjectChecker.committer;
 import static org.spearce.jgit.lib.ObjectChecker.encoding;
+import static org.spearce.jgit.lib.ObjectChecker.tagger;
 
 import java.nio.ByteBuffer;
 import java.nio.charset.CharacterCodingException;
@@ -397,6 +398,34 @@ public static final int committer(final byte[] b, int ptr) {
 	}
 
 	/**
+	 * Locate the "tagger " header line data.
+	 * 
+	 * @param b
+	 *            buffer to scan.
+	 * @param ptr
+	 *            position in buffer to start the scan at. Most callers should
+	 *            pass 0 to ensure the scan starts from the beginning of the tag
+	 *            buffer and does not accidentally look at message body.
+	 * @return position just after the space in "tagger ", so the first
+	 *         character of the tagger's name. If no tagger header can be
+	 *         located -1 is returned.
+	 */
+	public static final int tagger(final byte[] b, int ptr) {
+		final int sz = b.length;
+		if (ptr == 0)
+			ptr += 48; // skip the "object ..." line.
+		while (ptr < sz) {
+			if (b[ptr] == '\n')
+				return -1;
+			final int m = match(b, ptr, tagger);
+			if (m >= 0)
+				return m;
+			ptr = nextLF(b, ptr);
+		}
+		return -1;
+	}
+
+	/**
 	 * Locate the "encoding " header line.
 	 * 
 	 * @param b
@@ -648,9 +677,27 @@ public static final int commitMessage(final byte[] b, int ptr) {
 		while (ptr < sz && b[ptr] == 'p')
 			ptr += 48; // skip this parent.
 
-		// skip any remaining header lines, ignoring what their actual
-		// header line type is.
+		// Skip any remaining header lines, ignoring what their actual
+		// header line type is. This is identical to the logic for a tag.
 		//
+		return tagMessage(b, ptr);
+	}
+
+	/**
+	 * Locate the position of the tag message body.
+	 * 
+	 * @param b
+	 *            buffer to scan.
+	 * @param ptr
+	 *            position in buffer to start the scan at. Most callers should
+	 *            pass 0 to ensure the scan starts from the beginning of the tag
+	 *            buffer.
+	 * @return position of the user's message buffer.
+	 */
+	public static final int tagMessage(final byte[] b, int ptr) {
+		final int sz = b.length;
+		if (ptr == 0)
+			ptr += 48; // skip the "object ..." line.
 		while (ptr < sz && b[ptr] != '\n')
 			ptr = nextLF(b, ptr);
 		if (ptr < sz && b[ptr] == '\n')
-- 
1.6.1.2.418.gd79e6


-- 
Shawn.
