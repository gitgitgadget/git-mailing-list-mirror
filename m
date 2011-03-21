From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/3] revision.c: introduce --min-parents and --max-parents
Date: Mon, 21 Mar 2011 11:14:06 +0100
Message-ID: <41d12c53966faa9c9cb5acc7646e9098dcd911ea.1300702130.git.git@drmicha.warpmail.net>
References: <4D870157.2070309@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 11:14:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1c85-0007KI-Hd
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 11:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab1CUKOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 06:14:15 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55351 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752704Ab1CUKOO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 06:14:14 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4F8F020932;
	Mon, 21 Mar 2011 06:14:13 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 21 Mar 2011 06:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=EcQVUIghjpLVDZVrmxrJy/W+nfw=; b=inXVYdZ0yoadBvyoVplE8spDTr/hH4N8skqEhEMSeJvd1g5s4/xhK3FIz6BiiPsX5WPwxOaXdneD2tsZChhHayHzKgE50jYhmVCux2jmZuepkKHUV75WQQdrO3y6KmX3VdeD7DV9yy3YK8QnBsbJqH94mW5EWiFiG1ky8walexk=
X-Sasl-enc: A//qk8Jmcc687lkpJJabk6xYIt7GIHzlfX9414TR7Jxd 1300702452
Received: from localhost (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 42E86443D26;
	Mon, 21 Mar 2011 06:14:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.511.g72e46
In-Reply-To: <4D870157.2070309@drmicha.warpmail.net>
In-Reply-To: <cover.1300702130.git.git@drmicha.warpmail.net>
References: <cover.1300702130.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169576>

--merges and --no-merges are named confusingly and cannot be overridden
by each other, but they are there to stay for plumbers' sake.

Introduce --min-parents and --max-parents which limit the revisions to
those commits which have at least resp. at most that many commits, where
negative arguments for --max-parents= denote infinity (i.e. no upper
limit).

In particular:

--max-parents=1: no merges
--min-parents=2: merges only
--max-parents=0: only roots
--min-parents=3: only octopusses

--min-parents=n --max-parents=m with n>m gives you what you ask for
(nothing) just like --merges --no-merges does, but at least for an
obvious reason.

Implementation note:

We compute the number of parents only when we limit by that, so there
is no performance impact when there are no limiters.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/log.c       |    2 +-
 builtin/rev-list.c  |    2 ++
 builtin/rev-parse.c |    2 ++
 revision.c          |   24 +++++++++++++++++-------
 revision.h          |    4 ++--
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 796e9e5..4a0f78d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1061,7 +1061,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
 	rev.diff = 1;
-	rev.no_merges = 1;
+	rev.max_parents = 1;
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
index e96c281..8d48870 100644
--- a/revision.c
+++ b/revision.c
@@ -941,6 +941,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->min_age = -1;
 	revs->skip_count = -1;
 	revs->max_count = -1;
+	revs->max_parents = -1;
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
@@ -1277,9 +1278,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--remove-empty")) {
 		revs->remove_empty_trees = 1;
 	} else if (!strcmp(arg, "--merges")) {
-		revs->merges_only = 1;
+		revs->min_parents = 2;
 	} else if (!strcmp(arg, "--no-merges")) {
-		revs->no_merges = 1;
+		revs->max_parents = 1;
+	} else if (!prefixcmp(arg, "--min-parents=")) {
+		revs->min_parents = atoi(arg+14);
+	} else if (!prefixcmp(arg, "--max-parents=")) {
+		revs->max_parents = atoi(arg+14);
 	} else if (!strcmp(arg, "--boundary")) {
 		revs->boundary = 1;
 	} else if (!strcmp(arg, "--left-right")) {
@@ -1298,7 +1303,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			die("--cherry is incompatible with --left-only");
 		revs->cherry_mark = 1;
 		revs->right_only = 1;
-		revs->no_merges = 1;
+		revs->max_parents = 1;
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
@@ -2029,10 +2034,15 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 		return commit_ignore;
 	if (revs->min_age != -1 && (commit->date > revs->min_age))
 		return commit_ignore;
-	if (revs->no_merges && commit->parents && commit->parents->next)
-		return commit_ignore;
-	if (revs->merges_only && !(commit->parents && commit->parents->next))
-		return commit_ignore;
+	if (revs->min_parents || (revs->max_parents >= 0)) {
+		int n = 0;
+		struct commit_list *p;
+		for (p = commit->parents; p; p = p->next)
+			n++;
+		if ((n < revs->min_parents) ||
+		    ((revs->max_parents >= 0) && (n > revs->max_parents)))
+			return commit_ignore;
+	}
 	if (!commit_match(commit, revs))
 		return commit_ignore;
 	if (revs->prune && revs->dense) {
diff --git a/revision.h b/revision.h
index ae94860..9fd8f30 100644
--- a/revision.h
+++ b/revision.h
@@ -41,8 +41,6 @@ struct rev_info {
 	/* Traversal flags */
 	unsigned int	dense:1,
 			prune:1,
-			no_merges:1,
-			merges_only:1,
 			no_walk:1,
 			show_all:1,
 			remove_empty_trees:1,
@@ -126,6 +124,8 @@ struct rev_info {
 	int max_count;
 	unsigned long max_age;
 	unsigned long min_age;
+	int min_parents;
+	int max_parents;
 
 	/* diff info for patches and for paths limiting */
 	struct diff_options diffopt;
-- 
1.7.4.1.511.g72e46
