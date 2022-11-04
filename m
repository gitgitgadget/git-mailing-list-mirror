Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96546C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 21:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKDVe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKDVe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 17:34:57 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE4045A09
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 14:34:54 -0700 (PDT)
Date:   Fri, 04 Nov 2022 21:34:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667597693; x=1667856893;
        bh=y2bHNQ6FDqk7tHOrNv4IsxhZh/4wpHMw8+zxiq5sdqk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ei/lUFs2tRCcQcPOpnaKCn+ZezfbCFJvAU5ITJiAKbB3EamQ5NN1tHyFiMIQ/xOlg
         P6IOC6psNDiQ0SUxHkoq4OzkcMcNkPCikCPmdiSo1bDFBu6BxOhNho/2mShOPq2DOY
         L2goXJlOpnH8bgxj+yEFohxqdvMt+FWm+vURd3zv2dN0jLzW6Cyu1jkGtoNRdZRIR6
         OtA/b2UPH5NN4eVwu5FIA4UAWv0N6KtKUFkerFsPY87/9OmctC84cePo+3lCvBu/S3
         hEOzPv0LSo/BRoMxzD3gIyUEAalfOD22IjU6qkccZwxr65d/FrywR/UHU9Wcvqs9Ta
         hIk1R13Ogz/RA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 2/2] worktree add: add --orphan flag
Message-ID: <20221104213401.17393-3-jacobabel@nullpo.dev>
In-Reply-To: <20221104213401.17393-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds support for creating an orphan branch when adding a new worktree.
This functionality is equivalent to git checkout's --orphan flag.

The original reason this feature was implemented was to allow a user
to initialise a new repository using solely the worktree oriented
workflow. Example usage included below.

$ GIT_DIR=3D".git" git init --bare
$ git worktree add --orphan master master/

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt | 18 +++++++-
 builtin/worktree.c             | 81 ++++++++++++++++++++++++++++------
 t/t2400-worktree-add.sh        | 50 +++++++++++++++++++++
 3 files changed, 135 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 4dd658012b..92bd75564f 100644
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
@@ -95,6 +95,17 @@ exist, a new branch based on `HEAD` is automatically cre=
ated as if
 `-b <branch>` was given.  If `<branch>` does exist, it will be checked out
 in the new worktree, if it's not checked out anywhere else, otherwise the
 command will refuse to create the worktree (unless `--force` is used).
++
+------------
+$ git worktree add --orphan <branch> <path> [<commit-ish>]
+------------
++
+Create a worktree containing an orphan branch named `<branch>` based
+on `<commit-ish>`. If `<commit-ish>` is not specified, the new orphan bran=
ch
+will be created based on `HEAD`.
++
+Note that unlike with `-b` or `-B`, this operation will succeed even if
+`<commit-ish>` is a branch that is currently checked out somewhere else.

 list::

@@ -222,6 +233,11 @@ This can also be set up as the default behaviour by us=
ing the
 =09With `prune`, do not remove anything; just report what it would
 =09remove.

+--orphan <new-branch>::
+=09With `add`, create a new orphan branch named `<new-branch>` in the new
+=09worktree based on `<commit-ish>`. If `<commit-ish>` is omitted, it
+=09defaults to `HEAD`.
+
 --porcelain::
 =09With `list`, output in an easy-to-parse format for scripts.
 =09This format will remain stable across Git versions and regardless of us=
er
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fccb17f070..303a8fb935 100644
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
@@ -90,6 +90,8 @@ struct add_opts {
 =09int detach;
 =09int quiet;
 =09int checkout;
+=09int implicit;
+=09const char *orphan_branch;
 =09const char *keep_locked;
 };

@@ -364,6 +366,24 @@ static int checkout_worktree(const struct add_opts *op=
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
@@ -393,7 +413,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09=09=09die_if_checked_out(symref.buf, 0);
 =09}
 =09commit =3D lookup_commit_reference_by_name(refname);
-=09if (!commit)
+=09if (!commit && !opts->implicit)
 =09=09die(_("invalid reference: %s"), refname);

 =09name =3D worktree_basename(path, &len);
@@ -482,10 +502,10 @@ static int add_worktree(const char *path, const char =
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
@@ -497,9 +517,13 @@ static int add_worktree(const char *path, const char *=
refname,
 =09if (ret)
 =09=09goto done;

-=09if (opts->checkout &&
-=09    (ret =3D checkout_worktree(opts, &child_env)))
-=09=09goto done;
+=09if (opts->checkout) {
+=09=09ret =3D checkout_worktree(opts, &child_env);
+=09=09if (opts->orphan_branch && !ret)
+=09=09=09ret =3D make_worktree_orphan(opts, &child_env);
+=09=09if (ret)
+=09=09=09goto done;
+=09}

 =09is_junk =3D 0;
 =09FREE_AND_NULL(junk_work_tree);
@@ -516,7 +540,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09 * Hook failure does not warrant worktree deletion, so run hook after
 =09 * is_junk is cleared, but do return appropriate code when hook fails.
 =09 */
-=09if (!ret && opts->checkout) {
+=09if (!ret && opts->checkout && !opts->orphan_branch) {
 =09=09struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;

 =09=09strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
@@ -616,6 +640,8 @@ static int add(int ac, const char **av, const char *pre=
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
@@ -633,8 +659,16 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09memset(&opts, 0, sizeof(opts));
 =09opts.checkout =3D 1;
 =09ac =3D parse_options(ac, av, prefix, options, git_worktree_add_usage, 0=
);
-=09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
-=09=09die(_("options '%s', '%s', and '%s' cannot be used together"), "-b",=
 "-B", "--detach");
+=09opts.implicit =3D ac < 2;
+
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
@@ -646,11 +680,18 @@ static int add(int ac, const char **av, const char *p=
refix)
 =09=09usage_with_options(git_worktree_add_usage, options);

 =09path =3D prefix_filename(prefix, av[0]);
-=09branch =3D ac < 2 ? "HEAD" : av[1];
+=09branch =3D opts.implicit ? "HEAD" : av[1];

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

@@ -663,7 +704,21 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09=09strbuf_release(&symref);
 =09}

-=09if (ac < 2 && !new_branch && !opts.detach) {
+=09/*
+=09 * As the orphan cannot be created until the contents of branch
+=09 * are staged, opts.orphan_branch should be treated as both a boolean
+=09 * indicating that `--orphan` was selected and as the name of the new
+=09 * orphan branch from this point on.
+=09 *
+=09 * When creating a new orphan, force checkout regardless of whether
+=09 * the existing branch is already checked out.
+=09 */
+=09if (opts.orphan_branch) {
+=09=09new_branch =3D opts.orphan_branch;
+=09=09opts.force =3D 1;
+=09}
+
+=09if (ac < 2 && !new_branch && !opts.detach && !opts.orphan_branch) {
 =09=09const char *s =3D dwim_branch(path, &new_branch);
 =09=09if (s)
 =09=09=09branch =3D s;
@@ -686,7 +741,7 @@ static int add(int ac, const char **av, const char *pre=
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
index d587e0b20d..72930432f9 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -310,6 +310,26 @@ test_expect_success '"add" -B/--detach mutually exclus=
ive' '
 =09test_must_fail git worktree add -B poodle --detach bamboo main
 '

+test_expect_success '"add" --orphan/-b mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle -b poodle bamboo main
+'
+
+test_expect_success '"add" --orphan/-B mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle -B poodle bamboo main
+'
+
+test_expect_success '"add" --orphan/--detach mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle --detach bamboo main
+'
+
+test_expect_success '"add" --orphan/--no-checkout mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle --no-checkout bamboo ma=
in
+'
+
+test_expect_success '"add" -B/--detach mutually exclusive' '
+=09test_must_fail git worktree add -B poodle --detach bamboo main
+'
+
 test_expect_success '"add -B" fails if the branch is checked out' '
 =09git rev-parse newmain >before &&
 =09test_must_fail git worktree add -B newmain bamboo main &&
@@ -330,6 +350,36 @@ test_expect_success 'add --quiet' '
 =09test_must_be_empty actual
 '

+test_expect_success '"add --orphan"' '
+=09test_when_finished "git worktree remove -f -f orphandir" &&
+=09git worktree add --orphan neworphan orphandir main &&
+=09echo refs/heads/neworphan >expected &&
+=09git -C orphandir symbolic-ref HEAD >actual &&
+=09test_cmp expected actual &&
+=09git -C orphandir diff main
+'
+
+test_expect_success '"add --orphan" fails if the branch already exists' '
+=09test_when_finished "git worktree remove -f -f orphandir" &&
+=09git worktree add -b existingbranch orphandir main &&
+=09test_must_fail git worktree add --orphan existingbranch orphandir2 main=
 &&
+=09test ! -d orphandir2
+'
+
+test_expect_success '"add --orphan" fails if the commit-ish doesnt exist' =
'
+=09test_must_fail git worktree add --orphan badcommitish orphandir eee2222=
 &&
+=09test ! -d orphandir
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


