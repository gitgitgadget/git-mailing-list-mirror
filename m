From: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Subject: [PATCH] status: display the SHA1 of the commit being currently processed
Date: Mon, 17 Jun 2013 14:10:04 +0200
Message-ID: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 17 14:10:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoYGS-0007iR-VU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 14:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759Ab3FQMKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 08:10:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56839 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932727Ab3FQMKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 08:10:23 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5HCAId2014405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Jun 2013 14:10:18 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5HCAJkq012281;
	Mon, 17 Jun 2013 14:10:19 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5HCAJD6015689;
	Mon, 17 Jun 2013 14:10:19 +0200
Received: (from lienardm@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5HCAHY5015685;
	Mon, 17 Jun 2013 14:10:17 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Jun 2013 14:10:18 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228062>

When in the middle of a rebase, it can be annoying to go in .git
in order to find the SHA1 of the commit where the rebase stopped.

git-status now includes this information in its default output.
With this new information, the message is now shorter, to avoid
too long lines.

The new message looks like:
$ git status
 HEAD detached from 33e516f
 Editing c346c87 while rebasing branch 'rebase_i_edit' on 'f90e540'.

Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---

 -changes in the tests to match the new status output
 -read file rebase-merge/stopped_sha to include the SHA in status output

 t/t7512-status-help.sh |   36 ++++++++++++++++++++++++------------
 wt-status.c            |   25 +++++++++++++++++++++----
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index bf08d4e..dc93d77 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -189,10 +189,11 @@ test_expect_success 'status when rebasing -i in edit mode' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~2) &&
 	TGT=$(git rev-parse --short two_rebase_i) &&
+	SHA=$(git rev-parse --short three_rebase_i) &&
 	git rebase -i HEAD~2 &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $TGT
-	# You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
+	# Editing $SHA while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
 	#
@@ -217,9 +218,10 @@ test_expect_success 'status when splitting a commit' '
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	TGT=$(git rev-parse --short HEAD) &&
+	SHA=$(git rev-parse --short three_split) &&
 	cat >expected <<-EOF &&
 	# HEAD detached at $TGT
-	# You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
+	# Splitting $SHA while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
 	# Changes not staged for commit:
@@ -247,11 +249,12 @@ test_expect_success 'status after editing the last commit with --amend during a
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	TGT=$(git rev-parse --short three_amend) &&
+	SHA=$(git rev-parse --short four_amend) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $TGT
-	# You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
+	# Editing $SHA while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
 	#
@@ -277,11 +280,12 @@ test_expect_success 'status: (continue first edit) second edit' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
+	SHA=$(git rev-parse --short three_edits) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+	# Editing $SHA while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
 	#
@@ -298,12 +302,13 @@ test_expect_success 'status: (continue first edit) second edit and split' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
+	SHA=$(git rev-parse --short three_edits) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $ONTO
-	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+	# Splitting $SHA while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
 	# Changes not staged for commit:
@@ -325,12 +330,13 @@ test_expect_success 'status: (continue first edit) second edit and amend' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
+	SHA=$(git rev-parse --short three_edits) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+	# Editing $SHA while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
 	#
@@ -347,12 +353,13 @@ test_expect_success 'status: (amend first edit) second edit' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
+	SHA=$(git rev-parse --short three_edits) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "a" &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+	# Editing $SHA while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
 	#
@@ -369,13 +376,14 @@ test_expect_success 'status: (amend first edit) second edit and split' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
+	SHA=$(git rev-parse --short three_edits) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "b" &&
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $ONTO
-	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+	# Splitting $SHA while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
 	# Changes not staged for commit:
@@ -397,13 +405,14 @@ test_expect_success 'status: (amend first edit) second edit and amend' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
+	SHA=$(git rev-parse --short three_edits) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "c" &&
 	git rebase --continue &&
 	git commit --amend -m "d" &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+	# Editing $SHA while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
 	#
@@ -420,6 +429,7 @@ test_expect_success 'status: (split first edit) second edit' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
+	SHA=$(git rev-parse --short three_edits) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	git add main.txt &&
@@ -427,7 +437,7 @@ test_expect_success 'status: (split first edit) second edit' '
 	git rebase --continue &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+	# Editing $SHA while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
 	#
@@ -444,6 +454,7 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
+	SHA=$(git rev-parse --short three_edits) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	git add main.txt &&
@@ -452,7 +463,7 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $ONTO
-	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+	# Splitting $SHA while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
 	# Changes not staged for commit:
@@ -474,6 +485,7 @@ test_expect_success 'status: (split first edit) second edit and amend' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
+	SHA=$(git rev-parse --short three_edits) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	git add main.txt &&
@@ -482,7 +494,7 @@ test_expect_success 'status: (split first edit) second edit and amend' '
 	git commit --amend -m "h" &&
 	cat >expected <<-EOF &&
 	# HEAD detached from $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+	# Editing $SHA while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
 	#
diff --git a/wt-status.c b/wt-status.c
index bf84a86..5f5cddf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -885,8 +885,19 @@ static void show_rebase_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
 {
+	char *stopped_sha = read_line_from_git_path("rebase-merge/stopped-sha");
+	int must_free_stopped_sha = 1;
 	struct stat st;
 
+	/*
+	 * If the file stopped-sha does not exist
+	 * we go back to the old output saying "a commit"
+	 * instead of providing the commit's SHA1.
+	 */
+	if (!stopped_sha) {
+		stopped_sha = "a commit";
+		must_free_stopped_sha = 0;
+	}
 	if (has_unmerged(s)) {
 		if (state->branch)
 			status_printf_ln(s, color,
@@ -919,24 +930,28 @@ static void show_rebase_in_progress(struct wt_status *s,
 	} else if (split_commit_in_progress(s)) {
 		if (state->branch)
 			status_printf_ln(s, color,
-					 _("You are currently splitting a commit while rebasing branch '%s' on '%s'."),
+					 _("Splitting %s while rebasing branch '%s' on '%s'."),
+					 stopped_sha,
 					 state->branch,
 					 state->onto);
 		else
 			status_printf_ln(s, color,
-					 _("You are currently splitting a commit during a rebase."));
+					 _("Splitting %s during a rebase."),
+					 stopped_sha);
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
 	} else {
 		if (state->branch)
 			status_printf_ln(s, color,
-					 _("You are currently editing a commit while rebasing branch '%s' on '%s'."),
+					 _("Editing %s while rebasing branch '%s' on '%s'."),
+					 stopped_sha,
 					 state->branch,
 					 state->onto);
 		else
 			status_printf_ln(s, color,
-					 _("You are currently editing a commit during a rebase."));
+					 _("Editing %s during a rebase."),
+					 stopped_sha);
 		if (advice_status_hints && !s->amend) {
 			status_printf_ln(s, color,
 				_("  (use \"git commit --amend\" to amend the current commit)"));
@@ -945,6 +960,8 @@ static void show_rebase_in_progress(struct wt_status *s,
 		}
 	}
 	wt_status_print_trailer(s);
+	if (must_free_stopped_sha)
+		free(stopped_sha);
 }
 
 static void show_cherry_pick_in_progress(struct wt_status *s,
-- 
1.7.8
