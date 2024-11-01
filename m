Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1E148FE8
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730435951; cv=none; b=pBPGEZjABJt6AZg0AaY08cSa2JFhvnMureY1Xw0aHb18Sg7C7tmT9OlCc7TRz8tg3Qo9xduJfMXkZ9tcaYVidSuaVWxN+Y4nAsoSFYRiIcXI+hlxaA6BUN2gFi12as6+uWwasYD1cVFWD1JUKtb968kh4/5urFSLE+iyAVrHrLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730435951; c=relaxed/simple;
	bh=Ugjkf74Fo1MulgkqG7G9TkIq657STI4NcK+koZ9BYvo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4ye/eL0bLzdoy04gZjsp2qcC8DyUcxT44b8b0EqIr30C+gBdUOM5CGsebfvHTyqPBtqIRCjoGhIHhwat3O7zlPdkxlp8Hm1ssBFF3V+ldNofc9RuBCpANTHvEXtIWZw8ewpkGlvMyagPQJ1cPq4FhG/929aM61buBuQpea9AYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pYSgU7iT; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pYSgU7iT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730435946; x=1730695146;
	bh=U7NPavXSWlhmJ/iw0vxNYrKPBygr4STXhsC4rw5z1yA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pYSgU7iTFOvJrCJvg7RKRFYeu36Lth5YSkeHIEvOmH9alfg354wW00YTYhOe2QQjV
	 BFipcHUWrIA70CgZuIx5YlRUm/MSjKS75UQnkuphEbtXOYIBGpwGr0DMk+5apRiCU9
	 89H6YIen8eW8rrLKkMacTp6JoM/Uz3KQmhvcyKrXrL1T9rE8n1TZETeyDriwF317N5
	 FC62b8Yr/5uCRKeml1BiRRkn1fkbmkbwaLGiW0muu2lrUMaBaUkSX1A3WzmX+/Rnii
	 syRbThYd+G7ZSwPk21PYDg34V2z93N8k3LyGtk1zY2WDGn2QBJYw1l/5yU81IVMWD0
	 1aZo/Csre4qPA==
Date: Fri, 01 Nov 2024 04:39:01 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v4 8/8] worktree: refactor `repair_worktree_after_gitdir_move()`
Message-ID: <20241031-wt_relative_options-v4-8-07a3dc0f02a3@pm.me>
In-Reply-To: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 557b30894e8167020c1bd960151900ec37f740a4
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

This also adds a test case for reinitializing a repository that has
relative worktrees.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 t/t0001-init.sh | 22 ++++++++++++++++++----
 worktree.c      | 29 ++++++++---------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0178aa62a41f1606f2382a4a10ab593ccf11e0e8..264951592a711f6879555b78590=
5e799db6c5dd4 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -434,6 +434,12 @@ test_expect_success SYMLINKS 're-init to move gitdir s=
ymlink' '
 sep_git_dir_worktree ()  {
 =09test_when_finished "rm -rf mainwt linkwt seprepo" &&
 =09git init mainwt &&
+=09if test "relative" =3D $2
+=09then
+=09=09git -C mainwt config worktree.useRelativePaths true
+=09else
+=09=09git -C mainwt config worktree.useRelativePaths false
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
index 2cb994ac462debf966ac51b5a4f33c30cfebd4ef..2c2e9fd8fdc22d4fe3705227d72=
b8dbd293038b2 100644
--- a/worktree.c
+++ b/worktree.c
@@ -653,45 +653,32 @@ void repair_worktrees(worktree_repair_fn fn, void *cb=
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


