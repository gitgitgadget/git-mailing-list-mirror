Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3A7F460
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730351185; cv=none; b=t0JKbajwrBHrAu6rWkC+1e+xTZTSTLptJD2ASOMo6vTc9sN9M2NBKUvJT0KbSRPWyMQzfHGcoeZbWKwfeUbHlN8nXJPWAkd8zvWPeRZVlObslm2lCdib4/4ZzEF6B+uOH0GXU6HWrbH+0fP48yBXv2MgpRrH7txdqZjQThy5q6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730351185; c=relaxed/simple;
	bh=NaLIt9/R/ZopuKOarezqXA+gWg+UCfOoNy5xfYn/qPM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnvmeYwv2w8o5jPZZhhP7PNOXauXOONP2i1VtcHtYR+BFdJJVoBtwmylPpevQjFBqMzsGd9/CUkrMrhalH+zR5ycfzGLms/2w8oin1MsARF8tqv7TNLNfQSvRBX56fUzZZ2v0xIeanGOeV6yqZGydjWI3jaRwW/Lmme/lC1iDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CD0Z9VX/; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CD0Z9VX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730351180; x=1730610380;
	bh=Y7cTFxySM2FlwWOAO6t25hoFSiE1K8/ErABiqRK2G3I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CD0Z9VX/3D5oIAyOkq1r+nks8wNqe0YolT11fAQGJbxX13S6AquS1a7escTBtA2n4
	 xsx/WmTSmQ+eU/Rfu5vmlkLzgaQuSvKdaD4oYYWR+6rtkmLf/M7vNIRa/cAAykyeIC
	 6pWx2kGiv/82tJo0uKa+A74gHvnhCcKRnsn7XYv6fER6otVXPBSDxi8P0B26OsPPpA
	 yIieNaQRvt7GfKUgqBh3UlTiVJISRnIs1LJfaKu/eog76AjE7/oAo/ozDd/lS9XVJ4
	 YN6ioEtde22twmdMAFXNNHIrad9LvcE4Ysln7RWeFXd4EZUvuCVXuKiolzIWlsRfYJ
	 +/VTSxzS3ZaYA==
Date: Thu, 31 Oct 2024 05:06:14 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v3 7/8] worktree: add relative cli/config options to `repair` command
Message-ID: <20241031-wt_relative_options-v3-7-3e44ccdf64e6@pm.me>
In-Reply-To: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me>
References: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 3fb959f0db07f09a074521c7fa9ac0859989c7a8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This teaches the `worktree repair` command to respect the
`--[no-]relative-paths` CLI option and `worktree.useRelativePaths`
config setting. If an existing worktree with an absolute path is repaired
with `--relative-paths`, the links will be replaced with relative paths,
even if the original path was correct. This allows a user to covert
existing worktrees between absolute/relative as desired.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 Documentation/git-worktree.txt |  3 +++
 builtin/worktree.c             |  6 +++--
 t/t2406-worktree-repair.sh     | 26 +++++++++++++++++++
 worktree.c                     | 58 +++++++++++++++++++++-----------------=
----
 worktree.h                     |  5 ++--
 5 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 88d2261012166a929b7f167d79720e4d965fd71b..1d86323def16b15fbc85365aaea=
18ce6a2ef433a 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -219,6 +219,9 @@ This can also be set up as the default behaviour by usi=
ng the
 --[no-]relative-paths::
 =09Overrides the `worktree.useRelativePaths` config option, see
 =09linkgit:git-config[1].
++
+With `repair`, the linking files will be updated if there's an absolute/re=
lative
+mismatch, even if the links are correct.
=20
 --[no-]track::
 =09When creating a new branch, if `<commit-ish>` is a branch,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 302151506981718658db1cd338cd9064688f5c14..fde9ff4dc9a734c655e95ccd627=
74282950cbba6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1385,6 +1385,8 @@ static int repair(int ac, const char **av, const char=
 *prefix)
 =09const char **p;
 =09const char *self[] =3D { ".", NULL };
 =09struct option options[] =3D {
+=09=09OPT_BOOL(0, "relative-paths", &use_relative_paths,
+=09=09=09 N_("use relative paths for worktrees")),
 =09=09OPT_END()
 =09};
 =09int rc =3D 0;
@@ -1392,8 +1394,8 @@ static int repair(int ac, const char **av, const char=
 *prefix)
 =09ac =3D parse_options(ac, av, prefix, options, git_worktree_repair_usage=
, 0);
 =09p =3D ac > 0 ? av : self;
 =09for (; *p; p++)
-=09=09repair_worktree_at_path(*p, report_repair, &rc);
-=09repair_worktrees(report_repair, &rc);
+=09=09repair_worktree_at_path(*p, report_repair, &rc, use_relative_paths);
+=09repair_worktrees(report_repair, &rc, use_relative_paths);
 =09return rc;
 }
=20
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 7686e60f6ad186519b275f11a5e14064c905b207..84451e903b2ef3c645c0311faf0=
55c846588baf6 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -216,4 +216,30 @@ test_expect_success 'repair copied main and linked wor=
ktrees' '
 =09test_cmp dup/linked.expect dup/linked/.git
 '
=20
+test_expect_success 'repair absolute worktree to use relative paths' '
+=09test_when_finished "rm -rf main side sidemoved" &&
+=09test_create_repo main &&
+=09test_commit -C main init &&
+=09git -C main worktree add --detach ../side &&
+=09echo "../../../../sidemoved/.git" >expect-gitdir &&
+=09echo "gitdir: ../main/.git/worktrees/side" >expect-gitfile &&
+=09mv side sidemoved &&
+=09git -C main worktree repair --relative-paths ../sidemoved &&
+=09test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
+=09test_cmp expect-gitfile sidemoved/.git
+'
+
+test_expect_success 'repair relative worktree to use absolute paths' '
+=09test_when_finished "rm -rf main side sidemoved" &&
+=09test_create_repo main &&
+=09test_commit -C main init &&
+=09git -C main worktree add --relative-paths --detach ../side &&
+=09echo "$(pwd)/sidemoved/.git" >expect-gitdir &&
+=09echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
+=09mv side sidemoved &&
+=09git -C main worktree repair ../sidemoved &&
+=09test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
+=09test_cmp expect-gitfile sidemoved/.git
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index 6b640cd9549ecb060236f7eddf1390caa181f1a0..2cb994ac462debf966ac51b5a4f=
33c30cfebd4ef 100644
--- a/worktree.c
+++ b/worktree.c
@@ -574,12 +574,14 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
  * pointing at <repo>/worktrees/<id>.
  */
 static void repair_gitfile(struct worktree *wt,
-=09=09=09   worktree_repair_fn fn, void *cb_data)
+=09=09=09   worktree_repair_fn fn,
+=09=09=09   void *cb_data,
+=09=09=09   int use_relative_paths)
 {
 =09struct strbuf dotgit =3D STRBUF_INIT;
+=09struct strbuf gitdir =3D STRBUF_INIT;
 =09struct strbuf repo =3D STRBUF_INIT;
 =09struct strbuf backlink =3D STRBUF_INIT;
-=09struct strbuf tmp =3D STRBUF_INIT;
 =09char *dotgit_contents =3D NULL;
 =09const char *repair =3D NULL;
 =09int err;
@@ -595,6 +597,7 @@ static void repair_gitfile(struct worktree *wt,
=20
 =09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
 =09strbuf_addf(&dotgit, "%s/.git", wt->path);
+=09strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
 =09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, &er=
r));
=20
 =09if (dotgit_contents) {
@@ -612,18 +615,20 @@ static void repair_gitfile(struct worktree *wt,
 =09=09repair =3D _(".git file broken");
 =09else if (fspathcmp(backlink.buf, repo.buf))
 =09=09repair =3D _(".git file incorrect");
+=09else if (use_relative_paths =3D=3D is_absolute_path(dotgit_contents))
+=09=09repair =3D _(".git file absolute/relative path mismatch");
=20
 =09if (repair) {
 =09=09fn(0, wt->path, repair, cb_data);
-=09=09write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, wt->pat=
h, &tmp));
+=09=09write_worktree_linking_files(dotgit, gitdir, use_relative_paths);
 =09}
=20
 done:
 =09free(dotgit_contents);
 =09strbuf_release(&repo);
 =09strbuf_release(&dotgit);
+=09strbuf_release(&gitdir);
 =09strbuf_release(&backlink);
-=09strbuf_release(&tmp);
 }
=20
 static void repair_noop(int iserr UNUSED,
@@ -634,7 +639,7 @@ static void repair_noop(int iserr UNUSED,
 =09/* nothing */
 }
=20
-void repair_worktrees(worktree_repair_fn fn, void *cb_data)
+void repair_worktrees(worktree_repair_fn fn, void *cb_data, int use_relati=
ve_paths)
 {
 =09struct worktree **worktrees =3D get_worktrees_internal(1);
 =09struct worktree **wt =3D worktrees + 1; /* +1 skips main worktree */
@@ -642,7 +647,7 @@ void repair_worktrees(worktree_repair_fn fn, void *cb_d=
ata)
 =09if (!fn)
 =09=09fn =3D repair_noop;
 =09for (; *wt; wt++)
-=09=09repair_gitfile(*wt, fn, cb_data);
+=09=09repair_gitfile(*wt, fn, cb_data, use_relative_paths);
 =09free_worktrees(worktrees);
 }
=20
@@ -758,16 +763,15 @@ static ssize_t infer_backlink(const char *gitfile, st=
ruct strbuf *inferred)
  * the worktree's path.
  */
 void repair_worktree_at_path(const char *path,
-=09=09=09     worktree_repair_fn fn, void *cb_data)
+=09=09=09     worktree_repair_fn fn,
+=09=09=09     void *cb_data,
+=09=09=09     int use_relative_paths)
 {
 =09struct strbuf dotgit =3D STRBUF_INIT;
-=09struct strbuf realdotgit =3D STRBUF_INIT;
 =09struct strbuf backlink =3D STRBUF_INIT;
 =09struct strbuf inferred_backlink =3D STRBUF_INIT;
 =09struct strbuf gitdir =3D STRBUF_INIT;
 =09struct strbuf olddotgit =3D STRBUF_INIT;
-=09struct strbuf realolddotgit =3D STRBUF_INIT;
-=09struct strbuf tmp =3D STRBUF_INIT;
 =09char *dotgit_contents =3D NULL;
 =09const char *repair =3D NULL;
 =09int err;
@@ -779,25 +783,25 @@ void repair_worktree_at_path(const char *path,
 =09=09goto done;
=20
 =09strbuf_addf(&dotgit, "%s/.git", path);
-=09if (!strbuf_realpath(&realdotgit, dotgit.buf, 0)) {
+=09if (!strbuf_realpath(&dotgit, dotgit.buf, 0)) {
 =09=09fn(1, path, _("not a valid path"), cb_data);
 =09=09goto done;
 =09}
=20
-=09infer_backlink(realdotgit.buf, &inferred_backlink);
+=09infer_backlink(dotgit.buf, &inferred_backlink);
 =09strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0)=
;
-=09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(realdotgit.buf,=
 &err));
+=09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, &er=
r));
 =09if (dotgit_contents) {
 =09=09if (is_absolute_path(dotgit_contents)) {
 =09=09=09strbuf_addstr(&backlink, dotgit_contents);
 =09=09} else {
-=09=09=09strbuf_addbuf(&backlink, &realdotgit);
+=09=09=09strbuf_addbuf(&backlink, &dotgit);
 =09=09=09strbuf_strip_suffix(&backlink, ".git");
 =09=09=09strbuf_addstr(&backlink, dotgit_contents);
 =09=09=09strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
 =09=09}
 =09} else if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE) {
-=09=09fn(1, realdotgit.buf, _("unable to locate repository; .git is not a =
file"), cb_data);
+=09=09fn(1, dotgit.buf, _("unable to locate repository; .git is not a file=
"), cb_data);
 =09=09goto done;
 =09} else if (err =3D=3D READ_GITFILE_ERR_NOT_A_REPO) {
 =09=09if (inferred_backlink.len) {
@@ -810,11 +814,11 @@ void repair_worktree_at_path(const char *path,
 =09=09=09 */
 =09=09=09strbuf_swap(&backlink, &inferred_backlink);
 =09=09} else {
-=09=09=09fn(1, realdotgit.buf, _("unable to locate repository; .git file d=
oes not reference a repository"), cb_data);
+=09=09=09fn(1, dotgit.buf, _("unable to locate repository; .git file does =
not reference a repository"), cb_data);
 =09=09=09goto done;
 =09=09}
 =09} else {
-=09=09fn(1, realdotgit.buf, _("unable to locate repository; .git file brok=
en"), cb_data);
+=09=09fn(1, dotgit.buf, _("unable to locate repository; .git file broken")=
, cb_data);
 =09=09goto done;
 =09}
=20
@@ -836,39 +840,35 @@ void repair_worktree_at_path(const char *path,
 =09 * in the "copy" repository. In this case, point the "copy" worktree's
 =09 * .git file at the "copy" repository.
 =09 */
-=09if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.=
buf)) {
+=09if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.=
buf))
 =09=09strbuf_swap(&backlink, &inferred_backlink);
-=09}
=20
 =09strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
 =09if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
 =09=09repair =3D _("gitdir unreadable");
+=09else if (use_relative_paths =3D=3D is_absolute_path(olddotgit.buf))
+=09=09repair =3D _("gitdir absolute/relative path mismatch");
 =09else {
 =09=09strbuf_rtrim(&olddotgit);
-=09=09if (is_absolute_path(olddotgit.buf)) {
-=09=09=09strbuf_addbuf(&realolddotgit, &olddotgit);
-=09=09} else {
-=09=09=09strbuf_addf(&realolddotgit, "%s/%s", backlink.buf, olddotgit.buf)=
;
-=09=09=09strbuf_realpath_forgiving(&realolddotgit, realolddotgit.buf, 0);
+=09=09if (!is_absolute_path(olddotgit.buf)) {
+=09=09=09strbuf_insertf(&olddotgit, 0, "%s/", backlink.buf);
+=09=09=09strbuf_realpath_forgiving(&olddotgit, olddotgit.buf, 0);
 =09=09}
-=09=09if (fspathcmp(realolddotgit.buf, realdotgit.buf))
+=09=09if (fspathcmp(olddotgit.buf, dotgit.buf))
 =09=09=09repair =3D _("gitdir incorrect");
 =09}
=20
 =09if (repair) {
 =09=09fn(0, gitdir.buf, repair, cb_data);
-=09=09write_file(gitdir.buf, "%s", relative_path(realdotgit.buf, backlink.=
buf, &tmp));
+=09=09write_worktree_linking_files(dotgit, gitdir, use_relative_paths);
 =09}
 done:
 =09free(dotgit_contents);
 =09strbuf_release(&olddotgit);
-=09strbuf_release(&realolddotgit);
 =09strbuf_release(&backlink);
 =09strbuf_release(&inferred_backlink);
 =09strbuf_release(&gitdir);
-=09strbuf_release(&realdotgit);
 =09strbuf_release(&dotgit);
-=09strbuf_release(&tmp);
 }
=20
 int should_prune_worktree(const char *id, struct strbuf *reason, char **wt=
path, timestamp_t expire)
diff --git a/worktree.h b/worktree.h
index 6dd5dfc9b71870320c96aae35a7a983b5b9ba9a7..f158a2ee429cc7af971bf4a6665=
c058a9e15614a 100644
--- a/worktree.h
+++ b/worktree.h
@@ -130,7 +130,7 @@ typedef void (* worktree_repair_fn)(int iserr, const ch=
ar *path,
  * function, if non-NULL, is called with the path of the worktree and a
  * description of the repair or error, along with the callback user-data.
  */
-void repair_worktrees(worktree_repair_fn, void *cb_data);
+void repair_worktrees(worktree_repair_fn, void *cb_data, int use_relative_=
paths);
=20
 /*
  * Repair the linked worktrees after the gitdir has been moved.
@@ -152,7 +152,8 @@ void repair_worktree_after_gitdir_move(struct worktree =
*wt, const char *old_path
  * worktree and a description of the repair or error, along with the callb=
ack
  * user-data.
  */
-void repair_worktree_at_path(const char *, worktree_repair_fn, void *cb_da=
ta);
+void repair_worktree_at_path(const char *, worktree_repair_fn,
+=09=09=09     void *cb_data, int use_relative_paths);
=20
 /*
  * Free up the memory for a worktree.

--=20
2.47.0


