From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv7 4/4] status: better advices when splitting a commit (during rebase -i)
Date: Mon,  4 Jun 2012 19:19:59 +0200
Message-ID: <1338830399-31504-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 19:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbax2-0008WC-7R
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662Ab2FDRUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:20:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45270 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467Ab2FDRUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:20:06 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q54HBJmd016445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 19:11:19 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q54HK0Rl014343;
	Mon, 4 Jun 2012 19:20:00 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q54HK0l7031630;
	Mon, 4 Jun 2012 19:20:00 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q54HK0ov031629;
	Mon, 4 Jun 2012 19:20:00 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Jun 2012 19:11:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54HBJmd016445
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339434681.6367@vbbncQzmaS2aNuuVwMLaRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199152>

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
This part of the patch is the same as the one in the v6. The code has not
been modified.

 t/t7512-status-help.sh |   51 +++++++++++++++++++++++++++++++
 wt-status.c            |   77 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+), 0 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index e52a05a..413808e 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -180,6 +180,57 @@ test_expect_success 'status when rebasing -i in edit mode' '
 '
 
 
+test_expect_success 'status when splitting a commit' '
+	test_when_finished "git rebase --abort" &&
+	test_commit one_split main.txt one &&
+	test_commit two_split main.txt two &&
+	test_commit three_split main.txt three &&
+	test_commit four_split main.txt four &&
+	FAKE_LINES="1 edit 2 3" &&
+	export FAKE_LINES &&
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
+	test_cmp expected actual
+'
+
+
+test_expect_failure 'status after editing the last commit with --amend during a rebase -i' '
+	test_when_finished "git rebase --abort" &&
+	test_commit one_amend main.txt one &&
+	test_commit two_amend main.txt two &&
+	test_commit three_amend main.txt three &&
+	test_commit four_amend main.txt four &&
+	FAKE_LINES="1 2 edit 3" &&
+	export FAKE_LINES &&
+	git rebase -i HEAD~3 &&
+	git commit --amend -m "foo" &&
+	cat >expected <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing a commit during a rebase.
+	#   (use "git commit --amend" to amend the current commit)
+	#   (use "git rebase --continue" once you are satisfied with your changes)
+	#
+	nothing to commit (working directory clean)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
 test_expect_success 'status in an am session: file already exists' '
 	test_when_finished "
 		git am --abort &&
diff --git a/wt-status.c b/wt-status.c
index 3a2b787..2016b12 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "submodule.h"
 #include "column.h"
+#include "strbuf.h"
 
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -817,6 +818,77 @@ static void show_am_in_progress(struct wt_status *s,
 	wt_status_print_trailer(s);
 }
 
+static int split_commit_in_progress()
+{
+	FILE *head;
+	struct strbuf buf_head;
+	FILE *orig_head;
+	struct strbuf buf_orig_head;
+	FILE *rebase_amend;
+	struct strbuf buf_rebase_amend;
+	FILE *rebase_orig_head;
+	struct strbuf buf_rebase_orig_head;
+	int split_in_progress = 0;
+
+	head = fopen(git_path("HEAD"), "r");
+	if (!head)
+		return 0;
+
+	orig_head = fopen(git_path("ORIG_HEAD"), "r");
+	if (!orig_head) {
+		fclose(head);
+		return 0;
+	}
+
+	rebase_amend = fopen(git_path("rebase-merge/amend"), "r");
+	if (!rebase_amend) {
+		fclose(head);
+		fclose(orig_head);
+		return 0;
+	}
+
+	rebase_orig_head = fopen(git_path("rebase-merge/orig-head"), "r");
+	if (!rebase_orig_head) {
+		fclose(head);
+		fclose(orig_head);
+		fclose(rebase_amend);
+		return 0;
+	}
+
+	strbuf_init(&buf_head, 0);
+	strbuf_init(&buf_orig_head, 0);
+	strbuf_init(&buf_rebase_amend, 0);
+	strbuf_init(&buf_rebase_orig_head, 0);
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
@@ -838,6 +910,11 @@ static void show_rebase_in_progress(struct wt_status *s,
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
