From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] status: show the branch name if possible in in-progress info
Date: Sun,  3 Feb 2013 12:53:27 +0700
Message-ID: <1359870807-22817-1-git-send-email-pclouds@gmail.com>
References: <1359471493-32531-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 06:53:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1sVx-0006rd-PP
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 06:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204Ab3BCFw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2013 00:52:56 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:39327 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab3BCFwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 00:52:54 -0500
Received: by mail-pb0-f43.google.com with SMTP id jt11so2719937pbb.30
        for <git@vger.kernel.org>; Sat, 02 Feb 2013 21:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=6lS6EF6ut/Oq2vvFdfhyAQTlVseMAzw0AXWrPFvBMxA=;
        b=ZqCHP2s3lyd8cxLLkxUj5noIHtDCMnowhj78oSk8SH1bgNqxpsrzYLMW478NkZCBMX
         rx3xOS34T6Isgf/D+yky2Nb6uDCS8M9lHb0/wg/x1Xxp85xJ/2b0hBcDt0p/mD6AwSHH
         O8WKLS77wCg7FcRa3pP6HddNoNVS24Fo736cv7ImRv2sezGlV+wS1Iby7nT8mdrnb2mZ
         RGNQfYsdyP7V+eJVMCM9EvRxlYVbjZSIC+uY8PVPvOPR+wOtq347N1luyozrPYY/oVyz
         WdsnTkghxQKbOgFTznlVCJ1GlAGAOwrNMSCyu71OVd9XZIeyi0yOnwm2yNgzuqixklug
         Xm8Q==
X-Received: by 10.66.83.134 with SMTP id q6mr42308122pay.34.1359870774075;
        Sat, 02 Feb 2013 21:52:54 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id f9sm14696870paz.12.2013.02.02.21.52.49
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 02 Feb 2013 21:52:53 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 03 Feb 2013 12:53:29 +0700
X-Mailer: git-send-email 1.8.1.1.459.g5970e58
In-Reply-To: <1359471493-32531-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215301>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 - avoid hardcoding SHA-1 in t7512
 - I did not act on Junio's --format=3D%s idea because frankly I don't
   care much about the "on 'xxx'" part. It was Matthieu's idea and he
   did not make any comments on --format=3D%s

 t/t7512-status-help.sh | 87 +++++++++++++++++++++++++++---------------=
----
 wt-status.c            | 94 ++++++++++++++++++++++++++++++++++++++++++=
++++----
 wt-status.h            |  2 ++
 3 files changed, 142 insertions(+), 41 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index b3f6eb9..51ab894 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -73,10 +73,11 @@ test_expect_success 'prepare for rebase conflicts' =
'
=20
 test_expect_success 'status when rebase in progress before resolving c=
onflicts' '
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$=
ONTO'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
 	#   (use "git rebase --abort" to check out the original branch)
@@ -97,12 +98,13 @@ test_expect_success 'status when rebase in progress=
 before resolving conflicts'
 test_expect_success 'status when rebase in progress before rebase --co=
ntinue' '
 	git reset --hard rebase_conflicts &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	echo three >main.txt &&
 	git add main.txt &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$=
ONTO'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
 	# Changes to be committed:
@@ -130,10 +132,11 @@ test_expect_success 'prepare for rebase_i_conflic=
ts' '
=20
 test_expect_success 'status during rebase -i when conflicts unresolved=
' '
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing branch '\''rebase_i_conflicts_second'\''=
 on '\''$ONTO'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
 	#   (use "git rebase --abort" to check out the original branch)
@@ -154,11 +157,12 @@ test_expect_success 'status during rebase -i when=
 conflicts unresolved' '
 test_expect_success 'status during rebase -i after resolving conflicts=
' '
 	git reset --hard rebase_i_conflicts_second &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing branch '\''rebase_i_conflicts_second'\''=
 on '\''$ONTO'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
 	# Changes to be committed:
@@ -182,10 +186,11 @@ test_expect_success 'status when rebasing -i in e=
dit mode' '
 	FAKE_LINES=3D"1 edit 2" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~2) &&
 	git rebase -i HEAD~2 &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''rebase=
_i_edit'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -206,11 +211,12 @@ test_expect_success 'status when splitting a comm=
it' '
 	FAKE_LINES=3D"1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing branch '\''spli=
t_commit'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -236,11 +242,12 @@ test_expect_success 'status after editing the las=
t commit with --amend during a
 	FAKE_LINES=3D"1 2 edit 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''amend_=
last'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -265,11 +272,12 @@ test_expect_success 'status: (continue first edit=
) second edit' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -285,12 +293,13 @@ test_expect_success 'status: (continue first edit=
) second edit and split' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git reset HEAD^ &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing branch '\''seve=
ral_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -311,12 +320,13 @@ test_expect_success 'status: (continue first edit=
) second edit and amend' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -332,12 +342,13 @@ test_expect_success 'status: (amend first edit) s=
econd edit' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "a" &&
 	git rebase --continue &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -353,13 +364,14 @@ test_expect_success 'status: (amend first edit) s=
econd edit and split' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "b" &&
 	git rebase --continue &&
 	git reset HEAD^ &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing branch '\''seve=
ral_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -380,13 +392,14 @@ test_expect_success 'status: (amend first edit) s=
econd edit and amend' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "c" &&
 	git rebase --continue &&
 	git commit --amend -m "d" &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -402,14 +415,15 @@ test_expect_success 'status: (split first edit) s=
econd edit' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	git add main.txt &&
 	git commit -m "e" &&
 	git rebase --continue &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -425,15 +439,16 @@ test_expect_success 'status: (split first edit) s=
econd edit and split' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	git add main.txt &&
 	git commit --amend -m "f" &&
 	git rebase --continue &&
 	git reset HEAD^ &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing branch '\''seve=
ral_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -454,15 +469,16 @@ test_expect_success 'status: (split first edit) s=
econd edit and amend' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	git add main.txt &&
 	git commit --amend -m "g" &&
 	git rebase --continue &&
 	git commit --amend -m "h" &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -558,7 +574,7 @@ test_expect_success 'status when bisecting' '
 	git bisect good one_bisect &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently bisecting.
+	# You are currently bisecting branch '\''bisect'\''.
 	#   (use "git bisect reset" to get back to the original branch)
 	#
 	nothing to commit (use -u to show untracked files)
@@ -577,10 +593,11 @@ test_expect_success 'status when rebase conflicts=
 with statushints disabled' '
 	test_commit two_statushints main.txt two &&
 	test_commit three_statushints main.txt three &&
 	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing branch '\''statushints_disabled'\'' on '=
\''$ONTO'\''.
 	#
 	# Unmerged paths:
 	#	both modified:      main.txt
diff --git a/wt-status.c b/wt-status.c
index d7cfe8f..983e2f4 100644
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
@@ -923,16 +951,57 @@ static void show_bisect_in_progress(struct wt_sta=
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
+/*
+ * Extract branch information from rebase/bisect
+ */
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
@@ -947,17 +1016,28 @@ static void wt_status_print_state(struct wt_stat=
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
@@ -969,6 +1049,8 @@ static void wt_status_print_state(struct wt_status=
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
