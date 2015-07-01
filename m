From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v6 3/4] status: give more information during rebase -i
Date: Wed,  1 Jul 2015 23:08:35 +0200
Message-ID: <1435784916-15456-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqk2ujoadw.fsf@anie.imag.fr>
 <1435784916-15456-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 01 23:09:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAPFf-0004LE-M3
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 23:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbbGAVI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2015 17:08:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54717 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321AbbGAVIz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 17:08:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t61L8lYN011148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Jul 2015 23:08:47 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t61L8n3Z025578;
	Wed, 1 Jul 2015 23:08:49 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZAPFR-0004gn-Ni; Wed, 01 Jul 2015 23:08:49 +0200
X-Mailer: git-send-email 2.5.0.rc0.7.ge1edd74.dirty
In-Reply-To: <1435784916-15456-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 01 Jul 2015 23:08:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t61L8lYN011148
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436389728.70208@+NwaPDYSKvbtd6phIkqUpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273202>

=46rom: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-inp.fr>

git status gives more information during rebase -i, about the list of
command that are done during the rebase. It displays the two last
commands executed and the two next lines to be executed. It also gives
hints to find the whole files in .git directory.

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Applied Junio's remark on C code to abbreviate sha1s and filter comment=
s.

 t/t7512-status-help.sh | 111 +++++++++++++++++++++++++++++++++++++++++=
+++++++
 wt-status.c            | 113 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 224 insertions(+)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 190656d..9be0235 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -134,9 +134,13 @@ test_expect_success 'prepare for rebase_i_conflict=
s' '
 test_expect_success 'status during rebase -i when conflicts unresolved=
' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=3D$(git rev-parse --short rebase_i_conflicts) &&
+	LAST_COMMIT=3D$(git rev-parse --short rebase_i_conflicts_second) &&
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
+	LAST_COMMIT=3D$(git rev-parse --short rebase_i_conflicts_second) &&
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
+	COMMIT2=3D$(git rev-parse --short rebase_i_edit) &&
 	test_commit three_rebase_i main.txt three &&
+	COMMIT3=3D$(git rev-parse --short rebase_i_edit) &&
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
+	COMMIT2=3D$(git rev-parse --short split_commit) &&
 	test_commit three_split main.txt three &&
+	COMMIT3=3D$(git rev-parse --short split_commit) &&
 	test_commit four_split main.txt four &&
+	COMMIT4=3D$(git rev-parse --short split_commit) &&
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
+	COMMIT3=3D$(git rev-parse --short amend_last) &&
 	test_commit four_amend main.txt four &&
+	COMMIT4=3D$(git rev-parse --short amend_last) &&
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
+	COMMIT2=3D$(git rev-parse --short several_edits^^) &&
+	COMMIT3=3D$(git rev-parse --short several_edits^) &&
+	COMMIT4=3D$(git rev-parse --short several_edits) &&
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
+	COMMIT2=3D$(git rev-parse --short several_edits^^) &&
+	COMMIT3=3D$(git rev-parse --short several_edits^) &&
+	COMMIT4=3D$(git rev-parse --short several_edits) &&
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
+	COMMIT2=3D$(git rev-parse --short several_edits^^) &&
+	COMMIT3=3D$(git rev-parse --short several_edits^) &&
+	COMMIT4=3D$(git rev-parse --short several_edits) &&
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
+	COMMIT2=3D$(git rev-parse --short several_edits^^) &&
+	COMMIT3=3D$(git rev-parse --short several_edits^) &&
+	COMMIT4=3D$(git rev-parse --short several_edits) &&
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
+	COMMIT2=3D$(git rev-parse --short several_edits^^) &&
+	COMMIT3=3D$(git rev-parse --short several_edits^) &&
+	COMMIT4=3D$(git rev-parse --short several_edits) &&
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
+	COMMIT2=3D$(git rev-parse --short several_edits^^) &&
+	COMMIT3=3D$(git rev-parse --short several_edits^) &&
+	COMMIT4=3D$(git rev-parse --short several_edits) &&
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
+	COMMIT2=3D$(git rev-parse --short several_edits^^) &&
+	COMMIT3=3D$(git rev-parse --short several_edits^) &&
+	COMMIT4=3D$(git rev-parse --short several_edits) &&
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
+	COMMIT2=3D$(git rev-parse --short several_edits^^) &&
+	COMMIT3=3D$(git rev-parse --short several_edits^) &&
+	COMMIT4=3D$(git rev-parse --short several_edits) &&
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
+	COMMIT2=3D$(git rev-parse --short several_edits^^) &&
+	COMMIT3=3D$(git rev-parse --short several_edits^) &&
+	COMMIT4=3D$(git rev-parse --short several_edits) &&
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
index 81610dc..0204c17 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1027,6 +1027,118 @@ static int split_commit_in_progress(struct wt_s=
tatus *s)
 	return split_in_progress;
 }
=20
+/*
+ * Turn
+ * "pick d6a2f0303e897ec257dd0e0a39a5ccb709bc2047 some message"
+ * into
+ * "pick d6a2f03 some message"
+ *
+ * The function assumes that the line does not contain useless spaces
+ * before or after the command.
+ */
+static void abbrev_sha1_in_line(struct strbuf *line)
+{
+	struct strbuf **split;
+	int i;
+
+	if (starts_with(line->buf, "exec ") ||
+	    starts_with(line->buf, "x "))
+		return;
+
+	split =3D strbuf_split_max(line, ' ', 3);
+	if (split[0] && split[1]) {
+		unsigned char sha1[20];
+		const char *abbrev;
+
+		/*
+		 * strbuf_split_max left a space. Trim it and re-add
+		 * it after abbreviation.
+		 */
+		strbuf_trim(split[1]);
+		if (!get_sha1(split[1]->buf, sha1)) {
+			abbrev =3D find_unique_abbrev(sha1, DEFAULT_ABBREV);
+			strbuf_reset(split[1]);
+			strbuf_addf(split[1], "%s ", abbrev);
+			strbuf_reset(line);
+			for (i =3D 0; split[i]; i++)
+				strbuf_addf(line, "%s", split[i]->buf);
+		}
+	}
+	for (i =3D 0; split[i]; i++)
+		strbuf_release(split[i]);
+
+}
+
+static void read_rebase_todolist(const char *fname, struct string_list=
 *lines)
+{
+	struct strbuf line =3D STRBUF_INIT;
+	FILE *f =3D fopen(git_path(fname), "r");
+
+	if (!f)
+		die_errno("Could not open file %s for reading", git_path(fname));
+	while (!strbuf_getline(&line, f, '\n')) {
+		if (line.len && line.buf[0] =3D=3D comment_line_char)
+			continue;
+		strbuf_trim(&line);
+		if (!line.len)
+			continue;
+		abbrev_sha1_in_line(&line);
+		string_list_append(lines, line.buf);
+	}
+}
+
+static void show_rebase_information(struct wt_status *s,
+					struct wt_status_state *state,
+					const char *color)
+{
+	if (state->rebase_interactive_in_progress) {
+		int i;
+		int nr_lines_to_show =3D 2;
+
+		struct string_list have_done =3D STRING_LIST_INIT_DUP;
+		struct string_list yet_to_do =3D STRING_LIST_INIT_DUP;
+
+		read_rebase_todolist("rebase-merge/done", &have_done);
+		read_rebase_todolist("rebase-merge/git-rebase-todo", &yet_to_do);
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
@@ -1047,6 +1159,7 @@ static void show_rebase_in_progress(struct wt_sta=
tus *s,
 {
 	struct stat st;
=20
+	show_rebase_information(s, state, color);
 	if (has_unmerged(s)) {
 		print_rebase_state(s, state, color);
 		if (s->hints) {
--=20
2.5.0.rc0.7.ge1edd74.dirty
