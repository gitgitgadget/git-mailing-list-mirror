From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 1/2] branch: report invalid tracking branch as gone
Date: Mon, 26 Aug 2013 15:02:48 +0800
Message-ID: <5b4a10dc41db70c225dc1dfd840b509b73b3dad7.1377500206.git.worldhello.net@gmail.com>
References: <cover.1377500206.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 26 09:10:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDqwT-0000nZ-36
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 09:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab3HZHKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 03:10:15 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:39534 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057Ab3HZHKO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 03:10:14 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so3056398pbb.20
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=oi4A1+VwMJ11uy4ANiYOFk/O3sBXaPZ0eWbzz0yn4Pg=;
        b=JKWg7hUuZawyBcei7KRtPheakNbZWAiLWtuScPR5aZePNmGTB3VWH3eqG8daeoVLSE
         x6lhFQz0cd9CLCtsKIvWVy1RXpyagxyHvKPssfOGcRf9XPxGfDdg0r5lMZghdd6xxCm1
         PEIJu0b19AMng1ndZPBsTGem+UNptCIG8ihmRbyVmZOsD4scGrI0DPsK3+bviswEwlqS
         7dKHmjs5tIv2VY1JOTEXptpbMvB50jg4qSvbgD0j9iZB0aGd/NaAKgh6r5b55sLz2Iil
         g4Q1K0BZmsDfOrb1I107ufSWXmHvuj0SFNlSQR58T8bFhV0g5sd4fhDJ4q7AqP4sKRbp
         h9JA==
X-Received: by 10.68.224.161 with SMTP id rd1mr13823012pbc.121.1377501011577;
        Mon, 26 Aug 2013 00:10:11 -0700 (PDT)
Received: from localhost.localdomain ([114.248.144.150])
        by mx.google.com with ESMTPSA id kd1sm17994787pab.20.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 00:10:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.2.g434fd97
In-Reply-To: <cover.1377500206.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1377500206.git.worldhello.net@gmail.com>
References: <7v7gfiojz7.fsf@alter.siamese.dyndns.org> <cover.1377500206.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232978>

Command "git branch -vv" will report tracking branches, but invalid
tracking branches are also reported. This is because the function
stat_tracking_info() can not distinguish invalid tracking branch
from other cases which it would not like to report, such as
there is no upstream settings at all, or nothing is changed between
one branch and its upstream.

Junio suggested missing upstream should be reported [1] like:

    $ git branch -v -v
      master    e67ac84 initial
    * topic     3fc0f2a [topicbase: gone] topic

    $ git status
    # On branch topic
    # Your branch is based on 'topicbase', but the upstream is gone.
    #   (use "git branch --unset-upstream" to fixup)
    ...

    $ git status -b -s
    ## topic...topicbase [gone]
    ...

In order to do like that, we need to distinguish these three cases
(i.e. no tracking, with configured but no longer valid tracking, and
with tracking) in function stat_tracking_info(). So the refactored
function stat_tracking_info() has three return values: -1 (with "gone"
base), 0 (no base), and 1 (with base).

If the caller does not like to report tracking info when nothing
changed between the branch and its upstream, simply checks if
num_theirs and num_ours are both 0.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/231830/focus=232288

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c         | 36 ++++++++++++++----------
 remote.c                 | 71 +++++++++++++++++++++++++++++++-----------------
 t/t6040-tracking-info.sh | 57 +++++++++++++++++++++++++++++++++++---
 wt-status.c              | 26 +++++++++++++++---
 4 files changed, 142 insertions(+), 48 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..0539fda 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -423,19 +423,19 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	char *ref = NULL;
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
+	int upstream_is_gone = 0;
 
-	if (!stat_tracking_info(branch, &ours, &theirs)) {
-		if (branch && branch->merge && branch->merge[0]->dst &&
-		    show_upstream_ref) {
-			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
-			if (want_color(branch_use_color))
-				strbuf_addf(stat, "[%s%s%s] ",
-						branch_get_color(BRANCH_COLOR_UPSTREAM),
-						ref, branch_get_color(BRANCH_COLOR_RESET));
-			else
-				strbuf_addf(stat, "[%s] ", ref);
-		}
+	switch (stat_tracking_info(branch, &ours, &theirs)) {
+	case 0:
+		/* no base */
 		return;
+	case -1:
+		/* with "gone" base */
+		upstream_is_gone = 1;
+		break;
+	default:
+		/* with base */
+		break;
 	}
 
 	if (show_upstream_ref) {
@@ -448,19 +448,25 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 			strbuf_addstr(&fancy, ref);
 	}
 
-	if (!ours) {
-		if (ref)
+	if (upstream_is_gone) {
+		if (show_upstream_ref)
+			strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
+	} else if (!ours && !theirs) {
+		if (show_upstream_ref)
+			strbuf_addf(stat, _("[%s]"), fancy.buf);
+	} else if (!ours) {
+		if (show_upstream_ref)
 			strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
 		else
 			strbuf_addf(stat, _("[behind %d]"), theirs);
 
 	} else if (!theirs) {
-		if (ref)
+		if (show_upstream_ref)
 			strbuf_addf(stat, _("[%s: ahead %d]"), fancy.buf, ours);
 		else
 			strbuf_addf(stat, _("[ahead %d]"), ours);
 	} else {
-		if (ref)
+		if (show_upstream_ref)
 			strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
 				    fancy.buf, ours, theirs);
 		else
diff --git a/remote.c b/remote.c
index efcba93..87c8dd3 100644
--- a/remote.c
+++ b/remote.c
@@ -1695,7 +1695,11 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 }
 
 /*
- * Return true if there is anything to report, otherwise false.
+ * Compare a branch with its upstream, and save their differences (number
+ * of commits) in *num_ours and *num_theirs.
+ *
+ * Return 0 if branch has no upstream (no base), -1 if upstream is missing
+ * (with "gone" base), otherwise 1 (with base).
  */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 {
@@ -1706,34 +1710,30 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	const char *rev_argv[10], *base;
 	int rev_argc;
 
-	/*
-	 * Nothing to report unless we are marked to build on top of
-	 * somebody else.
-	 */
+	/* Cannot stat unless we are marked to build on top of somebody else. */
 	if (!branch ||
 	    !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
 		return 0;
 
-	/*
-	 * If what we used to build on no longer exists, there is
-	 * nothing to report.
-	 */
+	/* Cannot stat if what we used to build on no longer exists */
 	base = branch->merge[0]->dst;
 	if (read_ref(base, sha1))
-		return 0;
+		return -1;
 	theirs = lookup_commit_reference(sha1);
 	if (!theirs)
-		return 0;
+		return -1;
 
 	if (read_ref(branch->refname, sha1))
-		return 0;
+		return -1;
 	ours = lookup_commit_reference(sha1);
 	if (!ours)
-		return 0;
+		return -1;
 
 	/* are we the same? */
-	if (theirs == ours)
-		return 0;
+	if (theirs == ours) {
+		*num_theirs = *num_ours = 0;
+		return 1;
+	}
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	rev_argc = 0;
@@ -1775,31 +1775,52 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
  */
 int format_tracking_info(struct branch *branch, struct strbuf *sb)
 {
-	int num_ours, num_theirs;
+	int ours, theirs;
 	const char *base;
+	int upstream_is_gone = 0;
 
-	if (!stat_tracking_info(branch, &num_ours, &num_theirs))
+	switch (stat_tracking_info(branch, &ours, &theirs)) {
+	case 0:
+		/* no base */
 		return 0;
+	case -1:
+		/* with "gone" base */
+		upstream_is_gone = 1;
+		break;
+	default:
+		/* Nothing to report if neither side has changes. */
+		if (!ours && !theirs)
+			return 0;
+		/* with base */
+		break;
+	}
 
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
-	if (!num_theirs) {
+	if (upstream_is_gone) {
+		strbuf_addf(sb,
+			_("Your branch is based on '%s', but the upstream is gone.\n"),
+			base);
+		if (advice_status_hints)
+			strbuf_addf(sb,
+				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+	} else if (!theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
-			   num_ours),
-			base, num_ours);
+			   ours),
+			base, ours);
 		if (advice_status_hints)
 			strbuf_addf(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
-	} else if (!num_ours) {
+	} else if (!ours) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
 			       "and can be fast-forwarded.\n",
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
-			   num_theirs),
-			base, num_theirs);
+			   theirs),
+			base, theirs);
 		if (advice_status_hints)
 			strbuf_addf(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -1811,8 +1832,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			   "Your branch and '%s' have diverged,\n"
 			       "and have %d and %d different commits each, "
 			       "respectively.\n",
-			   num_theirs),
-			base, num_ours, num_theirs);
+			   theirs),
+			base, ours, theirs);
 		if (advice_status_hints)
 			strbuf_addf(sb,
 				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index ec2b516..6f678a4 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -28,10 +28,14 @@ test_expect_success setup '
 		git reset --hard HEAD^ &&
 		git checkout -b b4 origin &&
 		advance e &&
-		advance f
+		advance f &&
+		git checkout -b brokenbase origin &&
+		git checkout -b b5 --track brokenbase &&
+		advance g &&
+		git branch -d brokenbase
 	) &&
 	git checkout -b follower --track master &&
-	advance g
+	advance h
 '
 
 script='s/^..\(b.\)[	 0-9a-f]*\[\([^]]*\)\].*/\1 \2/p'
@@ -56,6 +60,7 @@ b1 origin/master: ahead 1, behind 1
 b2 origin/master: ahead 1, behind 1
 b3 origin/master: behind 1
 b4 origin/master: ahead 2
+b5 brokenbase: gone
 EOF
 
 test_expect_success 'branch -vv' '
@@ -67,7 +72,7 @@ test_expect_success 'branch -vv' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'checkout' '
+test_expect_success 'checkout (diverged from upstream)' '
 	(
 		cd test && git checkout b1
 	) >actual &&
@@ -80,7 +85,15 @@ test_expect_success 'checkout with local tracked branch' '
 	test_i18ngrep "is ahead of" actual
 '
 
-test_expect_success 'status' '
+test_expect_success 'checkout (upstream is gone)' '
+	(
+		cd test &&
+		git checkout b5
+	) >actual &&
+	test_i18ngrep "is based on .*, but the upstream is gone." actual
+'
+
+test_expect_success 'status (diverged from upstream)' '
 	(
 		cd test &&
 		git checkout b1 >/dev/null &&
@@ -90,6 +103,42 @@ test_expect_success 'status' '
 	test_i18ngrep "have 1 and 1 different" actual
 '
 
+test_expect_success 'status (upstream is gone)' '
+	(
+		cd test &&
+		git checkout b5 >/dev/null &&
+		# reports nothing to commit
+		test_must_fail git commit --dry-run
+	) >actual &&
+	test_i18ngrep "is based on .*, but the upstream is gone." actual
+'
+
+cat >expect <<\EOF
+## b1...origin/master [ahead 1, behind 1]
+EOF
+
+test_expect_success 'status -s -b (diverged from upstream)' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git status -s -b | head -1
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
+cat >expect <<\EOF
+## b5...brokenbase [gone]
+EOF
+
+test_expect_success 'status -s -b (upstream is gone)' '
+	(
+		cd test &&
+		git checkout b5 >/dev/null &&
+		git status -s -b | head -1
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'fail to track lightweight tags' '
 	git checkout master &&
 	git tag light &&
diff --git a/wt-status.c b/wt-status.c
index cb24f1f..4b1713e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1365,6 +1365,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	const char *base;
 	const char *branch_name;
 	int num_ours, num_theirs;
+	int upstream_is_gone = 0;
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
 
@@ -1382,20 +1383,37 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	branch = branch_get(s->branch + 11);
 	if (s->is_initial)
 		color_fprintf(s->fp, header_color, _("Initial commit on "));
-	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
-		color_fprintf(s->fp, branch_color_local, "%s", branch_name);
+
+	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
+
+	switch (stat_tracking_info(branch, &num_ours, &num_theirs)) {
+	case 0:
+		/* no base */
 		fputc(s->null_termination ? '\0' : '\n', s->fp);
 		return;
+	case -1:
+		/* with "gone" base */
+		upstream_is_gone = 1;
+		break;
+	default:
+		/* Stop reporting if neither side has changes. */
+		if (!num_ours && !num_theirs) {
+			fputc(s->null_termination ? '\0' : '\n', s->fp);
+			return;
+		}
+		/* with base */
+		break;
 	}
 
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
-	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", base);
 
 	color_fprintf(s->fp, header_color, " [");
-	if (!num_ours) {
+	if (upstream_is_gone) {
+		color_fprintf(s->fp, header_color, _("gone"));
+	} else if (!num_ours) {
 		color_fprintf(s->fp, header_color, _("behind "));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	} else if (!num_theirs) {
-- 
1.8.4.rc3.2.g434fd97
