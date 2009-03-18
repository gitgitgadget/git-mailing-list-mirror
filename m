From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/12] Add unit tests for FIFORevQueue
Date: Tue, 17 Mar 2009 18:40:45 -0700
Message-ID: <1237340451-31562-7-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
 <1237340451-31562-2-git-send-email-spearce@spearce.org>
 <1237340451-31562-3-git-send-email-spearce@spearce.org>
 <1237340451-31562-4-git-send-email-spearce@spearce.org>
 <1237340451-31562-5-git-send-email-spearce@spearce.org>
 <1237340451-31562-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpP-00052N-Ic
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798AbZCRBl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756751AbZCRBl0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:26 -0400
Received: from george.spearce.org ([209.20.77.23]:56669 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756726AbZCRBlY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:41:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6625338262; Wed, 18 Mar 2009 01:41:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 94A7138265;
	Wed, 18 Mar 2009 01:40:53 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113558>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/FIFORevQueueTest.java |   81 ++++++++++++++++++++
 .../org/spearce/jgit/revwalk/BlockRevQueue.java    |    2 +-
 2 files changed, 82 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FIFORevQueueTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FIFORevQueueTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FIFORevQueueTest.java
new file mode 100644
index 0000000..99ee031
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/FIFORevQueueTest.java
@@ -0,0 +1,81 @@
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
+import java.util.ArrayList;
+
+public class FIFORevQueueTest extends RevQueueTestCase<FIFORevQueue> {
+	protected FIFORevQueue create() {
+		return new FIFORevQueue();
+	}
+
+	public void testEmpty() throws Exception {
+		super.testEmpty();
+		assertEquals(0, q.outputType());
+	}
+
+	public void testCloneEmpty() throws Exception {
+		q = new FIFORevQueue(AbstractRevQueue.EMPTY_QUEUE);
+		assertNull(q.next());
+	}
+
+	public void testAddLargeBlocks() throws Exception {
+		final ArrayList<RevCommit> lst = new ArrayList<RevCommit>();
+		for (int i = 0; i < 3 * BlockRevQueue.Block.BLOCK_SIZE; i++) {
+			final RevCommit c = commit();
+			lst.add(c);
+			q.add(c);
+		}
+		for (int i = 0; i < lst.size(); i++)
+			assertSame(lst.get(i), q.next());
+	}
+
+	public void testUnpopAtFront() throws Exception {
+		final RevCommit a = commit();
+		final RevCommit b = commit();
+		final RevCommit c = commit();
+
+		q.add(a);
+		q.unpop(b);
+		q.unpop(c);
+
+		assertSame(c, q.next());
+		assertSame(b, q.next());
+		assertSame(a, q.next());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/BlockRevQueue.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/BlockRevQueue.java
index 9660de8..8c0e46d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/BlockRevQueue.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/BlockRevQueue.java
@@ -104,7 +104,7 @@ void clear() {
 	}
 
 	static final class Block {
-		private static final int BLOCK_SIZE = 256;
+		static final int BLOCK_SIZE = 256;
 
 		/** Next block in our chain of blocks; null if we are the last. */
 		Block next;
-- 
1.6.2.1.286.g8173
