Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F620D50C
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889877; cv=none; b=Qtqi3hkfnR3oCt4YUTgpsH07SpWIiLCxpSStH+kwr5hbo9Ixl/GFwmuremUVl9kWisMDEFL+X+8Kx50zpUIUrhbWBoiUIuQ/RYLxF+Scv8jZH19YcLZz9WMhxpvYenwOKKfm8YEP9hQ40P7ZXE722MZPX2XFn+j0RZzMWnz/MPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889877; c=relaxed/simple;
	bh=dUqsaIulVDMb5l3dLQXq4UF1yoVnuSterUw4AVgnfZs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoh1oLC3ckFRAyeKlr7iHcoF/VXrXVuGB2UT6ZYDQuScgJvZV3uxJDkVdXo467S46ouW/ZpF3VQDx25nHEQrIStV3J/xua1K742b0jEFWXY/xR3pSsz8+FKWO4Ivjby+3DE9U3HJtt020hc2Sivgw1znBvm8rKP5vqM0R6sOu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ry1PDJl6; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ry1PDJl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729889865; x=1730149065;
	bh=fsYVpjzuiHST3qklgDVe5Hb25UCfYKSvs8vKVP8+Q4Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ry1PDJl6jwmHWH1HjOTX4HgqnJP87PRHHUePTCoPz7MQOgZpxZf9nChMpbuQenXwW
	 MP8BH/zU0G+5lRL/MQzxQLZOQsTre5Hqa4/XIlgpKVNUbPKY/rGkbBkIUz7L+ATzgO
	 /vU1en4wWekkDC68CBT6g9xHIOc+ijEbciJsBoUq0EUyX/R/iMoAcpfs7poRXRj34+
	 lYbSuLLzuF/gMPf+NFyPYtQOHasqqczPsm8XSe3ZonFMUMldVfJA/NEw8j5vLnlRcN
	 5PaCCNsY5iFqFgGJZMrOWqQ8+/iFQFC7eBY57SRrAzeN50KbFpMJxOIEN7DUZWe3+F
	 7wrzwdYpyPIOw==
Date: Fri, 25 Oct 2024 20:57:40 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v3 3/5] worktree: optionally link worktrees with relative paths
Message-ID: <20241025-wt_relative_paths-v3-3-8860a5321c01@pm.me>
In-Reply-To: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
References: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 94148703e29743e22460caaa005caeb08feb77ba
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Git stores absolute paths when linking worktrees to the main repository.
However, this can cause problems when moving repositories and worktrees,
or when working in containerized environments where absolute paths
differ between systems. The worktree links break, and users are required
to manually execute `worktree repair` to repair them, leading to workflow
disruptions. Additionally, when repositories are mapped inside containers
with different absolute paths, they may become unusable. Repairing
worktrees in the container can then break them outside the container.

In some cases, relative paths can eliminate the need for `worktree repair`.
If both the repository and worktrees are moved together while preserving
their relative locations, the links remain intact. Common examples include
moving repositories and worktrees or mapping both inside containers that
use different absolute paths.

This patch adds support for optionally _writing_ relative paths to the
linking files. If desired, relative paths can be created through the
`--relative-paths` CLI option for `worktree {add,move,repair}` as well
as the `worktree.useRelativePaths` config option. If an existing
worktree uses absolute paths, executing `worktree {move,repair}` with
the relative option will create relative paths (and visa versa).

A new function, `write_worktree_linking_files()` is introduced to clean
the actual relative path computation in different locations. The
function accepts a strbuf to the worktree `.git` file and a strbuf to
the repository `gitdir` file and then writes the appropriate path to
each as configured by the user.

Additionally, `repair_worktrees_after_gitdir_move()` has been introduced
to address the case where both the `<worktree>/.git` and
`<repo>/worktrees/<id>/gitdir` links are broken after the gitdir is
moved (such as during a re-initialization). This function repairs both
sides of the worktree link using the old gitdir path to reestablish the
correct paths after a move.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 Documentation/config/worktree.txt |   5 ++
 Documentation/git-worktree.txt    |   9 +++
 builtin/worktree.c                |  18 +++---
 setup.c                           |   2 +-
 t/t0001-init.sh                   |  20 +++++--
 t/t2400-worktree-add.sh           |  41 ++++++++++++++
 t/t2402-worktree-list.sh          |  22 ++++++++
 t/t2403-worktree-move.sh          |  22 ++++++++
 t/t2406-worktree-repair.sh        |  26 +++++++++
 worktree.c                        | 116 +++++++++++++++++++++++++++++++---=
----
 worktree.h                        |  24 ++++++++
 11 files changed, 270 insertions(+), 35 deletions(-)

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
index fc31d072a620d7b455d7f150bd3a9e773ee9d4ed..bb06830d6fe82aa97833c6e87f0=
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
@@ -414,7 +417,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09=09=09const struct add_opts *opts)
 {
 =09struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
-=09struct strbuf sb =3D STRBUF_INIT, realpath =3D STRBUF_INIT;
+=09struct strbuf sb =3D STRBUF_INIT;
 =09const char *name;
 =09struct strvec child_env =3D STRVEC_INIT;
 =09unsigned int counter =3D 0;
@@ -490,11 +493,7 @@ static int add_worktree(const char *path, const char *=
refname,
=20
 =09strbuf_reset(&sb);
 =09strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-=09strbuf_realpath(&realpath, sb_git.buf, 1);
-=09write_file(sb.buf, "%s", realpath.buf);
-=09strbuf_realpath(&realpath, repo_get_common_dir(the_repository), 1);
-=09write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
-=09=09   realpath.buf, name);
+=09write_worktree_linking_files(sb_git, sb);
 =09strbuf_reset(&sb);
 =09strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 =09write_file(sb.buf, "../..");
@@ -582,7 +581,6 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09strbuf_release(&sb_repo);
 =09strbuf_release(&sb_git);
 =09strbuf_release(&sb_name);
-=09strbuf_release(&realpath);
 =09free_worktree(wt);
 =09return ret;
 }
@@ -794,6 +792,8 @@ static int add(int ac, const char **av, const char *pre=
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
@@ -1187,6 +1187,8 @@ static int move_worktree(int ac, const char **av, con=
st char *prefix)
 =09=09OPT__FORCE(&force,
 =09=09=09 N_("force move even if worktree is dirty or locked"),
 =09=09=09 PARSE_OPT_NOCOMPLETE),
+=09=09OPT_BOOL(0, "relative-paths", &use_relative_paths,
+=09=09=09 N_("use relative paths for worktrees")),
 =09=09OPT_END()
 =09};
 =09struct worktree **worktrees, *wt;
@@ -1380,6 +1382,8 @@ static int repair(int ac, const char **av, const char=
 *prefix)
 =09const char **p;
 =09const char *self[] =3D { ".", NULL };
 =09struct option options[] =3D {
+=09=09OPT_BOOL(0, "relative-paths", &use_relative_paths,
+=09=09=09 N_("use relative paths for worktrees")),
 =09=09OPT_END()
 =09};
 =09int rc =3D 0;
diff --git a/setup.c b/setup.c
index 94e79b2e487f3faa537547e190acf9b7ea0be3b5..7b648de0279116b381eea46800a=
d130606926103 100644
--- a/setup.c
+++ b/setup.c
@@ -2420,7 +2420,7 @@ static void separate_git_dir(const char *git_dir, con=
st char *git_link)
=20
 =09=09if (rename(src, git_dir))
 =09=09=09die_errno(_("unable to move %s to %s"), src, git_dir);
-=09=09repair_worktrees(NULL, NULL);
+=09=09repair_worktrees_after_gitdir_move(src);
 =09}
=20
 =09write_file(git_link, "gitdir: %s", git_dir);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0178aa62a41f1606f2382a4a10ab593ccf11e0e8..03ac9624cb418d05adb8dfb786c=
31b809c73efec 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -435,19 +435,27 @@ sep_git_dir_worktree ()  {
 =09test_when_finished "rm -rf mainwt linkwt seprepo" &&
 =09git init mainwt &&
 =09test_commit -C mainwt gumby &&
-=09git -C mainwt worktree add --detach ../linkwt &&
-=09git -C "$1" init --separate-git-dir ../seprepo &&
+=09git -C mainwt worktree add $1 --detach ../linkwt &&
+=09git -C "$2" init --separate-git-dir ../seprepo &&
 =09git -C mainwt rev-parse --git-common-dir >expect &&
 =09git -C linkwt rev-parse --git-common-dir >actual &&
 =09test_cmp expect actual
 }
=20
-test_expect_success 're-init to move gitdir with linked worktrees' '
-=09sep_git_dir_worktree mainwt
+test_expect_success 're-init to move gitdir with linked worktrees (absolut=
e)' '
+=09sep_git_dir_worktree --no-relative-paths mainwt
 '
=20
-test_expect_success 're-init to move gitdir within linked worktree' '
-=09sep_git_dir_worktree linkwt
+test_expect_success 're-init to move gitdir within linked worktree (absolu=
te)' '
+=09sep_git_dir_worktree --no-relative-paths linkwt
+'
+
+test_expect_success 're-init to move gitdir with linked worktrees (relativ=
e)' '
+=09sep_git_dir_worktree --relative-paths mainwt
+'
+
+test_expect_success 're-init to move gitdir within linked worktree (relati=
ve)' '
+=09sep_git_dir_worktree --relative-paths linkwt
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
index cf578c447589425d642fc8aa7a7fa07600e60a70..0d1685b892fcddf74a91304424a=
94e5ee847388b 100644
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
@@ -379,18 +381,24 @@ int validate_worktree(const struct worktree *wt, stru=
ct strbuf *errmsg,
 void update_worktree_location(struct worktree *wt, const char *path_)
 {
 =09struct strbuf path =3D STRBUF_INIT;
+=09struct strbuf dotgit =3D STRBUF_INIT;
+=09struct strbuf gitdir =3D STRBUF_INIT;
=20
 =09if (is_main_worktree(wt))
 =09=09BUG("can't relocate main worktree");
=20
+=09strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id)=
, 1);
 =09strbuf_realpath(&path, path_, 1);
+=09strbuf_addf(&dotgit, "%s/.git", path.buf);
 =09if (fspathcmp(wt->path, path.buf)) {
-=09=09write_file(git_common_path("worktrees/%s/gitdir", wt->id),
-=09=09=09   "%s/.git", path.buf);
+=09=09write_worktree_linking_files(dotgit, gitdir);
+
 =09=09free(wt->path);
 =09=09wt->path =3D strbuf_detach(&path, NULL);
 =09}
 =09strbuf_release(&path);
+=09strbuf_release(&dotgit);
+=09strbuf_release(&gitdir);
 }
=20
 int is_worktree_being_rebased(const struct worktree *wt,
@@ -569,6 +577,7 @@ static void repair_gitfile(struct worktree *wt,
 =09=09=09   worktree_repair_fn fn, void *cb_data)
 {
 =09struct strbuf dotgit =3D STRBUF_INIT;
+=09struct strbuf gitdir =3D STRBUF_INIT;
 =09struct strbuf repo =3D STRBUF_INIT;
 =09struct strbuf backlink =3D STRBUF_INIT;
 =09char *dotgit_contents =3D NULL;
@@ -586,6 +595,7 @@ static void repair_gitfile(struct worktree *wt,
=20
 =09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
 =09strbuf_addf(&dotgit, "%s/.git", wt->path);
+=09strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
 =09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, &er=
r));
=20
 =09if (dotgit_contents) {
@@ -603,16 +613,19 @@ static void repair_gitfile(struct worktree *wt,
 =09=09repair =3D _(".git file broken");
 =09else if (fspathcmp(backlink.buf, repo.buf))
 =09=09repair =3D _(".git file incorrect");
+=09else if (use_relative_paths =3D=3D is_absolute_path(dotgit_contents))
+=09=09repair =3D _(".git file absolute/relative path mismatch");
=20
 =09if (repair) {
 =09=09fn(0, wt->path, repair, cb_data);
-=09=09write_file(dotgit.buf, "gitdir: %s", repo.buf);
+=09=09write_worktree_linking_files(dotgit, gitdir);
 =09}
=20
 done:
 =09free(dotgit_contents);
 =09strbuf_release(&repo);
 =09strbuf_release(&dotgit);
+=09strbuf_release(&gitdir);
 =09strbuf_release(&backlink);
 }
=20
@@ -636,6 +649,45 @@ void repair_worktrees(worktree_repair_fn fn, void *cb_=
data)
 =09free_worktrees(worktrees);
 }
=20
+void repair_worktree_after_gitdir_move(struct worktree *wt,
+=09=09=09=09       const char *old_path)
+{
+=09struct strbuf gitdir =3D STRBUF_INIT;
+=09struct strbuf dotgit =3D STRBUF_INIT;
+
+=09if (is_main_worktree(wt))
+=09=09goto done;
+
+=09strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id)=
, 1);
+
+=09if (strbuf_read_file(&dotgit, gitdir.buf, 0) < 0)
+=09=09goto done;
+
+=09strbuf_rtrim(&dotgit);
+=09if (!is_absolute_path(dotgit.buf)) {
+=09=09strbuf_insertf(&dotgit, 0, "%s/worktrees/%s/", old_path, wt->id);
+=09=09strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
+=09}
+
+=09if (!file_exists(dotgit.buf))
+=09=09goto done;
+
+=09write_worktree_linking_files(dotgit, gitdir);
+done:
+=09strbuf_release(&gitdir);
+=09strbuf_release(&dotgit);
+}
+
+void repair_worktrees_after_gitdir_move(const char *old_path)
+{
+=09struct worktree **worktrees =3D get_worktrees_internal(1);
+=09struct worktree **wt =3D worktrees + 1; /* +1 skips main worktree */
+
+=09for (; *wt; wt++)
+=09=09repair_worktree_after_gitdir_move(*wt, old_path);
+=09free_worktrees(worktrees);
+}
+
 static int is_main_worktree_path(const char *path)
 {
 =09struct strbuf target =3D STRBUF_INIT;
@@ -698,12 +750,10 @@ void repair_worktree_at_path(const char *path,
 =09=09=09     worktree_repair_fn fn, void *cb_data)
 {
 =09struct strbuf dotgit =3D STRBUF_INIT;
-=09struct strbuf realdotgit =3D STRBUF_INIT;
 =09struct strbuf backlink =3D STRBUF_INIT;
 =09struct strbuf inferred_backlink =3D STRBUF_INIT;
 =09struct strbuf gitdir =3D STRBUF_INIT;
 =09struct strbuf olddotgit =3D STRBUF_INIT;
-=09struct strbuf realolddotgit =3D STRBUF_INIT;
 =09char *dotgit_contents =3D NULL;
 =09const char *repair =3D NULL;
 =09int err;
@@ -715,25 +765,25 @@ void repair_worktree_at_path(const char *path,
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
@@ -746,11 +796,11 @@ void repair_worktree_at_path(const char *path,
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
@@ -778,30 +828,28 @@ void repair_worktree_at_path(const char *path,
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
-=09=09write_file(gitdir.buf, "%s", realdotgit.buf);
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
 }
=20
@@ -963,3 +1011,29 @@ int init_worktree_config(struct repository *r)
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
index 11279d0c8fe249bb30642563bf221a8de7f3b0a3..5929089891c97318a8f5329f793=
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
@@ -131,6 +133,16 @@ typedef void (* worktree_repair_fn)(int iserr, const c=
har *path,
  */
 void repair_worktrees(worktree_repair_fn, void *cb_data);
=20
+/*
+ * Repair the linked worktrees after the gitdir has been moved.
+ */
+void repair_worktrees_after_gitdir_move(const char *old_path);
+
+/*
+ * Repair the linked worktree after the gitdir has been moved.
+ */
+void repair_worktree_after_gitdir_move(struct worktree *wt, const char *ol=
d_path);
+
 /*
  * Repair administrative files corresponding to the worktree at the given =
path.
  * The worktree's .git file pointing at the repository must be intact for =
the
@@ -205,4 +217,16 @@ void strbuf_worktree_ref(const struct worktree *wt,
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


