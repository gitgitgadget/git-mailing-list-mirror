Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728F54279
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732919005; cv=none; b=olxOmU/wcnTfaJ/TE/pTSAN5m2ZapIugny+SXgR1wcqlS5ffMxoYWpCbbhT8sLzayV7dhKuXhfI9LIx2MoTFPOuKyrmH0kWP05FYNTwBMdenUeb1Kqu/EyaDe/22SS6FVXic+wM7mDMiWsCt/59W5Lf3h12P112Z7Mqk0oEIyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732919005; c=relaxed/simple;
	bh=GQN2kZB4ckvK4vj3vr7zrJkB/21XX4FcDoOaYlot9+w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Re27KDLwJka9rlXPWPYHmJ/dneoBTAF1ImQq3lNSbnHceVtFn86bRKiApdoY6TrBC5inwIjMYoJhkjoWmsLnsZmsRZP1UCzkaB3HIKlfEf+b4jDnk0nvBRSHZ3mm0m+T5H43Bqf0emlZZIPd/rSSW4TyaUSQnj0iMjWRLpICMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=r6GDX4bw; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="r6GDX4bw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732919001; x=1733178201;
	bh=if7bClFIM6C6mmghzH4xQJX924FUfiJrGz5MyrEJhr0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=r6GDX4bwOLxedKYeCFXHYlKpziiR2LZ47feYpyWZxL4BrCF4TMF2iayW9p+jvaxBC
	 vOXrrmV+UqP67B6n6R9gWOtBjEI+WzK4hkZbHEF7RGPcDQeoIZbV+dJJWftgqLLX+s
	 CkIlwcszK7YsJWK5hc5aSCczCjOMC4bNha7lX69AbrwD87eeapKinIo6cMO+p1P1C4
	 gz4EuemdUSO1uIz6xqENwnsVnpgZPhWIfrp6aptLnDxStNatOFrKvqv2W4DIsVtWt7
	 nVb0xAge1+aZ6R9tCfqmR0D3SjludKKtOl3pzhNzjg6Pp/jPzzAYVR4tuL7lmO9cyo
	 xykuUHZu/QFJw==
Date: Fri, 29 Nov 2024 22:23:16 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v6 8/8] worktree: refactor `repair_worktree_after_gitdir_move()`
Message-ID: <20241129-wt_relative_options-v6-8-44e4e0bec8c3@pm.me>
In-Reply-To: <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me> <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 27a5666ac25ab97fe5a3d4cf2c3500317c6f9379
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This refactors `repair_worktree_after_gitdir_move()` to use the new
`write_worktree_linking_files` function. It also preserves the
relativity of the linking files; e.g., if an existing worktree used
absolute paths then the repaired paths will be absolute (and visa-versa).
`repair_worktree_after_gitdir_move()` is used to repair both sets of
worktree linking files if the `.git` directory is moved during a
re-initialization using `git init`.

This also adds a test case for reinitializing a repository that has
relative worktrees.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 t/t0001-init.sh | 22 ++++++++++++++++++----
 worktree.c      | 29 ++++++++---------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0178aa62a41f1606f2382a4a10ab593ccf11e0e8..e394147b8480fb5784f1c23c0d2=
eae712eecc44b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -434,6 +434,12 @@ test_expect_success SYMLINKS 're-init to move gitdir s=
ymlink' '
 sep_git_dir_worktree ()  {
 =09test_when_finished "rm -rf mainwt linkwt seprepo" &&
 =09git init mainwt &&
+=09if test "relative" =3D $2
+=09then
+=09=09test_config -C mainwt worktree.useRelativePaths true
+=09else
+=09=09test_config -C mainwt worktree.useRelativePaths false
+=09fi
 =09test_commit -C mainwt gumby &&
 =09git -C mainwt worktree add --detach ../linkwt &&
 =09git -C "$1" init --separate-git-dir ../seprepo &&
@@ -442,12 +448,20 @@ sep_git_dir_worktree ()  {
 =09test_cmp expect actual
 }
=20
-test_expect_success 're-init to move gitdir with linked worktrees' '
-=09sep_git_dir_worktree mainwt
+test_expect_success 're-init to move gitdir with linked worktrees (absolut=
e)' '
+=09sep_git_dir_worktree mainwt absolute
+'
+
+test_expect_success 're-init to move gitdir within linked worktree (absolu=
te)' '
+=09sep_git_dir_worktree linkwt absolute
+'
+
+test_expect_success 're-init to move gitdir with linked worktrees (relativ=
e)' '
+=09sep_git_dir_worktree mainwt relative
 '
=20
-test_expect_success 're-init to move gitdir within linked worktree' '
-=09sep_git_dir_worktree linkwt
+test_expect_success 're-init to move gitdir within linked worktree (relati=
ve)' '
+=09sep_git_dir_worktree linkwt relative
 '
=20
 test_expect_success MINGW '.git hidden' '
diff --git a/worktree.c b/worktree.c
index 2e76bbc1494afc125997f803dc39846a0b95a84f..af68b24f9d0917a99cd965347aa=
d6466e9dbb152 100644
--- a/worktree.c
+++ b/worktree.c
@@ -651,45 +651,32 @@ void repair_worktrees(worktree_repair_fn fn, void *cb=
_data, int use_relative_pat
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
+=09int is_relative_path;
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
+=09is_relative_path =3D ! is_absolute_path(dotgit.buf);
+=09if (is_relative_path) {
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
+=09write_worktree_linking_files(dotgit, gitdir, is_relative_path);
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

--=20
2.47.0


