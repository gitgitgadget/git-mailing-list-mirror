From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/12] Add tests for basic RevObject methods related to type, flags
Date: Tue, 17 Mar 2009 18:40:48 -0700
Message-ID: <1237340451-31562-10-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
 <1237340451-31562-2-git-send-email-spearce@spearce.org>
 <1237340451-31562-3-git-send-email-spearce@spearce.org>
 <1237340451-31562-4-git-send-email-spearce@spearce.org>
 <1237340451-31562-5-git-send-email-spearce@spearce.org>
 <1237340451-31562-6-git-send-email-spearce@spearce.org>
 <1237340451-31562-7-git-send-email-spearce@spearce.org>
 <1237340451-31562-8-git-send-email-spearce@spearce.org>
 <1237340451-31562-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpR-00052N-JE
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817AbZCRBle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756812AbZCRBld
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:33 -0400
Received: from george.spearce.org ([209.20.77.23]:56676 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806AbZCRBl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:41:29 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 09AB838267; Wed, 18 Mar 2009 01:41:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9898438268;
	Wed, 18 Mar 2009 01:40:54 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113564>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/RevObjectTest.java    |  171 ++++++++++++++++++++
 .../org/spearce/jgit/revwalk/RevWalkTestCase.java  |   18 ++
 2 files changed, 189 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevObjectTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevObjectTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevObjectTest.java
new file mode 100644
index 0000000..0eaafbf
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevObjectTest.java
@@ -0,0 +1,171 @@
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
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
+
+public class RevObjectTest extends RevWalkTestCase {
+	public void testId() throws Exception {
+		final RevCommit a = commit();
+		assertSame(a, a.getId());
+	}
+
+	public void testEqualsIsIdentity() throws Exception {
+		final RevCommit a1 = commit();
+		final RevCommit b1 = commit();
+
+		assertTrue(a1.equals(a1));
+		assertTrue(a1.equals((Object) a1));
+		assertFalse(a1.equals(b1));
+
+		assertFalse(a1.equals(a1.copy()));
+		assertFalse(a1.equals((Object) a1.copy()));
+		assertFalse(a1.equals(""));
+
+		final RevWalk rw2 = new RevWalk(db);
+		final RevCommit a2 = rw2.parseCommit(a1);
+		final RevCommit b2 = rw2.parseCommit(b1);
+		assertNotSame(a1, a2);
+		assertNotSame(b1, b2);
+
+		assertFalse(a1.equals(a2));
+		assertFalse(b1.equals(b2));
+
+		assertEquals(a1.hashCode(), a2.hashCode());
+		assertEquals(b1.hashCode(), b2.hashCode());
+
+		assertTrue(AnyObjectId.equals(a1, a2));
+		assertTrue(AnyObjectId.equals(b1, b2));
+	}
+
+	public void testRevObjectTypes() throws Exception {
+		assertEquals(Constants.OBJ_TREE, emptyTree.getType());
+		assertEquals(Constants.OBJ_COMMIT, commit().getType());
+		assertEquals(Constants.OBJ_BLOB, blob("").getType());
+		assertEquals(Constants.OBJ_TAG, tag("emptyTree", emptyTree).getType());
+	}
+
+	public void testHasRevFlag() throws Exception {
+		final RevCommit a = commit();
+		assertFalse(a.has(RevFlag.UNINTERESTING));
+		a.flags |= RevWalk.UNINTERESTING;
+		assertTrue(a.has(RevFlag.UNINTERESTING));
+	}
+
+	public void testHasAnyFlag() throws Exception {
+		final RevCommit a = commit();
+		final RevFlag flag1 = rw.newFlag("flag1");
+		final RevFlag flag2 = rw.newFlag("flag2");
+		final RevFlagSet s = new RevFlagSet();
+		s.add(flag1);
+		s.add(flag2);
+
+		assertFalse(a.hasAny(s));
+		a.flags |= flag1.mask;
+		assertTrue(a.hasAny(s));
+	}
+
+	public void testHasAllFlag() throws Exception {
+		final RevCommit a = commit();
+		final RevFlag flag1 = rw.newFlag("flag1");
+		final RevFlag flag2 = rw.newFlag("flag2");
+		final RevFlagSet s = new RevFlagSet();
+		s.add(flag1);
+		s.add(flag2);
+
+		assertFalse(a.hasAll(s));
+		a.flags |= flag1.mask;
+		assertFalse(a.hasAll(s));
+		a.flags |= flag2.mask;
+		assertTrue(a.hasAll(s));
+	}
+
+	public void testAddRevFlag() throws Exception {
+		final RevCommit a = commit();
+		final RevFlag flag1 = rw.newFlag("flag1");
+		final RevFlag flag2 = rw.newFlag("flag2");
+		assertEquals(0, a.flags);
+
+		a.add(flag1);
+		assertEquals(flag1.mask, a.flags);
+
+		a.add(flag2);
+		assertEquals(flag1.mask | flag2.mask, a.flags);
+	}
+
+	public void testAddRevFlagSet() throws Exception {
+		final RevCommit a = commit();
+		final RevFlag flag1 = rw.newFlag("flag1");
+		final RevFlag flag2 = rw.newFlag("flag2");
+		final RevFlagSet s = new RevFlagSet();
+		s.add(flag1);
+		s.add(flag2);
+
+		assertEquals(0, a.flags);
+
+		a.add(s);
+		assertEquals(flag1.mask | flag2.mask, a.flags);
+	}
+
+	public void testRemoveRevFlag() throws Exception {
+		final RevCommit a = commit();
+		final RevFlag flag1 = rw.newFlag("flag1");
+		final RevFlag flag2 = rw.newFlag("flag2");
+		a.add(flag1);
+		a.add(flag2);
+		assertEquals(flag1.mask | flag2.mask, a.flags);
+		a.remove(flag2);
+		assertEquals(flag1.mask, a.flags);
+	}
+
+	public void testRemoveRevFlagSet() throws Exception {
+		final RevCommit a = commit();
+		final RevFlag flag1 = rw.newFlag("flag1");
+		final RevFlag flag2 = rw.newFlag("flag2");
+		final RevFlag flag3 = rw.newFlag("flag3");
+		final RevFlagSet s = new RevFlagSet();
+		s.add(flag1);
+		s.add(flag2);
+		a.add(flag3);
+		a.add(s);
+		assertEquals(flag1.mask | flag2.mask | flag3.mask, a.flags);
+		a.remove(s);
+		assertEquals(flag3.mask, a.flags);
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
index f83be8d..501aa13 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
@@ -40,9 +40,11 @@
 import java.util.Date;
 
 import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectWriter;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.lib.Tree;
 
 /** Support for tests of the {@link RevWalk} class. */
@@ -67,6 +69,11 @@ protected void tick(final int secDelta) {
 		nowTick += secDelta * 1000L;
 	}
 
+	protected RevBlob blob(final String content) throws Exception {
+		return rw.lookupBlob(ow.writeBlob(content
+				.getBytes(Constants.CHARACTER_ENCODING)));
+	}
+
 	protected RevCommit commit(final RevCommit... parents) throws Exception {
 		return commit(1, parents);
 	}
@@ -83,6 +90,17 @@ protected RevCommit commit(final int secDelta, final RevCommit... parents)
 		return rw.lookupCommit(ow.writeCommit(c));
 	}
 
+	protected RevTag tag(final String name, final RevObject dst)
+			throws Exception {
+		final Tag t = new Tag(db);
+		t.setType(Constants.typeString(dst.getType()));
+		t.setObjId(dst.toObjectId());
+		t.setTag(name);
+		t.setTagger(new PersonIdent(jcommitter, new Date(nowTick)));
+		t.setMessage("");
+		return (RevTag) rw.lookupAny(ow.writeTag(t), Constants.OBJ_TAG);
+	}
+
 	protected <T extends RevObject> T parse(final T t) throws Exception {
 		rw.parse(t);
 		return t;
-- 
1.6.2.1.286.g8173
