From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 1/3] branch: not report invalid tracking branch
Date: Fri, 16 Aug 2013 10:29:32 +0800
Message-ID: <6bc0643a5fa0fae03be6fdb59f63075be1e4d983.1376620130.git.worldhello.net@gmail.com>
References: <cover.1376618877.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 16 04:31:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA9pB-0007Xa-I8
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 04:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab3HPCba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 22:31:30 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:39360 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab3HPCb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 22:31:28 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so1588292pde.38
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 19:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gC61ENdhf2oK+jPputNQXdOdcPCcdY6dmK3XYVfOU+E=;
        b=p5SOp/AoMBc1tss4SBIDDVJyzK7EcFxgUn6Z73F5hgoxAiznPk3QNrnLPQqPoYQ1b0
         n1VKLQvN1HGZPTE7qSMs80Wqi8pblPr34TLyaXqZNJZ/LJwwXTDwOVhpZnF3xbZZtgvN
         V4CVBv4c2V+fmqqmonlYn5xmN1w9fHe+7c2vz0YUu2VKepzrVEbOTgxSm+Y4WIJRb+sH
         2fMp59a0+h3bApW4X8ceHqX6UyJfRX6s9NY8hC4rLMBYoGmCzJX0GKK0WFdeJ/oCntES
         2XvZj8mHJZqCjO9ooMePuVJh+5sQrhpxrir7wL6EF8Dv7RMgrjz8VSAlgDOe7dbyA1zt
         jkyw==
X-Received: by 10.66.228.234 with SMTP id sl10mr574175pac.149.1376620287419;
        Thu, 15 Aug 2013 19:31:27 -0700 (PDT)
Received: from localhost.localdomain ([114.246.129.124])
        by mx.google.com with ESMTPSA id pw9sm2698975pbb.20.2013.08.15.19.31.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 19:31:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.479.g44abce8
In-Reply-To: <cover.1376618877.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1376620130.git.worldhello.net@gmail.com>
References: <7vzjsio99d.fsf@alter.siamese.dyndns.org> <cover.1376620130.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232394>

Command "git branch -vv" will report tracking branches, but invalid
tracking branches are also reported. This is because the function
stat_tracking_info() can not distinguish whether the upstream branch
does not exist, or nothing is changed between one branch and its
upstream.

This patch changes the return value of function stat_tracking_info().
Only returns false when there is no tracking branch or the tracking
branch is invalid, otherwise true. If the caller does not like to
report tracking info when nothing changed between the branch and its
upstream, simply checks if num_theirs and num_ours are both 0.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/branch.c         | 24 ++++++++----------------
 remote.c                 | 43 ++++++++++++++++++++++---------------------
 t/t6040-tracking-info.sh |  8 ++++++--
 wt-status.c              | 13 +++++++++++--
 4 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0903763..3e016a6 100644
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
@@ -448,19 +437,22 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 			strbuf_addstr(&fancy, ref);
 	}
 
-	if (!ours) {
-		if (ref)
+	if (!ours && !theirs) {
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
index 2433467..26bd543 100644
--- a/remote.c
+++ b/remote.c
@@ -1729,7 +1729,8 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 }
 
 /*
- * Return true if there is anything to report, otherwise false.
+ * Return false if cannot stat a tracking branch (not exist or invalid),
+ * otherwise true.
  */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 {
@@ -1740,18 +1741,12 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
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
 		return 0;
@@ -1766,8 +1761,10 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 		return 0;
 
 	/* are we the same? */
-	if (theirs == ours)
-		return 0;
+	if (theirs == ours) {
+		*num_theirs = *num_ours = 0;
+		return 1;
+	}
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	rev_argc = 0;
@@ -1809,31 +1806,35 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
  */
 int format_tracking_info(struct branch *branch, struct strbuf *sb)
 {
-	int num_ours, num_theirs;
+	int ours, theirs;
 	const char *base;
 
-	if (!stat_tracking_info(branch, &num_ours, &num_theirs))
+	if (!stat_tracking_info(branch, &ours, &theirs))
+		return 0;
+
+	/* Nothing to report if neither side has changes. */
+	if (!ours && !theirs)
 		return 0;
 
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
-	if (!num_theirs) {
+	if (!theirs) {
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
@@ -1845,8 +1846,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
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
index ec2b516..471dd64 100755
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
diff --git a/wt-status.c b/wt-status.c
index ff4b324..0c6a3a5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1380,15 +1380,24 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	branch = branch_get(s->branch + 11);
 	if (s->is_initial)
 		color_fprintf(s->fp, header_color, _("Initial commit on "));
+
+	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
+
+	/*
+	 * Not report tracking info if no tracking branch found
+	 * or no difference found.
+	 */
 	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
-		color_fprintf(s->fp, branch_color_local, "%s", branch_name);
+		fputc(s->null_termination ? '\0' : '\n', s->fp);
+		return;
+	}
+	if (!num_ours && !num_theirs) {
 		fputc(s->null_termination ? '\0' : '\n', s->fp);
 		return;
 	}
 
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
-	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", base);
 
-- 
1.8.4.rc2.479.g44abce8
