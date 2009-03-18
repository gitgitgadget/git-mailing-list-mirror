From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/12] Add some basic logic tests for TreeFilter on RevWalk
Date: Tue, 17 Mar 2009 18:40:50 -0700
Message-ID: <1237340451-31562-12-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
 <1237340451-31562-2-git-send-email-spearce@spearce.org>
 <1237340451-31562-3-git-send-email-spearce@spearce.org>
 <1237340451-31562-4-git-send-email-spearce@spearce.org>
 <1237340451-31562-5-git-send-email-spearce@spearce.org>
 <1237340451-31562-6-git-send-email-spearce@spearce.org>
 <1237340451-31562-7-git-send-email-spearce@spearce.org>
 <1237340451-31562-8-git-send-email-spearce@spearce.org>
 <1237340451-31562-9-git-send-email-spearce@spearce.org>
 <1237340451-31562-10-git-send-email-spearce@spearce.org>
 <1237340451-31562-11-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpS-00052N-Uc
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbZCRBll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756822AbZCRBli
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:38 -0400
Received: from george.spearce.org ([209.20.77.23]:56680 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbZCRBlf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:41:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 52BBB38269; Wed, 18 Mar 2009 01:41:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 449AB3826B;
	Wed, 18 Mar 2009 01:40:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113560>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/revwalk/RevWalkPathFilter1Test.java       |  176 ++++++++++++++++++++
 1 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkPathFilter1Test.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkPathFilter1Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkPathFilter1Test.java
new file mode 100644
index 0000000..c74ab80
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkPathFilter1Test.java
@@ -0,0 +1,176 @@
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
+import java.util.Collections;
+
+import org.spearce.jgit.treewalk.filter.AndTreeFilter;
+import org.spearce.jgit.treewalk.filter.PathFilterGroup;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
+
+public class RevWalkPathFilter1Test extends RevWalkTestCase {
+	protected void filter(final String path) {
+		rw.setTreeFilter(AndTreeFilter.create(PathFilterGroup
+				.createFromStrings(Collections.singleton(path)),
+				TreeFilter.ANY_DIFF));
+	}
+
+	public void testEmpty_EmptyTree() throws Exception {
+		final RevCommit a = commit();
+		filter("a");
+		markStart(a);
+		assertNull(rw.next());
+	}
+
+	public void testEmpty_NoMatch() throws Exception {
+		final RevCommit a = commit(tree(file("0", blob("0"))));
+		filter("a");
+		markStart(a);
+		assertNull(rw.next());
+	}
+
+	public void testSimple1() throws Exception {
+		final RevCommit a = commit(tree(file("0", blob("0"))));
+		filter("0");
+		markStart(a);
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testEdits_MatchNone() throws Exception {
+		final RevCommit a = commit(tree(file("0", blob("a"))));
+		final RevCommit b = commit(tree(file("0", blob("b"))), a);
+		final RevCommit c = commit(tree(file("0", blob("c"))), b);
+		final RevCommit d = commit(tree(file("0", blob("d"))), c);
+		filter("a");
+		markStart(d);
+		assertNull(rw.next());
+	}
+
+	public void testEdits_MatchAll() throws Exception {
+		final RevCommit a = commit(tree(file("0", blob("a"))));
+		final RevCommit b = commit(tree(file("0", blob("b"))), a);
+		final RevCommit c = commit(tree(file("0", blob("c"))), b);
+		final RevCommit d = commit(tree(file("0", blob("d"))), c);
+		filter("0");
+		markStart(d);
+		assertCommit(d, rw.next());
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testStringOfPearls_FilePath1() throws Exception {
+		final RevCommit a = commit(tree(file("d/f", blob("a"))));
+		final RevCommit b = commit(tree(file("d/f", blob("a"))), a);
+		final RevCommit c = commit(tree(file("d/f", blob("b"))), b);
+		filter("d/f");
+		markStart(c);
+
+		assertCommit(c, rw.next());
+		assertEquals(1, c.getParentCount());
+		assertCommit(a, c.getParent(0)); // b was skipped
+
+		assertCommit(a, rw.next());
+		assertEquals(0, a.getParentCount());
+		assertNull(rw.next());
+	}
+
+	public void testStringOfPearls_FilePath2() throws Exception {
+		final RevCommit a = commit(tree(file("d/f", blob("a"))));
+		final RevCommit b = commit(tree(file("d/f", blob("a"))), a);
+		final RevCommit c = commit(tree(file("d/f", blob("b"))), b);
+		final RevCommit d = commit(tree(file("d/f", blob("b"))), c);
+		filter("d/f");
+		markStart(d);
+
+		// d was skipped
+		assertCommit(c, rw.next());
+		assertEquals(1, c.getParentCount());
+		assertCommit(a, c.getParent(0)); // b was skipped
+
+		assertCommit(a, rw.next());
+		assertEquals(0, a.getParentCount());
+		assertNull(rw.next());
+	}
+
+	public void testStringOfPearls_DirPath2() throws Exception {
+		final RevCommit a = commit(tree(file("d/f", blob("a"))));
+		final RevCommit b = commit(tree(file("d/f", blob("a"))), a);
+		final RevCommit c = commit(tree(file("d/f", blob("b"))), b);
+		final RevCommit d = commit(tree(file("d/f", blob("b"))), c);
+		filter("d");
+		markStart(d);
+
+		// d was skipped
+		assertCommit(c, rw.next());
+		assertEquals(1, c.getParentCount());
+		assertCommit(a, c.getParent(0)); // b was skipped
+
+		assertCommit(a, rw.next());
+		assertEquals(0, a.getParentCount());
+		assertNull(rw.next());
+	}
+
+	public void testStringOfPearls_FilePath3() throws Exception {
+		final RevCommit a = commit(tree(file("d/f", blob("a"))));
+		final RevCommit b = commit(tree(file("d/f", blob("a"))), a);
+		final RevCommit c = commit(tree(file("d/f", blob("b"))), b);
+		final RevCommit d = commit(tree(file("d/f", blob("b"))), c);
+		final RevCommit e = commit(tree(file("d/f", blob("b"))), d);
+		final RevCommit f = commit(tree(file("d/f", blob("b"))), e);
+		final RevCommit g = commit(tree(file("d/f", blob("b"))), f);
+		final RevCommit h = commit(tree(file("d/f", blob("b"))), g);
+		final RevCommit i = commit(tree(file("d/f", blob("c"))), h);
+		filter("d/f");
+		markStart(i);
+
+		assertCommit(i, rw.next());
+		assertEquals(1, i.getParentCount());
+		assertCommit(c, i.getParent(0)); // h..d was skipped
+
+		assertCommit(c, rw.next());
+		assertEquals(1, c.getParentCount());
+		assertCommit(a, c.getParent(0)); // b was skipped
+
+		assertCommit(a, rw.next());
+		assertEquals(0, a.getParentCount());
+		assertNull(rw.next());
+	}
+}
-- 
1.6.2.1.286.g8173
