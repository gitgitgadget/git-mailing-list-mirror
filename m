From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/5] Avoid incorrect output of UNINTERESTING commits when clock skew occurs
Date: Thu, 12 Mar 2009 19:07:42 -0700
Message-ID: <1236910062-18476-6-git-send-email-spearce@spearce.org>
References: <1236910062-18476-1-git-send-email-spearce@spearce.org>
 <1236910062-18476-2-git-send-email-spearce@spearce.org>
 <1236910062-18476-3-git-send-email-spearce@spearce.org>
 <1236910062-18476-4-git-send-email-spearce@spearce.org>
 <1236910062-18476-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhwqW-0006PX-PQ
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 03:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbZCMCH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 22:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbZCMCH4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 22:07:56 -0400
Received: from george.spearce.org ([209.20.77.23]:46989 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbZCMCHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 22:07:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0A01938211; Fri, 13 Mar 2009 02:07:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1803038215;
	Fri, 13 Mar 2009 02:07:44 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.288.gc3f22
In-Reply-To: <1236910062-18476-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113135>

The prior commit added functionality to scan a few extra commits when
we otherwise would have aborted due to everything left being colored
UNINTERESTING.  When that happens we may wind up coloring a commit
that we already produced to the caller, giving the caller an incorrect
result set.

If we insert a fully buffered generator in the pipeline, such as that
used for RevSort.TOPO or RevSort.REVERSE, we can easily filter these
late-colored commits out before we show them to the application.  But
otherwise we delay the output by 6 commits, just long enough to give
PendingGenerator a reasonable chance at getting the coloring right.

This is only an approximation.  It is still possible for commits to
produce when they should be UNINTERESTING, such as if more than the
OVER_SCAN limit had clock skew between two branches and the common
merge base, even if we are fully buffering our output.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/DelayRevQueue.java    |   92 ++++++++++++++++++++
 .../jgit/revwalk/FixUninterestingGenerator.java    |   77 ++++++++++++++++
 .../org/spearce/jgit/revwalk/PendingGenerator.java |    2 +-
 .../org/spearce/jgit/revwalk/StartGenerator.java   |   23 ++++-
 4 files changed, 189 insertions(+), 5 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/revwalk/DelayRevQueue.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/revwalk/FixUninterestingGenerator.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/DelayRevQueue.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/DelayRevQueue.java
new file mode 100644
index 0000000..1eb7064
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/DelayRevQueue.java
@@ -0,0 +1,92 @@
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
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+
+/**
+ * Delays commits to be at least {@link PendingGenerator#OVER_SCAN} late.
+ * <p>
+ * This helps to "fix up" weird corner cases resulting from clock skew, by
+ * slowing down what we produce to the caller we get a better chance to ensure
+ * PendingGenerator reached back far enough in the graph to correctly mark
+ * commits {@link RevWalk#UNINTERESTING} if necessary.
+ * <p>
+ * This generator should appear before {@link FixUninterestingGenerator} if the
+ * lower level {@link #pending} isn't already fully buffered.
+ */
+final class DelayRevQueue extends Generator {
+	private static final int OVER_SCAN = PendingGenerator.OVER_SCAN;
+
+	private final Generator pending;
+
+	private final FIFORevQueue delay;
+
+	private int size;
+
+	DelayRevQueue(final Generator g) {
+		pending = g;
+		delay = new FIFORevQueue();
+	}
+
+	@Override
+	int outputType() {
+		return pending.outputType();
+	}
+
+	@Override
+	RevCommit next() throws MissingObjectException,
+			IncorrectObjectTypeException, IOException {
+		while (size < OVER_SCAN) {
+			final RevCommit c = pending.next();
+			if (c == null)
+				break;
+			delay.add(c);
+			size++;
+		}
+
+		final RevCommit c = delay.next();
+		if (c == null)
+			return null;
+		size--;
+		return c;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/FixUninterestingGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FixUninterestingGenerator.java
new file mode 100644
index 0000000..6a9ba61
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FixUninterestingGenerator.java
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
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+
+/**
+ * Filters out commits marked {@link RevWalk#UNINTERESTING}.
+ * <p>
+ * This generator is only in front of another generator that has fully buffered
+ * commits, such that we are called only after the {@link PendingGenerator} has
+ * exhausted its input queue and given up. It skips over any uninteresting
+ * commits that may have leaked out of the PendingGenerator due to clock skew
+ * being detected in the commit objects.
+ */
+final class FixUninterestingGenerator extends Generator {
+	private final Generator pending;
+
+	FixUninterestingGenerator(final Generator g) {
+		pending = g;
+	}
+
+	@Override
+	int outputType() {
+		return pending.outputType();
+	}
+
+	@Override
+	RevCommit next() throws MissingObjectException,
+			IncorrectObjectTypeException, IOException {
+		for (;;) {
+			final RevCommit c = pending.next();
+			if (c == null)
+				return null;
+			if ((c.flags & RevWalk.UNINTERESTING) == 0)
+				return c;
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
index cd24e8f..ebbb39f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
@@ -69,7 +69,7 @@
 	 * constant to 1 additional commit due to the use of a pre-increment
 	 * operator when accessing the value.
 	 */
-	private static final int OVER_SCAN = 5 + 1;
+	static final int OVER_SCAN = 5 + 1;
 
 	/** A commit near the end of time, to initialize {@link #last} with. */
 	private static final RevCommit INIT_LAST;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
index bf7067a..3535250 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
@@ -90,6 +90,7 @@ RevCommit next() throws MissingObjectException,
 			return mbg.next();
 		}
 
+		final boolean uninteresting = q.anybodyHasFlag(RevWalk.UNINTERESTING);
 		boolean boundary = walker.hasRevSort(RevSort.BOUNDARY);
 
 		if (!boundary && walker instanceof ObjectWalk) {
@@ -99,7 +100,7 @@ RevCommit next() throws MissingObjectException,
 			//
 			boundary = true;
 		}
-		if (boundary && !q.anybodyHasFlag(RevWalk.UNINTERESTING)) {
+		if (boundary && !uninteresting) {
 			// If we were not fed uninteresting commits we will never
 			// construct a boundary. There is no reason to include the
 			// extra overhead associated with that in our pipeline.
@@ -107,16 +108,19 @@ RevCommit next() throws MissingObjectException,
 			boundary = false;
 		}
 
+		final DateRevQueue pending;
 		int pendingOutputType = 0;
-		if (!(q instanceof DateRevQueue))
-			q = new DateRevQueue(q);
+		if (q instanceof DateRevQueue)
+			pending = (DateRevQueue)q;
+		else
+			pending = new DateRevQueue(q);
 		if (tf != TreeFilter.ALL) {
 			rf = AndRevFilter.create(rf, new RewriteTreeFilter(w, tf));
 			pendingOutputType |= HAS_REWRITE | NEEDS_REWRITE;
 		}
 
 		walker.queue = q;
-		g = new PendingGenerator(w, (DateRevQueue) q, rf, pendingOutputType);
+		g = new PendingGenerator(w, pending, rf, pendingOutputType);
 
 		if (boundary) {
 			// Because the boundary generator may produce uninteresting
@@ -143,6 +147,17 @@ RevCommit next() throws MissingObjectException,
 			g = new LIFORevQueue(g);
 		if (boundary)
 			g = new BoundaryGenerator(w, g);
+		else if (uninteresting) {
+			// Try to protect ourselves from uninteresting commits producing
+			// due to clock skew in the commit time stamps. Delay such that
+			// we have a chance at coloring enough of the graph correctly,
+			// and then strip any UNINTERESTING nodes that may have leaked
+			// through early.
+			//
+			if (pending.peek() != null)
+				g = new DelayRevQueue(g);
+			g = new FixUninterestingGenerator(g);
+		}
 
 		w.pending = g;
 		return g.next();
-- 
1.6.2.288.gc3f22
