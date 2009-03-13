From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] Remove the horribly stupid RevSort.START_ORDER
Date: Thu, 12 Mar 2009 19:07:40 -0700
Message-ID: <1236910062-18476-4-git-send-email-spearce@spearce.org>
References: <1236910062-18476-1-git-send-email-spearce@spearce.org>
 <1236910062-18476-2-git-send-email-spearce@spearce.org>
 <1236910062-18476-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhwqV-0006PX-DH
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 03:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbZCMCHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 22:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbZCMCHv
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 22:07:51 -0400
Received: from george.spearce.org ([209.20.77.23]:46992 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbZCMCHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 22:07:46 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E377838260; Fri, 13 Mar 2009 02:07:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7009F3821F;
	Fri, 13 Mar 2009 02:07:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.288.gc3f22
In-Reply-To: <1236910062-18476-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113134>

I must have been on crack the day I wrote 3b27268f49 ("Allow RevWalk
users to ask for FIFO style ordering").  Its a really bad idea.

Applications can get themselves into a situation where they process
one branch long before another, and then abort too early, before all
commits have been correctly flagged UNINTERESTING.

For example, given the graph:

  Z-A------------B
  |             /
  |    ---------
  \   /
   Q-R-S-T-U-V

If B is "interesting" and A,V are UNINTERESTING, without forcing the
commit timestamp ordering in the pending queue we wind up processing
all of B-Z, producing R,Q as "interesting" output in the process, and
terminate before S can even be parsed. Consequently we never push the
UNINTERESTING flag down onto R, and R,Q produced when they shouldn't.

We now require that the pending queue use a DateRevQueue instead of
the FIFORevQueue, so that in the above graph S must be parsed before
we can even consider R or A, even though R,A were reached earlier.
This of course still assumes there is no clock skew between S and R.
The next commit will address some limited clock skew issues.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/PendingGenerator.java |    8 +++-----
 .../src/org/spearce/jgit/revwalk/RevSort.java      |   11 -----------
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    6 +++---
 .../org/spearce/jgit/revwalk/StartGenerator.java   |    8 ++------
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
index 25b2966..144e909 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
@@ -62,7 +62,7 @@
 
 	private final RevWalk walker;
 
-	private final AbstractRevQueue pending;
+	private final DateRevQueue pending;
 
 	private final RevFilter filter;
 
@@ -70,7 +70,7 @@
 
 	boolean canDispose;
 
-	PendingGenerator(final RevWalk w, final AbstractRevQueue p,
+	PendingGenerator(final RevWalk w, final DateRevQueue p,
 			final RevFilter f, final int out) {
 		walker = w;
 		pending = p;
@@ -81,9 +81,7 @@ PendingGenerator(final RevWalk w, final AbstractRevQueue p,
 
 	@Override
 	int outputType() {
-		if (pending instanceof DateRevQueue)
-			return output | SORT_COMMIT_TIME_DESC;
-		return output;
+		return output | SORT_COMMIT_TIME_DESC;
 	}
 
 	@Override
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevSort.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevSort.java
index b0a03ad..8c3eaed 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevSort.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevSort.java
@@ -49,17 +49,6 @@
 	NONE,
 
 	/**
-	 * Maintain the order commits were marked as starting points.
-	 * <p>
-	 * This strategy is largely a FIFO strategy; commits are enumerated in the
-	 * order they were added to the RevWalk by the application. Parents not yet
-	 * visited are added behind all commits already enqueued for visiting.
-	 * <p>
-	 * This strategy should not be combined with {@link #COMMIT_TIME_DESC}.
-	 */
-	START_ORDER,
-
-	/**
 	 * Sort by commit time, descending (newest first, oldest last).
 	 * <p>
 	 * This strategy can be combined with {@link #TOPO}.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index c8ec458..316f722 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -187,7 +187,7 @@ public RevWalk(final Repository repo) {
 		idBuffer = new MutableObjectId();
 		objects = new ObjectIdSubclassMap<RevObject>();
 		roots = new ArrayList<RevCommit>();
-		queue = new FIFORevQueue();
+		queue = new DateRevQueue();
 		pending = new StartGenerator(this);
 		sorting = EnumSet.of(RevSort.NONE);
 		filter = RevFilter.ALL;
@@ -915,7 +915,7 @@ protected void reset(int retainFlags) {
 
 		curs.release();
 		roots.clear();
-		queue = new FIFORevQueue();
+		queue = new DateRevQueue();
 		pending = new StartGenerator(this);
 	}
 
@@ -934,7 +934,7 @@ public void dispose() {
 		objects.clear();
 		curs.release();
 		roots.clear();
-		queue = new FIFORevQueue();
+		queue = new DateRevQueue();
 		pending = new StartGenerator(this);
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
index 1b7947f..bf7067a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
@@ -108,11 +108,7 @@ RevCommit next() throws MissingObjectException,
 		}
 
 		int pendingOutputType = 0;
-		if (walker.hasRevSort(RevSort.START_ORDER)
-				&& !(q instanceof FIFORevQueue))
-			q = new FIFORevQueue(q);
-		if (walker.hasRevSort(RevSort.COMMIT_TIME_DESC)
-				&& !(q instanceof DateRevQueue))
+		if (!(q instanceof DateRevQueue))
 			q = new DateRevQueue(q);
 		if (tf != TreeFilter.ALL) {
 			rf = AndRevFilter.create(rf, new RewriteTreeFilter(w, tf));
@@ -120,7 +116,7 @@ RevCommit next() throws MissingObjectException,
 		}
 
 		walker.queue = q;
-		g = new PendingGenerator(w, q, rf, pendingOutputType);
+		g = new PendingGenerator(w, (DateRevQueue) q, rf, pendingOutputType);
 
 		if (boundary) {
 			// Because the boundary generator may produce uninteresting
-- 
1.6.2.288.gc3f22
