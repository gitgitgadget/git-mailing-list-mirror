Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0682C18C
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732919881; cv=none; b=nlHSpIeZ0W7piVzePgakKVIfXfEBilSAyAh5PcQ++tWIYJ81yX2L3sJH4r/vM2RR8FlIWhkmBLRDVWa+NptutCfRK2M3HQShMmDlKi6WW69p7v2xxnk6xwx2n+mlwi08D/ge920DlxA73ilB9njm94USVKKahGLJNqGJL2gQy2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732919881; c=relaxed/simple;
	bh=XosmYGWpRFTfxFVhYW/BvHcV9VWZYdiGax4AQq/3gEM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKU1uJpPeWY0rElNzN320se4sfdW24LYbBmf+hFOebGsnDXIrI7Kl2ORMxMfJ69ew96M2maj/FzVrj55Am1uWeC+Fsy4UbX/vKo06WWxCMwLc2GM1IMnUz4l1/fxdJrU3Y2CsVjJ267uQICmo+fR2wA84yc6gUKOBDmvaPr5p6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VnvLUc40; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VnvLUc40"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732919877; x=1733179077;
	bh=8QUv9cFqo87UgTka1v+K4DTZdyX6hHsXOyESzd7rQa4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=VnvLUc40nceRKBR9x/+FmM0yfUo5tOgXR1Q81Ed/+47dAgXwyTAODida+xclOEnFm
	 2soPRfS95MuHt0xC26NQVE2X8WSdz59EtPXuSPx7ek2dqN0fJXh5Pu57++oPbxSiS0
	 6TT32BtOsGBcplrzfNNZa5+OMfyyccMJn3W8VqoNO+2TnXjO21kjkYAAaoBUniVNQ5
	 5SOTg9vTcyr6Z/4vSeoOpSwMeSv032ozBbdJrgG3aNvRJY0sTjPOxgw2waJbtahISG
	 2w1MBDMX9E1Q0+6PkEdooAu3plY/XRbBiSyKVa1UAVS2pa3JD05Hp6K513J3Ssg2ky
	 WmDlPCeDg2PGA==
Date: Fri, 29 Nov 2024 22:37:51 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: shejialuo <shejialuo@gmail.com>, Junio C Hamano <gitster@pobox.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 2/3] worktree: rename worktree id during worktree move
Message-ID: <20241129-wt_unique_ids-v2-2-ff444e9e625a@pm.me>
In-Reply-To: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: c0a7c69c3568c063768a2952233dd1d6703bac12
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

During a `worktree move` the worktree directory is moved/renamed but the
repository under `worktrees/<id>` is not updated. For example, given the
following structure:

    foo/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-5445874156/
    =E2=94=94=E2=94=80=E2=94=80 develop/

moving `develop` to `master` results in

    foo/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-5445874156/
    =E2=94=94=E2=94=80=E2=94=80 master/

This works because the linking files still point to the correct
repository, but this is a little weird. This teaches Git to also
move/rename the repository / worktree id during a `move` so that the
structure now looks like:

    foo/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/master-1565465986/
    =E2=94=94=E2=94=80=E2=94=80 master/

Note that a new unique suffix is assigned to reduce the complexity of
trying to parse and reuse the existing suffix.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 builtin/worktree.c       | 24 ++++++++++++++++++++++++
 t/t2403-worktree-move.sh | 18 +++++++++---------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3ad355ca762729401fc0c8625f4fd05b154a84ec..36235546b492803707707ff208b=
13fe777bff1b4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1202,9 +1202,14 @@ static int move_worktree(int ac, const char **av, co=
nst char *prefix)
 =09};
 =09struct worktree **worktrees, *wt;
 =09struct strbuf dst =3D STRBUF_INIT;
+=09struct strbuf repo =3D STRBUF_INIT;
+=09struct strbuf repo_dst =3D STRBUF_INIT;
 =09struct strbuf errmsg =3D STRBUF_INIT;
 =09const char *reason =3D NULL;
+=09const char *new_id;
+=09const char *suffix;
 =09char *path;
+=09int len;
=20
 =09ac =3D parse_options(ac, av, prefix, options, git_worktree_move_usage,
 =09=09=09   0);
@@ -1250,9 +1255,28 @@ static int move_worktree(int ac, const char **av, co=
nst char *prefix)
 =09if (rename(wt->path, dst.buf) =3D=3D -1)
 =09=09die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
=20
+=09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
+=09new_id =3D worktree_basename(dst.buf, &len);
+=09strbuf_add(&repo_dst, new_id, dst.buf + len - new_id);
+=09strbuf_realpath(&repo_dst, git_common_path("worktrees/%s", repo_dst.buf=
), 1);
+=09suffix =3D getenv("GIT_TEST_WORKTREE_SUFFIX");
+=09if (suffix)
+=09=09strbuf_addf(&repo_dst, "-%s", suffix);
+=09else
+=09=09strbuf_addf(&repo_dst, "-%u", git_rand());
+=09new_id =3D strrchr(repo_dst.buf, '/') + 1;
+=09if (rename(repo.buf, repo_dst.buf) =3D=3D -1)
+=09=09die_errno(_("failed to move '%s' to '%s'"), repo.buf, repo_dst.buf);
+=09else {
+=09=09free(wt->id);
+=09=09wt->id =3D xstrdup(new_id);
+=09}
+
 =09update_worktree_location(wt, dst.buf, use_relative_paths);
=20
 =09strbuf_release(&dst);
+=09strbuf_release(&repo);
+=09strbuf_release(&repo_dst);
 =09free_worktrees(worktrees);
 =09return 0;
 }
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index ba3f05c16a4969fb84d98052ae375ef162f3e73a..703aa58d10643e99ffaf803aa38=
dabfd4af68a10 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -250,26 +250,26 @@ test_expect_success 'not remove a repo with initializ=
ed submodule' '
 test_expect_success 'move worktree with absolute path to relative path' '
 =09test_config worktree.useRelativePaths false &&
 =09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add ./absolute &&
-=09git worktree move --relative-paths absolute relative &&
-=09echo "gitdir: ../.git/worktrees/absolute-123" >expect &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git worktree move --relative-paths absol=
ute relative &&
+=09echo "gitdir: ../.git/worktrees/relative-456" >expect &&
 =09test_cmp expect relative/.git &&
 =09echo "../../../relative/.git" >expect &&
-=09test_cmp expect .git/worktrees/absolute-123/gitdir &&
+=09test_cmp expect .git/worktrees/relative-456/gitdir &&
 =09test_config worktree.useRelativePaths true &&
-=09git worktree move relative relative2 &&
-=09echo "gitdir: ../.git/worktrees/absolute-123" >expect &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D789 git worktree move relative relative2 &&
+=09echo "gitdir: ../.git/worktrees/relative2-789" >expect &&
 =09test_cmp expect relative2/.git &&
 =09echo "../../../relative2/.git" >expect &&
-=09test_cmp expect .git/worktrees/absolute-123/gitdir
+=09test_cmp expect .git/worktrees/relative2-789/gitdir
 '
=20
 test_expect_success 'move worktree with relative path to absolute path' '
 =09test_config worktree.useRelativePaths true &&
-=09git worktree move --no-relative-paths relative2 absolute &&
-=09echo "gitdir: $(pwd)/.git/worktrees/absolute-123" >expect &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D851 git worktree move --no-relative-paths re=
lative2 absolute &&
+=09echo "gitdir: $(pwd)/.git/worktrees/absolute-851" >expect &&
 =09test_cmp expect absolute/.git &&
 =09echo "$(pwd)/absolute/.git" >expect &&
-=09test_cmp expect .git/worktrees/absolute-123/gitdir
+=09test_cmp expect .git/worktrees/absolute-851/gitdir
 '
=20
 test_done

--=20
2.47.0


