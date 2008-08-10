From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 02/11] Add test case for the RevCommit parsing code
Date: Sun, 10 Aug 2008 01:46:17 -0700
Message-ID: <1218357986-19671-3-git-send-email-spearce@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org>
 <1218357986-19671-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6aT-0001pt-Il
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYHJIqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbYHJIqe
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:34 -0400
Received: from george.spearce.org ([209.20.77.23]:51266 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbYHJIqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7778C3837A; Sun, 10 Aug 2008 08:46:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 812EA381FD;
	Sun, 10 Aug 2008 08:46:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
In-Reply-To: <1218357986-19671-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91816>

Most of these are to address the errors identified in getShortMessage
when handling the different corner cases of a commit body.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/revwalk/RevCommitParseTest.java   |  190 ++++++++++++++++++++
 1 files changed, 190 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
new file mode 100644
index 0000000..2645337
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
@@ -0,0 +1,190 @@
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
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PersonIdent;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class RevCommitParseTest extends RepositoryTestCase {
+	public void testParse_NoParents() throws Exception {
+		final ObjectId treeId = id("9788669ad918b6fcce64af8882fc9a81cb6aba67");
+		final String authorName = "A U. Thor";
+		final String authorEmail = "a_u_thor@example.com";
+		final int authorTime = 1218123387;
+
+		final String committerName = "C O. Miter";
+		final String committerEmail = "comiter@example.com";
+		final int committerTime = 1218123390;
+		final StringBuilder body = new StringBuilder();
+
+		body.append("tree ");
+		body.append(treeId);
+		body.append("\n");
+
+		body.append("author ");
+		body.append(authorName);
+		body.append(" <");
+		body.append(authorEmail);
+		body.append("> ");
+		body.append(authorTime);
+		body.append(" +0700\n");
+
+		body.append("committer ");
+		body.append(committerName);
+		body.append(" <");
+		body.append(committerEmail);
+		body.append("> ");
+		body.append(committerTime);
+		body.append(" -0500\n");
+
+		body.append("\n");
+
+		final RevWalk rw = new RevWalk(db);
+		final RevCommit c;
+
+		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		assertNull(c.getTree());
+		assertNull(c.parents);
+
+		c.parseCanonical(rw, body.toString().getBytes("UTF-8"));
+		assertNotNull(c.getTree());
+		assertEquals(treeId, c.getTree().getId());
+		assertSame(rw.lookupTree(treeId), c.getTree());
+
+		assertNotNull(c.parents);
+		assertEquals(0, c.parents.length);
+		assertEquals("", c.getFullMessage());
+
+		final PersonIdent cAuthor = c.getAuthorIdent();
+		assertNotNull(cAuthor);
+		assertEquals(authorName, cAuthor.getName());
+		assertEquals(authorEmail, cAuthor.getEmailAddress());
+
+		final PersonIdent cCommitter = c.getCommitterIdent();
+		assertNotNull(cCommitter);
+		assertEquals(committerName, cCommitter.getName());
+		assertEquals(committerEmail, cCommitter.getEmailAddress());
+	}
+
+	private RevCommit create(final String msg) throws Exception {
+		final StringBuilder b = new StringBuilder();
+		b.append("tree 9788669ad918b6fcce64af8882fc9a81cb6aba67\n");
+		b.append("author A U. Thor <a_u_thor@example.com> 1218123387 +0700\n");
+		b.append("committer C O. Miter <c@example.com> 1218123390 -0500\n");
+		b.append("\n");
+		b.append(msg);
+
+		final RevCommit c;
+		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		c.parseCanonical(new RevWalk(db), b.toString().getBytes("UTF-8"));
+		return c;
+	}
+
+	public void testParse_WeirdHeaderOnlyCommit() throws Exception {
+		final StringBuilder b = new StringBuilder();
+		b.append("tree 9788669ad918b6fcce64af8882fc9a81cb6aba67\n");
+		b.append("author A U. Thor <a_u_thor@example.com> 1218123387 +0700\n");
+		b.append("committer C O. Miter <c@example.com> 1218123390 -0500\n");
+
+		final RevCommit c;
+		c = new RevCommit(id("9473095c4cb2f12aefe1db8a355fe3fafba42f67"));
+		c.parseCanonical(new RevWalk(db), b.toString().getBytes("UTF-8"));
+
+		assertEquals("", c.getFullMessage());
+		assertEquals("", c.getShortMessage());
+	}
+
+	public void testParse_NoMessage() throws Exception {
+		final String msg = "";
+		final RevCommit c = create(msg);
+		assertEquals(msg, c.getFullMessage());
+		assertEquals(msg, c.getShortMessage());
+	}
+
+	public void testParse_OnlyLFMessage() throws Exception {
+		final RevCommit c = create("\n");
+		assertEquals("\n", c.getFullMessage());
+		assertEquals("", c.getShortMessage());
+	}
+
+	public void testParse_ShortLineOnlyNoLF() throws Exception {
+		final String shortMsg = "This is a short message.";
+		final RevCommit c = create(shortMsg);
+		assertEquals(shortMsg, c.getFullMessage());
+		assertEquals(shortMsg, c.getShortMessage());
+	}
+
+	public void testParse_ShortLineOnlyEndLF() throws Exception {
+		final String shortMsg = "This is a short message.";
+		final String fullMsg = shortMsg + "\n";
+		final RevCommit c = create(fullMsg);
+		assertEquals(fullMsg, c.getFullMessage());
+		assertEquals(shortMsg, c.getShortMessage());
+	}
+
+	public void testParse_ShortLineOnlyEmbeddedLF() throws Exception {
+		final String fullMsg = "This is a\nshort message.";
+		final String shortMsg = fullMsg.replace('\n', ' ');
+		final RevCommit c = create(fullMsg);
+		assertEquals(fullMsg, c.getFullMessage());
+		assertEquals(shortMsg, c.getShortMessage());
+	}
+
+	public void testParse_ShortLineOnlyEmbeddedAndEndingLF() throws Exception {
+		final String fullMsg = "This is a\nshort message.\n";
+		final String shortMsg = "This is a short message.";
+		final RevCommit c = create(fullMsg);
+		assertEquals(fullMsg, c.getFullMessage());
+		assertEquals(shortMsg, c.getShortMessage());
+	}
+
+	public void testParse_GitStyleMessage() throws Exception {
+		final String shortMsg = "This fixes a bug.";
+		final String body = "We do it with magic and pixie dust and stuff.\n"
+				+ "\n" + "Signed-off-by: A U. Thor <author@example.com>\n";
+		final String fullMsg = shortMsg + "\n" + "\n" + body;
+		final RevCommit c = create(fullMsg);
+		assertEquals(fullMsg, c.getFullMessage());
+		assertEquals(shortMsg, c.getShortMessage());
+	}
+
+	private static ObjectId id(final String str) {
+		return ObjectId.fromString(str);
+	}
+}
-- 
1.6.0.rc2.219.g1250ab
