From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/4] status: show more info than "currently not on any branch"
Date: Wed,  6 Mar 2013 19:21:21 +0700
Message-ID: <1362572482-20570-4-git-send-email-pclouds@gmail.com>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 13:21:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDDLQ-0008AW-GN
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 13:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758060Ab3CFMUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 07:20:47 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:39668 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939Ab3CFMUp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 07:20:45 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so5939774pbc.11
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 04:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ueT/c9i5+bF92WN2QZXnOSf6PEcTkab0jPCa8Erh4+k=;
        b=Ezp33bkelimReej6cEfXqy0vwDu8IMwvpDLUUWk7UtGewpY7eCV4oFlrmHS67dqzXN
         SOa+7cjxY8c2JD9g120B1Ja+lhbMVk84Y7ldhhW9hpGMx6hx4jGxl3MEI/JTYnrYhI/X
         vawD07rYSiNOBDDw6G6x61c94UURKM0CnTB1DtmsYiKJ5sp+O4nGsmUNwHGJ6A+AG51G
         sqR7EW7Y6wIquJMOx5IFrQfI5v29h1lO//JrPbANO3VCGZ+TFZ05cDZVIl/XFEo/Z2WY
         WbM9iT9I66Id5RvY2KpmCrLPBHfn6I7P0q1LMpvaJyc2MBHrdgzGTVY+EQiPb9EygTf/
         IWig==
X-Received: by 10.68.41.197 with SMTP id h5mr46160896pbl.88.1362572445168;
        Wed, 06 Mar 2013 04:20:45 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id kl4sm31097578pbc.31.2013.03.06.04.20.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Mar 2013 04:20:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 06 Mar 2013 19:21:52 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362572482-20570-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217519>

When a remote ref or a tag is checked out, HEAD is automatically
detached. There is no user-friendly way to find out what ref is
checked out in this case. This patch digs in reflog for this
information and shows "HEAD detached from origin/master" or "HEAD
detached at v1.8.0" instead of "currently not on any branch".

When it cannot figure out the original ref, it shows an abbreviated
SHA-1. "Currently not on any branch" would never display (unless
reflog is pruned to near empty that the last checkout entry is lost).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t7406-submodule-update.sh |  6 ++--
 t/t7512-status-help.sh      | 52 +++++++++++++++++----------
 wt-status.c                 | 85 +++++++++++++++++++++++++++++++++++++=
+++++---
 wt-status.h                 |  4 ++-
 4 files changed, 121 insertions(+), 26 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4975ec0..50ac020 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -664,8 +664,10 @@ test_expect_success 'submodule add properly re-cre=
ates deeper level submodules'
=20
 test_expect_success 'submodule update properly revives a moved submodu=
le' '
 	(cd super &&
+	 H=3D$(git rev-parse --short HEAD) &&
 	 git commit -am "pre move" &&
-	 git status >expect&&
+	 H2=3D$(git rev-parse --short HEAD) &&
+	 git status | sed "s/$H/XXX/" >expect &&
 	 H=3D$(cd submodule2; git rev-parse HEAD) &&
 	 git rm --cached submodule2 &&
 	 rm -rf submodule2 &&
@@ -674,7 +676,7 @@ test_expect_success 'submodule update properly revi=
ves a moved submodule' '
 	 git config -f .gitmodules submodule.submodule2.path "moved/sub modul=
e"
 	 git commit -am "post move" &&
 	 git submodule update &&
-	 git status >actual &&
+	 git status | sed "s/$H2/XXX/" >actual &&
 	 test_cmp expect actual
 	)
 '
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index d2da89a..da22088 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -76,7 +76,7 @@ test_expect_success 'status when rebase in progress b=
efore resolving conflicts'
 	ONTO=3D$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached at $ONTO
 	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$=
ONTO'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
@@ -103,7 +103,7 @@ test_expect_success 'status when rebase in progress=
 before rebase --continue' '
 	echo three >main.txt &&
 	git add main.txt &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached at $ONTO
 	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$=
ONTO'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
@@ -135,7 +135,7 @@ test_expect_success 'status during rebase -i when c=
onflicts unresolved' '
 	ONTO=3D$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached at $ONTO
 	# You are currently rebasing branch '\''rebase_i_conflicts_second'\''=
 on '\''$ONTO'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
@@ -161,7 +161,7 @@ test_expect_success 'status during rebase -i after =
resolving conflicts' '
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached at $ONTO
 	# You are currently rebasing branch '\''rebase_i_conflicts_second'\''=
 on '\''$ONTO'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
@@ -187,9 +187,10 @@ test_expect_success 'status when rebasing -i in ed=
it mode' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=3D$(git rev-parse --short HEAD~2) &&
+	TGT=3D$(git rev-parse --short two_rebase_i) &&
 	git rebase -i HEAD~2 &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $TGT
 	# You are currently editing a commit while rebasing branch '\''rebase=
_i_edit'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
@@ -214,8 +215,9 @@ test_expect_success 'status when splitting a commit=
' '
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
+	TGT=3D$(git rev-parse --short HEAD) &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached at $TGT
 	# You are currently splitting a commit while rebasing branch '\''spli=
t_commit'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
@@ -243,10 +245,11 @@ test_expect_success 'status after editing the las=
t commit with --amend during a
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
+	TGT=3D$(git rev-parse --short three_amend) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $TGT
 	# You are currently editing a commit while rebasing branch '\''amend_=
last'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
@@ -276,7 +279,7 @@ test_expect_success 'status: (continue first edit) =
second edit' '
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $ONTO
 	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
@@ -298,7 +301,7 @@ test_expect_success 'status: (continue first edit) =
second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $ONTO
 	# You are currently splitting a commit while rebasing branch '\''seve=
ral_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
@@ -325,7 +328,7 @@ test_expect_success 'status: (continue first edit) =
second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $ONTO
 	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
@@ -347,7 +350,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit' '
 	git commit --amend -m "a" &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $ONTO
 	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
@@ -370,7 +373,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $ONTO
 	# You are currently splitting a commit while rebasing branch '\''seve=
ral_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
@@ -398,7 +401,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "d" &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $ONTO
 	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
@@ -422,7 +425,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit' '
 	git commit -m "e" &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $ONTO
 	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
@@ -447,7 +450,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $ONTO
 	# You are currently splitting a commit while rebasing branch '\''seve=
ral_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
@@ -477,7 +480,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "h" &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached from $ONTO
 	# You are currently editing a commit while rebasing branch '\''severa=
l_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
@@ -572,8 +575,9 @@ test_expect_success 'status when bisecting' '
 	git bisect start &&
 	git bisect bad &&
 	git bisect good one_bisect &&
-	cat >expected <<-\EOF &&
-	# Not currently on any branch.
+	TGT=3D$(git rev-parse --short two_bisect) &&
+	cat >expected <<-EOF &&
+	# HEAD detached at $TGT
 	# You are currently bisecting branch '\''bisect'\''.
 	#   (use "git bisect reset" to get back to the original branch)
 	#
@@ -596,7 +600,7 @@ test_expect_success 'status when rebase conflicts w=
ith statushints disabled' '
 	ONTO=3D$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<-EOF &&
-	# Not currently on any branch.
+	# HEAD detached at $ONTO
 	# You are currently rebasing branch '\''statushints_disabled'\'' on '=
\''$ONTO'\''.
 	#
 	# Unmerged paths:
@@ -662,5 +666,15 @@ test_expect_success 'status when cherry-picking af=
ter resolving conflicts' '
 	test_i18ncmp expected actual
 '
=20
+test_expect_success 'status showing detached from a tag' '
+	test_commit atag tagging &&
+	git checkout atag &&
+	cat >expected <<-\EOF
+	# HEAD detached at atag
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=3Dno >actual &&
+	test_i18ncmp expected actual
+'
=20
 test_done
diff --git a/wt-status.c b/wt-status.c
index 6a3566b..7797ccf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1001,7 +1001,68 @@ static void read_and_strip_branch(struct strbuf =
*sb,
 		*branch =3D xstrdup(*branch);
 }
=20
-void wt_status_get_state(struct wt_status_state *state)
+struct grab_1st_switch_cbdata {
+	struct strbuf buf;
+	unsigned char nsha1[20];
+};
+
+static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
+			   const char *email, unsigned long timestamp, int tz,
+			   const char *message, void *cb_data)
+{
+	struct grab_1st_switch_cbdata *cb =3D cb_data;
+	const char *target =3D NULL, *end;
+
+	if (prefixcmp(message, "checkout: moving from "))
+		return 0;
+	message +=3D strlen("checkout: moving from ");
+	target =3D strstr(message, " to ");
+	if (!target)
+		return 0;
+	target +=3D strlen(" to ");
+	strbuf_reset(&cb->buf);
+	hashcpy(cb->nsha1, nsha1);
+	for (end =3D target; *end && *end !=3D '\n'; end++)
+		;
+	strbuf_add(&cb->buf, target, end - target);
+	return 0;
+}
+
+static void wt_status_get_detached_from(struct wt_status_state *state)
+{
+	struct grab_1st_switch_cbdata cb;
+	struct commit *commit;
+	unsigned char sha1[20];
+	char *ref =3D NULL;
+
+	strbuf_init(&cb.buf, 0);
+	if (for_each_recent_reflog_ent("HEAD", grab_1st_switch, 4096, &cb))
+		for_each_reflog_ent("HEAD", grab_1st_switch, &cb);
+	if (!cb.buf.len)
+		return;
+
+	if (dwim_ref(cb.buf.buf, cb.buf.len, sha1, &ref) =3D=3D 1 &&
+	    (commit =3D lookup_commit_reference_gently(sha1, 1)) !=3D NULL &&
+	    !hashcmp(cb.nsha1, commit->object.sha1)) {
+		int ofs;
+		if (!prefixcmp(ref, "refs/tags/"))
+			ofs =3D strlen("refs/tags/");
+		else if (!prefixcmp(ref, "refs/remotes/"))
+			ofs =3D strlen("refs/remotes/");
+		else
+			ofs =3D 0;
+		state->detached_from =3D xstrdup(ref + ofs);
+	} else
+		state->detached_from =3D
+			xstrdup(find_unique_abbrev(cb.nsha1, DEFAULT_ABBREV));
+	hashcpy(state->detached_sha1, cb.nsha1);
+
+	free(ref);
+	strbuf_release(&cb.buf);
+}
+
+void wt_status_get_state(struct wt_status_state *state,
+			 int get_detached_from)
 {
 	struct strbuf branch =3D STRBUF_INIT;
 	struct strbuf onto =3D STRBUF_INIT;
@@ -1040,6 +1101,10 @@ void wt_status_get_state(struct wt_status_state =
*state)
 		read_and_strip_branch(&branch, &state->branch,
 				      "BISECT_START");
 	}
+
+	if (get_detached_from)
+		wt_status_get_detached_from(state);
+
 	strbuf_release(&branch);
 	strbuf_release(&onto);
 }
@@ -1066,7 +1131,8 @@ void wt_status_print(struct wt_status *s)
 	const char *branch_status_color =3D color(WT_STATUS_HEADER, s);
 	struct wt_status_state state;
=20
-	wt_status_get_state(&state);
+	wt_status_get_state(&state,
+			    s->branch && !strcmp(s->branch, "HEAD"));
=20
 	if (s->branch) {
 		const char *on_what =3D _("On branch ");
@@ -1074,9 +1140,19 @@ void wt_status_print(struct wt_status *s)
 		if (!prefixcmp(branch_name, "refs/heads/"))
 			branch_name +=3D 11;
 		else if (!strcmp(branch_name, "HEAD")) {
-			branch_name =3D "";
 			branch_status_color =3D color(WT_STATUS_NOBRANCH, s);
-			on_what =3D _("Not currently on any branch.");
+			if (state.detached_from) {
+				unsigned char sha1[20];
+				branch_name =3D state.detached_from;
+				if (!get_sha1("HEAD", sha1) &&
+				    !hashcmp(sha1, state.detached_sha1))
+					on_what =3D _("HEAD detached at ");
+				else
+					on_what =3D _("HEAD detached from ");
+			} else {
+				branch_name =3D "";
+				on_what =3D _("Not currently on any branch.");
+			}
 		}
 		status_printf(s, color(WT_STATUS_HEADER, s), "");
 		status_printf_more(s, branch_status_color, "%s", on_what);
@@ -1088,6 +1164,7 @@ void wt_status_print(struct wt_status *s)
 	wt_status_print_state(s, &state);
 	free(state.branch);
 	free(state.onto);
+	free(state.detached_from);
=20
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
diff --git a/wt-status.h b/wt-status.h
index 5ddcbf6..5cb7df9 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -81,12 +81,14 @@ struct wt_status_state {
 	int bisect_in_progress;
 	char *branch;
 	char *onto;
+	char *detached_from;
+	unsigned char detached_sha1[20];
 };
=20
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
-void wt_status_get_state(struct wt_status_state *state);
+void wt_status_get_state(struct wt_status_state *state, int get_detach=
ed_from);
=20
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
--=20
1.8.1.2.536.gf441e6d
