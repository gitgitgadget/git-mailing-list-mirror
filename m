Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5600054279
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732918989; cv=none; b=UVRJf2O6vtGsJY6UjzKfgaou5DFTQK9qI+HPO9GNuwOGzllAm5X+2rahx5t5a4/iDMgjtIAMnAQORAn3n/gTOgxz7vgMe6L2Qv2W8KHIj5xXN2ZuIe5gVVzTkkbMWicXFsiW5X2tegJo9wTqXLkePX1SfJN5U1phyBdXMSUVKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732918989; c=relaxed/simple;
	bh=5RVwVRXPjMb/VchdqSuEuNcCx96uDsAD0VAYA2Z/XZM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edtZOICdSkKd2sK3XXLiZDoGPRlXhuLjC7/HL+XgcRJT9qyYQM8Jmv/HAs3b+rXforSrnnj+DkdaiW4FIwjeytmHPLPo/NPR0PAhmD2gX1vx55oZ3efhEqKx7OFNPmNdwZHPvzI6ZrxxP4VhXQoqRTXP7/tSr1VpYG63K8uAEoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=A7Rf6Xwv; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="A7Rf6Xwv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732918979; x=1733178179;
	bh=wY1vID4Sklf42Lw/BToSA7vlm8TzRaMwNhCSxKy2cwE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=A7Rf6XwvuLB9BFFFt7i5T2cT5jWKhgM+s2aZ3F2xkXNfu5GfCgoi9y0rwM52Sjgft
	 YK/ugP3xAPJ3a9xgF/S/0Se+DDQNnibNmrSpWqvM0reCodnzmGRABV8mhKraNO/dVG
	 qMjCZsRsicU7BqsIEPJftgtSAJakvRdBUAu2+e3odwJZNmxQK+32AcOi1/lbdMSfD1
	 xhepEUNhrjYDYzkltRuYiciCBBKHFoW79T3KSyRjf8ejwaRoKi3d8Kt3RqdWbARzSQ
	 kr/MqkkeCrbbCupXev3GdYrkhQ6sbn7VUi8lvPvhP9THF2BT3+lwXP42gWnCyp4PjI
	 hMpXraykUNsWg==
Date: Fri, 29 Nov 2024 22:22:55 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v6 5/8] worktree: add relative cli/config options to `add` command
Message-ID: <20241129-wt_relative_options-v6-5-44e4e0bec8c3@pm.me>
In-Reply-To: <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me> <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 506134f3f3bd3635248cddf45eefef6bf02ee737
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This introduces the `--[no-]relative-paths` CLI option and
`worktree.useRelativePaths` configuration setting to the `worktree add`
command. When enabled these options allow worktrees to be linked using
relative paths, enhancing portability across environments where absolute
paths may differ (e.g., containerized setups, shared network drives).
Git still creates absolute paths by default, but these options allow
users to opt-in to relative paths if desired.

The t2408 test file is removed and more comprehensive tests are
written for the various worktree operations in their own files.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 Documentation/config/worktree.txt | 10 +++++++++
 Documentation/git-worktree.txt    |  5 +++++
 builtin/worktree.c                | 19 ++++++++--------
 t/t2400-worktree-add.sh           | 46 +++++++++++++++++++++++++++++++++++=
++++
 t/t2401-worktree-prune.sh         |  3 ++-
 t/t2402-worktree-list.sh          | 22 +++++++++++++++++++
 t/t2408-worktree-relative.sh      | 39 ---------------------------------
 7 files changed, 95 insertions(+), 49 deletions(-)

diff --git a/Documentation/config/worktree.txt b/Documentation/config/workt=
ree.txt
index 048e349482df6c892055720eb53cdcd6c327b6ed..5e35c7d018aecdedca0642b11e4=
5df6d19024d42 100644
--- a/Documentation/config/worktree.txt
+++ b/Documentation/config/worktree.txt
@@ -7,3 +7,13 @@ worktree.guessRemote::
 =09such a branch exists, it is checked out and set as "upstream"
 =09for the new branch.  If no such match can be found, it falls
 =09back to creating a new branch from the current HEAD.
+
+worktree.useRelativePaths::
+=09Link worktrees using relative paths (when "true") or absolute
+=09paths (when "false"). This is particularly useful for setups
+=09where the repository and worktrees may be moved between
+=09different locations or environments. Defaults to "false".
++
+Note that setting `worktree.useRelativePaths` to "true" implies enabling t=
he
+`extension.relativeWorktrees` config (see linkgit:git-config[1]),
+thus making it incompatible with older versions of Git.
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 70437c815f13852bd2eb862176b8b933e6de0acf..60a671bbc255aa7763b4f77511c=
09f6a02783e00 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -216,6 +216,11 @@ To remove a locked worktree, specify `--force` twice.
 This can also be set up as the default behaviour by using the
 `worktree.guessRemote` config option.
=20
+--[no-]relative-paths::
+=09Link worktrees using relative paths or absolute paths (default).
+=09Overrides the `worktree.useRelativePaths` config option, see
+=09linkgit:git-config[1].
+
 --[no-]track::
 =09When creating a new branch, if `<commit-ish>` is a branch,
 =09mark it as "upstream" from the new branch.  This is the
diff --git a/builtin/worktree.c b/builtin/worktree.c
index dae63dedf4cac2621f51f95a39aa456b33acd894..e3b4a71ee0bc13d5e817cf7dcc3=
98e9e2bd975de 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -120,12 +120,14 @@ struct add_opts {
 =09int quiet;
 =09int checkout;
 =09int orphan;
+=09int relative_paths;
 =09const char *keep_locked;
 };
=20
 static int show_only;
 static int verbose;
 static int guess_remote;
+static int use_relative_paths;
 static timestamp_t expire;
=20
 static int git_worktree_config(const char *var, const char *value,
@@ -134,6 +136,9 @@ static int git_worktree_config(const char *var, const c=
har *value,
 =09if (!strcmp(var, "worktree.guessremote")) {
 =09=09guess_remote =3D git_config_bool(var, value);
 =09=09return 0;
+=09} else if (!strcmp(var, "worktree.userelativepaths")) {
+=09=09use_relative_paths =3D git_config_bool(var, value);
+=09=09return 0;
 =09}
=20
 =09return git_default_config(var, value, ctx, cb);
@@ -414,8 +419,7 @@ static int add_worktree(const char *path, const char *r=
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
@@ -491,10 +495,7 @@ static int add_worktree(const char *path, const char *=
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
+=09write_worktree_linking_files(sb_git, sb, opts->relative_paths);
 =09strbuf_reset(&sb);
 =09strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 =09write_file(sb.buf, "../..");
@@ -578,12 +579,9 @@ static int add_worktree(const char *path, const char *=
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
@@ -796,12 +794,15 @@ static int add(int ac, const char **av, const char *p=
refix)
 =09=09=09     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
 =09=09OPT_BOOL(0, "guess-remote", &guess_remote,
 =09=09=09 N_("try to match the new branch name with a remote-tracking bran=
ch")),
+=09=09OPT_BOOL(0, "relative-paths", &opts.relative_paths,
+=09=09=09 N_("use relative paths for worktrees")),
 =09=09OPT_END()
 =09};
 =09int ret;
=20
 =09memset(&opts, 0, sizeof(opts));
 =09opts.checkout =3D 1;
+=09opts.relative_paths =3D use_relative_paths;
 =09ac =3D parse_options(ac, av, prefix, options, git_worktree_add_usage, 0=
);
 =09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 =09=09die(_("options '%s', '%s', and '%s' cannot be used together"), "-b",=
 "-B", "--detach");
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index cfc4aeb1798c6d023909cec771e5b74e983af5ea..bc4f4e90d6ecfedbde9082bda6f=
9e4eec3e3575d 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1207,4 +1207,50 @@ test_expect_success '"add" with initialized submodul=
e, with submodule.recurse se
 =09git -C project-clone -c submodule.recurse worktree add ../project-5
 '
=20
+test_expect_success 'can create worktrees with relative paths' '
+=09test_when_finished "git worktree remove relative" &&
+=09test_config worktree.useRelativePaths false &&
+=09git worktree add --relative-paths ./relative &&
+=09echo "gitdir: ../.git/worktrees/relative" >expect &&
+=09test_cmp expect relative/.git &&
+=09echo "../../../relative/.git" >expect &&
+=09test_cmp expect .git/worktrees/relative/gitdir
+'
+
+test_expect_success 'can create worktrees with absolute paths' '
+=09test_config worktree.useRelativePaths true &&
+=09git worktree add ./relative &&
+=09echo "gitdir: ../.git/worktrees/relative" >expect &&
+=09test_cmp expect relative/.git &&
+=09git worktree add --no-relative-paths ./absolute &&
+=09echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
+=09test_cmp expect absolute/.git &&
+=09echo "$(pwd)/absolute/.git" >expect &&
+=09test_cmp expect .git/worktrees/absolute/gitdir
+'
+
+test_expect_success 'move repo without breaking relative internal links' '
+=09test_when_finished rm -rf repo moved &&
+=09git init repo &&
+=09(
+=09=09cd repo &&
+=09=09test_commit initial &&
+=09=09git worktree add --relative-paths wt1 &&
+=09=09cd .. &&
+=09=09mv repo moved &&
+=09=09cd moved/wt1 &&
+=09=09git worktree list >out 2>err &&
+=09=09test_must_be_empty err
+=09)
+'
+
+test_expect_success 'relative worktree sets extension config' '
+=09test_when_finished "rm -rf repo" &&
+=09git init repo &&
+=09git -C repo commit --allow-empty -m base &&
+=09git -C repo worktree add --relative-paths ./foo &&
+=09test_cmp_config -C repo 1 core.repositoryformatversion &&
+=09test_cmp_config -C repo true extensions.relativeworktrees
+'
+
 test_done
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 976d048e3efc74be9cd909ce76d552b3944d2e10..5eb52b9abbf29514dc082c260eb=
b7a5e8e63aae0 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -120,11 +120,12 @@ test_expect_success 'prune duplicate (main/linked)' '
 =09! test -d .git/worktrees/wt
 '
=20
-test_expect_success 'not prune proper worktrees when run inside linked wor=
ktree' '
+test_expect_success 'not prune proper worktrees inside linked worktree wit=
h relative paths' '
 =09test_when_finished rm -rf repo wt_ext &&
 =09git init repo &&
 =09(
 =09    cd repo &&
+=09    git config worktree.useRelativePaths true &&
 =09    echo content >file &&
 =09    git add file &&
 =09    git commit -m msg &&
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 33ea9cb21ba07c9563530b54da06753eaa993fe2..780daa6cd6351f8fa9434619cc2=
12aade8f01420 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -261,6 +261,7 @@ test_expect_success 'broken main worktree still at the =
top' '
 '
=20
 test_expect_success 'linked worktrees are sorted' '
+=09test_when_finished "rm -rf sorted" &&
 =09mkdir sorted &&
 =09git init sorted/main &&
 =09(
@@ -280,6 +281,27 @@ test_expect_success 'linked worktrees are sorted' '
 =09test_cmp expected sorted/main/actual
 '
=20
+test_expect_success 'linked worktrees with relative paths are shown with a=
bsolute paths' '
+=09test_when_finished "rm -rf sorted" &&
+=09mkdir sorted &&
+=09git init sorted/main &&
+=09(
+=09=09cd sorted/main &&
+=09=09test_tick &&
+=09=09test_commit new &&
+=09=09git worktree add --relative-paths ../first &&
+=09=09git worktree add ../second &&
+=09=09git worktree list --porcelain >out &&
+=09=09grep ^worktree out >actual
+=09) &&
+=09cat >expected <<-EOF &&
+=09worktree $(pwd)/sorted/main
+=09worktree $(pwd)/sorted/first
+=09worktree $(pwd)/sorted/second
+=09EOF
+=09test_cmp expected sorted/main/actual
+'
+
 test_expect_success 'worktree path when called in .git directory' '
 =09git worktree list >list1 &&
 =09git -C .git worktree list >list2 &&
diff --git a/t/t2408-worktree-relative.sh b/t/t2408-worktree-relative.sh
deleted file mode 100755
index a3136db7e28cb20926ff44211e246ce625a6e51a..000000000000000000000000000=
0000000000000
--- a/t/t2408-worktree-relative.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/sh
-
-test_description=3D'test worktrees linked with relative paths'
-
-TEST_PASSES_SANITIZE_LEAK=3Dtrue
-. ./test-lib.sh
-
-test_expect_success 'links worktrees with relative paths' '
-=09test_when_finished rm -rf repo &&
-=09git init repo &&
-=09(
-=09=09cd repo &&
-=09=09test_commit initial &&
-=09=09git worktree add wt1 &&
-=09=09echo "../../../wt1/.git" >expected_gitdir &&
-=09=09cat .git/worktrees/wt1/gitdir >actual_gitdir &&
-=09=09echo "gitdir: ../.git/worktrees/wt1" >expected_git &&
-=09=09cat wt1/.git >actual_git &&
-=09=09test_cmp expected_gitdir actual_gitdir &&
-=09=09test_cmp expected_git actual_git
-=09)
-'
-
-test_expect_success 'move repo without breaking relative internal links' '
-=09test_when_finished rm -rf repo moved &&
-=09git init repo &&
-=09(
-=09=09cd repo &&
-=09=09test_commit initial &&
-=09=09git worktree add wt1 &&
-=09=09cd .. &&
-=09=09mv repo moved &&
-=09=09cd moved/wt1 &&
-=09=09git status >out 2>err &&
-=09=09test_must_be_empty err
-=09)
-'
-
-test_done

--=20
2.47.0


