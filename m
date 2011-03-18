From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] revision.c: introduce --min-parents and --max-parents
Date: Fri, 18 Mar 2011 15:50:23 +0100
Message-ID: <7f2a7d979cd8f6b9fce577994c82f50421575d58.1300459017.git.git@drmicha.warpmail.net>
References: <20110318085616.GA16703@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 15:54:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0b3y-0000lK-0F
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 15:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab1CROx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 10:53:58 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39540 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862Ab1CROx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 10:53:56 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3537320A90;
	Fri, 18 Mar 2011 10:53:56 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 18 Mar 2011 10:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=6zg2U4HXT3XlOqpLvCz09SCJiCY=; b=fnJvXtWn5kkcPPAW0Rb9RKSVqWgt6Snhatynq09Eu7qOD7XqtpvtK9VRYFPIfHghEpmzpjjpdkHcj/bUDd5u76oav5YNtdin5VtO+0htslwozXzJG5M68wuxsfmTovbZ/FzheJiGzwQALePFbVShQWs04uR0Qp5mnQJKWcooxaw=
X-Sasl-enc: e1WD5NpMDsNXGYqTqzzHfkvfbOsvPkpWjHYsR0a80Fj0 1300460035
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8C9AF402D11;
	Fri, 18 Mar 2011 10:53:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.464.gf81ff
In-Reply-To: <20110318085616.GA16703@sigill.intra.peff.net>
In-Reply-To: <cover.1300459016.git.git@drmicha.warpmail.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169324>

--merges and --no-merges are named confusingly and cannot be overridden
by each other, but they are there to stay for plumbers' sake.

Introduce --min-parents and --max-parents which take values 0,...,7 and
limit the revisions to those commits which have at least resp. at most
that many commits, where --max-parents=8 denotes --max-parents=infinity
(i.e. no upper limit). In fact, 7 (or any negative number) does, but 8
is infinity sideways 8-)

In particular:

--max-parents=1: no merges
--min-parents=2: merges only
--max-parents=0: only roots
--min-parents=3: only octopusses

--min-parents=n --max-parents=m with n>m gives you what you ask for
(nothing) just like --merges --no-merges does, but at least for an
obvious reason.

Implementation notes:

* We compute the number of parents only when we limit by that, so there
  is no performance impact when there are no limiters.

* This uses 6 bits in struct rev_info (rather than the previous 2). We
  need at least 4 to distinguish the 5 cases "all", "merges only", "no
  merges", "roots", "octopusses". 4 would get us to infinity == 3.
  I don't think two int's are warranted - they would also spoil the 8.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/log.c       |    2 +-
 builtin/rev-list.c  |    2 ++
 builtin/rev-parse.c |    2 ++
 revision.c          |   23 ++++++++++++++++-------
 revision.h          |    9 +++++++--
 5 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 796e9e5..9ffccc3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1061,7 +1061,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
 	rev.diff = 1;
-	rev.no_merges = 1;
+	rev.max_parents = MAX_PARENTS(1);
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f458cb7..7b276e0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -16,6 +16,8 @@ static const char rev_list_usage[] =
 "    --min-age=<epoch>\n"
 "    --sparse\n"
 "    --no-merges\n"
+"    --min-parents=<n>\n"
+"    --max-parents=<n>\n"
 "    --remove-empty\n"
 "    --all\n"
 "    --branches\n"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..9940546 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -48,6 +48,8 @@ static int is_rev_argument(const char *arg)
 		"--max-count=",
 		"--min-age=",
 		"--no-merges",
+		"--min-parents=",
+		"--max-parents=",
 		"--objects",
 		"--objects-edge",
 		"--parents",
diff --git a/revision.c b/revision.c
index e96c281..6cfd091 100644
--- a/revision.c
+++ b/revision.c
@@ -1277,9 +1277,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--remove-empty")) {
 		revs->remove_empty_trees = 1;
 	} else if (!strcmp(arg, "--merges")) {
-		revs->merges_only = 1;
+		revs->min_parents = MIN_PARENTS(2);
 	} else if (!strcmp(arg, "--no-merges")) {
-		revs->no_merges = 1;
+		revs->max_parents = MAX_PARENTS(1);
+	} else if (!prefixcmp(arg, "--min-parents=")) {
+		revs->min_parents = MIN_PARENTS(atoi(arg+14));
+	} else if (!prefixcmp(arg, "--max-parents=")) {
+		revs->max_parents = MAX_PARENTS(atoi(arg+14));
 	} else if (!strcmp(arg, "--boundary")) {
 		revs->boundary = 1;
 	} else if (!strcmp(arg, "--left-right")) {
@@ -1298,7 +1302,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			die("--cherry is incompatible with --left-only");
 		revs->cherry_mark = 1;
 		revs->right_only = 1;
-		revs->no_merges = 1;
+		revs->max_parents = MAX_PARENTS(1);
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
@@ -2029,10 +2033,15 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 		return commit_ignore;
 	if (revs->min_age != -1 && (commit->date > revs->min_age))
 		return commit_ignore;
-	if (revs->no_merges && commit->parents && commit->parents->next)
-		return commit_ignore;
-	if (revs->merges_only && !(commit->parents && commit->parents->next))
-		return commit_ignore;
+	if (revs->min_parents || revs->max_parents) {
+		int n = 0;
+		struct commit_list *p;
+		for (p = commit->parents; p; p = p->next)
+			n++;
+		if ((MIN_PARENTS(n) < revs->min_parents) ||
+		    (MAX_PARENTS(n) < revs->max_parents)) /* max is inv. */
+			return commit_ignore;
+	}
 	if (!commit_match(commit, revs))
 		return commit_ignore;
 	if (revs->prune && revs->dense) {
diff --git a/revision.h b/revision.h
index ae94860..192b2d4 100644
--- a/revision.h
+++ b/revision.h
@@ -20,6 +20,11 @@
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
 
+/* limit to used range */
+#define MIN_PARENTS(m)	({ unsigned int __n = (m); (__n < 0) ? 0 : (__n > 7) ? 7 : __n; })
+/* invert fox MAX so that default = 0 -> infinity */
+#define MAX_PARENTS(m)	({ unsigned int __n = (m); (__n < 0) ? 7 : (__n > 7) ? 0 : 7 - __n;})
+
 struct rev_info;
 struct log_info;
 struct string_list;
@@ -41,8 +46,8 @@ struct rev_info {
 	/* Traversal flags */
 	unsigned int	dense:1,
 			prune:1,
-			no_merges:1,
-			merges_only:1,
+			min_parents:3,
+			max_parents:3, /* MAX_PARENTS(n) */
 			no_walk:1,
 			show_all:1,
 			remove_empty_trees:1,
-- 
1.7.4.1.464.gf81ff
