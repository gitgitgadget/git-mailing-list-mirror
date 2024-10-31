Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A57F460
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730351175; cv=none; b=G5UmefVJL48npl+7HF3tKZ3qdKis7SC59BGoMCQPmDWsZ5G2pphyTODOTc82tWLujVXsxj5wFkGX8LFDY1NVY1aW41VGaAnK3CAJlW9Ax5KuNreBGMgC3oKqmjOevB663EmN3YVnNOrK73J1/fUu6wef2SJPMeGRe5PADUZgJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730351175; c=relaxed/simple;
	bh=i1yN7/D47SaLpCixDV1krhD1Lnr/bNLATK25Zr1s8fs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bq1ClDfmikJM7DL0Gg+YRMrvq81p2YvpMtvGqk/TSwnFj1gwIWm/i7+0r6Qd/jahP9dJql9iYiqSQ8vvMiVP4Rr4SEs1+2sxJI9q8kwEw0IsnhCO8L6tT6TNzD515QOf0H5ws6BC47vQxyVkNMqVgHVmk68hZ9oC/LfQfnfmFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Q0WZEpgU; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Q0WZEpgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730351170; x=1730610370;
	bh=FPVsN+dpkjuPzI93fmpmkajfAMhILun+V5LsX4KFflg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q0WZEpgUTK7UmLjocN9aBrQnAZ+rXPr7FjFSfIBFAd4QojpiaSJymkd7aD2tFNsHL
	 0mo88havjRGdySDGLOjD27a+5ki4HWQ2OA/JYMKwLTzDHa1+r5M0QNZbbk6S/j64wa
	 e6NTSJj6HDzjHbRhLl80muplrZ0zYzrBjpobmvu2plJVHtXK7juntExiqmZcQt4Uwf
	 KUdeVNadAcKfC7PiZTrU4oBovx9IRf631ZubvYbss1PS8YlUgUOh/VolqYgjK2+7hT
	 nl2R3Sh3db0BlYjr3rrQQBaOLJQbgloutOjLr90xJKaEF+9tXkiMaz2joT+JVqR7eQ
	 jFfYitiRkM5Sw==
Date: Thu, 31 Oct 2024 05:06:06 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v3 6/8] worktree: add relative cli/config options to `move` command
Message-ID: <20241031-wt_relative_options-v3-6-3e44ccdf64e6@pm.me>
In-Reply-To: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me>
References: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: c4332f4a9264fcf4765fcdc33f87f99f1e34551a
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
 t/t2403-worktree-move.sh | 22 ++++++++++++++++++++++
 worktree.c               | 23 ++++++++++-------------
 worktree.h               |  3 ++-
 4 files changed, 37 insertions(+), 15 deletions(-)

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
index 901342ea09b51a8e832f1109fbb737df84283aa2..6ce9ed3f1e6b3f73d2a290e7702=
33eec30221fe5 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -247,4 +247,26 @@ test_expect_success 'not remove a repo with initialize=
d submodule' '
 =09)
 '
=20
+test_expect_success 'move worktree with absolute path to relative path' '
+=09git config worktree.useRelativePaths false &&
+=09git worktree add ./absolute &&
+=09git worktree move --relative-paths absolute relative &&
+=09cat relative/.git >actual &&
+=09echo "gitdir: ../.git/worktrees/absolute" >expect &&
+=09test_cmp expect actual &&
+=09git config worktree.useRelativePaths true &&
+=09git worktree move relative relative2 &&
+=09cat relative2/.git >actual &&
+=09echo "gitdir: ../.git/worktrees/absolute" >expect &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'move worktree with relative path to absolute path' '
+=09git config worktree.useRelativePaths true &&
+=09git worktree move --no-relative-paths relative2 absolute &&
+=09cat absolute/.git >actual &&
+=09echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
+=09test_cmp expect actual
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index ab6f1e036fa019285a1a5152decb9aed5202909f..6b640cd9549ecb060236f7eddf1=
390caa181f1a0 100644
--- a/worktree.c
+++ b/worktree.c
@@ -376,32 +376,29 @@ int validate_worktree(const struct worktree *wt, stru=
ct strbuf *errmsg,
 =09return ret;
 }
=20
-void update_worktree_location(struct worktree *wt, const char *path_)
+void update_worktree_location(struct worktree *wt,
+=09=09=09      const char *path_,
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
index 4786aa545ca1fa12bb16a55ddf5a59c06503b2c5..6dd5dfc9b71870320c96aae35a7=
a983b5b9ba9a7 100644
--- a/worktree.h
+++ b/worktree.h
@@ -118,7 +118,8 @@ int validate_worktree(const struct worktree *wt,
  * Update worktrees/xxx/gitdir with the new path.
  */
 void update_worktree_location(struct worktree *wt,
-=09=09=09      const char *path_);
+=09=09=09      const char *path_,
+=09=09=09      int use_relative_paths);
=20
 typedef void (* worktree_repair_fn)(int iserr, const char *path,
 =09=09=09=09    const char *msg, void *cb_data);

--=20
2.47.0


