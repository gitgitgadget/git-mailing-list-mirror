Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1320A5D0
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889867; cv=none; b=rXkQEUwr28VIEEuSvgp1UB5+WJxzHA7W0jkgYbgyMmu98iQF/IgjoYNiqtuO+CubnbfTfOFGclHpOeecpQwdksRl2DZUTO6FAdSo6fGct7VF8Ts2sbWAN5q2jpgBeiCf17ZGh6cdgDRCLudG+n80v1sacIbogpvtXrT6VX6Rg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889867; c=relaxed/simple;
	bh=Bkl/2AWOFnKo7ln1HGemkK5KQ3H2mgfg7unYwkhWY5Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7XP0iOpVzLv6PyPsbmNT7P5OsRcaTX2ZF+6TscSXbeMA169ak1FyISN13r1r1klxvKWscGELM0wfY2+xddZ8mDh0N7IsVSDw1zxGRo3z43J8FepR5cmRC5JVRHerMlJalChBK+FlthyIH9WbEHZGsX4Ia3tFC9ub9QkcwM6QgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=iE70EFdV; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="iE70EFdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729889857; x=1730149057;
	bh=jNtNJGyVenlIOUm2MVXtx9PxL+4aL3J2iUp+VYab8ao=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iE70EFdVGPG4Utmn2OVHBO+60QVl9Sf9penVTcRL/lFb891znVLwt1rMMAjW6qKSw
	 fCsXJJs5ydcDZDxQNrwUac1cERfeeZXb99Ae9VuobV3MRwjQ+lLU3GBErzRyJ5ADf/
	 MF/kCURejoeV7jZpmPZve21cLQZbuJkB08w2lF7GpPoaWf0lX7V/w/9ad3QL6KM46F
	 wQiRLHSc2FMcGxsP9dP13EG3FUeuC8FEL/oAdARLelCxMX/CwokxZREEh6lmAbRaDt
	 s+gyxCkSPrk7kdl2b5TuJvpp4bKbAka4p3Ao0H3nnsr7h4ees7tgkaLqnhtLgtvB5w
	 ie7aDvrMAVkgw==
Date: Fri, 25 Oct 2024 20:57:32 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v3 2/5] worktree: support worktrees linked with relative paths
Message-ID: <20241025-wt_relative_paths-v3-2-8860a5321c01@pm.me>
In-Reply-To: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
References: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: d01868eaee9de7f7d2e6f91368f6a440b5513941
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Git stores absolute paths when linking worktrees to the main repository.
However, this can cause problems when moving repositories and worktrees,
or when working in containerized environments where absolute paths
differ between systems. The worktree links break, and users are required
to manually execute `worktree repair` to repair them, leading to workflow
disruptions. Additionally, when repositories are mapped inside containers
with different absolute paths, they may become unusable. Repairing
worktrees in the container can then break them outside the container.

In some cases, relative paths can eliminate the need for `worktree repair`.
If both the repository and worktrees are moved together while preserving
their relative locations, the links remain intact. Common examples include
manually moving repositories and worktrees (or by tarballing) or mapping
both inside containers that use different absolute paths.

This patch adds support for _reading_ linking files which could contain
relative paths (computing and _writing_ the relative paths will come in
the next patch). Generally, relative paths are resolved into absolute
paths before any operations or comparisons are performed.

The `worktree.path` struct member has also been updated to always contain
the absolute path of a worktree. This ensures that worktree consumers
never have to worry about trying to resolve the absolute path themselves.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 worktree.c | 131 +++++++++++++++++++++++++++++++++++++++++++--------------=
----
 1 file changed, 92 insertions(+), 39 deletions(-)

diff --git a/worktree.c b/worktree.c
index ad60ba0b5843f1676e89b05eca3c82aace5fb49b..cf578c447589425d642fc8aa7a7=
fa07600e60a70 100644
--- a/worktree.c
+++ b/worktree.c
@@ -110,6 +110,12 @@ struct worktree *get_linked_worktree(const char *id,
 =09strbuf_rtrim(&worktree_path);
 =09strbuf_strip_suffix(&worktree_path, "/.git");
=20
+=09if (!is_absolute_path(worktree_path.buf)) {
+=09=09strbuf_strip_suffix(&path, "gitdir");
+=09=09strbuf_addbuf(&path, &worktree_path);
+=09=09strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
+=09}
+
 =09CALLOC_ARRAY(worktree, 1);
 =09worktree->repo =3D the_repository;
 =09worktree->path =3D strbuf_detach(&worktree_path, NULL);
@@ -564,28 +570,38 @@ static void repair_gitfile(struct worktree *wt,
 {
 =09struct strbuf dotgit =3D STRBUF_INIT;
 =09struct strbuf repo =3D STRBUF_INIT;
-=09char *backlink;
+=09struct strbuf backlink =3D STRBUF_INIT;
+=09char *dotgit_contents =3D NULL;
 =09const char *repair =3D NULL;
 =09int err;
=20
 =09/* missing worktree can't be repaired */
 =09if (!file_exists(wt->path))
-=09=09return;
+=09=09goto done;
=20
 =09if (!is_directory(wt->path)) {
 =09=09fn(1, wt->path, _("not a directory"), cb_data);
-=09=09return;
+=09=09goto done;
 =09}
=20
 =09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
 =09strbuf_addf(&dotgit, "%s/.git", wt->path);
-=09backlink =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
+=09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, &er=
r));
+
+=09if (dotgit_contents) {
+=09=09if (is_absolute_path(dotgit_contents)) {
+=09=09=09strbuf_addstr(&backlink, dotgit_contents);
+=09=09} else {
+=09=09=09strbuf_addf(&backlink, "%s/%s", wt->path, dotgit_contents);
+=09=09=09strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
+=09=09}
+=09}
=20
 =09if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE)
 =09=09fn(1, wt->path, _(".git is not a file"), cb_data);
 =09else if (err)
 =09=09repair =3D _(".git file broken");
-=09else if (fspathcmp(backlink, repo.buf))
+=09else if (fspathcmp(backlink.buf, repo.buf))
 =09=09repair =3D _(".git file incorrect");
=20
 =09if (repair) {
@@ -593,9 +609,11 @@ static void repair_gitfile(struct worktree *wt,
 =09=09write_file(dotgit.buf, "gitdir: %s", repo.buf);
 =09}
=20
-=09free(backlink);
+done:
+=09free(dotgit_contents);
 =09strbuf_release(&repo);
 =09strbuf_release(&dotgit);
+=09strbuf_release(&backlink);
 }
=20
 static void repair_noop(int iserr UNUSED,
@@ -685,6 +703,7 @@ void repair_worktree_at_path(const char *path,
 =09struct strbuf inferred_backlink =3D STRBUF_INIT;
 =09struct strbuf gitdir =3D STRBUF_INIT;
 =09struct strbuf olddotgit =3D STRBUF_INIT;
+=09struct strbuf realolddotgit =3D STRBUF_INIT;
 =09char *dotgit_contents =3D NULL;
 =09const char *repair =3D NULL;
 =09int err;
@@ -702,9 +721,17 @@ void repair_worktree_at_path(const char *path,
 =09}
=20
 =09infer_backlink(realdotgit.buf, &inferred_backlink);
+=09strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0)=
;
 =09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(realdotgit.buf,=
 &err));
 =09if (dotgit_contents) {
-=09=09strbuf_addstr(&backlink, dotgit_contents);
+=09=09if (is_absolute_path(dotgit_contents)) {
+=09=09=09strbuf_addstr(&backlink, dotgit_contents);
+=09=09} else {
+=09=09=09strbuf_addbuf(&backlink, &realdotgit);
+=09=09=09strbuf_strip_suffix(&backlink, ".git");
+=09=09=09strbuf_addstr(&backlink, dotgit_contents);
+=09=09=09strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
+=09=09}
 =09} else if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE) {
 =09=09fn(1, realdotgit.buf, _("unable to locate repository; .git is not a =
file"), cb_data);
 =09=09goto done;
@@ -722,7 +749,7 @@ void repair_worktree_at_path(const char *path,
 =09=09=09fn(1, realdotgit.buf, _("unable to locate repository; .git file d=
oes not reference a repository"), cb_data);
 =09=09=09goto done;
 =09=09}
-=09} else if (err) {
+=09} else {
 =09=09fn(1, realdotgit.buf, _("unable to locate repository; .git file brok=
en"), cb_data);
 =09=09goto done;
 =09}
@@ -753,7 +780,13 @@ void repair_worktree_at_path(const char *path,
 =09=09repair =3D _("gitdir unreadable");
 =09else {
 =09=09strbuf_rtrim(&olddotgit);
-=09=09if (fspathcmp(olddotgit.buf, realdotgit.buf))
+=09=09if (is_absolute_path(olddotgit.buf)) {
+=09=09=09strbuf_addbuf(&realolddotgit, &olddotgit);
+=09=09} else {
+=09=09=09strbuf_addf(&realolddotgit, "%s/%s", backlink.buf, olddotgit.buf)=
;
+=09=09=09strbuf_realpath_forgiving(&realolddotgit, realolddotgit.buf, 0);
+=09=09}
+=09=09if (fspathcmp(realolddotgit.buf, realdotgit.buf))
 =09=09=09repair =3D _("gitdir incorrect");
 =09}
=20
@@ -764,6 +797,7 @@ void repair_worktree_at_path(const char *path,
 done:
 =09free(dotgit_contents);
 =09strbuf_release(&olddotgit);
+=09strbuf_release(&realolddotgit);
 =09strbuf_release(&backlink);
 =09strbuf_release(&inferred_backlink);
 =09strbuf_release(&gitdir);
@@ -774,69 +808,88 @@ void repair_worktree_at_path(const char *path,
 int should_prune_worktree(const char *id, struct strbuf *reason, char **wt=
path, timestamp_t expire)
 {
 =09struct stat st;
-=09char *path;
+=09struct strbuf dotgit =3D STRBUF_INIT;
+=09struct strbuf gitdir =3D STRBUF_INIT;
+=09struct strbuf repo =3D STRBUF_INIT;
+=09struct strbuf file =3D STRBUF_INIT;
+=09char *path =3D NULL;
+=09int rc =3D 0;
 =09int fd;
 =09size_t len;
 =09ssize_t read_result;
=20
 =09*wtpath =3D NULL;
-=09if (!is_directory(git_path("worktrees/%s", id))) {
+=09strbuf_realpath(&repo, git_common_path("worktrees/%s", id), 1);
+=09strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
+=09if (!is_directory(repo.buf)) {
 =09=09strbuf_addstr(reason, _("not a valid directory"));
-=09=09return 1;
+=09=09rc =3D 1;
+=09=09goto done;
 =09}
-=09if (file_exists(git_path("worktrees/%s/locked", id)))
-=09=09return 0;
-=09if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
+=09strbuf_addf(&file, "%s/locked", repo.buf);
+=09if (file_exists(file.buf)) {
+=09=09goto done;
+=09}
+=09if (stat(gitdir.buf, &st)) {
 =09=09strbuf_addstr(reason, _("gitdir file does not exist"));
-=09=09return 1;
+=09=09rc =3D 1;
+=09=09goto done;
 =09}
-=09fd =3D open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
+=09fd =3D open(gitdir.buf, O_RDONLY);
 =09if (fd < 0) {
 =09=09strbuf_addf(reason, _("unable to read gitdir file (%s)"),
 =09=09=09    strerror(errno));
-=09=09return 1;
+=09=09rc =3D 1;
+=09=09goto done;
 =09}
 =09len =3D xsize_t(st.st_size);
 =09path =3D xmallocz(len);
=20
 =09read_result =3D read_in_full(fd, path, len);
+=09close(fd);
 =09if (read_result < 0) {
 =09=09strbuf_addf(reason, _("unable to read gitdir file (%s)"),
 =09=09=09    strerror(errno));
-=09=09close(fd);
-=09=09free(path);
-=09=09return 1;
-=09}
-=09close(fd);
-
-=09if (read_result !=3D len) {
+=09=09rc =3D 1;
+=09=09goto done;
+=09} else if (read_result !=3D len) {
 =09=09strbuf_addf(reason,
 =09=09=09    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
 =09=09=09    (uintmax_t)len, (uintmax_t)read_result);
-=09=09free(path);
-=09=09return 1;
+=09=09rc =3D 1;
+=09=09goto done;
 =09}
 =09while (len && (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r'))
 =09=09len--;
 =09if (!len) {
 =09=09strbuf_addstr(reason, _("invalid gitdir file"));
-=09=09free(path);
-=09=09return 1;
+=09=09rc =3D 1;
+=09=09goto done;
 =09}
 =09path[len] =3D '\0';
-=09if (!file_exists(path)) {
-=09=09if (stat(git_path("worktrees/%s/index", id), &st) ||
-=09=09    st.st_mtime <=3D expire) {
+=09if (is_absolute_path(path)) {
+=09=09strbuf_addstr(&dotgit, path);
+=09} else {
+=09=09strbuf_addf(&dotgit, "%s/%s", repo.buf, path);
+=09=09strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
+=09}
+=09if (!file_exists(dotgit.buf)) {
+=09=09strbuf_reset(&file);
+=09=09strbuf_addf(&file, "%s/index", repo.buf);
+=09=09if (stat(file.buf, &st) || st.st_mtime <=3D expire) {
 =09=09=09strbuf_addstr(reason, _("gitdir file points to non-existent locat=
ion"));
-=09=09=09free(path);
-=09=09=09return 1;
-=09=09} else {
-=09=09=09*wtpath =3D path;
-=09=09=09return 0;
+=09=09=09rc =3D 1;
+=09=09=09goto done;
 =09=09}
 =09}
-=09*wtpath =3D path;
-=09return 0;
+=09*wtpath =3D strbuf_detach(&dotgit, NULL);
+done:
+=09free(path);
+=09strbuf_release(&dotgit);
+=09strbuf_release(&gitdir);
+=09strbuf_release(&repo);
+=09strbuf_release(&file);
+=09return rc;
 }
=20
 static int move_config_setting(const char *key, const char *value,

--=20
2.47.0


