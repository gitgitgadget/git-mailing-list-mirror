Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B65AC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 01:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiLLBmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 20:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLBmS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 20:42:18 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6762BCA4
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 17:42:15 -0800 (PST)
Date:   Mon, 12 Dec 2022 01:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1670809332; x=1671068532;
        bh=qdglucOxEaXpETM5AzbLoVYQArmhU04XBibLunyFhM0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cbpZeBspJjkfIwMl/M9S8o5/xNKYu08f5ie2wwvsxQd8HMxhk5/DZ0O3o4AGXa4eL
         y5UTcPnosM4nQhHPnSyj/DoOoVWxYz+ottCpisRBKq33HDOD8EsGb3vbFSn72Jal9b
         RUov506MUML6cG6TjK6Y13m0A/4yxiWW4TNnIroEP78rt+W/P9WXnkZa9HVJCF7c/h
         eCWPlLxyPVghsaWU0bdAn9nEz5TsYzUWsl07ysXRXKd4vqABGounzQGMMW+syCTDbE
         bY/wJLYctaA5wzE1JVjGQQVY3KbXnvaep0IXzCJ8lVXnvW6mulg6caEgcfSrEsdE9G
         I5SXp+Bg3gXCQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v4 0/3] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221212014003.20290-1-jacobabel@nullpo.dev>
In-Reply-To: <20221110233137.10414-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working with the worktree based git workflow, I realised that setting
up a new git repository required switching between the traditional and
worktree based workflows. Searching online I found a SO answer [1] which
seemed to support this and which indicated that adding support for this sho=
uld
not be technically difficult.

This patchset has three parts:
  * adding `-B` to the usage docs (noticed during dev and it seemed too sma=
ll
    to justify a separate submission)
  * adding orphan branch functionality (as is present in `git-switch`)
    to `git-worktree-add`
  * adding an advise for using --orphan when `git worktree add` fails due t=
o
    a bad ref.

Changes from v3:
  * Fix mistake in SYNOPSIS and `--help`. Patch for this change can be foun=
d
    in [2], by courtesy of =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.
  * Collapsed sequential if statements into if-else chain & simplified
    conditions as requested in [2].
  * Simplified tests for mutually exclusive options and removed duplicate
    `-B/--detach` test case. Patch for this change can be found in [3],
    by courtesy of =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.
  * Remove references to `git-switch`. Behavior is now explained fully in d=
ocs
    instead. Changes to the docs suggested in [4], by courtesy of Eric Suns=
hine.
  * Updated test case to use `test_path_is_missing` instead of `! test -d` =
[5].
  * Updated signature for `make_worktree_orphan()` and changed
    `const char *orphan_branch` in `struct add_opts` to `int orphan` (boole=
an)
    to simplify the patch and maintain consistency with other flags [6].
  * Added hint to common cases where `--orphan` is desired [7] to address
    concerns brought up in [8][9]. Slight change from `HEAD` to `branch`.
  * Added the new advice to the docs, advice.c/h, and using
    `advise_if_enabled()` as requested in [10].
  * Added tests to verify `--lock` and `--reason` work properly with
    the newly added `--orphan` flag.
  * Added tests to verify that the orphan advise [7] is emitted only at the
    proper times.
  * Added tests to verify the changes [7] do not interfere with existing
    behavior. ex: creating a worktree from a remote branch when HEAD is
    an orphan.

1. https://stackoverflow.com/a/68717229/15064705/
2. https://lore.kernel.org/git/221115.86edu3kfqz.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/221116.86a64rkdcj.gmgdl@evledraar.gmail.com/
4. https://lore.kernel.org/git/CAPig+cQiyd9yGE_XpPZmzLQnNDMypnrEgkV7nqRZZn3=
j6E0APQ@mail.gmail.com/
5. https://lore.kernel.org/git/221115.86iljfkjjo.gmgdl@evledraar.gmail.com/
6. https://lore.kernel.org/git/20221119025701.syuscuoqjuqhqsoz@phi/
7. https://lore.kernel.org/git/20221119034728.m4kxh4tdpof7us7j@phi/
8. https://lore.kernel.org/git/CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=3DtLieCa4=
zf-PGCegw@mail.gmail.com/
9. https://lore.kernel.org/git/221117.86sfihj3mw.gmgdl@evledraar.gmail.com/
10. https://lore.kernel.org/git/221123.86a64ia6bx.gmgdl@evledraar.gmail.com=
/

Jacob Abel (3):
  worktree add: Include -B in usage docs
  worktree add: add --orphan flag
  worktree add: Add hint to use --orphan when bad ref

 Documentation/config/advice.txt |  4 ++
 Documentation/git-worktree.txt  | 17 ++++++-
 advice.c                        |  1 +
 advice.h                        |  1 +
 builtin/worktree.c              | 81 ++++++++++++++++++++++++++---
 t/t2400-worktree-add.sh         | 90 +++++++++++++++++++++++++++++----
 6 files changed, 176 insertions(+), 18 deletions(-)

Range-diff against v3:
1:  f35d78cfb4 =3D 1:  f35d78cfb4 worktree add: Include -B in usage docs
2:  c040c87c6d ! 2:  8b1cdf1322 worktree add: add --orphan flag
    @@ Commit message

         The original reason this feature was implemented was to allow a us=
er
         to initialise a new repository using solely the worktree oriented
    -    workflow. Example usage included below.
    +    workflow.

    -    $ GIT_DIR=3D".git" git init --bare
    -    $ git worktree add --orphan master master/
    +    Current Behavior:
    +
    +    % git init --bare foo.git
    +    Initialized empty Git repository in /path/to/foo.git/
    +    % git -C foo.git worktree add main/
    +    Preparing worktree (new branch 'main')
    +    fatal: not a valid object name: 'HEAD'
    +    %
    +
    +    New Behavior:
    +
    +    % git init --bare foo.git
    +    Initialized empty Git repository in /path/to/foo.git/
    +    % git -C foo.git worktree add --orphan main main/
    +    Preparing worktree (new branch 'main')
    +    %

         Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>

      ## Documentation/git-worktree.txt ##
     @@ Documentation/git-worktree.txt: SYNOPSIS
    - --------
      [verse]
      'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]
    --=09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
    -+=09=09   [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]
    + =09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
    ++'git worktree add' [-f] [--lock [--reason <string>]]
    ++=09=09   --orphan <new-branch> <path>
      'git worktree list' [-v | --porcelain [-z]]
      'git worktree lock' [--reason <string>] <worktree>
      'git worktree move' <worktree> <new-path>
    @@ Documentation/git-worktree.txt: exist, a new branch based on `HEAD` =
is automatic
     +$ git worktree add --orphan <branch> <path>
     +------------
     ++
    -+Create a worktree containing an orphan branch named `<branch>` with a
    -+clean working directory.  See `--orphan` in linkgit:git-switch[1] for
    -+more details.
    ++Create a worktree containing no files, with an empty index, and assoc=
iated
    ++with a new orphan branch named `<branch>`. The first commit made on t=
his new
    ++branch will have no parents and will be the root of a new history dis=
connected
    ++from any other branches.

      list::

    @@ Documentation/git-worktree.txt: This can also be set up as the defau=
lt behaviour
      =09remove.

     +--orphan <new-branch>::
    -+=09With `add`, create a new orphan branch named `<new-branch>` in the=
 new
    -+=09worktree. See `--orphan` in linkgit:git-switch[1] for details.
    ++=09With `add`, make the new worktree and index empty, associating
    ++=09the worktree with a new orphan branch named `<new-branch>`.
     +
      --porcelain::
      =09With `list`, output in an easy-to-parse format for scripts.
    @@ builtin/worktree.c
      #define BUILTIN_WORKTREE_ADD_USAGE \
      =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reaso=
n <string>]]\n" \
     -=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>=
]")
    -+=09   "                 [[-b | -B | --orphan] <new-branch>] <path> [<=
commit-ish>]")
    ++=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>=
]"), \
    ++=09N_("git worktree add [-f] [--lock [--reason <string>]]\n" \
    ++=09   "                 --orphan <new-branch> <path>")
    ++
      #define BUILTIN_WORKTREE_LIST_USAGE \
      =09N_("git worktree list [-v | --porcelain [-z]]")
      #define BUILTIN_WORKTREE_LOCK_USAGE \
    @@ builtin/worktree.c: struct add_opts {
      =09int detach;
      =09int quiet;
      =09int checkout;
    -+=09const char *orphan_branch;
    ++=09int orphan;
      =09const char *keep_locked;
      };

    @@ builtin/worktree.c: static int checkout_worktree(const struct add_op=
ts *opts,
      =09return run_command(&cp);
      }

    -+static int make_worktree_orphan(const struct add_opts *opts,
    ++static int make_worktree_orphan(const char * ref, const struct add_op=
ts *opts,
     +=09=09=09=09struct strvec *child_env)
     +{
     +=09int ret;
    @@ builtin/worktree.c: static int checkout_worktree(const struct add_op=
ts *opts,
     +=09struct child_process cp =3D CHILD_PROCESS_INIT;
     +=09cp.git_cmd =3D 1;
     +
    -+=09validate_new_branchname(opts->orphan_branch, &symref, 0);
    ++=09validate_new_branchname(ref, &symref, 0);
     +=09strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
     +=09if (opts->quiet)
     +=09=09strvec_push(&cp.args, "--quiet");
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
      =09}
      =09commit =3D lookup_commit_reference_by_name(refname);
     -=09if (!commit)
    -+=09if (!commit && !opts->orphan_branch)
    ++=09if (!commit && !opts->orphan) {
      =09=09die(_("invalid reference: %s"), refname);
    ++=09}

      =09name =3D worktree_basename(path, &len);
    + =09strbuf_add(&sb, name, path + len - name);
     @@ builtin/worktree.c: static int add_worktree(const char *path, const=
 char *refname,
      =09strvec_pushf(&child_env, "%s=3D%s", GIT_WORK_TREE_ENVIRONMENT, pat=
h);
      =09cp.git_cmd =3D 1;
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
      =09if (ret)
      =09=09goto done;

    -+=09if (opts->orphan_branch &&
    -+=09    (ret =3D make_worktree_orphan(opts, &child_env)))
    ++=09if (opts->orphan &&
    ++=09    (ret =3D make_worktree_orphan(refname, opts, &child_env)))
     +=09=09goto done;
     +
      =09if (opts->checkout &&
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
      =09 * is_junk is cleared, but do return appropriate code when hook fa=
ils.
      =09 */
     -=09if (!ret && opts->checkout) {
    -+=09if (!ret && opts->checkout && !opts->orphan_branch) {
    ++=09if (!ret && opts->checkout && !opts->orphan) {
      =09=09struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;

      =09=09strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
    +@@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    + =09char *path;
    + =09const char *branch;
    + =09const char *new_branch =3D NULL;
    ++=09const char *orphan_branch =3D NULL;
    + =09const char *opt_track =3D NULL;
    + =09const char *lock_reason =3D NULL;
    + =09int keep_locked =3D 0;
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
      =09=09=09   N_("create a new branch")),
      =09=09OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
      =09=09=09   N_("create or reset a branch")),
    -+=09=09OPT_STRING(0, "orphan", &opts.orphan_branch, N_("branch"),
    ++=09=09OPT_STRING(0, "orphan", &orphan_branch, N_("branch"),
     +=09=09=09   N_("new unparented branch")),
      =09=09OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named =
commit")),
      =09=09OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new wo=
rking tree")),
      =09=09OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree=
 locked")),
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    + =09memset(&opts, 0, sizeof(opts));
    + =09opts.checkout =3D 1;
      =09ac =3D parse_options(ac, av, prefix, options, git_worktree_add_usa=
ge, 0);
    ++=09opts.orphan =3D !!orphan_branch;
      =09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
      =09=09die(_("options '%s', '%s', and '%s' cannot be used together"), =
"-b", "-B", "--detach");
    -+=09if (!!opts.detach + !!new_branch + !!new_branch_force + !!opts.orp=
han_branch > 1)
    ++=09if (!!opts.detach + !!opts.orphan + !!new_branch + !!new_branch_fo=
rce > 1)
     +=09=09die(_("options '%s', '%s', '%s', and '%s' cannot be used togeth=
er"),
     +=09=09    "-b", "-B", "--orphan", "--detach");
    -+=09if (opts.orphan_branch && opt_track)
    ++=09if (opts.orphan && opt_track)
     +=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan", "--=
track");
    -+=09if (opts.orphan_branch && !opts.checkout)
    ++=09if (opts.orphan && !opts.checkout)
     +=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan",
     +=09=09    "--no-checkout");
    ++=09if (opts.orphan && ac =3D=3D 2)
    ++=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan",
    ++=09=09    _("<commit-ish>"));
      =09if (lock_reason && !keep_locked)
      =09=09die(_("the option '%s' requires '%s'"), "--reason", "--lock");
      =09if (lock_reason)
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09}

     -=09if (ac < 2 && !new_branch && !opts.detach) {
    -+=09/*
    -+=09 * As the orphan cannot be created until the contents of branch
    -+=09 * are staged, opts.orphan_branch should be treated as both a bool=
ean
    -+=09 * indicating that `--orphan` was selected and as the name of the =
new
    -+=09 * orphan branch from this point on.
    -+=09 */
    -+=09if (opts.orphan_branch) {
    -+=09=09new_branch =3D opts.orphan_branch;
    -+=09}
    -+
    -+=09if (ac < 2 && !new_branch && !opts.detach && !opts.orphan_branch) =
{
    ++=09if (opts.orphan) {
    ++=09=09new_branch =3D orphan_branch;
    ++=09} else if (ac < 2 && !new_branch && !opts.detach) {
      =09=09const char *s =3D dwim_branch(path, &new_branch);
      =09=09if (s)
      =09=09=09branch =3D s;
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09=09print_preparing_worktree_line(opts.detach, branch, new_branch, =
!!new_branch_force);

     -=09if (new_branch) {
    -+=09if (new_branch && !opts.orphan_branch) {
    ++=09if (opts.orphan) {
    ++=09=09branch =3D new_branch;
    ++=09} else if (!lookup_commit_reference_by_name(branch)) {
    ++=09=09/*
    ++=09=09 * If `branch` does not reference a valid commit, a new
    ++=09=09 * worktree (and/or branch) cannot be created based off of it.
    ++=09=09 */
    ++=09=09die(_("invalid reference: %s"), branch);
    ++=09} else if (new_branch) {
      =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
      =09=09cp.git_cmd =3D 1;
      =09=09strvec_push(&cp.args, "branch");

      ## t/t2400-worktree-add.sh ##
    -@@ t/t2400-worktree-add.sh: test_expect_success '"add" -B/--detach mut=
ually exclusive' '
    - =09test_must_fail git worktree add -B poodle --detach bamboo main
    +@@ t/t2400-worktree-add.sh: test_expect_success '"add" no auto-vivify =
with --detach and <branch> omitted' '
    + =09test_must_fail git -C mish/mash symbolic-ref HEAD
      '

    -+test_expect_success '"add" --orphan/-b mutually exclusive' '
    -+=09test_must_fail git worktree add --orphan poodle -b poodle bamboo
    -+'
    -+
    -+test_expect_success '"add" --orphan/-B mutually exclusive' '
    -+=09test_must_fail git worktree add --orphan poodle -B poodle bamboo
    -+'
    -+
    -+test_expect_success '"add" --orphan/--detach mutually exclusive' '
    -+=09test_must_fail git worktree add --orphan poodle --detach bamboo
    -+'
    -+
    -+test_expect_success '"add" --orphan/--no-checkout mutually exclusive'=
 '
    -+=09test_must_fail git worktree add --orphan poodle --no-checkout bamb=
oo
    -+'
    -+
    -+test_expect_success '"add" -B/--detach mutually exclusive' '
    -+=09test_must_fail git worktree add -B poodle --detach bamboo main
    -+'
    -+
    +-test_expect_success '"add" -b/-B mutually exclusive' '
    +-=09test_must_fail git worktree add -b poodle -B poodle bamboo main
    +-'
    +-
    +-test_expect_success '"add" -b/--detach mutually exclusive' '
    +-=09test_must_fail git worktree add -b poodle --detach bamboo main
    +-'
    ++# Helper function to test mutually exclusive options.
    ++test_wt_add_excl() {
    ++=09local opts=3D"$@" &&
    ++=09test_expect_success "'worktree add' with '$opts' has mutually excl=
usive options" '
    ++=09=09test_must_fail git worktree add $opts
    ++=09'
    ++}
    +
    +-test_expect_success '"add" -B/--detach mutually exclusive' '
    +-=09test_must_fail git worktree add -B poodle --detach bamboo main
    +-'
    ++test_wt_add_excl -b poodle -B poodle bamboo main
    ++test_wt_add_excl -b poodle --orphan poodle bamboo
    ++test_wt_add_excl -b poodle --detach bamboo main
    ++test_wt_add_excl -B poodle --detach bamboo main
    ++test_wt_add_excl -B poodle --detach bamboo main
    ++test_wt_add_excl -B poodle --orphan poodle bamboo
    ++test_wt_add_excl --orphan poodle --detach bamboo
    ++test_wt_add_excl --orphan poodle --no-checkout bamboo
    ++test_wt_add_excl --orphan poodle bamboo main
    +
      test_expect_success '"add -B" fails if the branch is checked out' '
      =09git rev-parse newmain >before &&
    - =09test_must_fail git worktree add -B newmain bamboo main &&
     @@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet' '
      =09test_must_be_empty actual
      '
    @@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet' '
     +=09test_when_finished "git worktree remove -f -f orphandir" &&
     +=09git worktree add -b existingbranch orphandir main &&
     +=09test_must_fail git worktree add --orphan existingbranch orphandir2=
 &&
    -+=09test ! -d orphandir2
    ++=09test_path_is_missing orphandir2
     +'
     +
     +test_expect_success '"add --orphan" with empty repository' '
    @@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet' '
     +=09git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
     +=09test_cmp expected actual
     +'
    ++
    ++test_expect_success '"add" worktree with orphan branch and lock' '
    ++=09git worktree add --lock --orphan orphanbr orphan-with-lock &&
    ++=09test_when_finished "git worktree unlock orphan-with-lock || :" &&
    ++=09test -f .git/worktrees/orphan-with-lock/locked
    ++'
    ++
    ++test_expect_success '"add" worktree with orphan branch, lock, and rea=
son' '
    ++=09lock_reason=3D"why not" &&
    ++=09git worktree add --detach --lock --reason "$lock_reason" orphan-wi=
th-lock-reason main &&
    ++=09test_when_finished "git worktree unlock orphan-with-lock-reason ||=
 :" &&
    ++=09test -f .git/worktrees/orphan-with-lock-reason/locked &&
    ++=09echo "$lock_reason" >expect &&
    ++=09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
    ++'
     +
      test_expect_success 'local clone from linked checkout' '
      =09git clone --local here here-clone &&
      =09( cd here-clone && git fsck )
    +@@ t/t2400-worktree-add.sh: setup_remote_repo () {
    + =09)
    + }
    +
    ++test_expect_success '"add" <path> <remote/branch> w/ no HEAD' '
    ++=09test_when_finished rm -rf repo_upstream repo_local foo &&
    ++=09setup_remote_repo repo_upstream repo_local &&
    ++=09git -C repo_local config --bool core.bare true &&
    ++=09git -C repo_local branch -D main &&
    ++=09git -C repo_local worktree add ./foo repo_upstream/foo
    ++'
    ++
    + test_expect_success '--no-track avoids setting up tracking' '
    + =09test_when_finished rm -rf repo_upstream repo_local foo &&
    + =09setup_remote_repo repo_upstream repo_local &&
-:  ---------- > 3:  74cb091bb3 worktree add: Add hint to use --orphan when=
 bad ref
--
2.37.4


