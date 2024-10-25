Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B80157E99
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895390; cv=none; b=RfgnZptUcYXQbPl4wTFbdTbkI5jcTzxLFb+ijuCZcwBoopF8AHcfkAZH2Kh7wjXKfA6H7DCfI8ss0paYj6lkoHQRtxFpIzFdgPma/gszcl+R0Moem4lBmf2BIKsym7YrddDcm4xqeRy7yRgcCSIXU/Ybh0Ycbh3czliD2Dte3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895390; c=relaxed/simple;
	bh=3Ef4J9u+u6kRCGPAbVXwAfkdXa7AMbKPGgOOIuxg4go=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQXy2QYAsngCwM2zq/I6gGcHXZ9HzaUnAG2gDEbYuc926Xp3CmobvzX5JrE3SlcSVrcgZeHt47dkIhXpqVvwR2KQMVAqwKy6jy1RmDILR+Qg+iuMVH7BEEQTYg8AnYrExfHb9JAhl2ifaVkUUVgbB/G5eVzAjQFkii58F+FRNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aONU4uRl; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aONU4uRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729895383; x=1730154583;
	bh=pMxH2sr0eiDzN0zjD2EMbN0tztwZmuAz0WM5V/Rmiic=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aONU4uRl+n+SdYri+4FpGvrdQ3cDG5cVlB5jrDBdP1QOtCHH6IWxbH3V8cnhoMGsg
	 Powr3Hd4PFCLYJ+tQaXQiWd9ERVtEtT7OCE+GhqAtJ4q+n+0rSyqaGu7L5amvg5Iae
	 w3x/YcLUZ0wN9y57py0y27U0T9N+6gtt0/iY1cztYjZfHzwrA7tu/YiSF4Sb5UAhqE
	 mdhqS/2ipov12m+i2gDYR1Bivg5EAguPP11JAWXeVy06ax+PBqolB3lEg3cJxiV3Hm
	 /zZXz61SRPecxOCr4UReKgUpRw/2kq92bsNOQyhFqrjcHHqsYuTMlErNE3j7qEswY3
	 l+g/LYdMZujrQ==
Date: Fri, 25 Oct 2024 22:29:37 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH 1/2] worktree: add CLI/config options for relative path linking
Message-ID: <20241025-wt_relative_options-v1-1-c3005df76bf9@pm.me>
In-Reply-To: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: d29956ed19babb48053a5db26c85169e9896b669
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch introduces the `--[no-]relative-paths` CLI option for
`git worktree {add, move, repair}` commands, as well as the
`worktree.useRelativePaths` configuration setting. When enabled,
these options allow worktrees to be linked using relative paths,
enhancing portability across environments where absolute paths
may differ (e.g., containerized setups, shared network drives).

Using the `--relative-paths` option with `worktree {move, repair}`
will convert absolute paths to relative ones, while `--no-relative-paths`
does the reverse. For cases where users want consistency in path
handling, the config option `worktree.useRelativePaths` provides
a persistent setting.

A new helper function, `write_worktree_linking_files()`, centralizes
the logic for computing and writing either relative or absolute
paths, based on the provided configuration. This function accepts
`strbuf` pointers to both the worktree=E2=80=99s `.git` link and the
repository=E2=80=99s `gitdir`, and then writes the appropriate path to each=
.

In response to reviewer feedback from the initial patch series[1],
this revision includes slight refactoring for improved
maintainability and clarity in the code base.

[1]: https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-622cf18c45=
eb@pm.me

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 Documentation/config/worktree.txt |   5 ++
 Documentation/git-worktree.txt    |   9 +++
 builtin/worktree.c                |  20 +++---
 t/t0001-init.sh                   |  17 +++--
 t/t2400-worktree-add.sh           |  41 ++++++++++++
 t/t2401-worktree-prune.sh         |   3 +-
 t/t2402-worktree-list.sh          |  22 +++++++
 t/t2403-worktree-move.sh          |  22 +++++++
 t/t2406-worktree-repair.sh        |  26 ++++++++
 worktree.c                        | 135 ++++++++++++++++++++--------------=
----
 worktree.h                        |  14 ++++
 11 files changed, 235 insertions(+), 79 deletions(-)

diff --git a/Documentation/config/worktree.txt b/Documentation/config/workt=
ree.txt
index 048e349482df6c892055720eb53cdcd6c327b6ed..d0589c21d034f07f70ca1729475=
20d7d78720cca 100644
--- a/Documentation/config/worktree.txt
+++ b/Documentation/config/worktree.txt
@@ -7,3 +7,8 @@ worktree.guessRemote::
 =09such a branch exists, it is checked out and set as "upstream"
 =09for the new branch.  If no such match can be found, it falls
 =09back to creating a new branch from the current HEAD.
+worktree.useRelativePaths::
+=09If set to `true`, the worktree paths will be stored relative to the
+=09repository=E2=80=99s top-level directory, rather than using absolute pa=
ths.
+=09This is particularly useful for setups where the repository may be move=
d
+=09between different locations or environments.
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 70437c815f13852bd2eb862176b8b933e6de0acf..4a6ad481ee1d44b43683bd67881=
a2771e2b090c7 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -216,6 +216,15 @@ To remove a locked worktree, specify `--force` twice.
 This can also be set up as the default behaviour by using the
 `worktree.guessRemote` config option.
=20
+--[no-]relative-paths::
+=09The worktree paths will be stored relative to the repository=E2=80=
=99s
+=09top-level directory, rather than using absolute paths.
+=09This is particularly useful for setups where the repository may be move=
d
+=09between different locations or environments.
++
+This can also be set up as the default behaviour by using the
+`worktree.useRelativePaths` config option.
+
 --[no-]track::
 =09When creating a new branch, if `<commit-ish>` is a branch,
 =09mark it as "upstream" from the new branch.  This is the
diff --git a/builtin/worktree.c b/builtin/worktree.c
index dae63dedf4cac2621f51f95a39aa456b33acd894..bb06830d6fe82aa97833c6e87f0=
34115dfaa23bd 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -134,6 +134,9 @@ static int git_worktree_config(const char *var, const c=
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
@@ -414,8 +417,7 @@ static int add_worktree(const char *path, const char *r=
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
@@ -491,10 +493,7 @@ static int add_worktree(const char *path, const char *=
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
+=09write_worktree_linking_files(sb_git, sb);
 =09strbuf_reset(&sb);
 =09strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 =09write_file(sb.buf, "../..");
@@ -578,12 +577,9 @@ static int add_worktree(const char *path, const char *=
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
@@ -796,6 +792,8 @@ static int add(int ac, const char **av, const char *pre=
fix)
 =09=09=09     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
 =09=09OPT_BOOL(0, "guess-remote", &guess_remote,
 =09=09=09 N_("try to match the new branch name with a remote-tracking bran=
ch")),
+=09=09OPT_BOOL(0, "relative-paths", &use_relative_paths,
+=09=09=09 N_("use relative paths for worktrees")),
 =09=09OPT_END()
 =09};
 =09int ret;
@@ -1189,6 +1187,8 @@ static int move_worktree(int ac, const char **av, con=
st char *prefix)
 =09=09OPT__FORCE(&force,
 =09=09=09 N_("force move even if worktree is dirty or locked"),
 =09=09=09 PARSE_OPT_NOCOMPLETE),
+=09=09OPT_BOOL(0, "relative-paths", &use_relative_paths,
+=09=09=09 N_("use relative paths for worktrees")),
 =09=09OPT_END()
 =09};
 =09struct worktree **worktrees, *wt;
@@ -1382,6 +1382,8 @@ static int repair(int ac, const char **av, const char=
 *prefix)
 =09const char **p;
 =09const char *self[] =3D { ".", NULL };
 =09struct option options[] =3D {
+=09=09OPT_BOOL(0, "relative-paths", &use_relative_paths,
+=09=09=09 N_("use relative paths for worktrees")),
 =09=09OPT_END()
 =09};
 =09int rc =3D 0;
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0178aa62a41f1606f2382a4a10ab593ccf11e0e8..e21b9aa5e7f4599af8b20165b50=
896c9a49ba7ea 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -435,6 +435,7 @@ sep_git_dir_worktree ()  {
 =09test_when_finished "rm -rf mainwt linkwt seprepo" &&
 =09git init mainwt &&
 =09test_commit -C mainwt gumby &&
+=09git -C mainwt config worktree.useRelativePaths "$([ "$2" =3D "relative"=
 ] && echo true || echo false)" &&
 =09git -C mainwt worktree add --detach ../linkwt &&
 =09git -C "$1" init --separate-git-dir ../seprepo &&
 =09git -C mainwt rev-parse --git-common-dir >expect &&
@@ -442,12 +443,20 @@ sep_git_dir_worktree ()  {
 =09test_cmp expect actual
 }
=20
-test_expect_success 're-init to move gitdir with linked worktrees' '
-=09sep_git_dir_worktree mainwt
+test_expect_success 're-init to move gitdir with linked worktrees (absolut=
e)' '
+=09sep_git_dir_worktree mainwt absolute
 '
=20
-test_expect_success 're-init to move gitdir within linked worktree' '
-=09sep_git_dir_worktree linkwt
+test_expect_success 're-init to move gitdir within linked worktree (absolu=
te)' '
+=09sep_git_dir_worktree linkwt absolute
+'
+
+test_expect_success 're-init to move gitdir with linked worktrees (relativ=
e)' '
+=09sep_git_dir_worktree mainwt relative
+'
+
+test_expect_success 're-init to move gitdir within linked worktree (relati=
ve)' '
+=09sep_git_dir_worktree linkwt relative
 '
=20
 test_expect_success MINGW '.git hidden' '
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index cfc4aeb1798c6d023909cec771e5b74e983af5ea..630c13230b3cc762ce8d943e22b=
e8891aa2b1871 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1207,4 +1207,45 @@ test_expect_success '"add" with initialized submodul=
e, with submodule.recurse se
 =09git -C project-clone -c submodule.recurse worktree add ../project-5
 '
=20
+test_expect_success 'can create worktrees with relative paths' '
+=09test_when_finished "git worktree remove relative" &&
+=09git config worktree.useRelativePaths false &&
+=09git worktree add --relative-paths ./relative &&
+=09cat relative/.git >actual &&
+=09echo "gitdir: ../.git/worktrees/relative" >expect &&
+=09test_cmp expect actual &&
+=09cat .git/worktrees/relative/gitdir >actual &&
+=09echo "../../../relative/.git" >expect &&
+=09test_cmp expect actual
+
+'
+
+test_expect_success 'can create worktrees with absolute paths' '
+=09git config worktree.useRelativePaths true &&
+=09git worktree add ./relative &&
+=09cat relative/.git >actual &&
+=09echo "gitdir: ../.git/worktrees/relative" >expect &&
+=09test_cmp expect actual &&
+=09git worktree add --no-relative-paths ./absolute &&
+=09cat absolute/.git >actual &&
+=09echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'move repo without breaking relative internal links' '
+=09test_when_finished rm -rf repo moved &&
+=09git init repo &&
+=09(
+=09=09cd repo &&
+=09=09git config worktree.useRelativePaths true &&
+=09=09test_commit initial &&
+=09=09git worktree add wt1 &&
+=09=09cd .. &&
+=09=09mv repo moved &&
+=09=09cd moved/wt1 &&
+=09=09git status >out 2>err &&
+=09=09test_must_be_empty err
+=09)
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
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 7686e60f6ad186519b275f11a5e14064c905b207..84451e903b2ef3c645c0311faf0=
55c846588baf6 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -216,4 +216,30 @@ test_expect_success 'repair copied main and linked wor=
ktrees' '
 =09test_cmp dup/linked.expect dup/linked/.git
 '
=20
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
index 77ff484d3ec48c547ee4e3d958dfa28a52c1eaa7..f4cee73d7a1edecafdff30b6d5e=
2d9dd1365b93e 100644
--- a/worktree.c
+++ b/worktree.c
@@ -14,6 +14,8 @@
 #include "wt-status.h"
 #include "config.h"
=20
+int use_relative_paths =3D 0;
+
 void free_worktree(struct worktree *worktree)
 {
 =09if (!worktree)
@@ -111,9 +113,9 @@ struct worktree *get_linked_worktree(const char *id,
 =09strbuf_strip_suffix(&worktree_path, "/.git");
=20
 =09if (!is_absolute_path(worktree_path.buf)) {
-=09    strbuf_strip_suffix(&path, "gitdir");
-=09    strbuf_addbuf(&path, &worktree_path);
-=09    strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
+=09=09strbuf_strip_suffix(&path, "gitdir");
+=09=09strbuf_addbuf(&path, &worktree_path);
+=09=09strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
 =09}
=20
 =09CALLOC_ARRAY(worktree, 1);
@@ -379,29 +381,24 @@ int validate_worktree(const struct worktree *wt, stru=
ct strbuf *errmsg,
 void update_worktree_location(struct worktree *wt, const char *path_)
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
+=09=09write_worktree_linking_files(dotgit, gitdir);
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
@@ -580,9 +577,9 @@ static void repair_gitfile(struct worktree *wt,
 =09=09=09   worktree_repair_fn fn, void *cb_data)
 {
 =09struct strbuf dotgit =3D STRBUF_INIT;
+=09struct strbuf gitdir =3D STRBUF_INIT;
 =09struct strbuf repo =3D STRBUF_INIT;
 =09struct strbuf backlink =3D STRBUF_INIT;
-=09struct strbuf tmp =3D STRBUF_INIT;
 =09char *dotgit_contents =3D NULL;
 =09const char *repair =3D NULL;
 =09int err;
@@ -598,6 +595,7 @@ static void repair_gitfile(struct worktree *wt,
=20
 =09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
 =09strbuf_addf(&dotgit, "%s/.git", wt->path);
+=09strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
 =09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, &er=
r));
=20
 =09if (dotgit_contents) {
@@ -615,18 +613,20 @@ static void repair_gitfile(struct worktree *wt,
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
+=09=09write_worktree_linking_files(dotgit, gitdir);
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
@@ -651,45 +651,30 @@ void repair_worktrees(worktree_repair_fn fn, void *cb=
_data)
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
+=09if (!is_absolute_path(dotgit.buf)) {
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
+=09write_worktree_linking_files(dotgit, gitdir);
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
@@ -725,12 +710,15 @@ static int is_main_worktree_path(const char *path)
  * won't know which <repo>/worktrees/<id>/gitdir to repair. However, we ma=
y
  * be able to infer the gitdir by manually reading /path/to/worktree/.git,
  * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
+ *
+ * Returns -1 on failure and strbuf.len on success.
  */
 static int infer_backlink(const char *gitfile, struct strbuf *inferred)
 {
 =09struct strbuf actual =3D STRBUF_INIT;
 =09const char *id;
=20
+=09strbuf_reset(inferred);
 =09if (strbuf_read_file(&actual, gitfile, 0) < 0)
 =09=09goto error;
 =09if (!starts_with(actual.buf, "gitdir:"))
@@ -741,18 +729,16 @@ static int infer_backlink(const char *gitfile, struct=
 strbuf *inferred)
 =09id++; /* advance past '/' to point at <id> */
 =09if (!*id)
 =09=09goto error;
-=09strbuf_reset(inferred);
 =09strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
 =09if (!is_directory(inferred->buf))
 =09=09goto error;
=20
 =09strbuf_release(&actual);
-=09return 1;
-
+=09return inferred->len;
 error:
 =09strbuf_release(&actual);
 =09strbuf_reset(inferred); /* clear invalid path */
-=09return 0;
+=09return -1;
 }
=20
 /*
@@ -763,13 +749,10 @@ void repair_worktree_at_path(const char *path,
 =09=09=09     worktree_repair_fn fn, void *cb_data)
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
@@ -781,25 +764,25 @@ void repair_worktree_at_path(const char *path,
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
@@ -812,11 +795,11 @@ void repair_worktree_at_path(const char *path,
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
@@ -838,39 +821,35 @@ void repair_worktree_at_path(const char *path,
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
+=09=09write_worktree_linking_files(dotgit, gitdir);
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
@@ -1031,3 +1010,29 @@ int init_worktree_config(struct repository *r)
 =09free(main_worktree_file);
 =09return res;
 }
+
+void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitd=
ir)
+{
+=09struct strbuf path =3D STRBUF_INIT;
+=09struct strbuf repo =3D STRBUF_INIT;
+=09struct strbuf tmp =3D STRBUF_INIT;
+
+=09strbuf_addbuf(&path, &dotgit);
+=09strbuf_strip_suffix(&path, "/.git");
+=09strbuf_realpath(&path, path.buf, 1);
+=09strbuf_addbuf(&repo, &gitdir);
+=09strbuf_strip_suffix(&repo, "/gitdir");
+=09strbuf_realpath(&repo, repo.buf, 1);
+
+=09if (use_relative_paths) {
+=09=09write_file(gitdir.buf, "%s/.git", relative_path(path.buf, repo.buf, =
&tmp));
+=09=09write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.bu=
f, &tmp));
+=09} else {
+=09=09write_file(gitdir.buf, "%s/.git", path.buf);
+=09=09write_file(dotgit.buf, "gitdir: %s", repo.buf);
+=09}
+
+=09strbuf_release(&path);
+=09strbuf_release(&repo);
+=09strbuf_release(&tmp);
+}
diff --git a/worktree.h b/worktree.h
index e96118621638667d87c5d7e0452ed10bd1ddf606..5929089891c97318a8f5329f793=
8264c717050d5 100644
--- a/worktree.h
+++ b/worktree.h
@@ -5,6 +5,8 @@
=20
 struct strbuf;
=20
+extern int use_relative_paths;
+
 struct worktree {
 =09/* The repository this worktree belongs to. */
 =09struct repository *repo;
@@ -215,4 +217,16 @@ void strbuf_worktree_ref(const struct worktree *wt,
  */
 int init_worktree_config(struct repository *r);
=20
+/**
+ * Write the .git file and gitdir file that links the worktree to the repo=
sitory.
+ *
+ * The `dotgit` parameter is the path to the worktree's .git file, and `gi=
tdir`
+ * is the path to the repository's `gitdir` file.
+ *
+ * Example
+ *  dotgit: "/path/to/foo/.git"
+ *  gitdir: "/path/to/repo/worktrees/foo/gitdir"
+ */
+void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitd=
ir);
+
 #endif

--=20
2.47.0


