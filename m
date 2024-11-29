Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47F79CD
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 02:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848297; cv=none; b=Q5x6KvIyHwlkmYjOFabWkFuI1JHd99mxjU4AKNTISAtyI5NjgpXFUokK9COlYsRuuZm9SXXHUSm3s35j7TNbjdsOAAX8kL70JstBrRy1LfTJMXzeCfRfLwADMZjy3h0Js4zIvWc84nbhgQnb95EHB/dvlVvuyd/+tLDIEadoU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848297; c=relaxed/simple;
	bh=XosmYGWpRFTfxFVhYW/BvHcV9VWZYdiGax4AQq/3gEM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSEcbHPzbSpgELpCJJpQlLYRuVCePX10DiUEcQ9/l388sWUO8nM2UofOz8xb2w7XskIjepZ/6lxkMTbRuUkZ+ELUy+REWD9R9Wdsp08IZv35ivOPRxwjlY13xyFhMgVhcXm92kmhIRr+G2cbfZ2sJGpTh6a28hx1+cKN7iNBJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=hUEifn4w; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="hUEifn4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732848286; x=1733107486;
	bh=8QUv9cFqo87UgTka1v+K4DTZdyX6hHsXOyESzd7rQa4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=hUEifn4wWUx4KIWMmQa8Z45lFYkEmZe0q/2EZ4CIAYYIb8oB56hwjGNgO5RAxyAQM
	 XJFuRIKau0T0mgxIyMxibjcGSWy7RM9ZEJg7kP9ampB3+Hu6n2eIljeSvDzWIAkiS6
	 /J/g7W4RdDLv40z4ndD37sSw/Wp0Cm9NGXP2wPSHisb2eqMR+cTp/Ftnn2tD3p6pzy
	 XpYbZuslrkXIFwHz0yxh/OTokBQun3Q0F5XbRQAI/9qSoKgL1vZRMCxsgj8yKRYNv4
	 10OLLhfRKn774O8pwalUQnpGNmiEAVD+qZ4QMrVVY6pVjPVg610GdWOcMT9n9mV70G
	 P8cl5bfZS6h1Q==
Date: Fri, 29 Nov 2024 02:44:40 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 2/2] worktree: rename worktree id during worktree move
Message-ID: <20241128-wt_unique_ids-v1-2-30345d010e43@pm.me>
In-Reply-To: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
References: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 20ceac18e847b461ddd48518d62cbce218b18d9e
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


