From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv6 4/4] status: better advices when splitting a commit (during rebase -i)
Date: Sun,  3 Jun 2012 20:30:17 +0200
Message-ID: <1338748217-16440-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 20:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbFZZ-0007ge-DW
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 20:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab2FCSa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 14:30:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46306 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129Ab2FCSaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 14:30:22 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q53ILlbO024333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 20:21:47 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q53IUHXL013544;
	Sun, 3 Jun 2012 20:30:17 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q53IUHvW017063;
	Sun, 3 Jun 2012 20:30:17 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q53IUHT3017062;
	Sun, 3 Jun 2012 20:30:17 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 03 Jun 2012 20:21:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53ILlbO024333
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339352508.71907@2MiZfXsB/gQVnh9fSpk5LA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199095>

Add new informative help messages at the output of 'git status' when
the user is splitting a commit. The code figures this state by
comparing the contents of the following files in the .git/ directory:
	  - HEAD
	  - ORIG_HEAD
	  - rebase-merge/amend
	  - rebase-merge/orig-head

Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Nguyen Huynh Khoi Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
---
The second test added by this patch fails because the case in which
the user amend the last commit through rebase -i is not taken care of.
We infer that the user would directly run "git commit --amend" instead
of amending it with a rebase -i.

 t/t7512-status-help.sh |   63 +++++++++++++++++++++++++++++++++++++++++++-
 wt-status.c            |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 1 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 2bb43f3..0b7f231 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -106,7 +106,7 @@ test_expect_success 'status when rebase in progress before rebase --continue' '
 
 test_expect_success 'status when rebasing -i in edit mode' '
 	git init git &&
-	test_when_finished "rm -rf git fake-editor.sh" &&
+	test_when_finished "rm -rf git" &&
 	(
 		cd git &&
 		test_commit one main.txt one &&
@@ -130,6 +130,67 @@ test_expect_success 'status when rebasing -i in edit mode' '
 '
 
 
+test_expect_success 'status when splitting a commit' '
+	git init git &&
+	test_when_finished "rm -rf git" &&
+	(
+		cd git &&
+		test_commit one main.txt one &&
+		test_commit two main.txt two &&
+		test_commit three main.txt three &&
+		test_commit four main.txt four &&
+		FAKE_LINES="1 edit 2 3" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~3 &&
+		git reset HEAD^ &&
+		cat >expected <<-\EOF &&
+		# Not currently on any branch.
+		# You are currently splitting a commit.
+		#   (Once your working directory is clean, run "git rebase --continue")
+		#
+		# Changes not staged for commit:
+		#   (use "git add <file>..." to update what will be committed)
+		#   (use "git checkout -- <file>..." to discard changes in working directory)
+		#
+		#	modified:   main.txt
+		#
+		no changes added to commit (use "git add" and/or "git commit -a")
+		EOF
+		git status --untracked-files=no >actual &&
+		test_cmp expected actual &&
+		git rebase --abort
+	)
+'
+
+
+test_expect_failure 'status after editing the last commit with --amend during a rebase -i' '
+	git init git &&
+	test_when_finished "rm -rf git fake-editor.sh" &&
+	(
+		cd git &&
+		test_commit one main.txt one &&
+		test_commit two main.txt two &&
+		test_commit three main.txt three &&
+		test_commit four main.txt four &&
+		FAKE_LINES="1 2 edit 3" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~3 &&
+		git commit --amend -m "foo" &&
+		cat >expected <<-\EOF &&
+		# Not currently on any branch.
+		# You are currently editing a commit during a rebase.
+		#   (use "git commit --amend" to amend the current commit)
+		#   (use "git rebase --continue" once you are satisfied with your changes)
+		#
+		nothing to commit (working directory clean)
+		EOF
+		git status --untracked-files=no >actual &&
+		test_cmp expected actual &&
+		git rebase --abort
+	)
+'
+
+
 test_expect_success 'status in an am session: file already exists' '
 	git init git &&
 	test_when_finished "rm -rf git" &&
diff --git a/wt-status.c b/wt-status.c
index 5034eee..bbb3370 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "submodule.h"
 #include "column.h"
+#include "strbuf.h"
 
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -819,6 +820,69 @@ static void show_am_in_progress(struct wt_status *s,
 	wt_status_print_trailer(s);
 }
 
+static int split_commit_in_progress()
+{
+	int split_in_progress = 0;
+
+	FILE *head = fopen(git_path("HEAD"), "r");
+	if (!head)
+		return 0;
+
+	FILE *orig_head = fopen(git_path("ORIG_HEAD"), "r");
+	if (!orig_head) {
+		fclose(head);
+		return 0;
+	}
+
+	FILE *rebase_amend = fopen(git_path("rebase-merge/amend"), "r");
+	if (!rebase_amend) {
+		fclose(head);
+		fclose(orig_head);
+		return 0;
+	}
+
+	FILE *rebase_orig_head = fopen(git_path("rebase-merge/orig-head"), "r");
+	if (!rebase_orig_head) {
+		fclose(head);
+		fclose(orig_head);
+		fclose(rebase_amend);
+		return 0;
+	}
+
+	struct strbuf buf_head = STRBUF_INIT;
+	struct strbuf buf_orig_head = STRBUF_INIT;
+	struct strbuf buf_rebase_amend = STRBUF_INIT;
+	struct strbuf buf_rebase_orig_head = STRBUF_INIT;
+
+	strbuf_getline(&buf_head, head, '\n');
+	strbuf_getline(&buf_orig_head, orig_head, '\n');
+	strbuf_getline(&buf_rebase_amend, rebase_amend, '\n');
+	strbuf_getline(&buf_rebase_orig_head, rebase_orig_head, '\n');
+
+	fclose(head);
+	fclose(orig_head);
+	fclose(rebase_amend);
+	fclose(rebase_orig_head);
+
+	if (!strbuf_cmp(&buf_rebase_amend, &buf_rebase_orig_head)) {
+		if (strbuf_cmp(&buf_head, &buf_rebase_amend))
+			split_in_progress = 1;
+	} else if (!strbuf_cmp(&buf_orig_head, &buf_rebase_amend)) {
+		split_in_progress = 1;
+	} else if (strbuf_cmp(&buf_orig_head, &buf_rebase_orig_head)) {
+		split_in_progress = 1;
+	}
+
+	if (!strbuf_cmp(&buf_head, &buf_rebase_amend))
+		split_in_progress = 0;
+
+	strbuf_release(&buf_head);
+	strbuf_release(&buf_orig_head);
+	strbuf_release(&buf_rebase_amend);
+	strbuf_release(&buf_rebase_orig_head);
+	return split_in_progress;
+}
+
 static void show_rebase_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
@@ -838,6 +902,11 @@ static void show_rebase_in_progress(struct wt_status *s,
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
+	} else if (split_commit_in_progress()) {
+		status_printf_ln(s, color, _("You are currently splitting a commit."));
+		if (advice_status_hints)
+			status_printf_ln(s, color,
+				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
 	} else {
 		status_printf_ln(s, color, _("You are currently editing a commit during a rebase."));
 		if (advice_status_hints && !s->amend) {
-- 
1.7.8
