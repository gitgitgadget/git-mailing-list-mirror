From: Jiang Xin <worldhello.net@gmail.com>
Subject: [RFC] status: show tracking branch even no difference
Date: Wed,  7 Aug 2013 23:42:01 +0800
Message-ID: <46fb1948a57990b0ea737401f2d60f654da4bb4f.1375890091.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 17:43:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V75th-000773-34
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 17:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab3HGPnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 11:43:32 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:59766 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab3HGPnb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 11:43:31 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so2035255pbc.11
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ReOHkczl1rcvV3NA24dqkK0isbuLgHizPyNLYrxaE00=;
        b=QSjp0Glcx2a4yyC8FBfLrJ0JbUlJpQCpM6mI1en/u2sgglIxja5SoBhS9fXYNZXN6Q
         gpdFdxNgE8+DTYf0YHOWn1XDxVlyRsH4FeFsxcLYrxZeGt0yvgjltKbQ58P5fL3t8ojk
         Rrwb2JJDlrHCm5Jhexkp3Rjsp0T+L1tshnHWYhB0/PrgsSID5NV9WHc6Uzm7AXDQbwXx
         hTPvRiHYsApWtdfWzRZ0dKfB3JmYPJw90+i7mDLccPmtcXKP09T2oQK3gSmlYnln/IPW
         i9RxJG5MZpFvEpO0uGBBSCPNzgpEj9OaWzhuFbf83GNT3131I9mY6C0Jm1pCCV6/XF1k
         89Ng==
X-Received: by 10.66.159.132 with SMTP id xc4mr1400437pab.27.1375890211242;
        Wed, 07 Aug 2013 08:43:31 -0700 (PDT)
Received: from localhost.localdomain ([114.246.125.252])
        by mx.google.com with ESMTPSA id bt1sm8928697pbb.2.2013.08.07.08.43.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 08:43:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.429.g46fb194
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231830>

If the current branch has an upstream branch, and there are differences
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
`matching`, it's hard to tell whether current branch is pushed out
or not [1].

With this patch, "git status" will report relationship between current
branch and its upstream counterpart even if there is no difference.

    $ git status
    # On branch master
    # Your branch is identical to its tracking branch: 'origin/master'.
    #
    ...

    $ git status -bs
    ## master...origin/master
    ...

    $ git checkout master
    Already on 'master'
    Your branch is identical to its tracking branch: 'origin/master'.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/198703

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 remote.c    | 22 ++++++++++++++++------
 wt-status.c | 13 ++++++++++---
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/remote.c b/remote.c
index 2433467..8d6f278 100644
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
+	/* are we the same? both num_theirs and num_ours are set to 0. */
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
+			_("Your branch is identical to its tracking branch: '%s'.\n"),
+			base);
+	} else if (!num_theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
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
1.8.4.rc1.429.g46fb194
