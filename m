From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] rev-list: fix --reverse interaction with --parents
Date: Fri, 29 Aug 2008 21:18:38 +0200
Message-ID: <1220037518-11219-1-git-send-email-trast@student.ethz.ch>
References: <48AD9786.80707@viscovery.net>
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 21:20:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ9Vg-00008g-Fd
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 21:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136AbYH2TSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 15:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbYH2TSn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 15:18:43 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:32643 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756044AbYH2TSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 15:18:42 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 21:18:37 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 21:18:37 +0200
X-Mailer: git-send-email 1.6.0.1.227.g9d66
In-Reply-To: <48AD9786.80707@viscovery.net>
X-OriginalArrivalTime: 29 Aug 2008 19:18:37.0918 (UTC) FILETIME=[09ECF7E0:01C90A0C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94317>

--reverse did not interact well with --parents, as the included test
case shows: in a history like

  A--B.
   \   \
    `C--M--D

the command

  git rev-list --reverse --parents --full-history HEAD

erroneously lists D as having no parents at all.  (Without --reverse,
it correctly lists M.)

This is caused by the machinery driving --reverse: it first grabs all
commits through the normal routines, then runs them through the same
routines again, effectively simplifying them twice.

Fix this by moving the --reverse one level up, into get_revision().
This way we can cleanly grab all commits via the normal calls, then
just pop them off the list one by one without interfering with
get_revision_internal().

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Johannes Sixt wrote:
> This command does not give the expected result: It reports *two* initial
> commits and one merge; in particular, commit X is reported as initial commit.
> 
> $ git rev-list --parents --reverse --full-history master -- P2

The good news is: the patch really does fix your issue.  It also fixes
the test case (which uses the history from the diagram above).  And it
passes the test suite.

The bad news: I got as far as understanding that the repeated
simplification must be at fault, but gave up on trying to see exactly
_which step_ breaks the output.  Obviously parent rewriting is the
prime suspect.

And while I'm quite convinced that this is the "right" fix in the
sense that the new implementation captures how --reverse would be
described by someone not knowing the code, it does change behaviour in
some cases.  For example, with --boundary we always output boundaries
last, regardless of --reverse.  With this patch, --reverse is
essentially just |tac, so they move to the top.

- Thomas

PS: Apologies for the subject braino earlier today.  As advised on
IRC, I have labeled the resulting hole in my foot ***FIXME***.


 revision.c                          |   38 ++++++++++++++-----------------
 revision.h                          |    1 +
 t/t6013-rev-list-reverse-parents.sh |   42 +++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 21 deletions(-)
 create mode 100755 t/t6013-rev-list-reverse-parents.sh

diff --git a/revision.c b/revision.c
index 36291b6..ae4062c 100644
--- a/revision.c
+++ b/revision.c
@@ -1646,26 +1646,6 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 		return c;
 	}
 
-	if (revs->reverse) {
-		int limit = -1;
-
-		if (0 <= revs->max_count) {
-			limit = revs->max_count;
-			if (0 < revs->skip_count)
-				limit += revs->skip_count;
-		}
-		l = NULL;
-		while ((c = get_revision_1(revs))) {
-			commit_list_insert(c, &l);
-			if ((0 < limit) && !--limit)
-				break;
-		}
-		revs->commits = l;
-		revs->reverse = 0;
-		revs->max_count = -1;
-		c = NULL;
-	}
-
 	/*
 	 * Now pick up what they want to give us
 	 */
@@ -1738,7 +1718,23 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 
 struct commit *get_revision(struct rev_info *revs)
 {
-	struct commit *c = get_revision_internal(revs);
+	struct commit *c;
+	struct commit_list *reversed;
+
+	if (revs->reverse) {
+		reversed = NULL;
+		while ((c = get_revision_internal(revs))) {
+			commit_list_insert(c, &reversed);
+		}
+		revs->commits = reversed;
+		revs->reverse = 0;
+		revs->reverse_output_stage = 1;
+	}
+
+	if (revs->reverse_output_stage)
+		return pop_commit(&revs->commits);
+
+	c = get_revision_internal(revs);
 	if (c && revs->graph)
 		graph_update(revs->graph, c);
 	return c;
diff --git a/revision.h b/revision.h
index 91f1944..a636247 100644
--- a/revision.h
+++ b/revision.h
@@ -53,6 +53,7 @@ struct rev_info {
 			rewrite_parents:1,
 			print_parents:1,
 			reverse:1,
+			reverse_output_stage:1,
 			cherry_pick:1,
 			first_parent_only:1;
 
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
new file mode 100755
index 0000000..d294466
--- /dev/null
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='--reverse combines with --parents'
+
+. ./test-lib.sh
+
+
+commit () {
+	test_tick &&
+	echo $1 > foo &&
+	git add foo &&
+	git commit -m "$1"
+}
+
+test_expect_success 'set up --reverse example' '
+	commit one &&
+	git tag root &&
+	commit two &&
+	git checkout -b side HEAD^ &&
+	commit three &&
+	git checkout master &&
+	git merge -s ours side &&
+	commit five
+	'
+
+test_expect_success '--reverse --parents --full-history combines correctly' '
+	git rev-list --parents --full-history master -- foo |
+		tac > expected &&
+	git rev-list --reverse --parents --full-history master -- foo \
+		> actual &&
+	test_cmp actual expected
+	'
+
+test_expect_success '--boundary does too' '
+	git rev-list --boundary --parents --full-history master ^root -- foo |
+		tac > expected &&
+	git rev-list --boundary --reverse --parents --full-history \
+		master ^root -- foo > actual &&
+	test_cmp actual expected
+	'
+
+test_done
-- 
1.6.0.1.24.g4c7bd
