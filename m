From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] status: show the branch name if possible in in-progress info
Date: Tue, 29 Jan 2013 21:58:13 +0700
Message-ID: <1359471493-32531-1-git-send-email-pclouds@gmail.com>
References: <1359461450-24456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 15:58:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Cdu-0005uC-GH
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 15:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757119Ab3A2O6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 09:58:10 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:40960 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab3A2O6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 09:58:09 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so261101dal.29
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 06:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=eQKeoZvOgKZXe0ynaKPdUPZZDkSSSJqksTRVkradM9c=;
        b=Bl0CFtdIjD269ONFmwQuLARqwmE9549aGKgYSqmqP+lIzP0ZCipTsEiS+IZSUHUgFv
         UHazf0037WJTFV51te3NWGDY0XW3JHfNdE/C4oO/Nvgcy89KELaIk+sK1lDac+JyN8hu
         RUaD5fYPIUW2d4Eq1Po8i2aeWc/J9Poqld/mt4UabAz6yA90k+Mo9x5vKt+vhj3jyXf5
         a8eaa9ViDnuVaT8lM7QfeLs+42V2kET4SgaDumS7cz2AJk73GuJNTWOJvc1lb1Tm7rSZ
         5n612q2CIBMSkGI9TUoAq7DRVCK9XJdFnnxO/roaXed8gvNrVmKQlkAhBf7k2LrMP8bI
         1BFA==
X-Received: by 10.66.88.164 with SMTP id bh4mr3378043pab.41.1359471488719;
        Tue, 29 Jan 2013 06:58:08 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id gv9sm8540612pbc.21.2013.01.29.06.58.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 06:58:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jan 2013 21:58:41 +0700
X-Mailer: git-send-email 1.8.1.1.459.g5970e58
In-Reply-To: <1359461450-24456-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214938>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 - fix bisecting on detached HEAD
 - show onto sha-1 for rebase

 t/t7512-status-help.sh | 36 ++++++++++----------
 wt-status.c            | 91 ++++++++++++++++++++++++++++++++++++++++++=
++++----
 wt-status.h            |  2 ++
 3 files changed, 105 insertions(+), 24 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index b3f6eb9..67ece6b 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -76,7 +76,7 @@ test_expect_success 'status when rebase in progress b=
efore resolving conflicts'
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''0=
00106f'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
 	#   (use "git rebase --abort" to check out the original branch)
@@ -102,7 +102,7 @@ test_expect_success 'status when rebase in progress=
 before rebase --continue' '
 	git add main.txt &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''0=
00106f'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
 	# Changes to be committed:
@@ -133,7 +133,7 @@ test_expect_success 'status during rebase -i when c=
onflicts unresolved' '
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing branch '\''rebase_i_conflicts_second'\''=
 on '\''e0164e4'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
 	#   (use "git rebase --abort" to check out the original branch)
@@ -158,7 +158,7 @@ test_expect_success 'status during rebase -i after =
resolving conflicts' '
 	git add main.txt &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing branch '\''rebase_i_conflicts_second'\''=
 on '\''e0164e4'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
 	# Changes to be committed:
@@ -185,7 +185,7 @@ test_expect_success 'status when rebasing -i in edi=
t mode' '
 	git rebase -i HEAD~2 &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''rebase=
_i_edit'\'' on '\''f90e540'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -210,7 +210,7 @@ test_expect_success 'status when splitting a commit=
' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing branch '\''spli=
t_commit'\'' on '\''19b175e'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -240,7 +240,7 @@ test_expect_success 'status after editing the last =
commit with --amend during a
 	git commit --amend -m "foo" &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''amend_=
last'\'' on '\''dd030b9'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -269,7 +269,7 @@ test_expect_success 'status: (continue first edit) =
second edit' '
 	git rebase --continue &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''eb16a7e'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -290,7 +290,7 @@ test_expect_success 'status: (continue first edit) =
second edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing branch '\''seve=
ral_edits'\'' on '\''eb16a7e'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -316,7 +316,7 @@ test_expect_success 'status: (continue first edit) =
second edit and amend' '
 	git commit --amend -m "foo" &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''eb16a7e'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -337,7 +337,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit' '
 	git rebase --continue &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''eb16a7e'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -359,7 +359,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing branch '\''seve=
ral_edits'\'' on '\''eb16a7e'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -386,7 +386,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and amend' '
 	git commit --amend -m "d" &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''eb16a7e'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -409,7 +409,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit' '
 	git rebase --continue &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''eb16a7e'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -433,7 +433,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing branch '\''seve=
ral_edits'\'' on '\''eb16a7e'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -462,7 +462,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit and amend' '
 	git commit --amend -m "h" &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''eb16a7e'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -558,7 +558,7 @@ test_expect_success 'status when bisecting' '
 	git bisect good one_bisect &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently bisecting.
+	# You are currently bisecting branch '\''bisect'\''.
 	#   (use "git bisect reset" to get back to the original branch)
 	#
 	nothing to commit (use -u to show untracked files)
@@ -580,7 +580,7 @@ test_expect_success 'status when rebase conflicts w=
ith statushints disabled' '
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing branch '\''statushints_disabled'\'' on '=
\''1d51a61'\''.
 	#
 	# Unmerged paths:
 	#	both modified:      main.txt
diff --git a/wt-status.c b/wt-status.c
index d7cfe8f..42fafd0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -872,7 +872,14 @@ static void show_rebase_in_progress(struct wt_stat=
us *s,
 	struct stat st;
=20
 	if (has_unmerged(s)) {
-		status_printf_ln(s, color, _("You are currently rebasing."));
+		if (state->branch)
+			status_printf_ln(s, color,
+					 _("You are currently rebasing branch '%s' on '%s'."),
+					 state->branch,
+					 state->onto);
+		else
+			status_printf_ln(s, color,
+					 _("You are currently rebasing."));
 		if (advice_status_hints) {
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git rebase --continue\")"));
@@ -882,17 +889,38 @@ static void show_rebase_in_progress(struct wt_sta=
tus *s,
 				_("  (use \"git rebase --abort\" to check out the original branch)=
"));
 		}
 	} else if (state->rebase_in_progress || !stat(git_path("MERGE_MSG"), =
&st)) {
-		status_printf_ln(s, color, _("You are currently rebasing."));
+		if (state->branch)
+			status_printf_ln(s, color,
+					 _("You are currently rebasing branch '%s' on '%s'."),
+					 state->branch,
+					 state->onto);
+		else
+			status_printf_ln(s, color,
+					 _("You are currently rebasing."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
 	} else if (split_commit_in_progress(s)) {
-		status_printf_ln(s, color, _("You are currently splitting a commit d=
uring a rebase."));
+		if (state->branch)
+			status_printf_ln(s, color,
+					 _("You are currently splitting a commit while rebasing branch '%=
s' on '%s'."),
+					 state->branch,
+					 state->onto);
+		else
+			status_printf_ln(s, color,
+					 _("You are currently splitting a commit during a rebase."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (Once your working directory is clean, run \"git rebase --con=
tinue\")"));
 	} else {
-		status_printf_ln(s, color, _("You are currently editing a commit dur=
ing a rebase."));
+		if (state->branch)
+			status_printf_ln(s, color,
+					 _("You are currently editing a commit while rebasing branch '%s'=
 on '%s'."),
+					 state->branch,
+					 state->onto);
+		else
+			status_printf_ln(s, color,
+					 _("You are currently editing a commit during a rebase."));
 		if (advice_status_hints && !s->amend) {
 			status_printf_ln(s, color,
 				_("  (use \"git commit --amend\" to amend the current commit)"));
@@ -923,16 +951,54 @@ static void show_bisect_in_progress(struct wt_sta=
tus *s,
 				struct wt_status_state *state,
 				const char *color)
 {
-	status_printf_ln(s, color, _("You are currently bisecting."));
+	if (state->branch)
+		status_printf_ln(s, color,
+				 _("You are currently bisecting branch '%s'."),
+				 state->branch);
+	else
+		status_printf_ln(s, color,
+				 _("You are currently bisecting."));
 	if (advice_status_hints)
 		status_printf_ln(s, color,
 			_("  (use \"git bisect reset\" to get back to the original branch)"=
));
 	wt_status_print_trailer(s);
 }
=20
+static void read_and_strip_branch(struct strbuf *sb,
+				  const char **branch,
+				  const char *path)
+{
+	unsigned char sha1[20];
+
+	strbuf_reset(sb);
+	if (strbuf_read_file(sb, git_path("%s", path), 0) <=3D 0)
+		return;
+
+	while (sb->len && sb->buf[sb->len - 1] =3D=3D '\n')
+		strbuf_setlen(sb, sb->len - 1);
+	if (!sb->len)
+		return;
+	if (!prefixcmp(sb->buf, "refs/heads/"))
+		*branch =3D sb->buf + strlen("refs/heads/");
+	else if (!prefixcmp(sb->buf, "refs/"))
+		*branch =3D sb->buf;
+	else if (!get_sha1_hex(sb->buf, sha1)) {
+		const char *abbrev;
+		abbrev =3D find_unique_abbrev(sha1, DEFAULT_ABBREV);
+		strbuf_reset(sb);
+		strbuf_addstr(sb, abbrev);
+		*branch =3D sb->buf;
+	} else if (!strcmp(sb->buf, "detached HEAD")) /* rebase */
+		;
+	else			/* bisect */
+		*branch =3D sb->buf;
+}
+
 static void wt_status_print_state(struct wt_status *s)
 {
 	const char *state_color =3D color(WT_STATUS_HEADER, s);
+	struct strbuf branch =3D STRBUF_INIT;
+	struct strbuf onto =3D STRBUF_INIT;
 	struct wt_status_state state;
 	struct stat st;
=20
@@ -947,17 +1013,28 @@ static void wt_status_print_state(struct wt_stat=
us *s)
 				state.am_empty_patch =3D 1;
 		} else {
 			state.rebase_in_progress =3D 1;
+			read_and_strip_branch(&branch, &state.branch,
+					      "rebase-apply/head-name");
+			read_and_strip_branch(&onto, &state.onto,
+					      "rebase-apply/onto");
 		}
 	} else if (!stat(git_path("rebase-merge"), &st)) {
 		if (!stat(git_path("rebase-merge/interactive"), &st))
 			state.rebase_interactive_in_progress =3D 1;
 		else
 			state.rebase_in_progress =3D 1;
+		read_and_strip_branch(&branch, &state.branch,
+				      "rebase-merge/head-name");
+		read_and_strip_branch(&onto, &state.onto,
+				      "rebase-merge/onto");
 	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
 		state.cherry_pick_in_progress =3D 1;
 	}
-	if (!stat(git_path("BISECT_LOG"), &st))
+	if (!stat(git_path("BISECT_LOG"), &st)) {
 		state.bisect_in_progress =3D 1;
+		read_and_strip_branch(&branch, &state.branch,
+				      "BISECT_START");
+	}
=20
 	if (state.merge_in_progress)
 		show_merge_in_progress(s, &state, state_color);
@@ -969,6 +1046,8 @@ static void wt_status_print_state(struct wt_status=
 *s)
 		show_cherry_pick_in_progress(s, &state, state_color);
 	if (state.bisect_in_progress)
 		show_bisect_in_progress(s, &state, state_color);
+	strbuf_release(&branch);
+	strbuf_release(&onto);
 }
=20
 void wt_status_print(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index 236b41f..81e1dcf 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -79,6 +79,8 @@ struct wt_status_state {
 	int rebase_interactive_in_progress;
 	int cherry_pick_in_progress;
 	int bisect_in_progress;
+	const char *branch;
+	const char *onto;
 };
=20
 void wt_status_prepare(struct wt_status *s);
--=20
1.8.1.1.459.g5970e58
