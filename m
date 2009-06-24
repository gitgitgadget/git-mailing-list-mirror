From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Add parsing support for Signed-off-by lines in commit messages
Date: Tue, 23 Jun 2009 20:11:49 -0700
Message-ID: <1245813109-29763-2-git-send-email-spearce@spearce.org>
References: <1245813109-29763-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 05:12:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJIu1-0007eY-5T
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 05:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbZFXDLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 23:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbZFXDLy
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 23:11:54 -0400
Received: from george.spearce.org ([209.20.77.23]:34319 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbZFXDLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 23:11:51 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8A673381FE; Wed, 24 Jun 2009 03:11:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6FC4B381FD;
	Wed, 24 Jun 2009 03:11:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.3.420.gd4b46
In-Reply-To: <1245813109-29763-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122119>

The RevCommit.getFooterLines() methods now give us direct access to
the Signed-off-by, Acked-by, etc. footer lines in a commit message
body, making it easier to process this information in code.

The value of a SOB line is treated as an opaque string value.  JGit
does not attempt to break it down into a sort of micro PersonIdent,
even though it is very typical for a SOB line to have a name and an
email address.  Since this is very free-form text that a human can
modify when creating a commit object we can't make nearly the same
assumptions about uniformity of value as we can make when parsing
the machine generated commit headers.

To avoid unnecessary byte[] to String conversions we delay the
conversion of a key or a value section of a footer line until the
last possible moment in the application code.  This way we don't
spend time converting text for footer lines that the application
doesn't care to see.  We also can avoid allocating unnecessary
String objects if the application won't care about that particular
footer line value.

The FooterKey object can be used to more efficiently filter out
the footer lines, by using an optimized byte equality test and
avoiding String conversions.  Standard instances for the common
footers like Signed-off-by are supplied as constants, making it
easier for applications to read footers.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I think this is ready to go as-is.  We really should start to look
 at how one might replace Commit with RevCommit for the purposes
 of *creating* a new commit.  Because tools like the FooterKey and
 FooterLine start to make it easier to add/remove the SOB from within
 a GUI editor a bit easier.  But that's all for some future date.

 .../org/spearce/jgit/revwalk/FooterLineTest.java   |  277 ++++++++++++++++++++
 .../src/org/spearce/jgit/revwalk/FooterKey.java    |   77 ++++++
 .../src/org/spearce/jgit/revwalk/FooterLine.java   |  121 +++++++++
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |  102 +++++++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   44 +++
 5 files changed, 621 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FooterLineTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterKey.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterLine.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FooterLineTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FooterLineTest.java
new file mode 100644
index 0000000..342346f
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FooterLineTest.java
@@ -0,0 +1,277 @@
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
+package org.spearce.jgit.revwalk;
+
+import java.util.List;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class FooterLineTest extends RepositoryTestCase {
+	public void testNoFooters_EmptyBody() {
+		final RevCommit commit = parse("");
+		final List<FooterLine> footers = commit.getFooterLines();
+		assertNotNull(footers);
+		assertEquals(0, footers.size());
+	}
+
+	public void testNoFooters_NewlineOnlyBody1() {
+		final RevCommit commit = parse("\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		assertNotNull(footers);
+		assertEquals(0, footers.size());
+	}
+
+	public void testNoFooters_NewlineOnlyBody5() {
+		final RevCommit commit = parse("\n\n\n\n\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		assertNotNull(footers);
+		assertEquals(0, footers.size());
+	}
+
+	public void testNoFooters_OneLineBodyNoLF() {
+		final RevCommit commit = parse("this is a commit");
+		final List<FooterLine> footers = commit.getFooterLines();
+		assertNotNull(footers);
+		assertEquals(0, footers.size());
+	}
+
+	public void testNoFooters_OneLineBodyWithLF() {
+		final RevCommit commit = parse("this is a commit\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		assertNotNull(footers);
+		assertEquals(0, footers.size());
+	}
+
+	public void testNoFooters_ShortBodyNoLF() {
+		final RevCommit commit = parse("subject\n\nbody of commit");
+		final List<FooterLine> footers = commit.getFooterLines();
+		assertNotNull(footers);
+		assertEquals(0, footers.size());
+	}
+
+	public void testNoFooters_ShortBodyWithLF() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		assertNotNull(footers);
+		assertEquals(0, footers.size());
+	}
+
+	public void testSignedOffBy_OneUserNoLF() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n" + "\n"
+				+ "Signed-off-by: A. U. Thor <a@example.com>");
+		final List<FooterLine> footers = commit.getFooterLines();
+		FooterLine f;
+
+		assertNotNull(footers);
+		assertEquals(1, footers.size());
+
+		f = footers.get(0);
+		assertEquals("Signed-off-by", f.getKey());
+		assertEquals("A. U. Thor <a@example.com>", f.getValue());
+	}
+
+	public void testSignedOffBy_OneUserWithLF() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n" + "\n"
+				+ "Signed-off-by: A. U. Thor <a@example.com>\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		FooterLine f;
+
+		assertNotNull(footers);
+		assertEquals(1, footers.size());
+
+		f = footers.get(0);
+		assertEquals("Signed-off-by", f.getKey());
+		assertEquals("A. U. Thor <a@example.com>", f.getValue());
+	}
+
+	public void testSignedOffBy_IgnoreWhitespace() {
+		// We only ignore leading whitespace on the value, trailing
+		// is assumed part of the value.
+		//
+		final RevCommit commit = parse("subject\n\nbody of commit\n" + "\n"
+				+ "Signed-off-by:   A. U. Thor <a@example.com>  \n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		FooterLine f;
+
+		assertNotNull(footers);
+		assertEquals(1, footers.size());
+
+		f = footers.get(0);
+		assertEquals("Signed-off-by", f.getKey());
+		assertEquals("A. U. Thor <a@example.com>  ", f.getValue());
+	}
+
+	public void testEmptyValueNoLF() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n" + "\n"
+				+ "Signed-off-by:");
+		final List<FooterLine> footers = commit.getFooterLines();
+		FooterLine f;
+
+		assertNotNull(footers);
+		assertEquals(1, footers.size());
+
+		f = footers.get(0);
+		assertEquals("Signed-off-by", f.getKey());
+		assertEquals("", f.getValue());
+	}
+
+	public void testEmptyValueWithLF() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n" + "\n"
+				+ "Signed-off-by:\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		FooterLine f;
+
+		assertNotNull(footers);
+		assertEquals(1, footers.size());
+
+		f = footers.get(0);
+		assertEquals("Signed-off-by", f.getKey());
+		assertEquals("", f.getValue());
+	}
+
+	public void testShortKey() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n" + "\n"
+				+ "K:V\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		FooterLine f;
+
+		assertNotNull(footers);
+		assertEquals(1, footers.size());
+
+		f = footers.get(0);
+		assertEquals("K", f.getKey());
+		assertEquals("V", f.getValue());
+	}
+
+	public void testSignedOffBy_ManyUsers() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n"
+				+ "Not-A-Footer-Line: this line must not be read as a footer\n"
+				+ "\n" // paragraph break, now footers appear in final block
+				+ "Signed-off-by: A. U. Thor <a@example.com>\n"
+				+ "CC:            <some.mailing.list@example.com>\n"
+				+ "Acked-by: Some Reviewer <sr@example.com>\n"
+				+ "Signed-off-by: Main Tain Er <mte@example.com>\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		FooterLine f;
+
+		assertNotNull(footers);
+		assertEquals(4, footers.size());
+
+		f = footers.get(0);
+		assertEquals("Signed-off-by", f.getKey());
+		assertEquals("A. U. Thor <a@example.com>", f.getValue());
+
+		f = footers.get(1);
+		assertEquals("CC", f.getKey());
+		assertEquals("<some.mailing.list@example.com>", f.getValue());
+
+		f = footers.get(2);
+		assertEquals("Acked-by", f.getKey());
+		assertEquals("Some Reviewer <sr@example.com>", f.getValue());
+
+		f = footers.get(3);
+		assertEquals("Signed-off-by", f.getKey());
+		assertEquals("Main Tain Er <mte@example.com>", f.getValue());
+	}
+
+	public void testSignedOffBy_SkipNonFooter() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n"
+				+ "Not-A-Footer-Line: this line must not be read as a footer\n"
+				+ "\n" // paragraph break, now footers appear in final block
+				+ "Signed-off-by: A. U. Thor <a@example.com>\n"
+				+ "CC:            <some.mailing.list@example.com>\n"
+				+ "not really a footer line but we'll skip it anyway\n"
+				+ "Acked-by: Some Reviewer <sr@example.com>\n"
+				+ "Signed-off-by: Main Tain Er <mte@example.com>\n");
+		final List<FooterLine> footers = commit.getFooterLines();
+		FooterLine f;
+
+		assertNotNull(footers);
+		assertEquals(4, footers.size());
+
+		f = footers.get(0);
+		assertEquals("Signed-off-by", f.getKey());
+		assertEquals("A. U. Thor <a@example.com>", f.getValue());
+
+		f = footers.get(1);
+		assertEquals("CC", f.getKey());
+		assertEquals("<some.mailing.list@example.com>", f.getValue());
+
+		f = footers.get(2);
+		assertEquals("Acked-by", f.getKey());
+		assertEquals("Some Reviewer <sr@example.com>", f.getValue());
+
+		f = footers.get(3);
+		assertEquals("Signed-off-by", f.getKey());
+		assertEquals("Main Tain Er <mte@example.com>", f.getValue());
+	}
+
+	public void testFilterFootersIgnoreCase() {
+		final RevCommit commit = parse("subject\n\nbody of commit\n"
+				+ "Not-A-Footer-Line: this line must not be read as a footer\n"
+				+ "\n" // paragraph break, now footers appear in final block
+				+ "Signed-Off-By: A. U. Thor <a@example.com>\n"
+				+ "CC:            <some.mailing.list@example.com>\n"
+				+ "Acked-by: Some Reviewer <sr@example.com>\n"
+				+ "signed-off-by: Main Tain Er <mte@example.com>\n");
+		final List<String> footers = commit.getFooterLines("signed-off-by");
+
+		assertNotNull(footers);
+		assertEquals(2, footers.size());
+
+		assertEquals("A. U. Thor <a@example.com>", footers.get(0));
+		assertEquals("Main Tain Er <mte@example.com>", footers.get(1));
+	}
+
+	private RevCommit parse(final String msg) {
+		final StringBuilder buf = new StringBuilder();
+		buf.append("tree " + ObjectId.zeroId().name() + "\n");
+		buf.append("author A. U. Thor <a@example.com> 1 +0000\n");
+		buf.append("committer A. U. Thor <a@example.com> 1 +0000\n");
+		buf.append("\n");
+		buf.append(msg);
+
+		final RevWalk walk = new RevWalk(db);
+		walk.setRetainBody(true);
+		final RevCommit c = new RevCommit(ObjectId.zeroId());
+		c.parseCanonical(walk, Constants.encode(buf.toString()));
+		return c;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterKey.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterKey.java
new file mode 100644
index 0000000..1e651ff
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterKey.java
@@ -0,0 +1,77 @@
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
+package org.spearce.jgit.revwalk;
+
+import org.spearce.jgit.lib.Constants;
+
+/** Case insensitive key for a {@link FooterLine}. */
+public final class FooterKey {
+	/** Standard {@code Signed-off-by} */
+	public static final FooterKey SIGNED_OFF_BY = new FooterKey("Signed-off-by");
+
+	/** Standard {@code Acked-by} */
+	public static final FooterKey ACKED_BY = new FooterKey("Acked-by");
+
+	/** Standard {@code CC} */
+	public static final FooterKey CC = new FooterKey("CC");
+
+	private final String name;
+
+	final byte[] raw;
+
+	/**
+	 * Create a key for a specific footer line.
+	 *
+	 * @param keyName
+	 *            name of the footer line.
+	 */
+	public FooterKey(final String keyName) {
+		name = keyName;
+		raw = Constants.encode(keyName.toLowerCase());
+	}
+
+	/** @return name of this footer line. */
+	public String getName() {
+		return name;
+	}
+
+	@Override
+	public String toString() {
+		return "FooterKey[" + name + "]";
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterLine.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterLine.java
new file mode 100644
index 0000000..1fef47d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FooterLine.java
@@ -0,0 +1,121 @@
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
+package org.spearce.jgit.revwalk;
+
+import java.nio.charset.Charset;
+
+import org.spearce.jgit.util.RawParseUtils;
+
+/**
+ * Single line at the end of a message, such as a "Signed-off-by: someone".
+ * <p>
+ * These footer lines tend to be used to represent additional information about
+ * a commit, like the path it followed through reviewers before finally being
+ * accepted into the project's main repository as an immutable commit.
+ *
+ * @see RevCommit#getFooterLines()
+ */
+public final class FooterLine {
+	private final byte[] buffer;
+
+	private final Charset enc;
+
+	private final int keyStart;
+
+	private final int keyEnd;
+
+	private final int valStart;
+
+	private final int valEnd;
+
+	FooterLine(final byte[] b, final Charset e, final int ks, final int ke,
+			final int vs, final int ve) {
+		buffer = b;
+		enc = e;
+		keyStart = ks;
+		keyEnd = ke;
+		valStart = vs;
+		valEnd = ve;
+	}
+
+	/**
+	 * @param key
+	 *            key to test this line's key name against.
+	 * @return true if {@code key.getName().equalsIgnorecase(getKey())}.
+	 */
+	public boolean matches(final FooterKey key) {
+		final byte[] kRaw = key.raw;
+		final int len = kRaw.length;
+		int bPtr = keyStart;
+		if (keyEnd - bPtr != len)
+			return false;
+		for (int kPtr = 0; bPtr < len;) {
+			byte b = buffer[bPtr++];
+			if ('A' <= b && b <= 'Z')
+				b += 'a' - 'A';
+			if (b != kRaw[kPtr++])
+				return false;
+		}
+		return true;
+	}
+
+	/**
+	 * @return key name of this footer; that is the text before the ":" on the
+	 *         line footer's line. The text is decoded according to the commit's
+	 *         specified (or assumed) character encoding.
+	 */
+	public String getKey() {
+		return RawParseUtils.decode(enc, buffer, keyStart, keyEnd);
+	}
+
+	/**
+	 * @return value of this footer; that is the text after the ":" and any
+	 *         leading whitespace has been skipped. May be the empty string if
+	 *         the footer has no value (line ended with ":"). The text is
+	 *         decoded according to the commit's specified (or assumed)
+	 *         character encoding.
+	 */
+	public String getValue() {
+		return RawParseUtils.decode(enc, buffer, valStart, valEnd);
+	}
+
+	@Override
+	public String toString() {
+		return getKey() + ": " + getValue();
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index 284a183..44515ec 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -40,6 +40,9 @@
 
 import java.io.IOException;
 import java.nio.charset.Charset;
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.List;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
@@ -393,6 +396,105 @@ public final Charset getEncoding() {
 	}
 
 	/**
+	 * Parse the footer lines (e.g. "Signed-off-by") for machine processing.
+	 * <p>
+	 * This method splits all of the footer lines out of the last paragraph of
+	 * the commit message, providing each line as a key-value pair, ordered by
+	 * the order of the line's appearance in the commit message itself.
+	 * <p>
+	 * A footer line's key must match the pattern {@code ^[A-Za-z0-9-]+:}, while
+	 * the value is free-form, but must not contain an LF. Very common keys seen
+	 * in the wild are:
+	 * <ul>
+	 * <li>{@code Signed-off-by} (agrees to Developer Certificate of Origin)
+	 * <li>{@code Acked-by} (thinks change looks sane in context)
+	 * <li>{@code Reported-by} (originally found the issue this change fixes)
+	 * <li>{@code Tested-by} (validated change fixes the issue for them)
+	 * <li>{@code CC}, {@code Cc} (copy on all email related to this change)
+	 * <li>{@code Bug} (link to project's bug tracking system)
+	 * </ul>
+	 *
+	 * @return ordered list of footer lines; empty list if no footers found.
+	 */
+	public final List<FooterLine> getFooterLines() {
+		final byte[] raw = buffer;
+		int ptr = raw.length - 1;
+		while (raw[ptr] == '\n') // trim any trailing LFs, not interesting
+			ptr--;
+
+		final int msgB = RawParseUtils.commitMessage(raw, 0);
+		final ArrayList<FooterLine> r = new ArrayList<FooterLine>(4);
+		final Charset enc = getEncoding();
+		for (;;) {
+			ptr = RawParseUtils.prevLF(raw, ptr);
+			if (ptr <= msgB)
+				break; // Don't parse commit headers as footer lines.
+
+			final int keyStart = ptr + 2;
+			if (raw[keyStart] == '\n')
+				break; // Stop at first paragraph break, no footers above it.
+
+			final int keyEnd = RawParseUtils.endOfFooterLineKey(raw, keyStart);
+			if (keyEnd < 0)
+				continue; // Not a well formed footer line, skip it.
+
+			// Skip over the ': *' at the end of the key before the value.
+			//
+			int valStart = keyEnd + 1;
+			while (valStart < raw.length && raw[valStart] == ' ')
+				valStart++;
+
+			// Value ends at the LF, and does not include it.
+			//
+			int valEnd = RawParseUtils.nextLF(raw, valStart);
+			if (raw[valEnd - 1] == '\n')
+				valEnd--;
+
+			r.add(new FooterLine(raw, enc, keyStart, keyEnd, valStart, valEnd));
+		}
+		Collections.reverse(r);
+		return r;
+	}
+
+	/**
+	 * Get the values of all footer lines with the given key.
+	 *
+	 * @param keyName
+	 *            footer key to find values of, case insensitive.
+	 * @return values of footers with key of {@code keyName}, ordered by their
+	 *         order of appearance. Duplicates may be returned if the same
+	 *         footer appeared more than once. Empty list if no footers appear
+	 *         with the specified key, or there are no footers at all.
+	 * @see #getFooterLines()
+	 */
+	public final List<String> getFooterLines(final String keyName) {
+		return getFooterLines(new FooterKey(keyName));
+	}
+
+	/**
+	 * Get the values of all footer lines with the given key.
+	 *
+	 * @param keyName
+	 *            footer key to find values of, case insensitive.
+	 * @return values of footers with key of {@code keyName}, ordered by their
+	 *         order of appearance. Duplicates may be returned if the same
+	 *         footer appeared more than once. Empty list if no footers appear
+	 *         with the specified key, or there are no footers at all.
+	 * @see #getFooterLines()
+	 */
+	public final List<String> getFooterLines(final FooterKey keyName) {
+		final List<FooterLine> src = getFooterLines();
+		if (src.isEmpty())
+			return Collections.emptyList();
+		final ArrayList<String> r = new ArrayList<String>(src.size());
+		for (final FooterLine f : src) {
+			if (f.matches(keyName))
+				r.add(f.getValue());
+		}
+		return r;
+	}
+
+	/**
 	 * Reset this commit to allow another RevWalk with the same instances.
 	 * <p>
 	 * Subclasses <b>must</b> call <code>super.reset()</code> to ensure the
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 0de7eb8..43c3250 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -58,6 +58,8 @@
 
 	private static final byte[] digits16;
 
+	private static final byte[] footerLineKeyChars;
+
 	static {
 		digits10 = new byte['9' + 1];
 		Arrays.fill(digits10, (byte) -1);
@@ -72,6 +74,15 @@
 			digits16[i] = (byte) ((i - 'a') + 10);
 		for (char i = 'A'; i <= 'F'; i++)
 			digits16[i] = (byte) ((i - 'A') + 10);
+
+		footerLineKeyChars = new byte['z' + 1];
+		footerLineKeyChars['-'] = 1;
+		for (char i = '0'; i <= '9'; i++)
+			footerLineKeyChars[i] = 1;
+		for (char i = 'A'; i <= 'Z'; i++)
+			footerLineKeyChars[i] = 1;
+		for (char i = 'a'; i <= 'z'; i++)
+			footerLineKeyChars[i] = 1;
 	}
 
 	/**
@@ -713,6 +724,39 @@ public static PersonIdent parsePersonIdentOnly(final byte[] raw, final int nameB
 	}
 
 	/**
+	 * Locate the end of a footer line key string.
+	 * <p>
+	 * If the region at {@code raw[ptr]} matches {@code ^[A-Za-z0-9-]+:} (e.g.
+	 * "Signed-off-by: A. U. Thor\n") then this method returns the position of
+	 * the first ':'.
+	 * <p>
+	 * If the region at {@code raw[ptr]} does not match {@code ^[A-Za-z0-9-]+:}
+	 * then this method returns -1.
+	 *
+	 * @param raw
+	 *            buffer to scan.
+	 * @param ptr
+	 *            first position within raw to consider as a footer line key.
+	 * @return position of the ':' which terminates the footer line key if this
+	 *         is otherwise a valid footer line key; otherwise -1.
+	 */
+	public static int endOfFooterLineKey(final byte[] raw, int ptr) {
+		try {
+			for (;;) {
+				final byte c = raw[ptr];
+				if (footerLineKeyChars[c] == 0) {
+					if (c == ':')
+						return ptr;
+					return -1;
+				}
+				ptr++;
+			}
+		} catch (ArrayIndexOutOfBoundsException e) {
+			return -1;
+		}
+	}
+
+	/**
 	 * Decode a buffer under UTF-8, if possible.
 	 *
 	 * If the byte stream cannot be decoded that way, the platform default is tried
-- 
1.6.3.3.420.gd4b46
