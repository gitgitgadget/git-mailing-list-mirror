Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8677CC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKDVe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKDVeY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 17:34:24 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F46649B65
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 14:34:20 -0700 (PDT)
Date:   Fri, 04 Nov 2022 21:34:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667597657; x=1667856857;
        bh=NVpa312Z8FH3RdFB7wX8uuJLPI7HJiUqiaAqZ956FU4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Z/TAHKACL5hWafR/ccbevTuimIGH/5yzs8lnyhyULi4JFgrb2pzIsfHlcOxejJHhE
         1Sijg0B7Qk3fLMjqkTEQr7xTk9biuyD1Og396XsuowX117co5A1o2VKglPf4hxPrvZ
         gg/yMkq1Qe3F9k8to3Tsf3ArBjENg5POskCjj7EjSyEqZhTGTjyzyflQQd/oHVJkhI
         ItV0vuaUYqnMb0WviiZsDtqm881ijeymMGfSVSfPSPx0TILe7ZTtQFOAMkV2KBXEzW
         V/cJfacR0DWfsNORojEQ+HBtlPR3tmBJQED29TwQNeMb+p+N9ir9GAB9JxsvL14tzj
         uRjeVdNJAWV9A==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 0/2] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221104213401.17393-1-jacobabel@nullpo.dev>
In-Reply-To: <20221104010242.11555-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
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

This patchset has two parts:

  * adding `-B` to the usage docs (noticed during dev and it seemed too sma=
ll
    to justify a separate submission)
  * adding orphan branch functionality (as is present in `git-checkout`)
    to `git-worktree-add`

Changes from v1:

  * Reverted change to `checkout_worktree()` [2]. Instead we now change the
    HEAD after `git reset --hard` with a call to `git symbolic-ref`.
  * Removed noise-changes and weird formatting from the patchset.
  * Updated tests and squashed them into the main `--orphan` patch as
    requested [3].
  * Improved test cleanup.
  * Clarify comments regarding `new_branch_force` and `opts.orphan_branch` =
[4].

1. https://stackoverflow.com/a/68717229/15064705
2. https://lore.kernel.org/git/20221104010242.11555-3-jacobabel@nullpo.dev/
3. https://lore.kernel.org/git/221104.86k04bzeaa.gmgdl@evledraar.gmail.com/
4. https://lore.kernel.org/git/20221104164147.izizapz5mdwwalxu@phi/

Jacob Abel (2):
  worktree add: Include -B in usage docs
  worktree add: add --orphan flag

 Documentation/git-worktree.txt | 18 +++++++-
 builtin/worktree.c             | 81 ++++++++++++++++++++++++++++------
 t/t2400-worktree-add.sh        | 50 +++++++++++++++++++++
 3 files changed, 135 insertions(+), 14 deletions(-)

Range-diff against v1:
1:  d74a58b3bb ! 1:  f35d78cfb4 worktree add: Include -B in usage docs
    @@ Documentation/git-worktree.txt: SYNOPSIS

      ## builtin/worktree.c ##
     @@
    - #include "worktree.h"
    - #include "quote.h"

    --#define BUILTIN_WORKTREE_ADD_USAGE \
    -+#define BUILTIN_WORKTREE_ADD_USAGE                                   =
                     \
    + #define BUILTIN_WORKTREE_ADD_USAGE \
      =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reaso=
n <string>]]\n" \
     -=09   "                 [-b <new-branch>] <path> [<commit-ish>]")
     +=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>=
]")
2:  4e56a9494e < -:  ---------- builtin/worktree.c: Update checkout_worktre=
e() to use git-worktree
3:  b8b4098ff5 ! 2:  653be67e8a worktree add: add --orphan flag
    @@ Documentation/git-worktree.txt: This can also be set up as the defau=
lt behaviour
      ## builtin/worktree.c ##
     @@

    - #define BUILTIN_WORKTREE_ADD_USAGE                                   =
                     \
    + #define BUILTIN_WORKTREE_ADD_USAGE \
      =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reaso=
n <string>]]\n" \
     -=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>=
]")
     +=09   "                 [[-b | -B | --orphan] <new-branch>] <path> [<=
commit-ish>]")
    @@ builtin/worktree.c: struct add_opts {
      };

     @@ builtin/worktree.c: static int checkout_worktree(const struct add_o=
pts *opts,
    - =09strvec_pushl(&cp.args, "checkout", "--no-recurse-submodules", NULL=
);
    - =09if (opts->quiet)
    - =09=09strvec_push(&cp.args, "--quiet");
    -+=09if (opts->orphan_branch)
    -+=09=09strvec_pushl(&cp.args, "--orphan", opts->orphan_branch, NULL);
    - =09strvec_pushv(&cp.env, child_env->v);
      =09return run_command(&cp);
      }
    +
    ++static int make_worktree_orphan(const struct add_opts *opts,
    ++=09=09=09=09struct strvec *child_env)
    ++{
    ++=09int ret;
    ++=09struct strbuf symref =3D STRBUF_INIT;
    ++=09struct child_process cp =3D CHILD_PROCESS_INIT;
    ++=09cp.git_cmd =3D 1;
    ++
    ++=09validate_new_branchname(opts->orphan_branch, &symref, 0);
    ++=09strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
    ++=09if (opts->quiet)
    ++=09=09strvec_push(&cp.args, "--quiet");
    ++=09strvec_pushv(&cp.env, child_env->v);
    ++=09ret =3D run_command(&cp);
    ++=09strbuf_release(&symref);
    ++=09return ret;
    ++}
    ++
    + static int add_worktree(const char *path, const char *refname,
    + =09=09=09const struct add_opts *opts)
    + {
     @@ builtin/worktree.c: static int add_worktree(const char *path, const=
 char *refname,
      =09=09=09die_if_checked_out(symref.buf, 0);
      =09}
      =09commit =3D lookup_commit_reference_by_name(refname);
     -=09if (!commit)
    -+
     +=09if (!commit && !opts->implicit)
      =09=09die(_("invalid reference: %s"), refname);

    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
      =09=09strvec_pushl(&cp.args, "symbolic-ref", "HEAD",
      =09=09=09     symref.buf, NULL);
      =09=09if (opts->quiet)
    +@@ builtin/worktree.c: static int add_worktree(const char *path, const=
 char *refname,
    + =09if (ret)
    + =09=09goto done;
    +
    +-=09if (opts->checkout &&
    +-=09    (ret =3D checkout_worktree(opts, &child_env)))
    +-=09=09goto done;
    ++=09if (opts->checkout) {
    ++=09=09ret =3D checkout_worktree(opts, &child_env);
    ++=09=09if (opts->orphan_branch && !ret)
    ++=09=09=09ret =3D make_worktree_orphan(opts, &child_env);
    ++=09=09if (ret)
    ++=09=09=09goto done;
    ++=09}
    +
    + =09is_junk =3D 0;
    + =09FREE_AND_NULL(junk_work_tree);
     @@ builtin/worktree.c: static int add_worktree(const char *path, const=
 char *refname,
      =09 * Hook failure does not warrant worktree deletion, so run hook af=
ter
      =09 * is_junk is cleared, but do return appropriate code when hook fa=
ils.
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam

      =09=09strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    - =09const char *opt_track =3D NULL;
    - =09const char *lock_reason =3D NULL;
    - =09int keep_locked =3D 0;
    -+
    - =09struct option options[] =3D {
    --=09=09OPT__FORCE(&opts.force,
    --=09=09=09   N_("checkout <branch> even if already checked out in othe=
r worktree"),
    --=09=09=09   PARSE_OPT_NOCOMPLETE),
    -+=09=09OPT__FORCE(
    -+=09=09=09&opts.force,
    -+=09=09=09N_("checkout <branch> even if already checked out in other w=
orktree"),
    -+=09=09=09PARSE_OPT_NOCOMPLETE),
    - =09=09OPT_STRING('b', NULL, &new_branch, N_("branch"),
      =09=09=09   N_("create a new branch")),
      =09=09OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
      =09=09=09   N_("create or reset a branch")),
    --=09=09OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named =
commit")),
    --=09=09OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new wo=
rking tree")),
    --=09=09OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree=
 locked")),
     +=09=09OPT_STRING(0, "orphan", &opts.orphan_branch, N_("branch"),
    -+=09=09=09   N_("create a new unparented branch")),
    -+=09=09OPT_BOOL('d', "detach", &opts.detach,
    -+=09=09=09 N_("detach HEAD at named commit")),
    -+=09=09OPT_BOOL(0, "checkout", &opts.checkout,
    -+=09=09=09 N_("populate the new working tree")),
    -+=09=09OPT_BOOL(0, "lock", &keep_locked,
    -+=09=09=09 N_("keep the new working tree locked")),
    - =09=09OPT_STRING(0, "reason", &lock_reason, N_("string"),
    - =09=09=09   N_("reason for locking")),
    - =09=09OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
    - =09=09OPT_PASSTHRU(0, "track", &opt_track, NULL,
    - =09=09=09     N_("set up tracking mode (see git-branch(1))"),
    - =09=09=09     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
    --=09=09OPT_BOOL(0, "guess-remote", &guess_remote,
    --=09=09=09 N_("try to match the new branch name with a remote-tracking=
 branch")),
    -+=09=09OPT_BOOL(
    -+=09=09=090, "guess-remote", &guess_remote,
    -+=09=09=09N_("try to match the new branch name with a remote-tracking =
branch")),
    - =09=09OPT_END()
    - =09};
    -
    ++=09=09=09   N_("new unparented branch")),
    + =09=09OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named =
commit")),
    + =09=09OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new wo=
rking tree")),
    + =09=09OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree=
 locked")),
    +@@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
      =09memset(&opts, 0, sizeof(opts));
      =09opts.checkout =3D 1;
      =09ac =3D parse_options(ac, av, prefix, options, git_worktree_add_usa=
ge, 0);
     -=09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
     -=09=09die(_("options '%s', '%s', and '%s' cannot be used together"), =
"-b", "-B", "--detach");
    -+
     +=09opts.implicit =3D ac < 2;
     +
    -+=09if (!!opts.detach + !!new_branch + !!new_branch_force +
    -+=09=09    !!opts.orphan_branch >
    -+=09    1)
    ++=09if (!!opts.detach + !!new_branch + !!new_branch_force + !!opts.orp=
han_branch > 1)
     +=09=09die(_("options '%s', '%s', '%s', and '%s' cannot be used togeth=
er"),
     +=09=09    "-b", "-B", "--orphan", "--detach");
     +=09if (opts.orphan_branch && opt_track)
    -+=09=09die(_("'%s' cannot be used with '%s'"), "--orphan", "--track");
    ++=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan", "--=
track");
     +=09if (opts.orphan_branch && !opts.checkout)
    -+=09=09die(_("'%s' cannot be used with '%s'"), "--orphan",
    ++=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan",
     +=09=09    "--no-checkout");
      =09if (lock_reason && !keep_locked)
      =09=09die(_("the option '%s' requires '%s'"), "--reason", "--lock");
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09=09branch =3D "@{-1}";

     +=09/*
    -+=09 * From here on, new_branch will contain the branch to be checked =
out,
    -+=09 * and new_branch_force and opts.orphan_branch will tell us which =
one of
    -+=09 * -b/-B/--orphan is being used.
    ++=09 * When creating a new branch, new_branch now contains the branch =
to
    ++=09 * create.
    ++=09 *
    ++=09 * Past this point, new_branch_force can be treated solely as a
    ++=09 * boolean flag to indicate whether `-B` was selected.
     +=09 */
      =09if (new_branch_force) {
      =09=09struct strbuf symref =3D STRBUF_INIT;
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09=09strbuf_release(&symref);
      =09}

    +-=09if (ac < 2 && !new_branch && !opts.detach) {
    ++=09/*
    ++=09 * As the orphan cannot be created until the contents of branch
    ++=09 * are staged, opts.orphan_branch should be treated as both a bool=
ean
    ++=09 * indicating that `--orphan` was selected and as the name of the =
new
    ++=09 * orphan branch from this point on.
    ++=09 *
    ++=09 * When creating a new orphan, force checkout regardless of whethe=
r
    ++=09 * the existing branch is already checked out.
    ++=09 */
     +=09if (opts.orphan_branch) {
     +=09=09new_branch =3D opts.orphan_branch;
     +=09=09opts.force =3D 1;
     +=09}
     +
    - =09if (ac < 2 && !new_branch && !opts.detach) {
    ++=09if (ac < 2 && !new_branch && !opts.detach && !opts.orphan_branch) =
{
      =09=09const char *s =3D dwim_branch(path, &new_branch);
      =09=09if (s)
    + =09=09=09branch =3D s;
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
      =09if (!opts.quiet)
      =09=09print_preparing_worktree_line(opts.detach, branch, new_branch, =
!!new_branch_force);
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
      =09=09cp.git_cmd =3D 1;
      =09=09strvec_push(&cp.args, "branch");
    +
    + ## t/t2400-worktree-add.sh ##
    +@@ t/t2400-worktree-add.sh: test_expect_success '"add" -B/--detach mut=
ually exclusive' '
    + =09test_must_fail git worktree add -B poodle --detach bamboo main
    + '
    +
    ++test_expect_success '"add" --orphan/-b mutually exclusive' '
    ++=09test_must_fail git worktree add --orphan poodle -b poodle bamboo m=
ain
    ++'
    ++
    ++test_expect_success '"add" --orphan/-B mutually exclusive' '
    ++=09test_must_fail git worktree add --orphan poodle -B poodle bamboo m=
ain
    ++'
    ++
    ++test_expect_success '"add" --orphan/--detach mutually exclusive' '
    ++=09test_must_fail git worktree add --orphan poodle --detach bamboo ma=
in
    ++'
    ++
    ++test_expect_success '"add" --orphan/--no-checkout mutually exclusive'=
 '
    ++=09test_must_fail git worktree add --orphan poodle --no-checkout bamb=
oo main
    ++'
    ++
    ++test_expect_success '"add" -B/--detach mutually exclusive' '
    ++=09test_must_fail git worktree add -B poodle --detach bamboo main
    ++'
    ++
    + test_expect_success '"add -B" fails if the branch is checked out' '
    + =09git rev-parse newmain >before &&
    + =09test_must_fail git worktree add -B newmain bamboo main &&
    +@@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet' '
    + =09test_must_be_empty actual
    + '
    +
    ++test_expect_success '"add --orphan"' '
    ++=09test_when_finished "git worktree remove -f -f orphandir" &&
    ++=09git worktree add --orphan neworphan orphandir main &&
    ++=09echo refs/heads/neworphan >expected &&
    ++=09git -C orphandir symbolic-ref HEAD >actual &&
    ++=09test_cmp expected actual &&
    ++=09git -C orphandir diff main
    ++'
    ++
    ++test_expect_success '"add --orphan" fails if the branch already exist=
s' '
    ++=09test_when_finished "git worktree remove -f -f orphandir" &&
    ++=09git worktree add -b existingbranch orphandir main &&
    ++=09test_must_fail git worktree add --orphan existingbranch orphandir2=
 main &&
    ++=09test ! -d orphandir2
    ++'
    ++
    ++test_expect_success '"add --orphan" fails if the commit-ish doesnt ex=
ist' '
    ++=09test_must_fail git worktree add --orphan badcommitish orphandir ee=
e2222 &&
    ++=09test ! -d orphandir
    ++'
    ++
    ++test_expect_success '"add --orphan" with empty repository' '
    ++=09test_when_finished "rm -rf empty_repo" &&
    ++=09echo refs/heads/newbranch >expected &&
    ++=09GIT_DIR=3D"empty_repo" git init --bare &&
    ++=09git -C empty_repo  worktree add --orphan newbranch worktreedir &&
    ++=09git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
    ++=09test_cmp expected actual
    ++'
    ++
    + test_expect_success 'local clone from linked checkout' '
    + =09git clone --local here here-clone &&
    + =09( cd here-clone && git fsck )
4:  a167f440c3 < -:  ---------- worktree add: Add unit tests for --orphan
--
2.37.4


