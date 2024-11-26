Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294114A85
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585944; cv=none; b=fxTmje6GrRLMnYR09aoO/Nd7ezxOsTB/MUFjoXhBuFV9oQuensRDaIsP4qESsUqp1C0dv9iInVuG6fqhz7iZyf+BgoiygfIOTzszVBsbSiJRn/Ms+E7tURI0TYAGi+a00UBpQkmeSV6MTM4ZBOZSUPm7Mm+8VpmGk9+UG365n6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585944; c=relaxed/simple;
	bh=5R2eHq9FK0s9fBeBjijubUZ1ZIgEofJG5Ajvv+Lni1o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3wKXhnPGoBBnRvz+2hWJ9WTJO/6C5wfbtObElT5J7yp3/3w89Gh5CXR1xlXKJ0Ym+wEWEsAg0/4wlZp7JwL04K9E7KZ9Z7PpvxqTvBFTYh4NnC5wgf0vkaU4K67zCqbFBy+IV+QzjeepOPCkRDrAI41TwMlXh7SfZsTueJD0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=k2hU04pF; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="k2hU04pF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732585940; x=1732845140;
	bh=aPeKHRocydGkWYB4F37orDXLP52/pBrjks+pY8oM17U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=k2hU04pFUypRE5zF/lFFTifEjkHO1M/T/ooeqqgBk3n7wo4JKjKTJ3WXKssZW3NwG
	 VMMYJdJKtRv3rFkqdjhyZAO7vlAOAywYFV5hhyBoqr80YWkm+N6Ou+aOgQFCnEO0sW
	 ID+yQ47GjRpdWX2eYnus2nHlkyrIufYq89SKQtaegQ8EpEbAxAulo0uWy7VI2jIYIv
	 e6eS0Zr9qPpI0H7FAbNzgD7Z/4RIaVq04h5RTZ2uIxvjEFIRsWGWcI/npWfGgmvVHi
	 h1WGkQX4E5fdaLDaK+UE7sPew7fK604by1f0dnUHJ0BdDjgg0xp1rfgOOsxexFm7uv
	 zwS6DXywJHcVA==
Date: Tue, 26 Nov 2024 01:52:13 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v5 6/8] worktree: add relative cli/config options to `move` command
Message-ID: <20241125-wt_relative_options-v5-6-356d122ff3db@pm.me>
In-Reply-To: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 12264e1a30b1b3b4f033fa1a2387ea2788c07567
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This teaches the `worktree move` command to respect the
`--[no-]relative-paths` CLI option and `worktree.useRelativePaths`
config setting. If an existing worktree is moved with `--relative-paths`
the new path will be relative (and visa-versa).

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 builtin/worktree.c       |  4 +++-
 t/t2403-worktree-move.sh | 25 +++++++++++++++++++++++++
 worktree.c               | 22 +++++++++-------------
 worktree.h               |  4 ++--
 4 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e3b4a71ee0bc13d5e817cf7dcc398e9e2bd975de..302151506981718658db1cd338c=
d9064688f5c14 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1190,6 +1190,8 @@ static int move_worktree(int ac, const char **av, con=
st char *prefix)
 =09=09OPT__FORCE(&force,
 =09=09=09 N_("force move even if worktree is dirty or locked"),
 =09=09=09 PARSE_OPT_NOCOMPLETE),
+=09=09OPT_BOOL(0, "relative-paths", &use_relative_paths,
+=09=09=09 N_("use relative paths for worktrees")),
 =09=09OPT_END()
 =09};
 =09struct worktree **worktrees, *wt;
@@ -1242,7 +1244,7 @@ static int move_worktree(int ac, const char **av, con=
st char *prefix)
 =09if (rename(wt->path, dst.buf) =3D=3D -1)
 =09=09die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
=20
-=09update_worktree_location(wt, dst.buf);
+=09update_worktree_location(wt, dst.buf, use_relative_paths);
=20
 =09strbuf_release(&dst);
 =09free_worktrees(worktrees);
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 901342ea09b51a8e832f1109fbb737df84283aa2..422c1a05580057b18ab8bfdfe38=
da4d723749493 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -247,4 +247,29 @@ test_expect_success 'not remove a repo with initialize=
d submodule' '
 =09)
 '
=20
+test_expect_success 'move worktree with absolute path to relative path' '
+=09test_config worktree.useRelativePaths false &&
+=09git worktree add ./absolute &&
+=09git worktree move --relative-paths absolute relative &&
+=09echo "gitdir: ../.git/worktrees/absolute" >expect &&
+=09test_cmp expect relative/.git &&
+=09echo "../../../relative/.git" >expect &&
+=09test_cmp expect .git/worktrees/absolute/gitdir &&
+=09test_config worktree.useRelativePaths true &&
+=09git worktree move relative relative2 &&
+=09echo "gitdir: ../.git/worktrees/absolute" >expect &&
+=09test_cmp expect relative2/.git &&
+=09echo "../../../relative2/.git" >expect &&
+=09test_cmp expect .git/worktrees/absolute/gitdir
+'
+
+test_expect_success 'move worktree with relative path to absolute path' '
+=09test_config worktree.useRelativePaths true &&
+=09git worktree move --no-relative-paths relative2 absolute &&
+=09echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
+=09test_cmp expect absolute/.git &&
+=09echo "$(pwd)/absolute/.git" >expect &&
+=09test_cmp expect .git/worktrees/absolute/gitdir
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index cf05045cc973f121a0a76b5ccfa731acf25d1a73..c749cb16994cf46ccccd4c2880a=
c917e497671b8 100644
--- a/worktree.c
+++ b/worktree.c
@@ -376,32 +376,28 @@ int validate_worktree(const struct worktree *wt, stru=
ct strbuf *errmsg,
 =09return ret;
 }
=20
-void update_worktree_location(struct worktree *wt, const char *path_)
+void update_worktree_location(struct worktree *wt, const char *path_,
+=09=09=09      int use_relative_paths)
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
+=09=09write_worktree_linking_files(dotgit, gitdir, use_relative_paths);
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
diff --git a/worktree.h b/worktree.h
index fd040f5d999697b603df929679bdddd2ff7f6eea..9c699d080d8ebf3771204413667=
9db3821ee1f63 100644
--- a/worktree.h
+++ b/worktree.h
@@ -117,8 +117,8 @@ int validate_worktree(const struct worktree *wt,
 /*
  * Update worktrees/xxx/gitdir with the new path.
  */
-void update_worktree_location(struct worktree *wt,
-=09=09=09      const char *path_);
+void update_worktree_location(struct worktree *wt, const char *path_,
+=09=09=09      int use_relative_paths);
=20
 typedef void (* worktree_repair_fn)(int iserr, const char *path,
 =09=09=09=09    const char *msg, void *cb_data);

--=20
2.47.0


