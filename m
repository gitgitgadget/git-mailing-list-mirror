From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH 3/4] status: give more information during rebase -i
Date: Thu,  4 Jun 2015 00:00:24 +0200
Message-ID: <1433368825-24617-3-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
References: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 00:00:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0GiP-00030K-DF
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 00:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbbFCWAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 18:00:41 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:51981 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753322AbbFCWAj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 18:00:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 148D43605;
	Thu,  4 Jun 2015 00:00:38 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id deuspcoZGblE; Thu,  4 Jun 2015 00:00:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id ECE5535F8;
	Thu,  4 Jun 2015 00:00:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id E691E20E4;
	Thu,  4 Jun 2015 00:00:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ulEP6hggFu6V; Thu,  4 Jun 2015 00:00:37 +0200 (CEST)
Received: from localhost.localdomain (pas38-h02-176-189-96-8.dsl.sta.abo.bbox.fr [176.189.96.8])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 60C9420DF;
	Thu,  4 Jun 2015 00:00:37 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.342.g726a850
In-Reply-To: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270742>

git status gives more information during rebase -i, about the list of
command that are done during the rebase. It displays the two last
commands executed and the two next lines to be executed. It also gives
hints to find the whole files in .git directory.
---
 t/t7512-status-help.sh | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c            |  90 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 190656d..4dd201a 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -134,9 +134,13 @@ test_expect_success 'prepare for rebase_i_conflicts' '
 test_expect_success 'status during rebase -i when conflicts unresolved' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short rebase_i_conflicts) &&
+	LAST_COMMIT=$(git rev-parse rebase_i_conflicts_second) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (1 command(s) done):
+   pick $LAST_COMMIT one_second
+No command remaining.
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
   (fix conflicts and then run "git rebase --continue")
   (use "git rebase --skip" to skip this patch)
@@ -159,10 +163,14 @@ test_expect_success 'status during rebase -i after resolving conflicts' '
 	git reset --hard rebase_i_conflicts_second &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short rebase_i_conflicts) &&
+	LAST_COMMIT=$(git rev-parse rebase_i_conflicts_second) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (1 command(s) done):
+   pick $LAST_COMMIT one_second
+No command remaining.
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
   (all conflicts fixed: run "git rebase --continue")
 
@@ -183,7 +191,9 @@ test_expect_success 'status when rebasing -i in edit mode' '
 	git checkout -b rebase_i_edit &&
 	test_commit one_rebase_i main.txt one &&
 	test_commit two_rebase_i main.txt two &&
+	COMMIT2=$(git rev-parse rebase_i_edit) &&
 	test_commit three_rebase_i main.txt three &&
+	COMMIT3=$(git rev-parse rebase_i_edit) &&
 	FAKE_LINES="1 edit 2" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
@@ -191,6 +201,10 @@ test_expect_success 'status when rebasing -i in edit mode' '
 	git rebase -i HEAD~2 &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   pick $COMMIT2 two_rebase_i
+   edit $COMMIT3 three_rebase_i
+No command remaining.
 You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -207,8 +221,11 @@ test_expect_success 'status when splitting a commit' '
 	git checkout -b split_commit &&
 	test_commit one_split main.txt one &&
 	test_commit two_split main.txt two &&
+	COMMIT2=$(git rev-parse split_commit) &&
 	test_commit three_split main.txt three &&
+	COMMIT3=$(git rev-parse split_commit) &&
 	test_commit four_split main.txt four &&
+	COMMIT4=$(git rev-parse split_commit) &&
 	FAKE_LINES="1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
@@ -217,6 +234,12 @@ test_expect_success 'status when splitting a commit' '
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   pick $COMMIT2 two_split
+   edit $COMMIT3 three_split
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_split
+  (use git rebase --edit-todo to view and edit)
 You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
 
@@ -239,7 +262,9 @@ test_expect_success 'status after editing the last commit with --amend during a
 	test_commit one_amend main.txt one &&
 	test_commit two_amend main.txt two &&
 	test_commit three_amend main.txt three &&
+	COMMIT3=$(git rev-parse amend_last) &&
 	test_commit four_amend main.txt four &&
+	COMMIT4=$(git rev-parse amend_last) &&
 	FAKE_LINES="1 2 edit 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
@@ -248,6 +273,11 @@ test_expect_success 'status after editing the last commit with --amend during a
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (3 command(s) done):
+   pick $COMMIT3 three_amend
+   edit $COMMIT4 four_amend
+  (see more at .git/rebase-merge/done)
+No command remaining.
 You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -273,11 +303,20 @@ test_expect_success 'status: (continue first edit) second edit' '
 	FAKE_LINES="edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=$(git rev-parse several_edits^^) &&
+	COMMIT3=$(git rev-parse several_edits^) &&
+	COMMIT4=$(git rev-parse several_edits) &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -294,12 +333,21 @@ test_expect_success 'status: (continue first edit) second edit and split' '
 	FAKE_LINES="edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=$(git rev-parse several_edits^^) &&
+	COMMIT3=$(git rev-parse several_edits^) &&
+	COMMIT4=$(git rev-parse several_edits) &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
 
@@ -321,12 +369,21 @@ test_expect_success 'status: (continue first edit) second edit and amend' '
 	FAKE_LINES="edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=$(git rev-parse several_edits^^) &&
+	COMMIT3=$(git rev-parse several_edits^) &&
+	COMMIT4=$(git rev-parse several_edits) &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -343,12 +400,21 @@ test_expect_success 'status: (amend first edit) second edit' '
 	FAKE_LINES="edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=$(git rev-parse several_edits^^) &&
+	COMMIT3=$(git rev-parse several_edits^) &&
+	COMMIT4=$(git rev-parse several_edits) &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "a" &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -366,12 +432,21 @@ test_expect_success 'status: (amend first edit) second edit and split' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
+	COMMIT2=$(git rev-parse several_edits^^) &&
+	COMMIT3=$(git rev-parse several_edits^) &&
+	COMMIT4=$(git rev-parse several_edits) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "b" &&
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
 
@@ -393,6 +468,9 @@ test_expect_success 'status: (amend first edit) second edit and amend' '
 	FAKE_LINES="edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=$(git rev-parse several_edits^^) &&
+	COMMIT3=$(git rev-parse several_edits^) &&
+	COMMIT4=$(git rev-parse several_edits) &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "c" &&
@@ -400,6 +478,12 @@ test_expect_success 'status: (amend first edit) second edit and amend' '
 	git commit --amend -m "d" &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -416,6 +500,9 @@ test_expect_success 'status: (split first edit) second edit' '
 	FAKE_LINES="edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=$(git rev-parse several_edits^^) &&
+	COMMIT3=$(git rev-parse several_edits^) &&
+	COMMIT4=$(git rev-parse several_edits) &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
@@ -424,6 +511,12 @@ test_expect_success 'status: (split first edit) second edit' '
 	git rebase --continue &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
@@ -440,6 +533,9 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	FAKE_LINES="edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=$(git rev-parse several_edits^^) &&
+	COMMIT3=$(git rev-parse several_edits^) &&
+	COMMIT4=$(git rev-parse several_edits) &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
@@ -449,6 +545,12 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
 
@@ -470,6 +572,9 @@ test_expect_success 'status: (split first edit) second edit and amend' '
 	FAKE_LINES="edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=$(git rev-parse several_edits^^) &&
+	COMMIT3=$(git rev-parse several_edits^) &&
+	COMMIT4=$(git rev-parse several_edits) &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
@@ -479,6 +584,12 @@ test_expect_success 'status: (split first edit) second edit and amend' '
 	git commit --amend -m "h" &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
diff --git a/wt-status.c b/wt-status.c
index c83eca5..35ca55e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1026,12 +1026,102 @@ static int split_commit_in_progress(struct wt_status *s)
 	return split_in_progress;
 }
 
+void get_two_last_lines(char *filename, int *numlines, char **lines)
+{
+	struct strbuf buf = STRBUF_INIT;
+	FILE *fp;
+
+	*numlines = 0;
+	fp = fopen(git_path("%s", filename), "r");
+	if (!fp) {
+		strbuf_release(&buf);
+		return;
+	}
+	while (strbuf_getline(&buf, fp, '\n') != EOF) {
+		(*numlines)++;
+		lines[0] = lines[1];
+		lines[1] = strbuf_detach(&buf, NULL);
+	}
+	fclose(fp);
+}
+
+void get_two_first_lines(char *filename, int *numlines, char **lines)
+{
+	struct strbuf buf = STRBUF_INIT;;
+	char *line;
+	FILE *fp;
+
+
+	*numlines = 0;
+	fp = fopen(git_path("%s", filename), "r");
+	if (!fp) {
+		strbuf_release(&buf);
+		return;
+	}
+	while (strbuf_getline(&buf, fp, '\n') != EOF) {
+		stripspace(&buf, 1);
+		line = strbuf_detach(&buf, NULL);
+		if (strcmp(line, "") == 0)
+			continue;
+		if (*numlines < 2)
+			lines[*numlines] = line;
+		(*numlines)++;
+	}
+	fclose(fp);
+}
+
+static void show_rebase_information(struct wt_status *s,
+				    struct wt_status_state *state,
+				    const char *color)
+{
+	if (state->rebase_interactive_in_progress) {
+		int i, begin;
+		int numlines = 0;
+		char *lines[2];
+		get_two_last_lines("rebase-merge/done", &numlines, lines);
+		if (numlines == 0)
+			status_printf_ln(s,color,_("No command done."));
+		else{
+			status_printf_ln(s,color,
+				_("Last command(s) done (%d command(s) done):"),
+				numlines);
+			begin = numlines > 1? 0 : 1;
+			for (i = begin; i < 2; i++) {
+				status_printf_ln(s,color,"   %s",lines[i]);
+			}
+			if (numlines > 2 && s->hints)
+			   status_printf_ln(s,color,
+				_("  (see more at .git/rebase-merge/done)"));
+		}
+		numlines = 0;
+		get_two_first_lines("rebase-merge/git-rebase-todo",
+					 &numlines, lines);
+		if (numlines == 0)
+			status_printf_ln(s, color,
+					 _("No command remaining."));
+		else{
+
+			status_printf_ln(s, color,
+				_("Next command(s) to do (%d remaining command(s)):"),
+				numlines);
+			begin = numlines > 1? 0 : 1;
+			for (i = 0; (i < 2 && i < numlines); i++) {
+				status_printf(s, color, "   %s", lines[i]);
+			}
+			if (s->hints)
+			   status_printf_ln(s, color,
+				_("  (use git rebase --edit-todo to view and edit)"));
+		}
+	}
+}
+
 static void show_rebase_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
 {
 	struct stat st;
 
+	show_rebase_information(s, state, color);
 	if (has_unmerged(s) || state->rebase_in_progress || !stat(git_path("MERGE_MSG"), &st)) {
 		if (state->branch)
 			status_printf_ln(s, color,
-- 
2.4.2.342.g3cebd9b
