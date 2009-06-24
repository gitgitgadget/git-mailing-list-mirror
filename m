From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Add getEncoding() to RevCommit to discover the encoding
Date: Tue, 23 Jun 2009 20:11:48 -0700
Message-ID: <1245813109-29763-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 05:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJIu0-0007eY-Cc
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 05:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbZFXDLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 23:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbZFXDLt
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 23:11:49 -0400
Received: from george.spearce.org ([209.20.77.23]:34316 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbZFXDLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 23:11:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 87D4B381FF; Wed, 24 Jun 2009 03:11:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 183E03819F;
	Wed, 24 Jun 2009 03:11:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.3.420.gd4b46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122118>

If an application needs to parse the raw buffer by hand it might
benefit from knowing the encoding of the commit.  We can make it
available to them through a getEncoding() method, using the same
logic we already use for getFullMessage() and getShortMessage(),
but this is still only an estimate based on the "encoding" header
and may not be reality if the commit is horribly malformed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/revwalk/RevCommitParseTest.java   |    6 ++++++
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |   16 ++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
index 9b95924..62a4ab5 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
@@ -39,6 +39,7 @@
 
 import java.io.ByteArrayOutputStream;
 
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.RepositoryTestCase;
@@ -145,6 +146,7 @@ public void testParse_implicit_UTF8_encoded() throws Exception {
 		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67")); // bogus id
 		c.parseCanonical(new RevWalk(db), b.toByteArray());
 
+		assertSame(Constants.CHARSET, c.getEncoding());
 		assertEquals("F\u00f6r fattare", c.getAuthorIdent().getName());
 		assertEquals("Sm\u00f6rg\u00e5sbord", c.getShortMessage());
 		assertEquals("Sm\u00f6rg\u00e5sbord\n\n\u304d\u308c\u3044\n", c.getFullMessage());
@@ -163,6 +165,7 @@ public void testParse_implicit_mixed_encoded() throws Exception {
 		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67")); // bogus id
 		c.parseCanonical(new RevWalk(db), b.toByteArray());
 
+		assertSame(Constants.CHARSET, c.getEncoding());
 		assertEquals("F\u00f6r fattare", c.getAuthorIdent().getName());
 		assertEquals("Sm\u00f6rg\u00e5sbord", c.getShortMessage());
 		assertEquals("Sm\u00f6rg\u00e5sbord\n\n\u304d\u308c\u3044\n", c.getFullMessage());
@@ -187,6 +190,7 @@ public void testParse_explicit_encoded() throws Exception {
 		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67")); // bogus id
 		c.parseCanonical(new RevWalk(db), b.toByteArray());
 
+		assertEquals("EUC-JP", c.getEncoding().name());
 		assertEquals("F\u00f6r fattare", c.getAuthorIdent().getName());
 		assertEquals("\u304d\u308c\u3044", c.getShortMessage());
 		assertEquals("\u304d\u308c\u3044\n\nHi\n", c.getFullMessage());
@@ -215,6 +219,7 @@ public void testParse_explicit_bad_encoded() throws Exception {
 		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67")); // bogus id
 		c.parseCanonical(new RevWalk(db), b.toByteArray());
 
+		assertEquals("EUC-JP", c.getEncoding().name());
 		assertEquals("F\u00f6r fattare", c.getAuthorIdent().getName());
 		assertEquals("\u304d\u308c\u3044", c.getShortMessage());
 		assertEquals("\u304d\u308c\u3044\n\nHi\n", c.getFullMessage());
@@ -244,6 +249,7 @@ public void testParse_explicit_bad_encoded2() throws Exception {
 		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67")); // bogus id
 		c.parseCanonical(new RevWalk(db), b.toByteArray());
 
+		assertEquals("ISO-8859-1", c.getEncoding().name());
 		assertEquals("F\u00f6r fattare", c.getAuthorIdent().getName());
 		assertEquals("\u304d\u308c\u3044", c.getShortMessage());
 		assertEquals("\u304d\u308c\u3044\n\nHi\n", c.getFullMessage());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index f211dfd..284a183 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2009, Google Inc.
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
  *
  * All rights reserved.
@@ -377,6 +378,21 @@ static boolean hasLF(final byte[] r, int b, final int e) {
 	}
 
 	/**
+	 * Determine the encoding of the commit message buffer.
+	 * <p>
+	 * Locates the "encoding" header (if present) and then returns the proper
+	 * character set to apply to this buffer to evaluate its contents as
+	 * character data.
+	 * <p>
+	 * If no encoding header is present, {@link Constants#CHARSET} is assumed.
+	 *
+	 * @return the preferred encoding of {@link #getRawBuffer()}.
+	 */
+	public final Charset getEncoding() {
+		return RawParseUtils.parseEncoding(buffer);
+	}
+
+	/**
 	 * Reset this commit to allow another RevWalk with the same instances.
 	 * <p>
 	 * Subclasses <b>must</b> call <code>super.reset()</code> to ensure the
-- 
1.6.3.3.420.gd4b46
