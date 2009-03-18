From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/12] Change RevWalkTestCase to use RevCommit, not ObjectId
Date: Tue, 17 Mar 2009 18:40:42 -0700
Message-ID: <1237340451-31562-4-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
 <1237340451-31562-2-git-send-email-spearce@spearce.org>
 <1237340451-31562-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpN-00052N-9a
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705AbZCRBlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756669AbZCRBlT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:19 -0400
Received: from george.spearce.org ([209.20.77.23]:56663 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbZCRBlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:41:18 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 206A2382A1; Wed, 18 Mar 2009 01:41:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8861638221;
	Wed, 18 Mar 2009 01:40:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113556>

We build a RevWalk once per test, and only execute a single traversal
in that test run.  Its more clear to use the RevCommit type from that
object pool to represent a commit entity than the generic ObjectId.

When creating a new commit we allocate its RevCommit from the pool,
but we delay parsing until as late as necessary.  This is needed for
at least one test where it validates whether or not the parents of a
commit were allocated after traversal finishes.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/RevWalkCullTest.java  |   28 +++---
 .../spearce/jgit/revwalk/RevWalkFilterTest.java    |   91 ++++++++++----------
 .../spearce/jgit/revwalk/RevWalkMergeBaseTest.java |   45 +++++-----
 .../org/spearce/jgit/revwalk/RevWalkSortTest.java  |   64 +++++++-------
 .../org/spearce/jgit/revwalk/RevWalkTestCase.java  |   30 +++---
 5 files changed, 126 insertions(+), 132 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java
index e734273..2f61598 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java
@@ -37,8 +37,6 @@
 
 package org.spearce.jgit.revwalk;
 
-import org.spearce.jgit.lib.ObjectId;
-
 public class RevWalkCullTest extends RevWalkTestCase {
 	public void testProperlyCullAllAncestors1() throws Exception {
 		// Credit goes to Junio C Hamano <gitster@pobox.com> for this
@@ -46,10 +44,10 @@ public void testProperlyCullAllAncestors1() throws Exception {
 		//
 		// We induce a clock skew so two is dated before one.
 		//
-		final ObjectId a = commit();
-		final ObjectId b = commit(-2400, a);
-		final ObjectId c = commit(b);
-		final ObjectId d = commit(c);
+		final RevCommit a = commit();
+		final RevCommit b = commit(-2400, a);
+		final RevCommit c = commit(b);
+		final RevCommit d = commit(c);
 
 		markStart(a);
 		markUninteresting(d);
@@ -60,11 +58,11 @@ public void testProperlyCullAllAncestors2() throws Exception {
 		// Despite clock skew on c1 being very old it should not
 		// produce, neither should a or b, or any part of that chain.
 		//
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c1 = commit(-5, b);
-		final ObjectId c2 = commit(10, b);
-		final ObjectId d = commit(c1, c2);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c1 = commit(-5, b);
+		final RevCommit c2 = commit(10, b);
+		final RevCommit d = commit(c1, c2);
 
 		markStart(d);
 		markUninteresting(c1);
@@ -74,14 +72,14 @@ public void testProperlyCullAllAncestors2() throws Exception {
 	}
 
 	public void testProperlyCullAllAncestors_LongHistory() throws Exception {
-		final ObjectId a = commit();
-		ObjectId b = commit(a);
+		final RevCommit a = commit();
+		RevCommit b = commit(a);
 		for (int i = 0; i < 24; i++) {
 			b = commit(b);
 			if ((i & 2) == 0)
 				markUninteresting(b);
 		}
-		final ObjectId c = commit(b);
+		final RevCommit c = commit(b);
 
 		markStart(c);
 		markUninteresting(b);
@@ -91,6 +89,6 @@ public void testProperlyCullAllAncestors_LongHistory() throws Exception {
 		// We should have aborted before we got back so far that "a"
 		// would be parsed. Thus, its parents shouldn't be allocated.
 		//
-		assertNull(rw.lookupCommit(a).parents);
+		assertNull(a.parents);
 	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
index d079bdc..6a26d2e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
@@ -42,7 +42,6 @@
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.errors.StopWalkException;
-import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.revwalk.filter.AndRevFilter;
 import org.spearce.jgit.revwalk.filter.NotRevFilter;
 import org.spearce.jgit.revwalk.filter.OrRevFilter;
@@ -52,9 +51,9 @@
 	private static final MyAll MY_ALL = new MyAll();
 
 	public void testFilter_ALL() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(RevFilter.ALL);
 		markStart(c);
@@ -65,9 +64,9 @@ public void testFilter_ALL() throws Exception {
 	}
 
 	public void testFilter_Negate_ALL() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(RevFilter.ALL.negate());
 		markStart(c);
@@ -75,9 +74,9 @@ public void testFilter_Negate_ALL() throws Exception {
 	}
 
 	public void testFilter_NOT_ALL() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(NotRevFilter.create(RevFilter.ALL));
 		markStart(c);
@@ -85,9 +84,9 @@ public void testFilter_NOT_ALL() throws Exception {
 	}
 
 	public void testFilter_NONE() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(RevFilter.NONE);
 		markStart(c);
@@ -95,9 +94,9 @@ public void testFilter_NONE() throws Exception {
 	}
 
 	public void testFilter_NOT_NONE() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(NotRevFilter.create(RevFilter.NONE));
 		markStart(c);
@@ -108,9 +107,9 @@ public void testFilter_NOT_NONE() throws Exception {
 	}
 
 	public void testFilter_ALL_And_NONE() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(AndRevFilter.create(RevFilter.ALL, RevFilter.NONE));
 		markStart(c);
@@ -118,9 +117,9 @@ public void testFilter_ALL_And_NONE() throws Exception {
 	}
 
 	public void testFilter_NONE_And_ALL() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(AndRevFilter.create(RevFilter.NONE, RevFilter.ALL));
 		markStart(c);
@@ -128,9 +127,9 @@ public void testFilter_NONE_And_ALL() throws Exception {
 	}
 
 	public void testFilter_ALL_Or_NONE() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(OrRevFilter.create(RevFilter.ALL, RevFilter.NONE));
 		markStart(c);
@@ -141,9 +140,9 @@ public void testFilter_ALL_Or_NONE() throws Exception {
 	}
 
 	public void testFilter_NONE_Or_ALL() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(OrRevFilter.create(RevFilter.NONE, RevFilter.ALL));
 		markStart(c);
@@ -154,9 +153,9 @@ public void testFilter_NONE_Or_ALL() throws Exception {
 	}
 
 	public void testFilter_MY_ALL_And_NONE() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(AndRevFilter.create(MY_ALL, RevFilter.NONE));
 		markStart(c);
@@ -164,9 +163,9 @@ public void testFilter_MY_ALL_And_NONE() throws Exception {
 	}
 
 	public void testFilter_NONE_And_MY_ALL() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(AndRevFilter.create(RevFilter.NONE, MY_ALL));
 		markStart(c);
@@ -174,9 +173,9 @@ public void testFilter_NONE_And_MY_ALL() throws Exception {
 	}
 
 	public void testFilter_MY_ALL_Or_NONE() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(OrRevFilter.create(MY_ALL, RevFilter.NONE));
 		markStart(c);
@@ -187,9 +186,9 @@ public void testFilter_MY_ALL_Or_NONE() throws Exception {
 	}
 
 	public void testFilter_NONE_Or_MY_ALL() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
 
 		rw.setRevFilter(OrRevFilter.create(RevFilter.NONE, MY_ALL));
 		markStart(c);
@@ -200,12 +199,12 @@ public void testFilter_NONE_Or_MY_ALL() throws Exception {
 	}
 
 	public void testFilter_NO_MERGES() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c1 = commit(b);
-		final ObjectId c2 = commit(b);
-		final ObjectId d = commit(c1, c2);
-		final ObjectId e = commit(d);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c1 = commit(b);
+		final RevCommit c2 = commit(b);
+		final RevCommit d = commit(c1, c2);
+		final RevCommit e = commit(d);
 
 		rw.setRevFilter(RevFilter.NO_MERGES);
 		markStart(e);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
index cec4e3f..fc1a37c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
@@ -37,13 +37,12 @@
 
 package org.spearce.jgit.revwalk;
 
-import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.revwalk.filter.RevFilter;
 
 public class RevWalkMergeBaseTest extends RevWalkTestCase {
 	public void testNone() throws Exception {
-		final ObjectId c1 = commit(commit(commit()));
-		final ObjectId c2 = commit(commit(commit()));
+		final RevCommit c1 = commit(commit(commit()));
+		final RevCommit c2 = commit(commit(commit()));
 
 		rw.setRevFilter(RevFilter.MERGE_BASE);
 		markStart(c1);
@@ -52,10 +51,10 @@ public void testNone() throws Exception {
 	}
 
 	public void testSimple() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c1 = commit(commit(commit(commit(commit(b)))));
-		final ObjectId c2 = commit(commit(commit(commit(commit(b)))));
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c1 = commit(commit(commit(commit(commit(b)))));
+		final RevCommit c2 = commit(commit(commit(commit(commit(b)))));
 
 		rw.setRevFilter(RevFilter.MERGE_BASE);
 		markStart(c1);
@@ -65,11 +64,11 @@ public void testSimple() throws Exception {
 	}
 
 	public void testMultipleHeads_SameBase1() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c1 = commit(commit(commit(commit(commit(b)))));
-		final ObjectId c2 = commit(commit(commit(commit(commit(b)))));
-		final ObjectId c3 = commit(commit(commit(b)));
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c1 = commit(commit(commit(commit(commit(b)))));
+		final RevCommit c2 = commit(commit(commit(commit(commit(b)))));
+		final RevCommit c3 = commit(commit(commit(b)));
 
 		rw.setRevFilter(RevFilter.MERGE_BASE);
 		markStart(c1);
@@ -80,12 +79,12 @@ public void testMultipleHeads_SameBase1() throws Exception {
 	}
 
 	public void testMultipleHeads_SameBase2() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
-		final ObjectId d1 = commit(commit(commit(commit(commit(b)))));
-		final ObjectId d2 = commit(commit(commit(commit(commit(c)))));
-		final ObjectId d3 = commit(commit(commit(c)));
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
+		final RevCommit d1 = commit(commit(commit(commit(commit(b)))));
+		final RevCommit d2 = commit(commit(commit(commit(commit(c)))));
+		final RevCommit d3 = commit(commit(commit(c)));
 
 		rw.setRevFilter(RevFilter.MERGE_BASE);
 		markStart(d1);
@@ -101,11 +100,11 @@ public void testCrissCross() throws Exception {
 		// clean merge base for d,e as they each merged the parents b,c
 		// in different orders.
 		//
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(a);
-		final ObjectId d = commit(b, c);
-		final ObjectId e = commit(c, b);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(a);
+		final RevCommit d = commit(b, c);
+		final RevCommit e = commit(c, b);
 
 		rw.setRevFilter(RevFilter.MERGE_BASE);
 		markStart(d);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java
index 3ed1565..7435197 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java
@@ -37,14 +37,12 @@
 
 package org.spearce.jgit.revwalk;
 
-import org.spearce.jgit.lib.ObjectId;
-
 public class RevWalkSortTest extends RevWalkTestCase {
 	public void testSort_Default() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(1, a);
-		final ObjectId c = commit(1, b);
-		final ObjectId d = commit(1, c);
+		final RevCommit a = commit();
+		final RevCommit b = commit(1, a);
+		final RevCommit c = commit(1, b);
+		final RevCommit d = commit(1, c);
 
 		markStart(d);
 		assertCommit(d, rw.next());
@@ -55,10 +53,10 @@ public void testSort_Default() throws Exception {
 	}
 
 	public void testSort_COMMIT_TIME_DESC() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
-		final ObjectId d = commit(c);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
+		final RevCommit d = commit(c);
 
 		rw.sort(RevSort.COMMIT_TIME_DESC);
 		markStart(d);
@@ -70,10 +68,10 @@ public void testSort_COMMIT_TIME_DESC() throws Exception {
 	}
 
 	public void testSort_REVERSE() throws Exception {
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(b);
-		final ObjectId d = commit(c);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(b);
+		final RevCommit d = commit(c);
 
 		rw.sort(RevSort.REVERSE);
 		markStart(d);
@@ -88,10 +86,10 @@ public void testSort_COMMIT_TIME_DESC_OutOfOrder1() throws Exception {
 		// Despite being out of order time-wise, a strand-of-pearls must
 		// still maintain topological order.
 		//
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c = commit(-5, b);
-		final ObjectId d = commit(10, c);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c = commit(-5, b);
+		final RevCommit d = commit(10, c);
 		assertTrue(parse(a).getCommitTime() < parse(d).getCommitTime());
 		assertTrue(parse(c).getCommitTime() < parse(b).getCommitTime());
 
@@ -107,11 +105,11 @@ public void testSort_COMMIT_TIME_DESC_OutOfOrder1() throws Exception {
 	public void testSort_COMMIT_TIME_DESC_OutOfOrder2() throws Exception {
 		// c1 is back dated before its parent.
 		//
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c1 = commit(-5, b);
-		final ObjectId c2 = commit(10, b);
-		final ObjectId d = commit(c1, c2);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c1 = commit(-5, b);
+		final RevCommit c2 = commit(10, b);
+		final RevCommit d = commit(c1, c2);
 
 		rw.sort(RevSort.COMMIT_TIME_DESC);
 		markStart(d);
@@ -126,11 +124,11 @@ public void testSort_COMMIT_TIME_DESC_OutOfOrder2() throws Exception {
 	public void testSort_TOPO() throws Exception {
 		// c1 is back dated before its parent.
 		//
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c1 = commit(-5, b);
-		final ObjectId c2 = commit(10, b);
-		final ObjectId d = commit(c1, c2);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c1 = commit(-5, b);
+		final RevCommit c2 = commit(10, b);
+		final RevCommit d = commit(c1, c2);
 
 		rw.sort(RevSort.TOPO);
 		markStart(d);
@@ -145,11 +143,11 @@ public void testSort_TOPO() throws Exception {
 	public void testSort_TOPO_REVERSE() throws Exception {
 		// c1 is back dated before its parent.
 		//
-		final ObjectId a = commit();
-		final ObjectId b = commit(a);
-		final ObjectId c1 = commit(-5, b);
-		final ObjectId c2 = commit(10, b);
-		final ObjectId d = commit(c1, c2);
+		final RevCommit a = commit();
+		final RevCommit b = commit(a);
+		final RevCommit c1 = commit(-5, b);
+		final RevCommit c2 = commit(10, b);
+		final RevCommit d = commit(c1, c2);
 
 		rw.sort(RevSort.TOPO);
 		rw.sort(RevSort.REVERSE, true);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
index a477be9..f83be8d 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
@@ -40,7 +40,6 @@
 import java.util.Date;
 
 import org.spearce.jgit.lib.Commit;
-import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ObjectWriter;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.RepositoryTestCase;
@@ -50,7 +49,7 @@
 public abstract class RevWalkTestCase extends RepositoryTestCase {
 	protected ObjectWriter ow;
 
-	protected ObjectId emptyTree;
+	protected RevTree emptyTree;
 
 	protected long nowTick;
 
@@ -59,20 +58,20 @@
 	public void setUp() throws Exception {
 		super.setUp();
 		ow = new ObjectWriter(db);
-		emptyTree = ow.writeTree(new Tree(db));
-		nowTick = 1236977987000L;
 		rw = new RevWalk(db);
+		emptyTree = rw.parseTree(ow.writeTree(new Tree(db)));
+		nowTick = 1236977987000L;
 	}
 
 	protected void tick(final int secDelta) {
 		nowTick += secDelta * 1000L;
 	}
 
-	protected ObjectId commit(final ObjectId... parents) throws Exception {
+	protected RevCommit commit(final RevCommit... parents) throws Exception {
 		return commit(1, parents);
 	}
 
-	protected ObjectId commit(final int secDelta, final ObjectId... parents)
+	protected RevCommit commit(final int secDelta, final RevCommit... parents)
 			throws Exception {
 		tick(secDelta);
 		final Commit c = new Commit(db);
@@ -81,22 +80,23 @@ protected ObjectId commit(final int secDelta, final ObjectId... parents)
 		c.setAuthor(new PersonIdent(jauthor, new Date(nowTick)));
 		c.setCommitter(new PersonIdent(jcommitter, new Date(nowTick)));
 		c.setMessage("");
-		return ow.writeCommit(c);
+		return rw.lookupCommit(ow.writeCommit(c));
 	}
 
-	protected RevCommit parse(final ObjectId commitId) throws Exception {
-		return rw.parseCommit(commitId);
+	protected <T extends RevObject> T parse(final T t) throws Exception {
+		rw.parse(t);
+		return t;
 	}
 
-	protected void markStart(final ObjectId commitId) throws Exception {
-		rw.markStart(parse(commitId));
+	protected void markStart(final RevCommit commit) throws Exception {
+		rw.markStart(commit);
 	}
 
-	protected void markUninteresting(final ObjectId commitId) throws Exception {
-		rw.markUninteresting(parse(commitId));
+	protected void markUninteresting(final RevCommit commit) throws Exception {
+		rw.markUninteresting(commit);
 	}
 
-	protected void assertCommit(final ObjectId commitId, final RevCommit commit) {
-		assertEquals(commitId.name(), commit != null ? commit.name() : null);
+	protected void assertCommit(final RevCommit exp, final RevCommit act) {
+		assertSame(exp, act);
 	}
 }
-- 
1.6.2.1.286.g8173
