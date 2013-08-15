From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 2/3] branch: report invalid tracking branch as broken
Date: Fri, 16 Aug 2013 02:11:22 +0800
Message-ID: <8db143908bc969bbe1d720479fb6214729f7b1ae.1376590264.git.worldhello.net@gmail.com>
References: <6bc0643a5fa0fae03be6fdb59f63075be1e4d983.1376590264.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 15 20:13:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA22i-0003q0-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 20:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759374Ab3HOSM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 14:12:58 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:62145 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759308Ab3HOSMz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 14:12:55 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so1115775pdj.15
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 11:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hxfhejBMhh3hHS44EaNIuVUCYJX7u7DRE8Ujz9LLCFs=;
        b=VElKCRO/iyUDEsuSiZONu686SEkcN3TLkrP2a1UGrq1ugKChiHgUX6B9MVD0NMeU8R
         PIlRx5iwiL3bBsF1DlrQMg9ji6wl4FH7gAm3ugvSd5OPh0/KDnZ29azkKj8j3UDgEbTQ
         Z4BPbyrJVHcmZSNw2dpseknBvqZPlaca9auajL91Fmi1Rh1ESGugI34ezGVkGHkuw/Zp
         H+0QxUl0ByqHdx1N0lZydEchQjC7iXwH40RyjwTqwxxDPtjfSoweZjzsHOhnw4ot71zM
         6UpgEn177dodI2lV7uqPL2W1ZYr6abeuajVQd52LhC1g1o/pZnKPpNobHSkxfPgNuADu
         WD+A==
X-Received: by 10.66.139.166 with SMTP id qz6mr11339090pab.88.1376590374827;
        Thu, 15 Aug 2013 11:12:54 -0700 (PDT)
Received: from localhost.localdomain ([114.246.129.124])
        by mx.google.com with ESMTPSA id bt1sm1346733pbb.2.2013.08.15.11.12.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 11:12:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.478.g12f0bfd.dirty
In-Reply-To: <6bc0643a5fa0fae03be6fdb59f63075be1e4d983.1376590264.git.worldhello.net@gmail.com>
In-Reply-To: <7vbo50uvty.fsf@alter.siamese.dyndns.org>
References: <7vbo50uvty.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232359>

If a branch has been set to track a upstream, but the upstream branch
is missing or invalid, the tracking info is silently ignored in the
output of some commands such as "git branch -vv" and "git status",
as if there were no such tracking settings.

Junio suggested broken upstream should be reported [1]. E.g.

    $ git branch -v -v
      master    e67ac84 initial
    * topic     3fc0f2a [topicbase: broken] topic

    $ git status
    # On branch topic
    # Your branch is based on a broken ref 'topicbase'.
    #   (use "git branch --unset-upstream" to fixup)
    ...

    $ git status -b -s
    ## topic...topicbase [broken]
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
 builtin/branch.c         | 17 +++++++++++++++--
 remote.c                 | 43 ++++++++++++++++++++++++++++++------------
 t/t6040-tracking-info.sh | 49 ++++++++++++++++++++++++++++++++++++++++++++++--
 wt-status.c              | 27 ++++++++++++++++----------
 4 files changed, 110 insertions(+), 26 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3e016a6..247785e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -423,9 +423,19 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	char *ref = NULL;
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
+	int broken_upstream = 0;
 
-	if (!stat_tracking_info(branch, &ours, &theirs))
+	switch (stat_tracking_info(branch, &ours, &theirs)) {
+	case 0:
+		/* Not set upstream. */
 		return;
+	case -1:
+		/* Upstream is missing or invalid. */
+		broken_upstream = 1;
+		break;
+	default:
+		break;
+	}
 
 	if (show_upstream_ref) {
 		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
@@ -437,7 +447,10 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 			strbuf_addstr(&fancy, ref);
 	}
 
-	if (!ours && !theirs) {
+	if (broken_upstream) {
+		if (show_upstream_ref)
+			strbuf_addf(stat, _("[%s: broken]"), fancy.buf);
+	} else if (!ours && !theirs) {
 		if (show_upstream_ref)
 			strbuf_addf(stat, _("[%s]"), fancy.buf);
 	} else if (!ours) {
diff --git a/remote.c b/remote.c
index 26bd543..aa87381 100644
--- a/remote.c
+++ b/remote.c
@@ -1729,8 +1729,11 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 }
 
 /*
- * Return false if cannot stat a tracking branch (not exist or invalid),
- * otherwise true.
+ * Compare a branch with its tracking branch, and save their differences
+ * (number of commits) in *num_ours and *num_theirs.
+ *
+ * Return 0 if branch has no upstream, -1 if upstream is missing or invalid,
+ * otherwise 1.
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
@@ -1808,17 +1811,33 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 {
 	int ours, theirs;
 	const char *base;
+	int broken_upstream = 0;
 
-	if (!stat_tracking_info(branch, &ours, &theirs))
-		return 0;
-
-	/* Nothing to report if neither side has changes. */
-	if (!ours && !theirs)
+	switch (stat_tracking_info(branch, &ours, &theirs)) {
+	case 0:
+		/* Not set upstream. */
 		return 0;
+	case -1:
+		/* Upstream is missing or invalid. */
+		broken_upstream = 1;
+		break;
+	default:
+		/* Nothing to report if neither side has changes. */
+		if (!ours && !theirs)
+			return 0;
+		break;
+	}
 
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
-	if (!theirs) {
+	if (broken_upstream) {
+		strbuf_addf(sb,
+			_("Your branch is based on a broken ref '%s'.\n"),
+			base);
+		if (advice_status_hints)
+			strbuf_addf(sb,
+				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+	} else if (!theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 471dd64..e362a01 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -60,6 +60,7 @@ b1 origin/master: ahead 1, behind 1
 b2 origin/master: ahead 1, behind 1
 b3 origin/master: behind 1
 b4 origin/master: ahead 2
+b5 brokenbase: broken
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
+test_expect_success 'checkout (broken upstream)' '
+	(
+		cd test &&
+		git checkout b5
+	) >actual &&
+	test_i18ngrep "is based on a broken ref" actual
+'
+
+test_expect_success 'status (diverged from upstream)' '
 	(
 		cd test &&
 		git checkout b1 >/dev/null &&
@@ -94,6 +103,42 @@ test_expect_success 'status' '
 	test_i18ngrep "have 1 and 1 different" actual
 '
 
+test_expect_success 'status (broken upstream)' '
+	(
+		cd test &&
+		git checkout b5 >/dev/null &&
+		# reports nothing to commit
+		test_must_fail git commit --dry-run
+	) >actual &&
+	test_i18ngrep "is based on a broken ref" actual
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
+## b5...brokenbase [broken]
+EOF
+
+test_expect_success 'status -s -b (broken upstream)' '
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
index 0c6a3a5..60164d4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1363,6 +1363,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	const char *base;
 	const char *branch_name;
 	int num_ours, num_theirs;
+	int broken_upstream = 0;
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
 
@@ -1383,17 +1384,21 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
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
+		/* Not report tracking info if no tracking branch found. */
 		fputc(s->null_termination ? '\0' : '\n', s->fp);
 		return;
+	case -1:
+		/* Upstream is missing or invalid. */
+		broken_upstream = 1;
+		break;
+	default:
+		if (!num_ours && !num_theirs) {
+			fputc(s->null_termination ? '\0' : '\n', s->fp);
+			return;
+		}
+		break;
 	}
 
 	base = branch->merge[0]->dst;
@@ -1402,7 +1407,9 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, branch_color_remote, "%s", base);
 
 	color_fprintf(s->fp, header_color, " [");
-	if (!num_ours) {
+	if (broken_upstream) {
+		color_fprintf(s->fp, header_color, _("broken"));
+	} else if (!num_ours) {
 		color_fprintf(s->fp, header_color, _("behind "));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	} else if (!num_theirs) {
-- 
1.8.4.rc2.478.g12f0bfd.dirty
