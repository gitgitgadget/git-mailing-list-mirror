From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] git-rev-list: add --bisect-vars option.
Date: Wed, 21 Mar 2007 23:36:09 -0700
Message-ID: <7v7it9yecm.fsf_-_@assigned-by-dhcp.cox.net>
References: <20070317141209.GA7838@cepheus>
	<Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070317195840.GA20735@informatik.uni-freiburg.de>
	<20070321210454.GA2844@lala>
	<Pine.LNX.4.64.0703211521290.6730@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703220240590.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Uwe =?utf-8?Q?Kleine-?= =?utf-8?Q?K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 22 07:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUGvp-0001BJ-Py
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 07:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbXCVGhu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 02:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbXCVGhu
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 02:37:50 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64335 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbXCVGht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 02:37:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322063748.RGIO1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 22 Mar 2007 02:37:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id didn1W0151kojtg0000000; Thu, 22 Mar 2007 02:37:48 -0400
In-Reply-To: <Pine.LNX.4.63.0703220240590.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Mar 2007 02:43:18 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42841>

This adds --bisect-vars option to rev-list.  The output is suitable
for `eval` in shell and defines five variables:

 - bisect_rev is the next revision to test.
 - bisect_nr is the expected number of commits to test after
   bisect_rev is tested.
 - bisect_good is the expected number of commits to test
   if bisect_rev turns out to be good.
 - bisect_bad is the expected number of commits to test
   if bisect_rev turns out to be bad.
 - bisect_all is the number of commits we are bisecting right now.

The documentation text was partly stolen from Joahnnes
Schindelin's patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This comes first, on top of 'master', without any of my
   optimization hack.

 Documentation/git-rev-list.txt |   13 +++++++++
 builtin-rev-list.c             |   54 +++++++++++++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 4f145ea..3fa45b8 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -26,6 +26,7 @@ SYNOPSIS
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
+	     [ \--bisect-vars ]
 	     [ \--merge ]
 	     [ \--reverse ]
 	     [ \--walk-reflogs ]
@@ -249,6 +250,18 @@ introduces a regression is thus reduced to a binary search: repeatedly
 generate and test new 'midpoint's until the commit chain is of length
 one.
 
+--bisect-vars::
+
+This calculates the same as `--bisect`, but outputs text ready
+to be eval'ed by the shell. These lines will assign the name of
+the midpoint revision to the variable `bisect_rev`, and the
+expected number of commits to be tested after `bisect_rev` is
+tested to `bisect_nr`, the expected number of commits to be
+tested if `bisect_rev` turns out to be good to `bisect_good`,
+the expected number of commits to be tested if `bisect_rev`
+turns out to be bad to `bisect_bad`, and the number of commits
+we are bisecting right now to `bisect_all`.
+
 --
 
 Commit Ordering
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c2db5a5..723e4d4 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -36,7 +36,8 @@ static const char rev_list_usage[] =
 "    --abbrev=nr | --no-abbrev\n"
 "    --abbrev-commit\n"
 "  special purpose:\n"
-"    --bisect"
+"    --bisect\n"
+"    --bisect-vars"
 ;
 
 static struct rev_info revs;
@@ -168,7 +169,8 @@ static void clear_distance(struct commit_list *list)
 	}
 }
 
-static struct commit_list *find_bisection(struct commit_list *list)
+static struct commit_list *find_bisection(struct commit_list *list,
+					  int *reaches, int *all)
 {
 	int nr, closest;
 	struct commit_list *p, *best;
@@ -180,21 +182,23 @@ static struct commit_list *find_bisection(struct commit_list *list)
 			nr++;
 		p = p->next;
 	}
+	*all = nr;
 	closest = 0;
 	best = list;
 
 	for (p = list; p; p = p->next) {
-		int distance;
+		int distance, reach;
 
 		if (revs.prune_fn && !(p->item->object.flags & TREECHANGE))
 			continue;
 
-		distance = count_distance(p);
+		distance = reach = count_distance(p);
 		clear_distance(list);
 		if (nr - distance < distance)
 			distance = nr - distance;
 		if (distance > closest) {
 			best = p;
+			*reaches = reach;
 			closest = distance;
 		}
 	}
@@ -225,6 +229,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	struct commit_list *list;
 	int i;
 	int read_from_stdin = 0;
+	int bisect_show_vars = 0;
 
 	git_config(git_default_config);
 	init_revisions(&revs, prefix);
@@ -247,6 +252,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_list = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--bisect-vars")) {
+			bisect_list = 1;
+			bisect_show_vars = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--stdin")) {
 			if (read_from_stdin++)
 				die("--stdin given twice?");
@@ -285,8 +295,40 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.tree_objects)
 		mark_edges_uninteresting(revs.commits, &revs, show_edge);
 
-	if (bisect_list)
-		revs.commits = find_bisection(revs.commits);
+	if (bisect_list) {
+		int reaches = reaches, all = all;
+
+		revs.commits = find_bisection(revs.commits,
+					      &reaches, &all);
+		if (bisect_show_vars) {
+			int cnt;
+			if (!revs.commits)
+				return 1;
+			/*
+			 * revs.commits can reach "reaches" commits among
+			 * "all" commits.  If it is good, then there are
+			 * (all-reaches) commits left to be bisected.
+			 * On the other hand, if it is bad, then the set
+			 * to bisect is "reaches".
+			 * A bisect set of size N has (N-1) commits further
+			 * to test, as we already know one bad one.
+			 */
+			cnt = all-reaches;
+			if (cnt < reaches)
+				cnt = reaches;
+			printf("bisect_rev=%s\n"
+			       "bisect_nr=%d\n"
+			       "bisect_good=%d\n"
+			       "bisect_bad=%d\n"
+			       "bisect_all=%d\n",
+			       sha1_to_hex(revs.commits->item->object.sha1),
+			       cnt - 1,
+			       all - reaches - 1,
+			       reaches - 1,
+			       all);
+			return 0;
+		}
+	}
 
 	traverse_commit_list(&revs, show_commit, show_object);
 
-- 
1.5.1.rc1.610.g3ba7
