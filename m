Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3913B590
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730351196; cv=none; b=bWk9Pw/T7lMXUboAclgfU/T5p+ush4hj0JC7i52q+Gly0YmEKNQfZ8gUtym1SnHqjGLfyNs9hLyT10RKbO+emw2AKb74ZzwxbpHlnXe6O2XOBVT02ihLFjkS25iyZrYr0DqZfE3eqt3owsMTGdUTxQqnazFbJshG0sZKs8EIajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730351196; c=relaxed/simple;
	bh=Ugjkf74Fo1MulgkqG7G9TkIq657STI4NcK+koZ9BYvo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLiOJgADYz4DRZvbiDP32zJBNeDZF9j+ONhaCpBZzvRmlpJipxGQqXm+uGVxYiJTCmnc09RNfln02lN4iHXQ5fjVE3Xs4fP9ZV5zy+BRFup6+8ozLMkJBXOXw2WGJsokK6l/97GlcoNFOmySx6paQhcout9x30UmeY9QVrl1MD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Gf90hZzS; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Gf90hZzS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730351185; x=1730610385;
	bh=U7NPavXSWlhmJ/iw0vxNYrKPBygr4STXhsC4rw5z1yA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Gf90hZzS+BItKmNtql6NmEILTmzXKFXVJybKnkH05ySgMdVZzIxTulBh6jiUxXCZr
	 oznvcyv1Fs/HMFTzzybMoliwpAutPiTfcBYO/bM6gYtVMh2qZ1AQ3nu03VQEm/f4mQ
	 o39tAHD5Xg8vPcNKplgudWO21co4Kykmn6V/oNjofQulwqSOg3OvJZ3C1ks8VLSrXG
	 wYrcKV+xGeKXUHkAR+U8aXCr++I+8r6xUrWBU2dvFa5199wniZ8qyckuVzLHX/Lm9b
	 w/NZ36QH0ReFOnrO1uh0c1fdfORh8bIwuVMp9n8K9Hs5OrfL8g/KhMiWhJHZ9BemRI
	 EIiLsWBqGjItw==
Date: Thu, 31 Oct 2024 05:06:21 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v3 8/8] worktree: refactor `repair_worktree_after_gitdir_move()`
Message-ID: <20241031-wt_relative_options-v3-8-3e44ccdf64e6@pm.me>
In-Reply-To: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me>
References: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 9f953c7ab8cf35ffaa6a6dc82db72153a4f81ee9
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


