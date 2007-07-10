From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix --cherry-pick with given paths
Date: Tue, 10 Jul 2007 14:50:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707101449220.4047@racer.site>
References: <469378AB.7030909@vilain.net> <4693800F.4010308@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 15:58:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GEd-00051M-Ot
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 15:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbXGJN6d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 09:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbXGJN6d
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 09:58:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:41117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752837AbXGJN6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 09:58:32 -0400
Received: (qmail invoked by alias); 10 Jul 2007 13:58:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 10 Jul 2007 15:58:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/peBAInb7pfPyjAosJoPpgte2OaYAnAuXCFcweyT
	wT5tv2MUkBxhXB
X-X-Sender: gene099@racer.site
In-Reply-To: <4693800F.4010308@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52071>


If you say --cherry-pick, you do not want to see patches which are
in the upstream.  If you specify paths with that, what you usually
expect is that only those parts of the patches are looked at which
actually touch the given paths.

With this patch, that expectation is met.

Noticed by Sam Vilain.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 11 Jul 2007, Sam Vilain wrote:

	> Sam Vilain wrote:
	> > I'm interested in extending the cherry analysis to allow 
	> > specification of the diff options used when calculating diff 
	> > IDs, presenting the calculated diff IDs for analysis by 
	> > external tools, and even calculating and dealing with per-hunk 
	> > diff IDs.
	> 
	> On reflection I think so long as --cherry-pick works together 
	> with a file selection, it would probably be enough.
	> 
	> ie, if I have these commits:
	> 
	> A---B
	>  \
	>   \
	>    C
	> 
	> B changes a file foo.c, adding a line of text.  C changes foo.c 
	> as well as bar.c, but the change in foo.c was identical to 
	> change B.
	> 
	> I want this to show me nothing:
	> 
	>   git-rev-list --left-right --cherry-pick B...C -- foo.c
	> 
	> Would it be the right approach to put this information in 
	> ids->diffopts, or somewhere else?

	That was interesting.  And it is indeed the right place to put it.

 revision.c                           |    9 +++++-
 t/t6007-rev-list-cherry-pick-file.sh |   43 ++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100755 t/t6007-rev-list-cherry-pick-file.sh

diff --git a/revision.c b/revision.c
index 33ee9ee..27cce09 100644
--- a/revision.c
+++ b/revision.c
@@ -437,7 +437,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 	return 0;
 }
 
-static void cherry_pick_list(struct commit_list *list)
+static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 {
 	struct commit_list *p;
 	int left_count = 0, right_count = 0;
@@ -458,6 +458,11 @@ static void cherry_pick_list(struct commit_list *list)
 
 	left_first = left_count < right_count;
 	init_patch_ids(&ids);
+	if (revs->diffopt.nr_paths) {
+		ids.diffopts.nr_paths = revs->diffopt.nr_paths;
+		ids.diffopts.paths = revs->diffopt.paths;
+		ids.diffopts.pathlens = revs->diffopt.pathlens;
+	}
 
 	/* Compute patch-ids for one side */
 	for (p = list; p; p = p->next) {
@@ -546,7 +551,7 @@ static int limit_list(struct rev_info *revs)
 		p = &commit_list_insert(commit, p)->next;
 	}
 	if (revs->cherry_pick)
-		cherry_pick_list(newlist);
+		cherry_pick_list(newlist, revs);
 
 	revs->commits = newlist;
 	return 0;
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
new file mode 100755
index 0000000..143f332
--- /dev/null
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='test git rev-list --cherry-pick -- file'
+
+. ./test-lib.sh
+
+# A---B
+#  \
+#   \
+#    C
+# 
+# B changes a file foo.c, adding a line of text.  C changes foo.c as
+# well as bar.c, but the change in foo.c was identical to change B.
+
+test_expect_success setup '
+	echo Hallo > foo &&
+	git add foo &&
+	test_tick &&
+	git commit -m "A" &&
+	git tag A &&
+	git checkout -b branch &&
+	echo Bello > foo &&
+	echo Cello > bar &&
+	git add foo bar &&
+	test_tick &&
+	git commit -m "C" &&
+	git tag C &&
+	git checkout master &&
+	git checkout branch foo &&
+	test_tick &&
+	git commit -m "B" &&
+	git tag B
+'
+
+test_expect_success '--cherry-pick foo comes up empty' '
+	test -z "$(git rev-list --left-right --cherry-pick B...C -- foo)"
+'
+
+test_expect_success '--cherry-pick bar does not come up empty' '
+	! test -z "$(git rev-list --left-right --cherry-pick B...C -- bar)"
+'
+
+test_done
-- 
1.5.3.rc0.2782.g192a9-dirty
