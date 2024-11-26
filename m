Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0917BB6
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585950; cv=none; b=o2wZu+B0xfisntEAZUm7cAxrnXMQOQ8IW033amHiwXFWB2tBkBxq0ilgyZ0FJWJFVDfXlyL5d2BYK0c2Qjgdmom5cQ1k5GuRJDnKUWOvFEG36PfzzDWn0E6mqASa+6e5a2KbtuRI1gWZkdz861rXO7JwD5+mYkepSm8DI7OE21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585950; c=relaxed/simple;
	bh=4NPL2heA1snkE+VKnDMZfghf41BS1ErhIKHkrVc2Gq0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFJ+w6WlI270bNhqPXheaveQdpyZI1wuMrFpLXHBButMJYDpMOTRtGUakhmUq/jfnXoecHHNL9hfKEzssE471gR10B8iaCU6LN716zJoaG+nlSNk/W30H9Pl6gpW6PTh8f5K/QvOQUEkCbvpG7UYQKjs2XIbCgG+0LDbl8k6krw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Z8F58Dq4; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Z8F58Dq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732585946; x=1732845146;
	bh=j/C+S3UGzXOOG06S9gQ1gaCYgaZ068/rrSN3mOQDY3E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Z8F58Dq4htvSAxqWmv2c97CD6apHCL4b7xOgaG5fUF+HbSMwJ8iqHdq37O0f/Fb6K
	 6IW0+eUd4MS/mcH5j1qE+3WBWbgg4s0lUxtBOGN3orke8u+NlTL7a44y9SoFep9m2H
	 cgLUYR6ryIUlQiCbUBL9ERECpMnElgm0xlU8yLoKhggOG7mqFrsx/bJWWlJgE+s+2L
	 19lelk3C7xETkFPC03MZ6uPTl9c+QeJQteSIYP2ZslxMpdm+7qWFw0kxkFeqECilMA
	 PuK8HpInsGMmTqrl5QKp6QxZq5vWv/BWA6APB8cwdsU/l2DI9OkwBSZSDaRhbMtVmV
	 iR444pvNj2wZQ==
Date: Tue, 26 Nov 2024 01:52:21 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v5 7/8] worktree: add relative cli/config options to `repair` command
Message-ID: <20241125-wt_relative_options-v5-7-356d122ff3db@pm.me>
In-Reply-To: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: ea5c433d8c98212f23875ead0002f32fbfee0d92
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

To simplify things, both linking files are written when one of the files
needs to be repaired. In some cases, this fixes the other file before it
is checked, in other cases this results in a correct file being written
with the same contents.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 Documentation/git-worktree.txt |  3 +++
 builtin/worktree.c             |  6 +++--
 t/t2406-worktree-repair.sh     | 39 +++++++++++++++++++++++++++++
 worktree.c                     | 56 ++++++++++++++++++++------------------=
----
 worktree.h                     |  5 ++--
 5 files changed, 76 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 60a671bbc255aa7763b4f77511c09f6a02783e00..8340b7f028e6c1c3bae3de0879e=
9754098466d14 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -220,6 +220,9 @@ This can also be set up as the default behaviour by usi=
ng the
 =09Link worktrees using relative paths or absolute paths (default).
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
index 7686e60f6ad186519b275f11a5e14064c905b207..49b70b999518d47e1edd72a61a8=
47b427f4c67a1 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -216,4 +216,43 @@ test_expect_success 'repair copied main and linked wor=
ktrees' '
 =09test_cmp dup/linked.expect dup/linked/.git
 '
=20
+test_expect_success 'repair worktree with relative path with missing gitfi=
le' '
+=09test_when_finished "rm -rf main wt" &&
+=09test_create_repo main &&
+=09git -C main config worktree.useRelativePaths true &&
+=09test_commit -C main init &&
+=09git -C main worktree add --detach ../wt &&
+=09rm wt/.git &&
+=09test_path_is_missing wt/.git &&
+=09git -C main worktree repair &&
+=09echo "gitdir: ../main/.git/worktrees/wt" >expect &&
+=09test_cmp expect wt/.git
+'
+
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
index c749cb16994cf46ccccd4c2880ac917e497671b8..2e76bbc1494afc125997f803dc3=
9846a0b95a84f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -573,12 +573,13 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
  * pointing at <repo>/worktrees/<id>.
  */
 static void repair_gitfile(struct worktree *wt,
-=09=09=09   worktree_repair_fn fn, void *cb_data)
+=09=09=09   worktree_repair_fn fn, void *cb_data,
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
@@ -594,6 +595,7 @@ static void repair_gitfile(struct worktree *wt,
=20
 =09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
 =09strbuf_addf(&dotgit, "%s/.git", wt->path);
+=09strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
 =09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, &er=
r));
=20
 =09if (dotgit_contents) {
@@ -611,18 +613,20 @@ static void repair_gitfile(struct worktree *wt,
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
@@ -633,7 +637,7 @@ static void repair_noop(int iserr UNUSED,
 =09/* nothing */
 }
=20
-void repair_worktrees(worktree_repair_fn fn, void *cb_data)
+void repair_worktrees(worktree_repair_fn fn, void *cb_data, int use_relati=
ve_paths)
 {
 =09struct worktree **worktrees =3D get_worktrees_internal(1);
 =09struct worktree **wt =3D worktrees + 1; /* +1 skips main worktree */
@@ -641,7 +645,7 @@ void repair_worktrees(worktree_repair_fn fn, void *cb_d=
ata)
 =09if (!fn)
 =09=09fn =3D repair_noop;
 =09for (; *wt; wt++)
-=09=09repair_gitfile(*wt, fn, cb_data);
+=09=09repair_gitfile(*wt, fn, cb_data, use_relative_paths);
 =09free_worktrees(worktrees);
 }
=20
@@ -757,16 +761,14 @@ static ssize_t infer_backlink(const char *gitfile, st=
ruct strbuf *inferred)
  * the worktree's path.
  */
 void repair_worktree_at_path(const char *path,
-=09=09=09     worktree_repair_fn fn, void *cb_data)
+=09=09=09     worktree_repair_fn fn, void *cb_data,
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
@@ -778,25 +780,25 @@ void repair_worktree_at_path(const char *path,
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
@@ -809,11 +811,11 @@ void repair_worktree_at_path(const char *path,
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
@@ -835,39 +837,35 @@ void repair_worktree_at_path(const char *path,
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
index 9c699d080d8ebf37712044136679db3821ee1f63..38145df80f41079f301d3aeaaff=
cc35b7f6760b9 100644
--- a/worktree.h
+++ b/worktree.h
@@ -129,7 +129,7 @@ typedef void (* worktree_repair_fn)(int iserr, const ch=
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
@@ -151,7 +151,8 @@ void repair_worktree_after_gitdir_move(struct worktree =
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


