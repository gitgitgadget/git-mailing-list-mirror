From: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv9 4/4] status: better advices when splitting a commit (during rebase -i)
Date: Thu,  7 Jun 2012 15:17:09 +0200
Message-ID: <1339075029-27109-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338927687-29822-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339075029-27109-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 15:17:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sccan-0003i5-Jo
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 15:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760154Ab2FGNRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 09:17:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45922 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759793Ab2FGNRP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 09:17:15 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q57D8SFq022900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Jun 2012 15:08:28 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q57DH9er025723;
	Thu, 7 Jun 2012 15:17:09 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q57DH941027683;
	Thu, 7 Jun 2012 15:17:09 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q57DH9g7027682;
	Thu, 7 Jun 2012 15:17:09 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1339075029-27109-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Jun 2012 15:08:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q57D8SFq022900
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339679309.28315@bPpAG8sLpRLQIt25hS3H4Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199407>

Add new informative help messages at the output of 'git status' when
the user is splitting a commit. The code figures this state by
comparing the contents of the following files in the .git/ directory:
	  - HEAD
	  - ORIG_HEAD
	  - rebase-merge/amend
	  - rebase-merge/orig-head

Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
The code is now restructured. The right help message is now displayed when
you amend the last commit through rebase interactive, and when you're
editing several edits whether you're amending or splitting them.

 t/t7512-status-help.sh |  277 ++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c            |   52 +++++++++
 2 files changed, 329 insertions(+), 0 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index bdce192..3ce384a 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -196,6 +196,283 @@ test_expect_success 'status when rebasing -i in edit mode' '
 '
 
 
+test_expect_success 'status when splitting a commit' '
+	git reset --hard master &&
+	git checkout -b split_commit &&
+	test_commit one_split main.txt one &&
+	test_commit two_split main.txt two &&
+	test_commit three_split main.txt three &&
+	test_commit four_split main.txt four &&
+	FAKE_LINES="1 edit 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git reset HEAD^ &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently splitting a commit.
+	#   (Once your working directory is clean, run "git rebase --continue")
+	#
+	# Changes not staged for commit:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   main.txt
+	#
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status after editing the last commit with --amend during a rebase -i' '
+	git reset --hard master &&
+	git checkout -b amend_last &&
+	test_commit one_amend main.txt one &&
+	test_commit two_amend main.txt two &&
+	test_commit three_amend main.txt three &&
+	test_commit four_amend main.txt four &&
+	FAKE_LINES="1 2 edit 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git commit --amend -m "foo" &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing a commit during a rebase.
+	#   (use "git commit --amend" to amend the current commit)
+	#   (use "git rebase --continue" once you are satisfied with your changes)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'prepare for several edits' '
+	git reset --hard master &&
+	git checkout -b several_edits &&
+	test_commit one_edits main.txt one &&
+	test_commit two_edits main.txt two &&
+	test_commit three_edits main.txt three &&
+	test_commit four_edits main.txt four
+'
+
+
+test_expect_success 'status: (continue first edit) second edit' '
+	FAKE_LINES="edit 1 edit 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git rebase --continue &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing a commit during a rebase.
+	#   (use "git commit --amend" to amend the current commit)
+	#   (use "git rebase --continue" once you are satisfied with your changes)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status: (continue first edit) second edit and split' '
+	git reset --hard several_edits &&
+	FAKE_LINES="edit 1 edit 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git rebase --continue &&
+	git reset HEAD^ &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently splitting a commit.
+	#   (Once your working directory is clean, run "git rebase --continue")
+	#
+	# Changes not staged for commit:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   main.txt
+	#
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status: (continue first edit) second edit and amend' '
+	git reset --hard several_edits &&
+	FAKE_LINES="edit 1 edit 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git rebase --continue &&
+	git commit --amend -m "foo" &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing a commit during a rebase.
+	#   (use "git commit --amend" to amend the current commit)
+	#   (use "git rebase --continue" once you are satisfied with your changes)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status: (amend first edit) second edit' '
+	git reset --hard several_edits &&
+	FAKE_LINES="edit 1 edit 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git commit --amend -m "a" &&
+	git rebase --continue &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing a commit during a rebase.
+	#   (use "git commit --amend" to amend the current commit)
+	#   (use "git rebase --continue" once you are satisfied with your changes)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status: (amend first edit) second edit and split' '
+	git reset --hard several_edits &&
+	FAKE_LINES="edit 1 edit 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git commit --amend -m "b" &&
+	git rebase --continue &&
+	git reset HEAD^ &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently splitting a commit.
+	#   (Once your working directory is clean, run "git rebase --continue")
+	#
+	# Changes not staged for commit:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   main.txt
+	#
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status: (amend first edit) second edit and amend' '
+	git reset --hard several_edits &&
+	FAKE_LINES="edit 1 edit 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git commit --amend -m "c" &&
+	git rebase --continue &&
+	git commit --amend -m "d" &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing a commit during a rebase.
+	#   (use "git commit --amend" to amend the current commit)
+	#   (use "git rebase --continue" once you are satisfied with your changes)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status: (split first edit) second edit' '
+	git reset --hard several_edits &&
+	FAKE_LINES="edit 1 edit 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git reset HEAD^ &&
+	git add main.txt &&
+	git commit -m "e" &&
+	git rebase --continue &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing a commit during a rebase.
+	#   (use "git commit --amend" to amend the current commit)
+	#   (use "git rebase --continue" once you are satisfied with your changes)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status: (split first edit) second edit and split' '
+	git reset --hard several_edits &&
+	FAKE_LINES="edit 1 edit 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git reset HEAD^ &&
+	git add main.txt &&
+	git commit --amend -m "f" &&
+	git rebase --continue &&
+	git reset HEAD^ &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently splitting a commit.
+	#   (Once your working directory is clean, run "git rebase --continue")
+	#
+	# Changes not staged for commit:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   main.txt
+	#
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'status: (split first edit) second edit and amend' '
+	git reset --hard several_edits &&
+	FAKE_LINES="edit 1 edit 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	git rebase -i HEAD~3 &&
+	git reset HEAD^ &&
+	git add main.txt &&
+	git commit --amend -m "g" &&
+	git rebase --continue &&
+	git commit --amend -m "h" &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing a commit during a rebase.
+	#   (use "git commit --amend" to amend the current commit)
+	#   (use "git rebase --continue" once you are satisfied with your changes)
+	#
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+
 test_expect_success 'prepare am_session' '
 	git reset --hard master &&
 	git checkout -b am_session &&
diff --git a/wt-status.c b/wt-status.c
index fcde045..5c0706b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "submodule.h"
 #include "column.h"
+#include "strbuf.h"
 
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -817,6 +818,52 @@ static void show_am_in_progress(struct wt_status *s,
 	wt_status_print_trailer(s);
 }
 
+static char *read_line_from_git_path(const char *filename)
+{
+	struct strbuf buf = STRBUF_INIT;
+	FILE *fp = fopen(git_path(filename), "r");
+	if (!fp) {
+		strbuf_release(&buf);
+		return NULL;
+	}
+	strbuf_getline(&buf, fp, '\n');
+	if (!fclose(fp)) {
+		return strbuf_detach(&buf, NULL);
+	} else {
+		strbuf_release(&buf);
+		return NULL;
+	}
+}
+
+static int split_commit_in_progress(struct wt_status *s)
+{
+	int split_in_progress = 0;
+	const char *head = read_line_from_git_path("HEAD");
+	const char *orig_head = read_line_from_git_path("ORIG_HEAD");
+	const char *rebase_amend = read_line_from_git_path("rebase-merge/amend");
+	const char *rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
+
+	if (!head || !orig_head || !rebase_amend ||
+			!rebase_orig_head || !prefixcmp(head, "refs/heads/"))
+		return split_in_progress;
+
+	if (!strcmp(rebase_amend, rebase_orig_head)) {
+		if (strcmp(head, rebase_amend))
+			split_in_progress = 1;
+	} else if (strcmp(orig_head, rebase_orig_head)) {
+		split_in_progress = 1;
+	}
+
+	if (!s->amend && !s->nowarn && !s->workdir_dirty)
+		split_in_progress = 0;
+
+	free((char*)head);
+	free((char*)orig_head);
+	free((char*)rebase_amend);
+	free((char*)rebase_orig_head);
+	return split_in_progress;
+}
+
 static void show_rebase_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
@@ -838,6 +885,11 @@ static void show_rebase_in_progress(struct wt_status *s,
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
+	} else if (split_commit_in_progress(s)) {
+		status_printf_ln(s, color, _("You are currently splitting a commit."));
+		if (advice_status_hints)
+			status_printf_ln(s, color,
+				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
 	} else {
 		status_printf_ln(s, color, _("You are currently editing a commit during a rebase."));
 		if (advice_status_hints && !s->amend) {
-- 
1.7.8
