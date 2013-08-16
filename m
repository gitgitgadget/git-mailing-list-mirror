From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 2/3] branch: mark missing tracking branch as gone
Date: Fri, 16 Aug 2013 10:29:33 +0800
Message-ID: <a4b446b4ff63f56f8203df0723eeb319b2ba58dc.1376620130.git.worldhello.net@gmail.com>
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
	id 1VA9pC-0007Xa-As
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 04:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab3HPCbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 22:31:34 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:55167 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab3HPCbb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 22:31:31 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so1607123pdi.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 19:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=U4ZD0vCoyh518xdeoVRe6ldIzosfQwyfjqIPs8LcrD0=;
        b=CmwOSOr8fFbTz87M9uavJMYhj57NA9UcKJ/9JJl4+VCe6W5C0v2h9pY2Ndvk/w0HFD
         Yfp1jJ8QPAo8rOxN1R/h1Nf2Zt4pNt8ohVzQNnAyfuwYV3VL81d8pLP00GOYJL6v+wgy
         EUoZRrApvj7oEPWcmXNIfo//HWeGUXzHb0IJ7A8GIoLm6t2HgmmlQVu3tOTM98cE4IkJ
         V4uu8NnoG+Qq0O5wOpYM7TIU25PVVpF1xPMwIcSJ5pF6m4KHCE4JGH7Lipw7bzvEHffx
         poo+BXGqoTiRIibPzrsdd4tXOy8x91wZbReJbqlwEOPSautgDhzmHPOdszs/YaCq9hoS
         ugow==
X-Received: by 10.66.164.136 with SMTP id yq8mr640906pab.67.1376620290650;
        Thu, 15 Aug 2013 19:31:30 -0700 (PDT)
Received: from localhost.localdomain ([114.246.129.124])
        by mx.google.com with ESMTPSA id pw9sm2698975pbb.20.2013.08.15.19.31.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 19:31:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.479.g44abce8
In-Reply-To: <cover.1376618877.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1376620130.git.worldhello.net@gmail.com>
References: <7vzjsio99d.fsf@alter.siamese.dyndns.org> <cover.1376620130.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232393>

If a branch has been set to track a upstream, but the upstream branch
is missing, the tracking info is silently ignored in the output of
some commands such as "git branch -vv" and "git status", as if there
were no such tracking settings.

Junio suggested missing upstream should be reported [1], such as:

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

[1]: http://thread.gmane.org/gmane.comp.version-control.git/231830/focus=232288

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/branch.c         | 18 ++++++++++++++++--
 remote.c                 | 44 +++++++++++++++++++++++++++++++------------
 t/t6040-tracking-info.sh | 49 ++++++++++++++++++++++++++++++++++++++++++++++--
 wt-status.c              | 28 +++++++++++++++++----------
 4 files changed, 113 insertions(+), 26 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3e016a6..ad0f86d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -423,9 +423,20 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	char *ref = NULL;
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
+	int upstream_is_gone = 0;
 
-	if (!stat_tracking_info(branch, &ours, &theirs))
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
+	}
 
 	if (show_upstream_ref) {
 		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
@@ -437,7 +448,10 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 			strbuf_addstr(&fancy, ref);
 	}
 
-	if (!ours && !theirs) {
+	if (upstream_is_gone) {
+		if (show_upstream_ref)
+			strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
+	} else if (!ours && !theirs) {
 		if (show_upstream_ref)
 			strbuf_addf(stat, _("[%s]"), fancy.buf);
 	} else if (!ours) {
diff --git a/remote.c b/remote.c
index 26bd543..4caccb5 100644
--- a/remote.c
+++ b/remote.c
@@ -1729,8 +1729,11 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 }
 
 /*
- * Return false if cannot stat a tracking branch (not exist or invalid),
- * otherwise true.
+ * Compare a branch with its upstream, and save their differences (number
+ * of commits) in *num_ours and *num_theirs.
+ *
+ * Return 0 if branch has no upstream (no base), -1 if upstream is missing
+ * (with "gone" base), otherwise 1 (with base).
  */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 {
@@ -1749,16 +1752,16 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	/* Cannot stat if what we used to build on no longer exists */
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
 	if (theirs == ours) {
@@ -1808,17 +1811,34 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 {
 	int ours, theirs;
 	const char *base;
+	int upstream_is_gone = 0;
 
-	if (!stat_tracking_info(branch, &ours, &theirs))
-		return 0;
-
-	/* Nothing to report if neither side has changes. */
-	if (!ours && !theirs)
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
-	if (!theirs) {
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
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 471dd64..6f678a4 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -60,6 +60,7 @@ b1 origin/master: ahead 1, behind 1
 b2 origin/master: ahead 1, behind 1
 b3 origin/master: behind 1
 b4 origin/master: ahead 2
+b5 brokenbase: gone
 EOF
 
 test_expect_success 'branch -vv' '
@@ -71,7 +72,7 @@ test_expect_success 'branch -vv' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'checkout' '
+test_expect_success 'checkout (diverged from upstream)' '
 	(
 		cd test && git checkout b1
 	) >actual &&
@@ -84,7 +85,15 @@ test_expect_success 'checkout with local tracked branch' '
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
@@ -94,6 +103,42 @@ test_expect_success 'status' '
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
index 0c6a3a5..46d181a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1363,6 +1363,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	const char *base;
 	const char *branch_name;
 	int num_ours, num_theirs;
+	int upstream_is_gone = 0;
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
 
@@ -1383,17 +1384,22 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-	/*
-	 * Not report tracking info if no tracking branch found
-	 * or no difference found.
-	 */
-	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
-		fputc(s->null_termination ? '\0' : '\n', s->fp);
-		return;
-	}
-	if (!num_ours && !num_theirs) {
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
+		/* with base */
+		if (!num_ours && !num_theirs) {
+			fputc(s->null_termination ? '\0' : '\n', s->fp);
+			return;
+		}
+		break;
 	}
 
 	base = branch->merge[0]->dst;
@@ -1402,7 +1408,9 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
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
1.8.4.rc2.479.g44abce8
