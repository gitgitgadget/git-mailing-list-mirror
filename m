Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840C1DFE31
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142595; cv=none; b=WChYY5NEjAiRVg983YpuhS6REcrsk40th/wNtCJ0wAj6kOpirTmP224Whg4K3YroL4fbI2px8n4PwfQ42O9jEw+ov1GaLAjcpAfmb1wTmp2JdBrtPhuoyc0BFdBgFilgcYpXaoFTAL6RuWI1KV0w4MYz/YB0raP6SaIZzHGUmho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142595; c=relaxed/simple;
	bh=9nF3Pyd9e3xMvEEFiqr1c9LAEHRF3vBuKYz8RyrsAic=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPELhOJEyfnNI9PVqYPnGFW5UuTk5GB3dyZa6EG3MOfwdcSSYJM4nTPNDU/Wvw+waYOBFv7Q76Uvn1L7Hc2BRUTrfl44fI4hze3D9p1HiDXwUwa+1IDUgTAFiLqlV3f+jmCNKiE/jyni+GP9tlUBqD9ni6N1O+cQ2hbdf93xBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=AgZ31Szw; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="AgZ31Szw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730142590; x=1730401790;
	bh=7KbAd//3RgGnMgGvikf7YEKi24RqHlunISaqql35VIU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AgZ31SzwoAhkqlNUAVa/P2GKsC17Wjdtev07ERgUkKF+OA6Y47qJj+trERinN5KZm
	 2cLK23aik8Y/HxbABLXW6RgaUMwnFn12uau6qVHwlI33ybX4mKWslHIJIO0JneMFdl
	 uukIagc5B61JReG8SwckQSW47uwVHF4MocFf9Q5W6sdUPLv4eFPJYa9OLUrwoaa3P6
	 qKLsCE5k0HdLiAF8FJPaAenHQhfV64X60da5rgRRJKKQCrDCDK9duapyiL84DyIqfW
	 ctCuj1AXOQyQ7KlHi4YWMVY7OX+4clzbdc96wi5gkryMXwGvD7IcitQB+2PGjYLpuN
	 EEDLgFLcqgU9Q==
Date: Mon, 28 Oct 2024 19:09:44 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 2/5] worktree: add `write_worktree_linking_files` function
Message-ID: <20241028-wt_relative_options-v2-2-33a5021bd7bb@pm.me>
In-Reply-To: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 8044d349f56f18f7e48c3bbbc23fbed925378edc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A new helper function, `write_worktree_linking_files()`, centralizes
the logic for computing and writing either relative or absolute
paths, based on the provided configuration. This function accepts
`strbuf` pointers to both the worktree=E2=80=99s `.git` link and the
repository=E2=80=99s `gitdir`, and then writes the appropriate path to each=
.

This also teachs `git worktree repair` to fix the linking files if
there is an absolute/relative paths but the links are correct. E.g.,
`git worktree repair` can be used to convert a valid worktree between
absolute and relative paths.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 builtin/worktree.c |  11 +----
 worktree.c         | 118 +++++++++++++++++++++++++++----------------------=
----
 worktree.h         |  12 ++++++
 3 files changed, 74 insertions(+), 67 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index c1130be5890c905c0b648782a834eb8dfcd79ba5..bb06830d6fe82aa97833c6e87f0=
34115dfaa23bd 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -417,8 +417,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09=09=09const struct add_opts *opts)
 {
 =09struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
-=09struct strbuf sb =3D STRBUF_INIT, sb_tmp =3D STRBUF_INIT;
-=09struct strbuf sb_path_realpath =3D STRBUF_INIT, sb_repo_realpath =3D ST=
RBUF_INIT;
+=09struct strbuf sb =3D STRBUF_INIT;
 =09const char *name;
 =09struct strvec child_env =3D STRVEC_INIT;
 =09unsigned int counter =3D 0;
@@ -494,10 +493,7 @@ static int add_worktree(const char *path, const char *=
refname,
=20
 =09strbuf_reset(&sb);
 =09strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-=09strbuf_realpath(&sb_path_realpath, path, 1);
-=09strbuf_realpath(&sb_repo_realpath, sb_repo.buf, 1);
-=09write_file(sb.buf, "%s/.git", relative_path(sb_path_realpath.buf, sb_re=
po_realpath.buf, &sb_tmp));
-=09write_file(sb_git.buf, "gitdir: %s", relative_path(sb_repo_realpath.buf=
, sb_path_realpath.buf, &sb_tmp));
+=09write_worktree_linking_files(sb_git, sb);
 =09strbuf_reset(&sb);
 =09strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 =09write_file(sb.buf, "../..");
@@ -581,12 +577,9 @@ static int add_worktree(const char *path, const char *=
refname,
=20
 =09strvec_clear(&child_env);
 =09strbuf_release(&sb);
-=09strbuf_release(&sb_tmp);
 =09strbuf_release(&symref);
 =09strbuf_release(&sb_repo);
-=09strbuf_release(&sb_repo_realpath);
 =09strbuf_release(&sb_git);
-=09strbuf_release(&sb_path_realpath);
 =09strbuf_release(&sb_name);
 =09free_worktree(wt);
 =09return ret;
diff --git a/worktree.c b/worktree.c
index de5c5e53a5f2a758ddf470b5d6a9ad6c66247181..f4cee73d7a1edecafdff30b6d5e=
2d9dd1365b93e 100644
--- a/worktree.c
+++ b/worktree.c
@@ -381,29 +381,24 @@ int validate_worktree(const struct worktree *wt, stru=
ct strbuf *errmsg,
 void update_worktree_location(struct worktree *wt, const char *path_)
 {
 =09struct strbuf path =3D STRBUF_INIT;
-=09struct strbuf repo =3D STRBUF_INIT;
-=09struct strbuf file =3D STRBUF_INIT;
-=09struct strbuf tmp =3D STRBUF_INIT;
+=09struct strbuf dotgit =3D STRBUF_INIT;
+=09struct strbuf gitdir =3D STRBUF_INIT;
=20
 =09if (is_main_worktree(wt))
 =09=09BUG("can't relocate main worktree");
=20
-=09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
+=09strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id)=
, 1);
 =09strbuf_realpath(&path, path_, 1);
+=09strbuf_addf(&dotgit, "%s/.git", path.buf);
 =09if (fspathcmp(wt->path, path.buf)) {
-=09=09strbuf_addf(&file, "%s/gitdir", repo.buf);
-=09=09write_file(file.buf, "%s/.git", relative_path(path.buf, repo.buf, &t=
mp));
-=09=09strbuf_reset(&file);
-=09=09strbuf_addf(&file, "%s/.git", path.buf);
-=09=09write_file(file.buf, "gitdir: %s", relative_path(repo.buf, path.buf,=
 &tmp));
+=09=09write_worktree_linking_files(dotgit, gitdir);
=20
 =09=09free(wt->path);
 =09=09wt->path =3D strbuf_detach(&path, NULL);
 =09}
 =09strbuf_release(&path);
-=09strbuf_release(&repo);
-=09strbuf_release(&file);
-=09strbuf_release(&tmp);
+=09strbuf_release(&dotgit);
+=09strbuf_release(&gitdir);
 }
=20
 int is_worktree_being_rebased(const struct worktree *wt,
@@ -582,9 +577,9 @@ static void repair_gitfile(struct worktree *wt,
 =09=09=09   worktree_repair_fn fn, void *cb_data)
 {
 =09struct strbuf dotgit =3D STRBUF_INIT;
+=09struct strbuf gitdir =3D STRBUF_INIT;
 =09struct strbuf repo =3D STRBUF_INIT;
 =09struct strbuf backlink =3D STRBUF_INIT;
-=09struct strbuf tmp =3D STRBUF_INIT;
 =09char *dotgit_contents =3D NULL;
 =09const char *repair =3D NULL;
 =09int err;
@@ -600,6 +595,7 @@ static void repair_gitfile(struct worktree *wt,
=20
 =09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
 =09strbuf_addf(&dotgit, "%s/.git", wt->path);
+=09strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
 =09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, &er=
r));
=20
 =09if (dotgit_contents) {
@@ -617,18 +613,20 @@ static void repair_gitfile(struct worktree *wt,
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
+=09=09write_worktree_linking_files(dotgit, gitdir);
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
@@ -653,45 +651,30 @@ void repair_worktrees(worktree_repair_fn fn, void *cb=
_data)
=20
 void repair_worktree_after_gitdir_move(struct worktree *wt, const char *ol=
d_path)
 {
-=09struct strbuf path =3D STRBUF_INIT;
-=09struct strbuf repo =3D STRBUF_INIT;
 =09struct strbuf gitdir =3D STRBUF_INIT;
 =09struct strbuf dotgit =3D STRBUF_INIT;
-=09struct strbuf olddotgit =3D STRBUF_INIT;
-=09struct strbuf tmp =3D STRBUF_INIT;
=20
 =09if (is_main_worktree(wt))
 =09=09goto done;
=20
-=09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
-=09strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
+=09strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id)=
, 1);
=20
-=09if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
+=09if (strbuf_read_file(&dotgit, gitdir.buf, 0) < 0)
 =09=09goto done;
=20
-=09strbuf_rtrim(&olddotgit);
-=09if (is_absolute_path(olddotgit.buf)) {
-=09=09strbuf_addbuf(&dotgit, &olddotgit);
-=09} else {
-=09=09strbuf_addf(&dotgit, "%s/worktrees/%s/%s", old_path, wt->id, olddotg=
it.buf);
+=09strbuf_rtrim(&dotgit);
+=09if (!is_absolute_path(dotgit.buf)) {
+=09=09strbuf_insertf(&dotgit, 0, "%s/worktrees/%s/", old_path, wt->id);
 =09=09strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
 =09}
=20
 =09if (!file_exists(dotgit.buf))
 =09=09goto done;
=20
-=09strbuf_addbuf(&path, &dotgit);
-=09strbuf_strip_suffix(&path, "/.git");
-
-=09write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.buf, =
&tmp));
-=09write_file(gitdir.buf, "%s", relative_path(dotgit.buf, repo.buf, &tmp))=
;
+=09write_worktree_linking_files(dotgit, gitdir);
 done:
-=09strbuf_release(&path);
-=09strbuf_release(&repo);
 =09strbuf_release(&gitdir);
 =09strbuf_release(&dotgit);
-=09strbuf_release(&olddotgit);
-=09strbuf_release(&tmp);
 }
=20
 void repair_worktrees_after_gitdir_move(const char *old_path)
@@ -766,13 +749,10 @@ void repair_worktree_at_path(const char *path,
 =09=09=09     worktree_repair_fn fn, void *cb_data)
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
@@ -784,25 +764,25 @@ void repair_worktree_at_path(const char *path,
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
@@ -815,11 +795,11 @@ void repair_worktree_at_path(const char *path,
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
@@ -841,39 +821,35 @@ void repair_worktree_at_path(const char *path,
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
+=09=09write_worktree_linking_files(dotgit, gitdir);
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
@@ -1034,3 +1010,29 @@ int init_worktree_config(struct repository *r)
 =09free(main_worktree_file);
 =09return res;
 }
+
+void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitd=
ir)
+{
+=09struct strbuf path =3D STRBUF_INIT;
+=09struct strbuf repo =3D STRBUF_INIT;
+=09struct strbuf tmp =3D STRBUF_INIT;
+
+=09strbuf_addbuf(&path, &dotgit);
+=09strbuf_strip_suffix(&path, "/.git");
+=09strbuf_realpath(&path, path.buf, 1);
+=09strbuf_addbuf(&repo, &gitdir);
+=09strbuf_strip_suffix(&repo, "/gitdir");
+=09strbuf_realpath(&repo, repo.buf, 1);
+
+=09if (use_relative_paths) {
+=09=09write_file(gitdir.buf, "%s/.git", relative_path(path.buf, repo.buf, =
&tmp));
+=09=09write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.bu=
f, &tmp));
+=09} else {
+=09=09write_file(gitdir.buf, "%s/.git", path.buf);
+=09=09write_file(dotgit.buf, "gitdir: %s", repo.buf);
+=09}
+
+=09strbuf_release(&path);
+=09strbuf_release(&repo);
+=09strbuf_release(&tmp);
+}
diff --git a/worktree.h b/worktree.h
index 37e65d508ed23d3e7a29850bb938285072a3aaa6..5929089891c97318a8f5329f793=
8264c717050d5 100644
--- a/worktree.h
+++ b/worktree.h
@@ -217,4 +217,16 @@ void strbuf_worktree_ref(const struct worktree *wt,
  */
 int init_worktree_config(struct repository *r);
=20
+/**
+ * Write the .git file and gitdir file that links the worktree to the repo=
sitory.
+ *
+ * The `dotgit` parameter is the path to the worktree's .git file, and `gi=
tdir`
+ * is the path to the repository's `gitdir` file.
+ *
+ * Example
+ *  dotgit: "/path/to/foo/.git"
+ *  gitdir: "/path/to/repo/worktrees/foo/gitdir"
+ */
+void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitd=
ir);
+
 #endif

--=20
2.47.0


