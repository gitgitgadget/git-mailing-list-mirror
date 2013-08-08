From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2] status: always show tracking branch even no change
Date: Thu,  8 Aug 2013 13:40:20 +0800
Message-ID: <1481cfff6c22568f2a73613668cee0b99ceb4629.1375940354.git.worldhello.net@gmail.com>
References: <vpqr4e5h55b.fsf@anie.imag.fr>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 08 07:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7J05-0001MA-KO
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 07:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab3HHFnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 01:43:00 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60560 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab3HHFm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 01:42:59 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so190933pac.17
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 22:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8y0GyDMiaFgNBPFMQpvOsNJR28lOn6XspejUvmGj3Pg=;
        b=UpjLNrmf+hlcdnTZIRcriKvEqheu3+be8CyyneQ6bFjh0TrsrvhBLZO5wgsrJpXV5X
         vsndq17nIHBmpHFHy5PoBZOm79qExSQWBzNDGSaG18IKuklGaMZvIEHbsyChazW/MtTK
         MJwOyIsANrvmySCb98acJszmg3+6uNkhWiBCjVbiQq9DT7AMN4epJJkLKRoYlUImNN3A
         yxt8cHIuV9f3NlJuRvYpj7N71GvJ+ADNKPG0id3Ft+NUVNhfHX6fyYgg4A6JnVglbCS9
         WjDya6Jktjy+2QOVsWTdR3ryHTgZqLoO9JlnMONbkpymkxpGx1rXQIgAqBHe9Ku8VQQF
         dyUQ==
X-Received: by 10.68.106.36 with SMTP id gr4mr4385107pbb.0.1375940579024;
        Wed, 07 Aug 2013 22:42:59 -0700 (PDT)
Received: from localhost.localdomain ([114.246.125.252])
        by mx.google.com with ESMTPSA id eq5sm12002409pbc.15.2013.08.07.22.42.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 22:42:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.429.geed1a03
In-Reply-To: <vpqr4e5h55b.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231862>

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

With this patch, "git status" will report relationship between the
current branch and its upstream counterpart even if there is no
difference.

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

[1]: http://thread.gmane.org/gmane.comp.version-control.git/198703

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 remote.c                 | 22 ++++++++++++++------
 t/t6040-tracking-info.sh | 54 ++++++++++++++++++++++++++++++++++++++++++++----
 wt-status.c              | 13 +++++++++---
 3 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/remote.c b/remote.c
index 2433467..825f278 100644
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
@@ -1758,14 +1762,16 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
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
 		return 0;
 
@@ -1786,8 +1792,6 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	prepare_revision_walk(&revs);
 
 	/* ... and count the commits on each side. */
-	*num_ours = 0;
-	*num_theirs = 0;
 	while (1) {
 		struct commit *c = get_revision(&revs);
 		if (!c)
@@ -1812,12 +1816,18 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	int num_ours, num_theirs;
 	const char *base;
 
-	if (!stat_tracking_info(branch, &num_ours, &num_theirs))
-		return 0;
+	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
+		if (num_ours || num_theirs)
+			return 0;
+	}
 
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
index ff4b324..56f3c19 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1381,9 +1381,11 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	if (s->is_initial)
 		color_fprintf(s->fp, header_color, _("Initial commit on "));
 	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
-		color_fprintf(s->fp, branch_color_local, "%s", branch_name);
-		fputc(s->null_termination ? '\0' : '\n', s->fp);
-		return;
+		if (num_ours || num_theirs) {
+			color_fprintf(s->fp, branch_color_local, "%s", branch_name);
+			fputc(s->null_termination ? '\0' : '\n', s->fp);
+			return;
+		}
 	}
 
 	base = branch->merge[0]->dst;
@@ -1392,6 +1394,11 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
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
1.8.4.rc1.429.geed1a03
