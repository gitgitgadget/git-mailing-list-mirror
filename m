From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5 v2] Fix RevWalk with Linus Torvald's occasional
	bad commit date hack
Date: Fri, 13 Mar 2009 17:54:42 -0700
Message-ID: <20090314005442.GJ22920@spearce.org>
References: <1236910062-18476-5-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 01:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiIBw-000500-UO
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 01:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763333AbZCNAyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 20:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759636AbZCNAyq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 20:54:46 -0400
Received: from george.spearce.org ([209.20.77.23]:54343 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763315AbZCNAyo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 20:54:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8918E38211; Sat, 14 Mar 2009 00:54:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1236910062-18476-5-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113227>

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

 This version inverts the "n.commitTime <= last.commitTime",
 I confused myself and wrote it backwards.

 The next patch I'm going to send with the tests has a test for
 this condition, to verify its correct.

 .../org/spearce/jgit/revwalk/PendingGenerator.java |   51 ++++++++++++++++++--
 1 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
index 144e909..4e24431 100644
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
+						if (n != null && n.commitTime >= last.commitTime) {
+							// This is too close to call. The next commit we
+							// would pop is dated after the last one produced.
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
