From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH 3/4] status: give more information during rebase -i
Date: Tue,  9 Jun 2015 16:42:41 +0200
Message-ID: <1433860962-13222-3-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
References: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 16:43:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Kk3-0004XY-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 16:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbbFIOm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 10:42:58 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:53782 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932466AbbFIOmv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 10:42:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D428423B4;
	Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MT9yXevVZxtC; Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C1C21234B;
	Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id BD4E420E2;
	Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mmxI3AXmD+7k; Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
Received: from guillaume-W35-37ET.grenet.fr (wificampus-028068.grenet.fr [130.190.28.68])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id A457120DC;
	Tue,  9 Jun 2015 16:42:48 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.342.ga3499d3
In-Reply-To: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271187>

git status gives more information during rebase -i, about the list of
command that are done during the rebase. It displays the two last
commands executed and the two next lines to be executed. It also gives
hints to find the whole files in .git directory.

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
---
 t/t7512-status-help.sh | 111 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 wt-status.c            |  64 ++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 190656d..0c889fa 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -134,9 +134,13 @@ test_expect_success 'prepare for rebase_i_conflict=
s' '
 test_expect_success 'status during rebase -i when conflicts unresolved=
' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=3D$(git rev-parse --short rebase_i_conflicts) &&
+	LAST_COMMIT=3D$(git rev-parse rebase_i_conflicts_second) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command done (1 command done):
+   pick $LAST_COMMIT one_second
+No commands remaining.
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on=
 '\''$ONTO'\''.
   (fix conflicts and then run "git rebase --continue")
   (use "git rebase --skip" to skip this patch)
@@ -159,10 +163,14 @@ test_expect_success 'status during rebase -i afte=
r resolving conflicts' '
 	git reset --hard rebase_i_conflicts_second &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=3D$(git rev-parse --short rebase_i_conflicts) &&
+	LAST_COMMIT=3D$(git rev-parse rebase_i_conflicts_second) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last command done (1 command done):
+   pick $LAST_COMMIT one_second
+No commands remaining.
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on=
 '\''$ONTO'\''.
   (all conflicts fixed: run "git rebase --continue")
=20
@@ -183,7 +191,9 @@ test_expect_success 'status when rebasing -i in edi=
t mode' '
 	git checkout -b rebase_i_edit &&
 	test_commit one_rebase_i main.txt one &&
 	test_commit two_rebase_i main.txt two &&
+	COMMIT2=3D$(git rev-parse rebase_i_edit) &&
 	test_commit three_rebase_i main.txt three &&
+	COMMIT3=3D$(git rev-parse rebase_i_edit) &&
 	FAKE_LINES=3D"1 edit 2" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
@@ -191,6 +201,10 @@ test_expect_success 'status when rebasing -i in ed=
it mode' '
 	git rebase -i HEAD~2 &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   pick $COMMIT2 two_rebase_i
+   edit $COMMIT3 three_rebase_i
+No commands remaining.
 You are currently editing a commit while rebasing branch '\''rebase_i_=
edit'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -207,8 +221,11 @@ test_expect_success 'status when splitting a commi=
t' '
 	git checkout -b split_commit &&
 	test_commit one_split main.txt one &&
 	test_commit two_split main.txt two &&
+	COMMIT2=3D$(git rev-parse split_commit) &&
 	test_commit three_split main.txt three &&
+	COMMIT3=3D$(git rev-parse split_commit) &&
 	test_commit four_split main.txt four &&
+	COMMIT4=3D$(git rev-parse split_commit) &&
 	FAKE_LINES=3D"1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
@@ -217,6 +234,12 @@ test_expect_success 'status when splitting a commi=
t' '
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   pick $COMMIT2 two_split
+   edit $COMMIT3 three_split
+Next command to do (1 remaining command):
+   pick $COMMIT4 four_split
+  (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''split_c=
ommit'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -239,7 +262,9 @@ test_expect_success 'status after editing the last =
commit with --amend during a
 	test_commit one_amend main.txt one &&
 	test_commit two_amend main.txt two &&
 	test_commit three_amend main.txt three &&
+	COMMIT3=3D$(git rev-parse amend_last) &&
 	test_commit four_amend main.txt four &&
+	COMMIT4=3D$(git rev-parse amend_last) &&
 	FAKE_LINES=3D"1 2 edit 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
@@ -248,6 +273,11 @@ test_expect_success 'status after editing the last=
 commit with --amend during a
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (3 commands done):
+   pick $COMMIT3 three_amend
+   edit $COMMIT4 four_amend
+  (see more in file .git/rebase-merge/done)
+No commands remaining.
 You are currently editing a commit while rebasing branch '\''amend_las=
t'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -273,11 +303,20 @@ test_expect_success 'status: (continue first edit=
) second edit' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command to do (1 remaining command):
+   pick $COMMIT4 four_edits
+  (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -294,12 +333,21 @@ test_expect_success 'status: (continue first edit=
) second edit and split' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command to do (1 remaining command):
+   pick $COMMIT4 four_edits
+  (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -321,12 +369,21 @@ test_expect_success 'status: (continue first edit=
) second edit and amend' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command to do (1 remaining command):
+   pick $COMMIT4 four_edits
+  (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -343,12 +400,21 @@ test_expect_success 'status: (amend first edit) s=
econd edit' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "a" &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command to do (1 remaining command):
+   pick $COMMIT4 four_edits
+  (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -366,12 +432,21 @@ test_expect_success 'status: (amend first edit) s=
econd edit and split' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "b" &&
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command to do (1 remaining command):
+   pick $COMMIT4 four_edits
+  (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -393,6 +468,9 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and amend' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "c" &&
@@ -400,6 +478,12 @@ test_expect_success 'status: (amend first edit) se=
cond edit and amend' '
 	git commit --amend -m "d" &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command to do (1 remaining command):
+   pick $COMMIT4 four_edits
+  (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -416,6 +500,9 @@ test_expect_success 'status: (split first edit) sec=
ond edit' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
@@ -424,6 +511,12 @@ test_expect_success 'status: (split first edit) se=
cond edit' '
 	git rebase --continue &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command to do (1 remaining command):
+   pick $COMMIT4 four_edits
+  (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -440,6 +533,9 @@ test_expect_success 'status: (split first edit) sec=
ond edit and split' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
@@ -449,6 +545,12 @@ test_expect_success 'status: (split first edit) se=
cond edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command to do (1 remaining command):
+   pick $COMMIT4 four_edits
+  (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -470,6 +572,9 @@ test_expect_success 'status: (split first edit) sec=
ond edit and amend' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
@@ -479,6 +584,12 @@ test_expect_success 'status: (split first edit) se=
cond edit and amend' '
 	git commit --amend -m "h" &&
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command to do (1 remaining command):
+   pick $COMMIT4 four_edits
+  (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
diff --git a/wt-status.c b/wt-status.c
index 2339000..8b6d29c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1025,6 +1025,69 @@ static int split_commit_in_progress(struct wt_st=
atus *s)
 	free(rebase_orig_head);
 	return split_in_progress;
 }
+
+static void show_rebase_information(struct wt_status *s,
+					struct wt_status_state *state,
+					const char *color)
+{
+	if (state->rebase_interactive_in_progress) {
+		int i;
+		int nr_lines_to_show =3D 2;
+
+		struct strbuf buf =3D STRBUF_INIT;
+		struct string_list have_done =3D STRING_LIST_INIT_DUP;
+		struct string_list yet_to_do =3D STRING_LIST_INIT_DUP;
+
+		strbuf_read_file(&buf, git_path("rebase-merge/done"), 0);
+		stripspace(&buf, 1);
+		string_list_split(&have_done, buf.buf, '\n', -1);
+		string_list_remove_empty_items(&have_done, 1);
+		strbuf_release(&buf);
+
+		strbuf_read_file(&buf, git_path("rebase-merge/git-rebase-todo"), 0);
+		stripspace(&buf, 1);
+		string_list_split(&yet_to_do, buf.buf, '\n', -1);
+		string_list_remove_empty_items(&yet_to_do, 1);
+		strbuf_release(&buf);
+
+		if (have_done.nr =3D=3D 0)
+			status_printf_ln(s, color, _("No commands done."));
+		else {
+			status_printf_ln(s, color,
+				Q_("Last command done (%d command done):",
+					"Last commands done (%d commands done):",
+					have_done.nr),
+				have_done.nr);
+			for (i =3D (have_done.nr > nr_lines_to_show)
+				? have_done.nr - nr_lines_to_show : 0;
+				i < have_done.nr;
+				i++)
+				status_printf_ln(s, color, "   %s", have_done.items[i].string);
+			if (have_done.nr > nr_lines_to_show && s->hints)
+				status_printf_ln(s, color,
+					_("  (see more in file %s)"), git_path("rebase-merge/done"));
+		}
+
+		if (yet_to_do.nr =3D=3D 0)
+			status_printf_ln(s, color,
+					 _("No commands remaining."));
+		else {
+			status_printf_ln(s, color,
+				Q_("Next command to do (%d remaining command):",
+					"Next commands to do (%d remaining commands):",
+					yet_to_do.nr),
+				yet_to_do.nr);
+			for (i =3D 0; i < nr_lines_to_show && i < yet_to_do.nr; i++)
+				status_printf_ln(s, color, "   %s", yet_to_do.items[i].string);
+			if (s->hints)
+				status_printf_ln(s, color,
+					_("  (use \"git rebase --edit-todo\" to view and edit)"));
+		}
+		string_list_clear(&yet_to_do, 0);
+		string_list_clear(&have_done, 0);
+	}
+}
+
 static void print_rebase_state(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
@@ -1045,6 +1108,7 @@ static void show_rebase_in_progress(struct wt_sta=
tus *s,
 {
 	struct stat st;
=20
+	show_rebase_information(s, state, color);
 	if (has_unmerged(s)) {
 		print_rebase_state(s, state, color);
 		if (s->hints) {
--=20
2.4.2.342.ga3499d3
