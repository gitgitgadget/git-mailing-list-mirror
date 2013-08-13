From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 2/2] status: always show tracking branch even no change
Date: Tue, 13 Aug 2013 12:53:49 +0800
Message-ID: <6b540dd551924a2e4f60c2892ad4872259c2c1d3.1376369554.git.worldhello.net@gmail.com>
References: <96e0ed4f67eaf058466ead9228cad0dcfe1b5c6a.1376369554.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 13 06:55:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V96ds-0007fH-7Z
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 06:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab3HMEz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 00:55:29 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:56716 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab3HMEz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 00:55:26 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so2901046pab.41
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 21:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VtiBeStmjcM7kujxfIGUZpVppPNV+X1TCCMAZRg4IA0=;
        b=vR5U0cG7WXsXB8tlAjtLB3fot9DIFpQNoYL8iY6SVs2HC6803/hofdjsX5TlV5TdKP
         Ragui4UKj+mP9XkRxIEEjiFhMx+S8R2M0NPSLnlQ03Y6wEdKp9GYdF3mc3dIxxShsmzF
         wTnD0h1n1/PDLl67uSkB4t612pYrhzkl5Wh7o/6DDVWYzgKLIdQC+TEsPjulg8eGfUL6
         YvvkewEwJPHcDc/qfrfFPZSgwNrsoHIpZ6dzqu4VXoJG5Na9Xw0ownDMqcJFe/oFygew
         a1NSc9GSPsc84j0+cumtsYK9qv5cgU6UMW4INrbVtuqMV3leJnmBT4mqS7q6f0X0aAnV
         e+aw==
X-Received: by 10.68.137.1 with SMTP id qe1mr2607321pbb.25.1376369726295;
        Mon, 12 Aug 2013 21:55:26 -0700 (PDT)
Received: from localhost.localdomain ([114.246.129.124])
        by mx.google.com with ESMTPSA id dg3sm41181259pbc.24.2013.08.12.21.55.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 21:55:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.430.g417e2f3
In-Reply-To: <96e0ed4f67eaf058466ead9228cad0dcfe1b5c6a.1376369554.git.worldhello.net@gmail.com>
In-Reply-To: <CANYiYbFGBRV+EP8oV_chKvBsHLAAZeKmt0395_z9QD-bBZtErQ@mail.gmail.com>
References: <CANYiYbFGBRV+EP8oV_chKvBsHLAAZeKmt0395_z9QD-bBZtErQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232210>

In order to see what the current branch is tracking, one way is using
"git branch -v -v", but branches other than the current are also
reported. Another way is using "git status", such as:

    $ git status
    # On branch master
    # Your branch is ahead of 'origin/master' by 1 commit.
    ...

But this will not work if there is no change between the current
branch and its upstream. What if report upstream tracking info
always even if there is no difference. E.g.

    $ git status
    # On branch feature1
    # Your branch is identical to 'github/feature1'.
    ...

    $ git status -bs
    ## feature1...github/feature1
    ...

    $ git checkout feature1
    Already on 'feature1'
    Your branch is identical to 'github/feature1'.
    ...

Also add some test cases in t6040.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 remote.c                 | 10 ++++-----
 t/t6040-tracking-info.sh | 54 ++++++++++++++++++++++++++++++++++++++++++++----
 wt-status.c              | 13 +++++-------
 3 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/remote.c b/remote.c
index c747936..70307f4 100644
--- a/remote.c
+++ b/remote.c
@@ -1811,13 +1811,13 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	if (!stat_tracking_info(branch, &num_ours, &num_theirs))
 		return 0;
 
-	/* Nothing to report if neither side has changes. */
-	if (!num_ours && !num_theirs)
-		return 0;
-
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
index 0c6a3a5..627b59e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1383,24 +1383,21 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-	/*
-	 * Not report tracking info if no tracking branch found
-	 * or no difference found.
-	 */
 	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
 		fputc(s->null_termination ? '\0' : '\n', s->fp);
 		return;
 	}
-	if (!num_ours && !num_theirs) {
-		fputc(s->null_termination ? '\0' : '\n', s->fp);
-		return;
-	}
 
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
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
