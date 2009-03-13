From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Fix RevWalk with Linus Torvald's occasional bad commit date hack
Date: Thu, 12 Mar 2009 19:07:41 -0700
Message-ID: <1236910062-18476-5-git-send-email-spearce@spearce.org>
References: <1236910062-18476-1-git-send-email-spearce@spearce.org>
 <1236910062-18476-2-git-send-email-spearce@spearce.org>
 <1236910062-18476-3-git-send-email-spearce@spearce.org>
 <1236910062-18476-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhwqW-0006PX-2e
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 03:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbZCMCH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 22:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbZCMCHy
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 22:07:54 -0400
Received: from george.spearce.org ([209.20.77.23]:46995 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZCMCHr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 22:07:47 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A2AA938221; Fri, 13 Mar 2009 02:07:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id BEFC238211;
	Fri, 13 Mar 2009 02:07:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.288.gc3f22
In-Reply-To: <1236910062-18476-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113133>

In git-core commit 7d004199d134c9d465e013064f72dbc04507f6c0 Linus
describes a hack he created to improve the handling of cases where
commit dates are out of order, such as a child commit having a date
older than its parent.  These cases can show up when there is bad
imported data, or significant clock skew between distributed peers.

The original git-core bug report identified a failure in:

  git rev-list A..B C

where commits contained in both A and B were reported, due to out
of order commit dates.

We keep running until the most recent commit in the pending queue
is more recent than the last commit sent to the caller.  If the
pending queue suddenly goes "backwards" due to one of our parent's
having a more recent commit date, this new check ensures we will
keep processing the graph until we see a more consistent cut.

We process an extra OVER_SCAN commits after we decide that all
remaining commits are UNINTERESTING.  Processing these extra
commits ensures flags are carried back further in the graph,
increasing the chances that we correctly mark relevant nodes.

As a result of this hack, we may produce a commit to our caller,
but then later mark it UNINTERESTING if we discover date skew.
To handle such cases, callers could buffer produced commits and
filter out those that are UNINTERESTING, but this somewhat costly
and may not always be necessary.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/PendingGenerator.java |   51 ++++++++++++++++++--
 1 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
index 144e909..cd24e8f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
@@ -42,6 +42,7 @@
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.errors.StopWalkException;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.revwalk.filter.RevFilter;
 
 /**
@@ -60,6 +61,24 @@
 
 	private static final int UNINTERESTING = RevWalk.UNINTERESTING;
 
+	/**
+	 * Number of additional commits to scan after we think we are done.
+	 * <p>
+	 * This small buffer of commits is scanned to ensure we didn't miss anything
+	 * as a result of clock skew when the commits were made. We need to set our
+	 * constant to 1 additional commit due to the use of a pre-increment
+	 * operator when accessing the value.
+	 */
+	private static final int OVER_SCAN = 5 + 1;
+
+	/** A commit near the end of time, to initialize {@link #last} with. */
+	private static final RevCommit INIT_LAST;
+
+	static {
+		INIT_LAST = new RevCommit(ObjectId.zeroId());
+		INIT_LAST.commitTime = Integer.MAX_VALUE;
+	}
+
 	private final RevWalk walker;
 
 	private final DateRevQueue pending;
@@ -68,6 +87,17 @@
 
 	private final int output;
 
+	/** Last commit produced to the caller from {@link #next()}. */
+	private RevCommit last = INIT_LAST;
+
+	/**
+	 * Number of commits we have remaining in our over-scan allotment.
+	 * <p>
+	 * Only relevant if there are {@link #UNINTERESTING} commits in the
+	 * {@link #pending} queue.
+	 */
+	private int overScan = OVER_SCAN;
+
 	boolean canDispose;
 
 	PendingGenerator(final RevWalk w, final DateRevQueue p,
@@ -112,14 +142,27 @@ RevCommit next() throws MissingObjectException,
 				walker.carryFlagsImpl(c);
 
 				if ((c.flags & UNINTERESTING) != 0) {
-					if (pending.everbodyHasFlag(UNINTERESTING))
-						throw StopWalkException.INSTANCE;
-					c.dispose();
+					if (pending.everbodyHasFlag(UNINTERESTING)) {
+						final RevCommit n = pending.peek();
+						if (n != null && n.commitTime <= last.commitTime) {
+							// This is too close to call. The next commit we
+							// would pop is before the last one we produced.
+							// We have to keep going to ensure that we carry
+							// flags as much as necessary.
+							//
+							overScan = OVER_SCAN;
+						} else if (--overScan == 0)
+							throw StopWalkException.INSTANCE;
+					} else {
+						overScan = OVER_SCAN;
+					}
+					if (canDispose)
+						c.dispose();
 					continue;
 				}
 
 				if (produce)
-					return c;
+					return last = c;
 				else if (canDispose)
 					c.dispose();
 			}
-- 
1.6.2.288.gc3f22
