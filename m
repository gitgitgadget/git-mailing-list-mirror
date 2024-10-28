Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66541E32DC
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142586; cv=none; b=mEdLur6IMXslMP3AEeL6nHtVXE4uC8w13S32xpcEUYxG5aM/qYL/k76lCR33K/TJjrMquYL5T8oS2MESvi0xcK2NS7wS40UafxFTpWOkRGGRm5yaKU+OQzhrWLpU36+d6FLVmRHFmEm/B1fzYWSqDoi7t6zTY2MZ6iFc+sIge/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142586; c=relaxed/simple;
	bh=x5lquUQKna9XXorWiydNkCgMJXafcGe6yfA/JEfSeLw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brjg+sGvuo8bo3vozx1/YysFGuPvDiR+VnNAix+LvmY5s2V5FaRRTWqxuM453p3slpY+XZEeaAafBJcSIyzZBUKhRJrBJxb7I76HAYxljpgZ6uM1YIX267aC0fOheunkLsctzsW8orlGi4AkSKMzfYqTlApFYcVvx1Yw2xD30Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=eAYhmRn5; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="eAYhmRn5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730142581; x=1730401781;
	bh=uX5jOI7q0BNxL4ut/6Ug0DKM0Eq/+S0J/E2Uyd/RZzU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eAYhmRn5kVkwS27NTrCSqUCn9pt9Ime0N82d0BuXVEQSNa2rifTIBU4ux2LVlIhVl
	 VDpOPStDcWoBvWJUsHZN252x3A3vIQyKOzBiZye8Bh0BGwBkzNn2Gk6ZgIagB9Nb+4
	 CikrySXfGit6bbmlYXj51UdCTBXGe77JaSl7/Xvyb8w517uWWY6R222x36RZwPLtD3
	 kdR83Zg4wo79twCGVGCNvnXzTwWW7wFYwSN5xucza2vC0udq6nwLyf2L4pjREsOB5+
	 Q4Nsh+YmX/vVDldlDQHWTSwiXL2K1CjaFL/6Tu8kdaECvhea70GO5G5wUZYD4/sBUW
	 1sA2D5ysingrw==
Date: Mon, 28 Oct 2024 19:09:37 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 1/5] worktree: add CLI/config options for relative path linking
Message-ID: <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me>
In-Reply-To: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 68f1954a783edb6b243ca18b3f2539c396b77539
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
Git still creates absolute paths by default, but these options allow
users to opt-in to relative paths if desired.

Using the `--relative-paths` option with `worktree {move, repair}`
will convert absolute paths to relative ones, while `--no-relative-paths`
does the reverse. For cases where users want consistency in path
handling, the config option `worktree.useRelativePaths` provides
a persistent setting.

In response to reviewer feedback from the initial patch series[1],
this revision includes slight refactoring for improved
maintainability and clarity in the code base.

[1]: https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-622cf18c45=
eb@pm.me

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 Documentation/config/worktree.txt |  5 +++++
 Documentation/git-worktree.txt    | 12 ++++++++++++
 builtin/worktree.c                |  9 +++++++++
 t/t2408-worktree-relative.sh      | 39 -----------------------------------=
----
 worktree.c                        | 17 ++++++++++-------
 worktree.h                        |  2 ++
 6 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/Documentation/config/worktree.txt b/Documentation/config/workt=
ree.txt
index 048e349482df6c892055720eb53cdcd6c327b6ed..44b783c2774dc5ff65e3fa232b0=
c25cd5254876b 100644
--- a/Documentation/config/worktree.txt
+++ b/Documentation/config/worktree.txt
@@ -7,3 +7,8 @@ worktree.guessRemote::
 =09such a branch exists, it is checked out and set as "upstream"
 =09for the new branch.  If no such match can be found, it falls
 =09back to creating a new branch from the current HEAD.
+worktree.useRelativePaths::
+=09If set to `true`, worktrees will be linked to the repository using
+=09relative paths rather than using absolute paths. This is particularly
+=09useful for setups where the repository and worktrees may be moved betwe=
en
+=09different locations or environments.
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 70437c815f13852bd2eb862176b8b933e6de0acf..975dc3c46d480480457ec485798=
8a6b8bc67b647 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -216,6 +216,18 @@ To remove a locked worktree, specify `--force` twice.
 This can also be set up as the default behaviour by using the
 `worktree.guessRemote` config option.
=20
+--[no-]relative-paths::
+=09Worktrees will be linked to the repository using relative paths
+=09rather than using absolute paths. This is particularly useful for setup=
s
+=09where the repository and worktrees may be moved between different
+=09locations or environments.
++
+With `repair`, the linking files will be updated if there's an absolute/re=
lative
+mismatch, even if the links are correct.
++
+This can also be set up as the default behaviour by using the
+`worktree.useRelativePaths` config option.
+
 --[no-]track::
 =09When creating a new branch, if `<commit-ish>` is a branch,
 =09mark it as "upstream" from the new branch.  This is the
diff --git a/builtin/worktree.c b/builtin/worktree.c
index dae63dedf4cac2621f51f95a39aa456b33acd894..c1130be5890c905c0b648782a83=
4eb8dfcd79ba5 100644
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
@@ -796,6 +799,8 @@ static int add(int ac, const char **av, const char *pre=
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
@@ -1189,6 +1194,8 @@ static int move_worktree(int ac, const char **av, con=
st char *prefix)
 =09=09OPT__FORCE(&force,
 =09=09=09 N_("force move even if worktree is dirty or locked"),
 =09=09=09 PARSE_OPT_NOCOMPLETE),
+=09=09OPT_BOOL(0, "relative-paths", &use_relative_paths,
+=09=09=09 N_("use relative paths for worktrees")),
 =09=09OPT_END()
 =09};
 =09struct worktree **worktrees, *wt;
@@ -1382,6 +1389,8 @@ static int repair(int ac, const char **av, const char=
 *prefix)
 =09const char **p;
 =09const char *self[] =3D { ".", NULL };
 =09struct option options[] =3D {
+=09=09OPT_BOOL(0, "relative-paths", &use_relative_paths,
+=09=09=09 N_("use relative paths for worktrees")),
 =09=09OPT_END()
 =09};
 =09int rc =3D 0;
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
diff --git a/worktree.c b/worktree.c
index 77ff484d3ec48c547ee4e3d958dfa28a52c1eaa7..de5c5e53a5f2a758ddf470b5d6a=
9ad6c66247181 100644
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
@@ -725,12 +727,15 @@ static int is_main_worktree_path(const char *path)
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
@@ -741,18 +746,16 @@ static int infer_backlink(const char *gitfile, struct=
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
diff --git a/worktree.h b/worktree.h
index e96118621638667d87c5d7e0452ed10bd1ddf606..37e65d508ed23d3e7a29850bb93=
8285072a3aaa6 100644
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

--=20
2.47.0


