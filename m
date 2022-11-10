Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B313C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 23:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiKJXdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 18:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiKJXdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 18:33:25 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A46174E
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 15:33:10 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:32:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1668123188; x=1668382388;
        bh=cis8sBbtTrH/D97KKhNfcvpASidAgGz8U/5r/44cY88=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=XRYwWtEJ2lY/bPFd7bFwdsiOASzk8RkUyDShywnAg6XQ7WEbAkd8JCUGyR9ebvAt5
         kJIFQdSpkG0+8LdUz98OZ7MV7IJy0j+AOKzmDf2o5ubfDKuQiyK+Y0B/heIir069+B
         mABSUuozwqsZhsZuM80dDXg5e9ZBsfyceVVp/sksKP73ckIc6VzMFIpyCiqM6XhcyX
         cFmOb4ZXKk0e3fyBBwQK8cDH8/dj8hwmb9V+Jn4YhfnX6ojY8WNW1f3UtqRSL635fP
         7oUmxbmK7X8tKsP/EfZ9gO4187VsgHkYxyFCgc8hz7995EgUu2DXzqv0TLiKFIlP+J
         QcqxiKHH6xFYw==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 2/2] worktree add: add --orphan flag
Message-ID: <20221110233137.10414-3-jacobabel@nullpo.dev>
In-Reply-To: <20221110233137.10414-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds support for creating an orphan branch when adding a new worktree.
This functionality is equivalent to git switch's --orphan flag.

The original reason this feature was implemented was to allow a user
to initialise a new repository using solely the worktree oriented
workflow. Example usage included below.

$ GIT_DIR=3D".git" git init --bare
$ git worktree add --orphan master master/

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt | 14 +++++++-
 builtin/worktree.c             | 64 ++++++++++++++++++++++++++++++----
 t/t2400-worktree-add.sh        | 45 ++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 4dd658012b..1310bfb564 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>=
]]
-=09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
+=09=09   [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
@@ -95,6 +95,14 @@ exist, a new branch based on `HEAD` is automatically cre=
ated as if
 `-b <branch>` was given.  If `<branch>` does exist, it will be checked out
 in the new worktree, if it's not checked out anywhere else, otherwise the
 command will refuse to create the worktree (unless `--force` is used).
++
+------------
+$ git worktree add --orphan <branch> <path>
+------------
++
+Create a worktree containing an orphan branch named `<branch>` with a
+clean working directory.  See `--orphan` in linkgit:git-switch[1] for
+more details.

 list::

@@ -222,6 +230,10 @@ This can also be set up as the default behaviour by us=
ing the
 =09With `prune`, do not remove anything; just report what it would
 =09remove.

+--orphan <new-branch>::
+=09With `add`, create a new orphan branch named `<new-branch>` in the new
+=09worktree. See `--orphan` in linkgit:git-switch[1] for details.
+
 --porcelain::
 =09With `list`, output in an easy-to-parse format for scripts.
 =09This format will remain stable across Git versions and regardless of us=
er
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fccb17f070..71786b72f6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -17,7 +17,7 @@

 #define BUILTIN_WORKTREE_ADD_USAGE \
 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]\n" \
-=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]")
+=09   "                 [[-b | -B | --orphan] <new-branch>] <path> [<commi=
t-ish>]")
 #define BUILTIN_WORKTREE_LIST_USAGE \
 =09N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
@@ -90,6 +90,7 @@ struct add_opts {
 =09int detach;
 =09int quiet;
 =09int checkout;
+=09const char *orphan_branch;
 =09const char *keep_locked;
 };

@@ -364,6 +365,24 @@ static int checkout_worktree(const struct add_opts *op=
ts,
 =09return run_command(&cp);
 }

+static int make_worktree_orphan(const struct add_opts *opts,
+=09=09=09=09struct strvec *child_env)
+{
+=09int ret;
+=09struct strbuf symref =3D STRBUF_INIT;
+=09struct child_process cp =3D CHILD_PROCESS_INIT;
+=09cp.git_cmd =3D 1;
+
+=09validate_new_branchname(opts->orphan_branch, &symref, 0);
+=09strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
+=09if (opts->quiet)
+=09=09strvec_push(&cp.args, "--quiet");
+=09strvec_pushv(&cp.env, child_env->v);
+=09ret =3D run_command(&cp);
+=09strbuf_release(&symref);
+=09return ret;
+}
+
 static int add_worktree(const char *path, const char *refname,
 =09=09=09const struct add_opts *opts)
 {
@@ -393,7 +412,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09=09=09die_if_checked_out(symref.buf, 0);
 =09}
 =09commit =3D lookup_commit_reference_by_name(refname);
-=09if (!commit)
+=09if (!commit && !opts->orphan_branch)
 =09=09die(_("invalid reference: %s"), refname);

 =09name =3D worktree_basename(path, &len);
@@ -482,10 +501,10 @@ static int add_worktree(const char *path, const char =
*refname,
 =09strvec_pushf(&child_env, "%s=3D%s", GIT_WORK_TREE_ENVIRONMENT, path);
 =09cp.git_cmd =3D 1;

-=09if (!is_branch)
+=09if (!is_branch && commit) {
 =09=09strvec_pushl(&cp.args, "update-ref", "HEAD",
 =09=09=09     oid_to_hex(&commit->object.oid), NULL);
-=09else {
+=09} else {
 =09=09strvec_pushl(&cp.args, "symbolic-ref", "HEAD",
 =09=09=09     symref.buf, NULL);
 =09=09if (opts->quiet)
@@ -497,6 +516,10 @@ static int add_worktree(const char *path, const char *=
refname,
 =09if (ret)
 =09=09goto done;

+=09if (opts->orphan_branch &&
+=09    (ret =3D make_worktree_orphan(opts, &child_env)))
+=09=09goto done;
+
 =09if (opts->checkout &&
 =09    (ret =3D checkout_worktree(opts, &child_env)))
 =09=09goto done;
@@ -516,7 +539,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09 * Hook failure does not warrant worktree deletion, so run hook after
 =09 * is_junk is cleared, but do return appropriate code when hook fails.
 =09 */
-=09if (!ret && opts->checkout) {
+=09if (!ret && opts->checkout && !opts->orphan_branch) {
 =09=09struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;

 =09=09strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
@@ -616,6 +639,8 @@ static int add(int ac, const char **av, const char *pre=
fix)
 =09=09=09   N_("create a new branch")),
 =09=09OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 =09=09=09   N_("create or reset a branch")),
+=09=09OPT_STRING(0, "orphan", &opts.orphan_branch, N_("branch"),
+=09=09=09   N_("new unparented branch")),
 =09=09OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commi=
t")),
 =09=09OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working=
 tree")),
 =09=09OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree lock=
ed")),
@@ -635,6 +660,14 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09ac =3D parse_options(ac, av, prefix, options, git_worktree_add_usage, 0=
);
 =09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 =09=09die(_("options '%s', '%s', and '%s' cannot be used together"), "-b",=
 "-B", "--detach");
+=09if (!!opts.detach + !!new_branch + !!new_branch_force + !!opts.orphan_b=
ranch > 1)
+=09=09die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
+=09=09    "-b", "-B", "--orphan", "--detach");
+=09if (opts.orphan_branch && opt_track)
+=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan", "--track=
");
+=09if (opts.orphan_branch && !opts.checkout)
+=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan",
+=09=09    "--no-checkout");
 =09if (lock_reason && !keep_locked)
 =09=09die(_("the option '%s' requires '%s'"), "--reason", "--lock");
 =09if (lock_reason)
@@ -651,6 +684,13 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09if (!strcmp(branch, "-"))
 =09=09branch =3D "@{-1}";

+=09/*
+=09 * When creating a new branch, new_branch now contains the branch to
+=09 * create.
+=09 *
+=09 * Past this point, new_branch_force can be treated solely as a
+=09 * boolean flag to indicate whether `-B` was selected.
+=09 */
 =09if (new_branch_force) {
 =09=09struct strbuf symref =3D STRBUF_INIT;

@@ -663,7 +703,17 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09=09strbuf_release(&symref);
 =09}

-=09if (ac < 2 && !new_branch && !opts.detach) {
+=09/*
+=09 * As the orphan cannot be created until the contents of branch
+=09 * are staged, opts.orphan_branch should be treated as both a boolean
+=09 * indicating that `--orphan` was selected and as the name of the new
+=09 * orphan branch from this point on.
+=09 */
+=09if (opts.orphan_branch) {
+=09=09new_branch =3D opts.orphan_branch;
+=09}
+
+=09if (ac < 2 && !new_branch && !opts.detach && !opts.orphan_branch) {
 =09=09const char *s =3D dwim_branch(path, &new_branch);
 =09=09if (s)
 =09=09=09branch =3D s;
@@ -686,7 +736,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 =09if (!opts.quiet)
 =09=09print_preparing_worktree_line(opts.detach, branch, new_branch, !!new=
_branch_force);

-=09if (new_branch) {
+=09if (new_branch && !opts.orphan_branch) {
 =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
 =09=09cp.git_cmd =3D 1;
 =09=09strvec_push(&cp.args, "branch");
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..93c340f4af 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -310,6 +310,26 @@ test_expect_success '"add" -B/--detach mutually exclus=
ive' '
 =09test_must_fail git worktree add -B poodle --detach bamboo main
 '

+test_expect_success '"add" --orphan/-b mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle -b poodle bamboo
+'
+
+test_expect_success '"add" --orphan/-B mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle -B poodle bamboo
+'
+
+test_expect_success '"add" --orphan/--detach mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle --detach bamboo
+'
+
+test_expect_success '"add" --orphan/--no-checkout mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle --no-checkout bamboo
+'
+
+test_expect_success '"add" -B/--detach mutually exclusive' '
+=09test_must_fail git worktree add -B poodle --detach bamboo main
+'
+
 test_expect_success '"add -B" fails if the branch is checked out' '
 =09git rev-parse newmain >before &&
 =09test_must_fail git worktree add -B newmain bamboo main &&
@@ -330,6 +350,31 @@ test_expect_success 'add --quiet' '
 =09test_must_be_empty actual
 '

+test_expect_success '"add --orphan"' '
+=09test_when_finished "git worktree remove -f -f orphandir" &&
+=09git worktree add --orphan neworphan orphandir &&
+=09echo refs/heads/neworphan >expected &&
+=09git -C orphandir symbolic-ref HEAD >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success '"add --orphan" fails if the branch already exists' '
+=09test_when_finished "git branch -D existingbranch" &&
+=09test_when_finished "git worktree remove -f -f orphandir" &&
+=09git worktree add -b existingbranch orphandir main &&
+=09test_must_fail git worktree add --orphan existingbranch orphandir2 &&
+=09test ! -d orphandir2
+'
+
+test_expect_success '"add --orphan" with empty repository' '
+=09test_when_finished "rm -rf empty_repo" &&
+=09echo refs/heads/newbranch >expected &&
+=09GIT_DIR=3D"empty_repo" git init --bare &&
+=09git -C empty_repo  worktree add --orphan newbranch worktreedir &&
+=09git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
+=09test_cmp expected actual
+'
+
 test_expect_success 'local clone from linked checkout' '
 =09git clone --local here here-clone &&
 =09( cd here-clone && git fsck )
--
2.37.4


