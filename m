From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] Object validation tests for "jgit fsck"
Date: Tue, 30 Sep 2008 18:31:28 -0700
Message-ID: <1222824690-7632-4-git-send-email-spearce@spearce.org>
References: <1222824690-7632-1-git-send-email-spearce@spearce.org>
 <1222824690-7632-2-git-send-email-spearce@spearce.org>
 <1222824690-7632-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 03:33:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkqan-0006Nd-Rk
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 03:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbYJABbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 21:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbYJABbr
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 21:31:47 -0400
Received: from george.spearce.org ([209.20.77.23]:51630 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbYJABbg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 21:31:36 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id EB56738377; Wed,  1 Oct 2008 01:31:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 88D2138268;
	Wed,  1 Oct 2008 01:31:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.569.g798a2a
In-Reply-To: <1222824690-7632-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97183>

The ObjectChecker provides strict validation rules for objects.  If
any commit, tag or tree object is malformed in a way that might cause
a Git implementation to misinterpret the data CorruptObjectException
is thrown back to the caller for error handling.

Due to the shear size of the validation code this change provides
only the validation code and its unit tests.  It is at least as
paranoid as git.git's "git-fsck" is on the same object types, but
is actually a bit stricter about the commit and tag objects having
the well known header fields populated correctly.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/ObjectCheckerTest.java    | 1294 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/ObjectChecker.java    |  352 ++++++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   10 +-
 3 files changed, 1650 insertions(+), 6 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectCheckerTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectCheckerTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectCheckerTest.java
new file mode 100644
index 0000000..fa37fb5
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectCheckerTest.java
@@ -0,0 +1,1294 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+package org.spearce.jgit.lib;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.errors.CorruptObjectException;
+
+public class ObjectCheckerTest extends TestCase {
+	private ObjectChecker checker;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		checker = new ObjectChecker();
+	}
+
+	public void testInvalidType() {
+		try {
+			checker.check(Constants.OBJ_BAD, new byte[0]);
+			fail("Did not throw CorruptObjectException");
+		} catch (CorruptObjectException e) {
+			final String m = e.getMessage();
+			assertEquals("Invalid object type: " + Constants.OBJ_BAD, m);
+		}
+	}
+
+	public void testCheckBlob() throws CorruptObjectException {
+		// Any blob should pass...
+		checker.checkBlob(new byte[0]);
+		checker.checkBlob(new byte[1]);
+
+		checker.check(Constants.OBJ_BLOB, new byte[0]);
+		checker.check(Constants.OBJ_BLOB, new byte[1]);
+	}
+
+	public void testValidCommitNoParent() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author A. U. Thor <author@localhost> 1 +0000\n");
+		b.append("committer A. U. Thor <author@localhost> 1 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkCommit(data);
+		checker.check(Constants.OBJ_COMMIT, data);
+	}
+
+	public void testValidCommitBlankAuthor() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author <> 0 +0000\n");
+		b.append("committer <> 0 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkCommit(data);
+		checker.check(Constants.OBJ_COMMIT, data);
+	}
+
+	public void testValidCommit1Parent() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("parent ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author A. U. Thor <author@localhost> 1 +0000\n");
+		b.append("committer A. U. Thor <author@localhost> 1 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkCommit(data);
+		checker.check(Constants.OBJ_COMMIT, data);
+	}
+
+	public void testValidCommit2Parent() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("parent ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("parent ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author A. U. Thor <author@localhost> 1 +0000\n");
+		b.append("committer A. U. Thor <author@localhost> 1 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkCommit(data);
+		checker.check(Constants.OBJ_COMMIT, data);
+	}
+
+	public void testValidCommit128Parent() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		for (int i = 0; i < 128; i++) {
+			b.append("parent ");
+			b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+			b.append('\n');
+		}
+
+		b.append("author A. U. Thor <author@localhost> 1 +0000\n");
+		b.append("committer A. U. Thor <author@localhost> 1 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkCommit(data);
+		checker.check(Constants.OBJ_COMMIT, data);
+	}
+
+	public void testValidCommitNormalTime() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		final String when = "1222757360 -0730";
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author A. U. Thor <author@localhost> " + when + "\n");
+		b.append("committer A. U. Thor <author@localhost> " + when + "\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkCommit(data);
+		checker.check(Constants.OBJ_COMMIT, data);
+	}
+
+	public void testInvalidCommitNoTree1() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("parent ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("no tree header", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitNoTree2() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("trie ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("no tree header", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitNoTree3() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("no tree header", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitNoTree4() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree\t");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("no tree header", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidTree1() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("zzzzfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid tree", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidTree2() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append("z\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid tree", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidTree3() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9b");
+		b.append("\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid tree", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidTree4() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree  ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid tree", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidParent1() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("parent ");
+		b.append("\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid parent", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidParent2() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("parent ");
+		b.append("zzzzfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append("\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid parent", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidParent3() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("parent  ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append("\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid parent", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidParent4() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("parent  ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append("z\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid parent", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidParent5() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("parent\t");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append("\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("no author", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitNoAuthor() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("committer A. U. Thor <author@localhost> 1 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("no author", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitNoCommitter1() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author A. U. Thor <author@localhost> 1 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("no committer", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitNoCommitter2() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author A. U. Thor <author@localhost> 1 +0000\n");
+		b.append("\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("no committer", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidAuthor1() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author A. U. Thor <foo 1 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("invalid author", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidAuthor2() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author A. U. Thor foo> 1 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("invalid author", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidAuthor3() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author 1 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("invalid author", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidAuthor4() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author a <b> +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("invalid author", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidAuthor5() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author a <b>\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("invalid author", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidAuthor6() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author a <b> z");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("invalid author", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidAuthor7() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author a <b> 1 z");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("invalid author", e.getMessage());
+		}
+	}
+
+	public void testInvalidCommitInvalidCommitter() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("tree ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("author a <b> 1 +0000\n");
+		b.append("committer a <");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkCommit(data);
+			fail("Did not catch corrupt object");
+		} catch (CorruptObjectException e) {
+			// Yes, really, we complain about author not being
+			// found as the invalid parent line wasn't consumed.
+			assertEquals("invalid committer", e.getMessage());
+		}
+	}
+
+	public void testValidTag() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("type commit\n");
+		b.append("tag test-tag\n");
+		b.append("tagger A. U. Thor <author@localhost> 1 +0000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTag(data);
+		checker.check(Constants.OBJ_TAG, data);
+	}
+
+	public void testInvalidTagNoObject1() {
+		final StringBuilder b = new StringBuilder();
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no object header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoObject2() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object\t");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no object header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoObject3() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("obejct ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no object header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoObject4() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("zz9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid object", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoObject5() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append(" \n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid object", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoObject6() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid object", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoType1() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no type header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoType2() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("type\tcommit\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no type header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoType3() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("tpye commit\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no type header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoType4() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("type commit");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no tag header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoTagHeader1() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("type commit\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no tag header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoTagHeader2() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("type commit\n");
+		b.append("tag\tfoo\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no tag header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoTagHeader3() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("type commit\n");
+		b.append("tga foo\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no tag header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoTagHeader4() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("type commit\n");
+		b.append("tag foo");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no tagger header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagNoTaggerHeader1() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("type commit\n");
+		b.append("tag foo\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("no tagger header", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagInvalidTaggerHeader1() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("type commit\n");
+		b.append("tag foo\n");
+		b.append("tagger \n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid tagger", e.getMessage());
+		}
+	}
+
+	public void testInvalidTagInvalidTaggerHeader3() {
+		final StringBuilder b = new StringBuilder();
+
+		b.append("object ");
+		b.append("be9bfa841874ccc9f2ef7c48d0c76226f89b7189");
+		b.append('\n');
+
+		b.append("type commit\n");
+		b.append("tag foo\n");
+		b.append("tagger a < 1 +000\n");
+
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTag(data);
+			fail("incorrectly accepted invalid tag");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid tagger", e.getMessage());
+		}
+	}
+
+	public void testValidEmptyTree() throws CorruptObjectException {
+		checker.checkTree(new byte[0]);
+		checker.check(Constants.OBJ_TREE, new byte[0]);
+	}
+
+	public void testValidTree1() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 regular-file");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTree2() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100755 executable");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTree3() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "40000 tree");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTree4() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "120000 symlink");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTree5() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "160000 git link");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTreeSorting1() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 fooaaa");
+		entry(b, "100755 foobar");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTreeSorting2() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100755 fooaaa");
+		entry(b, "100644 foobar");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTreeSorting3() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "40000 a");
+		entry(b, "100644 b");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTreeSorting4() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 a");
+		entry(b, "40000 b");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTreeSorting5() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 a.c");
+		entry(b, "40000 a");
+		entry(b, "100644 a0c");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTreeSorting6() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "40000 a");
+		entry(b, "100644 apple");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTreeSorting7() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "40000 an orang");
+		entry(b, "40000 an orange");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testValidTreeSorting8() throws CorruptObjectException {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 a");
+		entry(b, "100644 a0c");
+		entry(b, "100644 b");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		checker.checkTree(data);
+	}
+
+	public void testInvalidTreeModeStartsWithZero1() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "0 a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("mode starts with '0'", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeModeStartsWithZero2() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "0100644 a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("mode starts with '0'", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeModeStartsWithZero3() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "040000 a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("mode starts with '0'", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeModeNotOctal1() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "8 a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid mode character", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeModeNotOctal2() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "Z a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid mode character", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeModeNotSupportedMode1() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "1 a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid mode 1", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeModeNotSupportedMode2() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "170000 a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("invalid mode " + 0170000, e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeModeMissingName() {
+		final StringBuilder b = new StringBuilder();
+		b.append("100644");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("truncated in mode", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeNameContainsSlash() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 a/b");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("name contains '/'", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeNameIsEmpty() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 ");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("zero length name", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeTruncatedInName() {
+		final StringBuilder b = new StringBuilder();
+		b.append("100644 b");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("truncated in name", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeTruncatedInObjectId() {
+		final StringBuilder b = new StringBuilder();
+		b.append("100644 b\0\1\2");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("truncated in object id", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeBadSorting1() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 foobar");
+		entry(b, "100644 fooaaa");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("incorrectly sorted", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeBadSorting2() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "40000 a");
+		entry(b, "100644 a.c");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("incorrectly sorted", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeBadSorting3() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 a0c");
+		entry(b, "40000 a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("incorrectly sorted", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeDuplicateNames1() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 a");
+		entry(b, "100644 a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("duplicate entry names", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeDuplicateNames2() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 a");
+		entry(b, "100755 a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("duplicate entry names", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeDuplicateNames3() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 a");
+		entry(b, "40000 a");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("duplicate entry names", e.getMessage());
+		}
+	}
+
+	public void testInvalidTreeDuplicateNames4() {
+		final StringBuilder b = new StringBuilder();
+		entry(b, "100644 a");
+		entry(b, "100644 a.c");
+		entry(b, "100644 a.d");
+		entry(b, "100644 a.e");
+		entry(b, "40000 a");
+		entry(b, "100644 zoo");
+		final byte[] data = Constants.encodeASCII(b.toString());
+		try {
+			checker.checkTree(data);
+			fail("incorrectly accepted an invalid tree");
+		} catch (CorruptObjectException e) {
+			assertEquals("duplicate entry names", e.getMessage());
+		}
+	}
+
+	private static void entry(final StringBuilder b, final String modeName) {
+		b.append(modeName);
+		b.append('\0');
+		for (int i = 0; i < Constants.OBJECT_ID_LENGTH; i++)
+			b.append((char) i);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
new file mode 100644
index 0000000..0d165af
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
@@ -0,0 +1,352 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+package org.spearce.jgit.lib;
+
+import static org.spearce.jgit.util.RawParseUtils.match;
+import static org.spearce.jgit.util.RawParseUtils.nextLF;
+import static org.spearce.jgit.util.RawParseUtils.parseBase10;
+
+import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.util.MutableInteger;
+
+/**
+ * Verifies that an object is formatted correctly.
+ * <p>
+ * Verifications made by this class only check that the fields of an object are
+ * formatted correctly. The ObjectId checksum of the object is not verified, and
+ * connectivity links between objects are also not verified. Its assumed that
+ * the caller can provide both of these validations on its own.
+ * <p>
+ * Instances of this class are not thread safe, but they may be reused to
+ * perform multiple object validations.
+ */
+public class ObjectChecker {
+	/** Header "tree " */
+	public static final byte[] tree = Constants.encodeASCII("tree ");
+
+	/** Header "parent " */
+	public static final byte[] parent = Constants.encodeASCII("parent ");
+
+	/** Header "author " */
+	public static final byte[] author = Constants.encodeASCII("author ");
+
+	/** Header "committer " */
+	public static final byte[] committer = Constants.encodeASCII("committer ");
+
+	/** Header "encoding " */
+	public static final byte[] encoding = Constants.encodeASCII("encoding ");
+
+	/** Header "object " */
+	public static final byte[] object = Constants.encodeASCII("object ");
+
+	/** Header "type " */
+	public static final byte[] type = Constants.encodeASCII("type ");
+
+	/** Header "tag " */
+	public static final byte[] tag = Constants.encodeASCII("tag ");
+
+	/** Header "tagger " */
+	public static final byte[] tagger = Constants.encodeASCII("tagger ");
+
+	private final MutableObjectId tempId = new MutableObjectId();
+
+	private final MutableInteger ptrout = new MutableInteger();
+
+	/**
+	 * Check an object for parsing errors.
+	 * 
+	 * @param objType
+	 *            type of the object. Must be a valid object type code in
+	 *            {@link Constants}.
+	 * @param raw
+	 *            the raw data which comprises the object. This should be in the
+	 *            canonical format (that is the format used to generate the
+	 *            ObjectId of the object). The array is never modified.
+	 * @throws CorruptObjectException
+	 *             if an error is identified.
+	 */
+	public void check(final int objType, final byte[] raw)
+			throws CorruptObjectException {
+		switch (objType) {
+		case Constants.OBJ_COMMIT:
+			checkCommit(raw);
+			break;
+		case Constants.OBJ_TAG:
+			checkTag(raw);
+			break;
+		case Constants.OBJ_TREE:
+			checkTree(raw);
+			break;
+		case Constants.OBJ_BLOB:
+			checkBlob(raw);
+			break;
+		default:
+			throw new CorruptObjectException("Invalid object type: " + objType);
+		}
+	}
+
+	private int id(final byte[] raw, final int ptr) {
+		try {
+			tempId.fromString(raw, ptr);
+			return ptr + AnyObjectId.STR_LEN;
+		} catch (IllegalArgumentException e) {
+			return -1;
+		}
+	}
+
+	private int personIdent(final byte[] raw, int ptr) {
+		final int emailB = nextLF(raw, ptr, '<');
+		if (emailB == ptr || raw[emailB - 1] != '<')
+			return -1;
+
+		final int emailE = nextLF(raw, emailB, '>');
+		if (emailE == emailB || raw[emailE - 1] != '>')
+			return -1;
+		if (emailE == raw.length || raw[emailE] != ' ')
+			return -1;
+
+		parseBase10(raw, emailE + 1, ptrout); // when
+		ptr = ptrout.value;
+		if (emailE + 1 == ptr)
+			return -1;
+		if (ptr == raw.length || raw[ptr] != ' ')
+			return -1;
+
+		parseBase10(raw, ptr + 1, ptrout); // tz offset
+		if (ptr + 1 == ptrout.value)
+			return -1;
+		return ptrout.value;
+	}
+
+	/**
+	 * Check a commit for errors.
+	 * 
+	 * @param raw
+	 *            the commit data. The array is never modified.
+	 * @throws CorruptObjectException
+	 *             if any error was detected.
+	 */
+	public void checkCommit(final byte[] raw) throws CorruptObjectException {
+		int ptr = 0;
+
+		if ((ptr = match(raw, ptr, tree)) < 0)
+			throw new CorruptObjectException("no tree header");
+		if ((ptr = id(raw, ptr)) < 0 || raw[ptr++] != '\n')
+			throw new CorruptObjectException("invalid tree");
+
+		while (match(raw, ptr, parent) >= 0) {
+			ptr += parent.length;
+			if ((ptr = id(raw, ptr)) < 0 || raw[ptr++] != '\n')
+				throw new CorruptObjectException("invalid parent");
+		}
+
+		if ((ptr = match(raw, ptr, author)) < 0)
+			throw new CorruptObjectException("no author");
+		if ((ptr = personIdent(raw, ptr)) < 0 || raw[ptr++] != '\n')
+			throw new CorruptObjectException("invalid author");
+
+		if ((ptr = match(raw, ptr, committer)) < 0)
+			throw new CorruptObjectException("no committer");
+		if ((ptr = personIdent(raw, ptr)) < 0 || raw[ptr++] != '\n')
+			throw new CorruptObjectException("invalid committer");
+	}
+
+	/**
+	 * Check an annotated tag for errors.
+	 * 
+	 * @param raw
+	 *            the tag data. The array is never modified.
+	 * @throws CorruptObjectException
+	 *             if any error was detected.
+	 */
+	public void checkTag(final byte[] raw) throws CorruptObjectException {
+		int ptr = 0;
+
+		if ((ptr = match(raw, ptr, object)) < 0)
+			throw new CorruptObjectException("no object header");
+		if ((ptr = id(raw, ptr)) < 0 || raw[ptr++] != '\n')
+			throw new CorruptObjectException("invalid object");
+
+		if ((ptr = match(raw, ptr, type)) < 0)
+			throw new CorruptObjectException("no type header");
+		ptr = nextLF(raw, ptr, '\n');
+
+		if ((ptr = match(raw, ptr, tag)) < 0)
+			throw new CorruptObjectException("no tag header");
+		ptr = nextLF(raw, ptr, '\n');
+
+		if ((ptr = match(raw, ptr, tagger)) < 0)
+			throw new CorruptObjectException("no tagger header");
+		if ((ptr = personIdent(raw, ptr)) < 0 || raw[ptr++] != '\n')
+			throw new CorruptObjectException("invalid tagger");
+	}
+
+	private static int lastPathChar(final int mode) {
+		return FileMode.TREE.equals(mode) ? '/' : '\0';
+	}
+
+	private static int pathCompare(final byte[] raw, int aPos, final int aEnd,
+			final int aMode, int bPos, final int bEnd, final int bMode) {
+		while (aPos < aEnd && bPos < bEnd) {
+			final int cmp = (raw[aPos++] & 0xff) - (raw[bPos++] & 0xff);
+			if (cmp != 0)
+				return cmp;
+		}
+
+		if (aPos < aEnd)
+			return (raw[aPos] & 0xff) - lastPathChar(bMode);
+		if (bPos < bEnd)
+			return lastPathChar(aMode) - (raw[bPos] & 0xff);
+		return 0;
+	}
+
+	private static boolean duplicateName(final byte[] raw,
+			final int thisNamePos, final int thisNameEnd) {
+		final int sz = raw.length;
+		int nextPtr = thisNameEnd + 1 + Constants.OBJECT_ID_LENGTH;
+		for (;;) {
+			int nextMode = 0;
+			for (;;) {
+				if (nextPtr >= sz)
+					return false;
+				final byte c = raw[nextPtr++];
+				if (' ' == c)
+					break;
+				nextMode <<= 3;
+				nextMode += c - '0';
+			}
+
+			final int nextNamePos = nextPtr;
+			for (;;) {
+				if (nextPtr == sz)
+					return false;
+				final byte c = raw[nextPtr++];
+				if (c == 0)
+					break;
+			}
+			if (nextNamePos + 1 == nextPtr)
+				return false;
+
+			final int cmp = pathCompare(raw, thisNamePos, thisNameEnd,
+					FileMode.TREE.getBits(), nextNamePos, nextPtr - 1, nextMode);
+			if (cmp < 0)
+				return false;
+			else if (cmp == 0)
+				return true;
+
+			nextPtr += Constants.OBJECT_ID_LENGTH;
+		}
+	}
+
+	/**
+	 * Check a canonical formatted tree for errors.
+	 * 
+	 * @param raw
+	 *            the raw tree data. The array is never modified.
+	 * @throws CorruptObjectException
+	 *             if any error was detected.
+	 */
+	public void checkTree(final byte[] raw) throws CorruptObjectException {
+		final int sz = raw.length;
+		int ptr = 0;
+		int lastNameB = 0, lastNameE = 0, lastMode = 0;
+
+		while (ptr < sz) {
+			int thisMode = 0;
+			for (;;) {
+				if (ptr == sz)
+					throw new CorruptObjectException("truncated in mode");
+				final byte c = raw[ptr++];
+				if (' ' == c)
+					break;
+				if (c < '0' || c > '7')
+					throw new CorruptObjectException("invalid mode character");
+				if (thisMode == 0 && c == '0')
+					throw new CorruptObjectException("mode starts with '0'");
+				thisMode <<= 3;
+				thisMode += c - '0';
+			}
+
+			if (FileMode.fromBits(thisMode).getObjectType() == Constants.OBJ_BAD)
+				throw new CorruptObjectException("invalid mode " + thisMode);
+
+			final int thisNameB = ptr;
+			for (;;) {
+				if (ptr == sz)
+					throw new CorruptObjectException("truncated in name");
+				final byte c = raw[ptr++];
+				if (c == 0)
+					break;
+				if (c == '/')
+					throw new CorruptObjectException("name contains '/'");
+			}
+			if (thisNameB + 1 == ptr)
+				throw new CorruptObjectException("zero length name");
+			if (duplicateName(raw, thisNameB, ptr - 1))
+				throw new CorruptObjectException("duplicate entry names");
+
+			if (lastNameB != 0) {
+				final int cmp = pathCompare(raw, lastNameB, lastNameE,
+						lastMode, thisNameB, ptr - 1, thisMode);
+				if (cmp > 0)
+					throw new CorruptObjectException("incorrectly sorted");
+			}
+
+			lastNameB = thisNameB;
+			lastNameE = ptr - 1;
+			lastMode = thisMode;
+
+			ptr += Constants.OBJECT_ID_LENGTH;
+			if (ptr > sz)
+				throw new CorruptObjectException("truncated in object id");
+		}
+	}
+
+	/**
+	 * Check a blob for errors.
+	 * 
+	 * @param raw
+	 *            the blob data. The array is never modified.
+	 * @throws CorruptObjectException
+	 *             if any error was detected.
+	 */
+	public void checkBlob(final byte[] raw) throws CorruptObjectException {
+		// We can always assume the blob is valid.
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 2ab3bfe..c2c9b00 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -37,6 +37,10 @@
 
 package org.spearce.jgit.util;
 
+import static org.spearce.jgit.lib.ObjectChecker.author;
+import static org.spearce.jgit.lib.ObjectChecker.committer;
+import static org.spearce.jgit.lib.ObjectChecker.encoding;
+
 import java.nio.ByteBuffer;
 import java.nio.charset.Charset;
 import java.util.Arrays;
@@ -46,12 +50,6 @@
 
 /** Handy utility functions to parse raw object contents. */
 public final class RawParseUtils {
-	private static final byte[] author = Constants.encodeASCII("author ");
-
-	private static final byte[] committer = Constants.encodeASCII("committer ");
-
-	private static final byte[] encoding = Constants.encodeASCII("encoding ");
-
 	private static final byte[] digits;
 
 	static {
-- 
1.6.0.2.569.g798a2a
