From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/12] Add unit tests for DateRevQueue
Date: Tue, 17 Mar 2009 18:40:44 -0700
Message-ID: <1237340451-31562-6-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
 <1237340451-31562-2-git-send-email-spearce@spearce.org>
 <1237340451-31562-3-git-send-email-spearce@spearce.org>
 <1237340451-31562-4-git-send-email-spearce@spearce.org>
 <1237340451-31562-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpO-00052N-TC
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740AbZCRBl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756734AbZCRBlZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:25 -0400
Received: from george.spearce.org ([209.20.77.23]:56667 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699AbZCRBlX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:41:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id ECBB738222; Wed, 18 Mar 2009 01:41:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4FEF338262;
	Wed, 18 Mar 2009 01:40:53 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113562>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/DateRevQueueTest.java |  118 ++++++++++++++++++++
 .../org/spearce/jgit/revwalk/RevQueueTestCase.java |   85 ++++++++++++++
 2 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/DateRevQueueTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevQueueTestCase.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/DateRevQueueTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/DateRevQueueTest.java
new file mode 100644
index 0000000..c29fd55
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/DateRevQueueTest.java
@@ -0,0 +1,118 @@
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
+public class DateRevQueueTest extends RevQueueTestCase<DateRevQueue> {
+	protected DateRevQueue create() {
+		return new DateRevQueue();
+	}
+
+	public void testEmpty() throws Exception {
+		super.testEmpty();
+		assertNull(q.peek());
+		assertEquals(Generator.SORT_COMMIT_TIME_DESC, q.outputType());
+	}
+
+	public void testCloneEmpty() throws Exception {
+		q = new DateRevQueue(AbstractRevQueue.EMPTY_QUEUE);
+		assertNull(q.next());
+	}
+
+	public void testInsertOutOfOrder() throws Exception {
+		final RevCommit a = parse(commit());
+		final RevCommit b = parse(commit(10, a));
+		final RevCommit c1 = parse(commit(5, b));
+		final RevCommit c2 = parse(commit(-50, b));
+
+		q.add(c2);
+		q.add(a);
+		q.add(b);
+		q.add(c1);
+
+		assertCommit(c1, q.next());
+		assertCommit(b, q.next());
+		assertCommit(a, q.next());
+		assertCommit(c2, q.next());
+		assertNull(q.next());
+	}
+
+	public void testInsertTie() throws Exception {
+		final RevCommit a = parse(commit());
+		final RevCommit b = parse(commit(0, a));
+		{
+			q = create();
+			q.add(a);
+			q.add(b);
+
+			assertCommit(a, q.next());
+			assertCommit(b, q.next());
+			assertNull(q.next());
+		}
+		{
+			q = create();
+			q.add(b);
+			q.add(a);
+
+			assertCommit(b, q.next());
+			assertCommit(a, q.next());
+			assertNull(q.next());
+		}
+	}
+
+	public void testCloneFIFO() throws Exception {
+		final RevCommit a = parse(commit());
+		final RevCommit b = parse(commit(200, a));
+		final RevCommit c = parse(commit(200, b));
+
+		final FIFORevQueue src = new FIFORevQueue();
+		src.add(a);
+		src.add(b);
+		src.add(c);
+
+		q = new DateRevQueue(src);
+		assertFalse(q.everbodyHasFlag(RevWalk.UNINTERESTING));
+		assertFalse(q.anybodyHasFlag(RevWalk.UNINTERESTING));
+		assertCommit(c, q.peek());
+		assertCommit(c, q.peek());
+
+		assertCommit(c, q.next());
+		assertCommit(b, q.next());
+		assertCommit(a, q.next());
+		assertNull(q.next());
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevQueueTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevQueueTestCase.java
new file mode 100644
index 0000000..8b379d6
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevQueueTestCase.java
@@ -0,0 +1,85 @@
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
+public abstract class RevQueueTestCase<T extends AbstractRevQueue> extends
+		RevWalkTestCase {
+	protected T q;
+
+	public void setUp() throws Exception {
+		super.setUp();
+		q = create();
+	}
+
+	protected abstract T create();
+
+	public void testEmpty() throws Exception {
+		assertNull(q.next());
+		assertTrue(q.everbodyHasFlag(RevWalk.UNINTERESTING));
+		assertFalse(q.anybodyHasFlag(RevWalk.UNINTERESTING));
+	}
+
+	public void testClear() throws Exception {
+		final RevCommit a = parse(commit());
+		final RevCommit b = parse(commit(a));
+
+		q.add(a);
+		q.add(b);
+		q.clear();
+		assertNull(q.next());
+	}
+
+	public void testHasFlags() throws Exception {
+		final RevCommit a = parse(commit());
+		final RevCommit b = parse(commit(a));
+
+		q.add(a);
+		q.add(b);
+
+		assertFalse(q.everbodyHasFlag(RevWalk.UNINTERESTING));
+		assertFalse(q.anybodyHasFlag(RevWalk.UNINTERESTING));
+
+		a.flags |= RevWalk.UNINTERESTING;
+		assertFalse(q.everbodyHasFlag(RevWalk.UNINTERESTING));
+		assertTrue(q.anybodyHasFlag(RevWalk.UNINTERESTING));
+
+		b.flags |= RevWalk.UNINTERESTING;
+		assertTrue(q.everbodyHasFlag(RevWalk.UNINTERESTING));
+		assertTrue(q.anybodyHasFlag(RevWalk.UNINTERESTING));
+	}
+}
-- 
1.6.2.1.286.g8173
