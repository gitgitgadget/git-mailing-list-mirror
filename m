From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3] status: always show tracking branch even no change
Date: Thu,  8 Aug 2013 22:49:21 +0800
Message-ID: <0affa278c225273a2d3fdcf8f55b61e26d322f1e.1375972599.git.worldhello.net@gmail.com>
References: <cover.1375972599.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 08 16:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7RZB-0000v2-Cj
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 16:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab3HHOvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 10:51:47 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:51550 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850Ab3HHOvq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 10:51:46 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so3336756pbc.4
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6U4Q333qm+WTUYIPPiyEJgxvInc7tVW1y9HboNG0nZI=;
        b=T7TKUtvVa8F2AAFvd6+qgC8UStzFF2f2nJHuaL8zkb8nRo8CupKp8QQFGVJlSpnDox
         SKZju4Sz55hNGW3ROQAfv8DlNfspdVu+J0Jhj4w5mh5R3bamuDEiw226aJPJFkD6dQw/
         TbaxjjWoVRSpozP4+j/QMLVcXQEXv829imbdpdI0P2cQm1tP6Z0pgQxQ6hFDPqgtSbWp
         qQgLCOWFSoYsaxyI3pFVxWjWWB1VrkPPpnIAIlOx5fUBxl254Eb4OUjUkOX3v6JHqnOq
         Kh7YZS7RtZoaFuHbCjzSd7ZgYieEA2uYgu6oa/ZkWTMV2P+q7Gk3O9Xwa40EcLHpQ/5f
         rP8w==
X-Received: by 10.66.121.131 with SMTP id lk3mr6677437pab.43.1375973505677;
        Thu, 08 Aug 2013 07:51:45 -0700 (PDT)
Received: from localhost.localdomain ([114.246.125.252])
        by mx.google.com with ESMTPSA id qf7sm16969647pac.14.2013.08.08.07.51.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 07:51:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.430.g417e2f3
In-Reply-To: <cover.1375972599.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1375972599.git.worldhello.net@gmail.com>
References: <1481cfff6c22568f2a73613668cee0b99ceb4629.1375940354.git.worldhello.net@gmail.com> <cover.1375972599.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231890>

If the current branch has an upstream branch, and there are changes
between the current branch and its upstream, some commands (such as
"git status", "git status -bs", and "git checkout") will report their
relationship. E.g.

    $ git status
    # On branch master
    # Your branch is ahead of 'origin/master' by 1 commit.
    #   (use "git push" to publish your local commits)
    #
    ...

    $ git status -bs
    ## master...origin/master [ahead 1]
    ...

    $ git checkout master
    Already on 'master'
    Your branch is ahead of 'origin/master' by 1 commit.
      (use "git push" to publish your local commits)

But if there is no difference between the current branch and its
upstream, the relationship will not be reported, and it's hard to
tell whether the current branch has a tracking branch or not. And
what's worse, when the 'push.default' config variable is set to
`matching`, it's hard to tell whether the current branch has already
been pushed out or not at all [1].

So always show the remote tracking branch in the output of "git status"
and other commands will help users to see where the current branch
will push to and pull from. E.g.

    $ git status
    # On branch master
    # Your branch is identical to 'origin/master'.
    #
    ...

    $ git status -bs
    ## master...origin/master
    ...

    $ git checkout master
    Already on 'master'
    Your branch is identical to 'origin/master'.

This patch changes the return value of function stat_tracking_info().
When the current branch and its remote tracking branch point to the
same commit, will return 1, instead of 0. Because we want to report
the tracking info for such case. Also add some test cases in t6040.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/198703

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/branch.c         | 18 +++++-----------
 remote.c                 | 18 +++++++++++-----
 t/t6040-tracking-info.sh | 54 ++++++++++++++++++++++++++++++++++++++++++++----
 wt-status.c              |  5 +++++
 4 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..359e75d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -424,19 +424,8 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
 
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
+	if (!stat_tracking_info(branch, &ours, &theirs))
 		return;
-	}
 
 	if (show_upstream_ref) {
 		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
@@ -448,7 +437,10 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 			strbuf_addstr(&fancy, ref);
 	}
 
-	if (!ours) {
+	if (!ours && !theirs) {
+		if (ref)
+			strbuf_addf(stat, _("[%s]"), fancy.buf);
+	} else if (!ours) {
 		if (ref)
 			strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
 		else
diff --git a/remote.c b/remote.c
index 2433467..79766df 100644
--- a/remote.c
+++ b/remote.c
@@ -1740,6 +1740,10 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	const char *rev_argv[10], *base;
 	int rev_argc;
 
+	/* Set both num_theirs and num_ours as undetermined. */
+	*num_theirs = -1;
+	*num_ours = -1;
+
 	/*
 	 * Nothing to report unless we are marked to build on top of
 	 * somebody else.
@@ -1758,16 +1762,18 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	theirs = lookup_commit_reference(sha1);
 	if (!theirs)
 		return 0;
+	*num_theirs = 0;
 
 	if (read_ref(branch->refname, sha1))
 		return 0;
 	ours = lookup_commit_reference(sha1);
 	if (!ours)
 		return 0;
+	*num_ours = 0;
 
-	/* are we the same? */
+	/* are we the same? both num_theirs and num_ours have been set to 0. */
 	if (theirs == ours)
-		return 0;
+		return 1;
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	rev_argc = 0;
@@ -1786,8 +1792,6 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	prepare_revision_walk(&revs);
 
 	/* ... and count the commits on each side. */
-	*num_ours = 0;
-	*num_theirs = 0;
 	while (1) {
 		struct commit *c = get_revision(&revs);
 		if (!c)
@@ -1817,7 +1821,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
-	if (!num_theirs) {
+	if (!num_ours && !num_theirs) {
+		strbuf_addf(sb,
+			_("Your branch is identical to '%s'.\n"),
+			base);
+	} else if (!num_theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index ec2b516..eafce7d 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -28,18 +28,20 @@ test_expect_success setup '
 		git reset --hard HEAD^ &&
 		git checkout -b b4 origin &&
 		advance e &&
-		advance f
+		advance f &&
+		git checkout -b b5 origin
 	) &&
 	git checkout -b follower --track master &&
 	advance g
 '
 
-script='s/^..\(b.\)[	 0-9a-f]*\[\([^]]*\)\].*/\1 \2/p'
+script='s/^..\(b.\)[	 0-9a-f]*\(\[\([^]]*\)\]\)\{0,1\}.*/\1 \3/p'
 cat >expect <<\EOF
 b1 ahead 1, behind 1
 b2 ahead 1, behind 1
 b3 behind 1
 b4 ahead 2
+b5 
 EOF
 
 test_expect_success 'branch -v' '
@@ -56,6 +58,7 @@ b1 origin/master: ahead 1, behind 1
 b2 origin/master: ahead 1, behind 1
 b3 origin/master: behind 1
 b4 origin/master: ahead 2
+b5 origin/master
 EOF
 
 test_expect_success 'branch -vv' '
@@ -67,20 +70,27 @@ test_expect_success 'branch -vv' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'checkout' '
+test_expect_success 'checkout (diverged from upstream)' '
 	(
 		cd test && git checkout b1
 	) >actual &&
 	test_i18ngrep "have 1 and 1 different" actual
 '
 
+test_expect_success 'checkout (identical to upstream)' '
+	(
+		cd test && git checkout b5
+	) >actual &&
+	test_i18ngrep "Your branch is identical to .origin/master" actual
+'
+
 test_expect_success 'checkout with local tracked branch' '
 	git checkout master &&
 	git checkout follower >actual &&
 	test_i18ngrep "is ahead of" actual
 '
 
-test_expect_success 'status' '
+test_expect_success 'status (diverged from upstream)' '
 	(
 		cd test &&
 		git checkout b1 >/dev/null &&
@@ -90,6 +100,42 @@ test_expect_success 'status' '
 	test_i18ngrep "have 1 and 1 different" actual
 '
 
+test_expect_success 'status (identical to upstream)' '
+	(
+		cd test &&
+		git checkout b5 >/dev/null &&
+		# reports nothing to commit
+		test_must_fail git commit --dry-run
+	) >actual &&
+	test_i18ngrep "Your branch is identical to .origin/master" actual
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
+## b5...origin/master
+EOF
+
+test_expect_success 'status -s -b (identical to upstream)' '
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
index ff4b324..39742ff 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1392,6 +1392,11 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", base);
 
+	if (!num_ours && !num_theirs) {
+		fputc(s->null_termination ? '\0' : '\n', s->fp);
+		return;
+	}
+
 	color_fprintf(s->fp, header_color, " [");
 	if (!num_ours) {
 		color_fprintf(s->fp, header_color, _("behind "));
-- 
1.8.4.rc1.430.g417e2f3
