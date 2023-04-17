Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC1C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDQJgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjDQJgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:36:10 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5203421D
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:35:30 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:33:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681724017; x=1681983217;
        bh=UXIYb7Pn8PSVj0/knyneujLGRCv7ZUuEHqkG/gknOuE=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=0BoJixV5bvULCuDd8bVFkeAiY9rrmAuPfhkbt40Hb/iKhXVvu5PkncRspucVn4Fsi
         6fqT5Xl3PiAwGylepuBsJnn4uWJlzVfI2FZtfy316oM5OuPOIOtP81sZ5poDMzvUBC
         6shWUGo6hb6yor8/9Z9VxSgsf/+hEka6C9py5khWGflZbDaeelDgWy7bYCfDkwwKlg
         9hR2U91GJIQ0Hd81lVHh4EoKwTcu22Q/MJT7JkqjvmytDJ9sozMI/YOCNqrTRdWXse
         q2izNXqEWERXjng02y/N7LuLdyK4/FzvDL88dFH7Ol0TwXiiBQTSsnz/G3ASFzmcom
         kUdepksi9C7RA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v9 0/8] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20230417093255.31079-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset introduces the ability to create new worktrees from orphan/un=
born
branches and introduces DWIM behavior to create worktrees from an orphan br=
anch
when no valid refs exists locally in the repository (as is typical in newly
initialized repositories) or on a remote (when `--guess-remote` is used).

This addresses the issue of `git worktree add` failing when attempting to c=
reate
a worktree from a newly initialized repository (which can be seen in this S=
O
question [1]).

Note: The last 2 patches in this patchset were initially intended to be par=
t of
a "part 2" patchset but given that they are so closely tied to this patchse=
t I
have been developing the two together. I'm fine with either splitting the
patchset and resending it or leaving them rolled together, whichever is
easier/more convenient for everyone.

This patchset has eight parts:
  * adding `-B` to the usage docs (noticed during dev and it seemed too sma=
ll
    to justify a separate submission)
  * updating test cases to still show the output of git commands when the t=
est
    script is run with `-x` to aid in debugging.
  * adding a helper fn to simplify testing for mutual exclusion of options
    in `t/t2400-worktree-add.sh`
  * adding additional test cases to verify both that behavior doesn't chang=
e
    when using `--quiet` and that the extraneous output is properly suppres=
sed.
  * adding the ability to create a worktree from an unborn/orphan branch
    to `git-worktree-add`
  * adding an advise for using --orphan when `git worktree add` fails due t=
o
    a bad ref.
  * adding functionality to DWIM when there are no existing branches and th=
e
    user likely intends to create an orphan branch.
  * updating worktree add to emit a warning (containing debug information
    about the current HEAD) when trying to use a HEAD that points to a
    non-existant (or unborn) reference and there exist other valid branches=
.

Changes from v8 (patches 1/8 - 6/8):
  * Rebase to a newer commit on main (from c03801e19c to 9857273be0) to byp=
ass
    build failures caused by curl deprecation compile warnings & to elimina=
te
    merge conflicts. The below range diff is made against a v8 rebased agai=
nst
    the same point
  * Touched up commit messages.
  * Shortened title for patch 6/8 to fit in 50 character limit.
  * Updated tests to print stderr on test exit for tests which capture stde=
rr
    to improve debugging of individual test failures.
  * Added tests to verify `--quiet` is actually quiet and doesn't otherwise
    change command behavior.
  * Changed `--orphan` from an option to a flag that can be used either on =
its
    own or with `-b`/`-B` as requested in [2].
  * Pulled a conditional and `die()` out of `print_preparing_worktree_line(=
)`
    so that it'd always be checked regardless of `--quiet`. This change was
    made because a bug was introduced in an early revision of v9 that cause=
d
    behavior to differ depending on whether `--quiet` was supplied to the
    command. To limit the changes made, the original `die()` was left as a
    `BUG()`.
  * Moved `!lookup_commit_reference_by_name(branch)` check and `--orphan` h=
int
    to the line before the call to `print_preparing_worktree_line()` to com=
bine
    with the conditional from the above/previous change.
  * Wrapped `--orphan` advice/hint in conditional to suppress display when
    using `--quiet`.
  * Updated `--orphan` advice/hint to match the `add -b branch dir/` vs
    `add dir/` syntax initially supplied by the user.
  * Updated `--orphan` hint tests to check presence on bad HEAD instead of
    empty repo.

Changes from v8 (patches 7/8 & 8/8):
  * Extended DWIM to infer `--orphan` when no other branches exist in the r=
epo
    (or remotely when using `--guess-remote` while not using `-b`) [3][4].
  * Added checks to warn/die when inferring `--orphan` causes the set of
    supplied options & flags to produce an illegal combination.
  * Added extensive tests to verify new DWIM behavior.
  * Added a failure/warning when the user likely forgot to fetch from an
    upstream repo (i.e. when there is a remote, guess_remote is enabled, an=
d
    there aren't any local or remote branches in the repo). Can be bypassed
    with `--force`/`-f` [3].
  * Updated documentation for worktree-add to mention `--orphan` when
    discussing situations where DWIM behavior does or does not occur.
  * Added a warning when the current namespace's HEAD points to an invalid
    or non-existant reference and the user is trying to create a new worktr=
ee
    from that HEAD.

1. https://stackoverflow.com/a/68717229/15064705/
2. https://lore.kernel.org/git/e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.=
org.uk/
3. https://lore.kernel.org/git/20230119222003.qcdrhcsvjlyab6af@phi/
4. https://lore.kernel.org/git/20230118224020.vrytmeyt3vbanoh2@phi/

Jacob Abel (8):
  worktree add: include -B in usage docs
  t2400: print captured git output when finished
  t2400: refactor "worktree add" opt exclusion tests
  t2400: add tests to verify --quiet
  worktree add: add --orphan flag
  worktree add: introduce "try --orphan" hint
  worktree add: extend DWIM to infer --orphan
  worktree add: emit warn when there is a bad HEAD

 Documentation/config/advice.txt |   4 +
 Documentation/git-worktree.txt  |  16 +-
 advice.c                        |   1 +
 advice.h                        |   1 +
 builtin/worktree.c              | 226 +++++++++++++-
 t/t2400-worktree-add.sh         | 520 +++++++++++++++++++++++++++++++-
 6 files changed, 747 insertions(+), 21 deletions(-)

Range-diff against v8:
1:  cbda416378 =3D 1:  91153fdb4c worktree add: include -B in usage docs
-:  ---------- > 2:  8cfbc89dd5 t2400: print captured git output when finis=
hed
2:  5f83015779 ! 3:  ab03d92c3a worktree add: refactor opt exclusion tests
    @@ Metadata
     Author: Jacob Abel <jacobabel@nullpo.dev>

      ## Commit message ##
    -    worktree add: refactor opt exclusion tests
    +    t2400: refactor "worktree add" opt exclusion tests

         Pull duplicate test code into a function so that additional opt
         combinations can be tested succinctly.
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" no auto-vivify w=
ith --detach
     +test_wt_add_excl () {
     +=09local opts=3D"$*" &&
     +=09test_expect_success "'worktree add' with '$opts' has mutually excl=
usive options" '
    ++=09=09test_when_finished cat actual >&2 &&
     +=09=09test_must_fail git worktree add $opts 2>actual &&
     +=09=09grep -E "fatal:( options)? .* cannot be used together" actual
     +=09'
-:  ---------- > 4:  d9a3468c93 t2400: add tests to verify --quiet
3:  6ac19eeeae ! 5:  8ef9587deb worktree add: add --orphan flag
    @@ Metadata
      ## Commit message ##
         worktree add: add --orphan flag

    -    Adds support for creating an orphan branch when adding a new workt=
ree.
    -    This functionality is equivalent to git switch's --orphan flag.
    -
    -    The original reason this feature was implemented was to allow a us=
er
    -    to initialise a new repository using solely the worktree oriented
    -    workflow.
    +    Add support for creating an orphan branch when adding a new worktr=
ee.
    +    The functionality of this flag is equivalent to git switch's --orp=
han
    +    option.

         Current Behavior:
         % git -C foo.git --no-pager branch -l
    @@ Commit message
         % git -C bar.git worktree add main/
         Preparing worktree (new branch 'main')
         fatal: invalid reference: HEAD
    -    % git -C bar.git worktree add --orphan main main/
    +    % git -C bar.git worktree add --orphan -b main/
         Preparing worktree (new branch 'main')
    +    % git -C bar.git worktree add --orphan -b newbranch worktreedir/
    +    Preparing worktree (new branch 'newbranch')
         %

         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
    @@ Commit message

      ## Documentation/git-worktree.txt ##
     @@ Documentation/git-worktree.txt: SYNOPSIS
    + --------
      [verse]
      'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]
    - =09=09   [(-b | -B) <new-branch>] <path> [<commit-ish>]
    -+'git worktree add' [-f] [--lock [--reason <string>]]
    -+=09=09   --orphan <new-branch> <path>
    +-=09=09   [(-b | -B) <new-branch>] <path> [<commit-ish>]
    ++=09=09   [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
      'git worktree list' [-v | --porcelain [-z]]
      'git worktree lock' [--reason <string>] <worktree>
      'git worktree move' <worktree> <new-path>
    -@@ Documentation/git-worktree.txt: exist, a new branch based on `HEAD`=
 is automatically created as if
    - `-b <branch>` was given.  If `<branch>` does exist, it will be checke=
d out
    - in the new worktree, if it's not checked out anywhere else, otherwise=
 the
    - command will refuse to create the worktree (unless `--force` is used)=
.
    -++
    -+------------
    -+$ git worktree add --orphan <branch> <path>
    -+------------
    -++
    -+Create a worktree containing no files, with an empty index, and assoc=
iated
    -+with a new orphan branch named `<branch>`. The first commit made on t=
his new
    -+branch will have no parents and will be the root of a new history dis=
connected
    -+from any other branches.
    -
    - list::
    -
     @@ Documentation/git-worktree.txt: This can also be set up as the defa=
ult behaviour by using the
      =09With `prune`, do not remove anything; just report what it would
      =09remove.

    -+--orphan <new-branch>::
    ++--orphan::
     +=09With `add`, make the new worktree and index empty, associating
    -+=09the worktree with a new orphan branch named `<new-branch>`.
    ++=09the worktree with a new orphan/unborn branch named `<new-branch>`.
     +
      --porcelain::
      =09With `list`, output in an easy-to-parse format for scripts.
    @@ builtin/worktree.c
      #define BUILTIN_WORKTREE_ADD_USAGE \
      =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reaso=
n <string>]]\n" \
     -=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>=
]")
    -+=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>=
]"), \
    -+=09N_("git worktree add [-f] [--lock [--reason <string>]]\n" \
    -+=09   "                 --orphan <new-branch> <path>")
    ++=09   "                 [--orphan] [(-b | -B) <new-branch>] <path> [<=
commit-ish>]")
     +
      #define BUILTIN_WORKTREE_LIST_USAGE \
      =09N_("git worktree list [-v | --porcelain [-z]]")
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
      =09=09struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;

      =09=09strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
    -@@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    - =09char *path;
    - =09const char *branch;
    - =09const char *new_branch =3D NULL;
    -+=09const char *orphan_branch =3D NULL;
    - =09const char *opt_track =3D NULL;
    - =09const char *lock_reason =3D NULL;
    - =09int keep_locked =3D 0;
    +@@ builtin/worktree.c: static void print_preparing_worktree_line(int d=
etach,
    + =09=09else {
    + =09=09=09struct commit *commit =3D lookup_commit_reference_by_name(br=
anch);
    + =09=09=09if (!commit)
    +-=09=09=09=09die(_("invalid reference: %s"), branch);
    ++=09=09=09=09BUG(_("unreachable: invalid reference: %s"), branch);
    + =09=09=09fprintf_ln(stderr, _("Preparing worktree (detached HEAD %s)"=
),
    + =09=09=09=09  repo_find_unique_abbrev(the_repository, &commit->object=
.oid, DEFAULT_ABBREV));
    + =09=09}
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
      =09=09=09   N_("create a new branch")),
      =09=09OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
      =09=09=09   N_("create or reset a branch")),
    -+=09=09OPT_STRING(0, "orphan", &orphan_branch, N_("branch"),
    -+=09=09=09   N_("new unparented branch")),
    ++=09=09OPT_BOOL(0, "orphan", &opts.orphan, N_("create unborn/orphaned =
branch")),
      =09=09OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named =
commit")),
      =09=09OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new wo=
rking tree")),
      =09=09OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree=
 locked")),
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    - =09memset(&opts, 0, sizeof(opts));
    - =09opts.checkout =3D 1;
      =09ac =3D parse_options(ac, av, prefix, options, git_worktree_add_usa=
ge, 0);
    -+=09opts.orphan =3D !!orphan_branch;
      =09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
      =09=09die(_("options '%s', '%s', and '%s' cannot be used together"), =
"-b", "-B", "--detach");
    -+=09if (!!opts.detach + !!opts.orphan + !!new_branch + !!new_branch_fo=
rce > 1)
    -+=09=09die(_("options '%s', '%s', '%s', and '%s' cannot be used togeth=
er"),
    -+=09=09    "-b", "-B", "--orphan", "--detach");
    ++=09if (opts.detach && opts.orphan)
    ++=09=09die(_("options '%s', and '%s' cannot be used together"),
    ++=09=09    "--orphan", "--detach");
     +=09if (opts.orphan && opt_track)
     +=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan", "--=
track");
     +=09if (opts.orphan && !opts.checkout)
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09}

     -=09if (ac < 2 && !new_branch && !opts.detach) {
    -+=09if (opts.orphan) {
    -+=09=09new_branch =3D orphan_branch;
    -+=09} else if (ac < 2 && !new_branch && !opts.detach) {
    ++=09if (opts.orphan && !new_branch) {
    ++=09=09int n;
    ++=09=09const char *s =3D worktree_basename(path, &n);
    ++=09=09new_branch =3D xstrndup(s, n);
    ++=09} else if (new_branch || opts.detach || opts.orphan) {
    ++=09=09// No-op
    ++=09} else if (ac < 2) {
      =09=09const char *s =3D dwim_branch(path, &new_branch);
      =09=09if (s)
      =09=09=09branch =3D s;
    +-=09}
    +-
    +-=09if (ac =3D=3D 2 && !new_branch && !opts.detach) {
    ++=09} else if (ac =3D=3D 2) {
    + =09=09struct object_id oid;
    + =09=09struct commit *commit;
    + =09=09const char *remote;
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    + =09=09=09}
    + =09=09}
    + =09}
    ++
    ++=09if (!opts.orphan && !lookup_commit_reference_by_name(branch)) {
    ++=09=09die(_("invalid reference: %s"), branch);
    ++=09}
    ++
      =09if (!opts.quiet)
      =09=09print_preparing_worktree_line(opts.detach, branch, new_branch, =
!!new_branch_force);

     -=09if (new_branch) {
     +=09if (opts.orphan) {
     +=09=09branch =3D new_branch;
    -+=09} else if (!lookup_commit_reference_by_name(branch)) {
    -+=09=09die(_("invalid reference: %s"), branch);
     +=09} else if (new_branch) {
      =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
      =09=09cp.git_cmd =3D 1;
    @@ t/t2400-worktree-add.sh: test_wt_add_excl () {
      test_wt_add_excl -b poodle -B poodle bamboo main
      test_wt_add_excl -b poodle --detach bamboo main
      test_wt_add_excl -B poodle --detach bamboo main
    -+test_wt_add_excl -B poodle --orphan poodle bamboo
    -+test_wt_add_excl -b poodle --orphan poodle bamboo
    -+test_wt_add_excl --orphan poodle --detach bamboo
    -+test_wt_add_excl --orphan poodle --no-checkout bamboo
    -+test_wt_add_excl --orphan poodle bamboo main
    ++test_wt_add_excl --orphan --detach bamboo
    ++test_wt_add_excl --orphan --no-checkout bamboo
    ++test_wt_add_excl --orphan bamboo main
    ++test_wt_add_excl --orphan -b bamboo wtdir/ main

      test_expect_success '"add -B" fails if the branch is checked out' '
      =09git rev-parse newmain >before &&
    -@@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet' '
    +@@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet -b' '
      =09test_must_be_empty actual
      '

     +test_expect_success '"add --orphan"' '
     +=09test_when_finished "git worktree remove -f -f orphandir" &&
    -+=09git worktree add --orphan neworphan orphandir &&
    ++=09git worktree add --orphan -b neworphan orphandir &&
    ++=09echo refs/heads/neworphan >expected &&
    ++=09git -C orphandir symbolic-ref HEAD >actual &&
    ++=09test_cmp expected actual
    ++'
    ++
    ++test_expect_success '"add --orphan (no -b)"' '
    ++=09test_when_finished "git worktree remove -f -f neworphan" &&
    ++=09git worktree add --orphan neworphan &&
    ++=09echo refs/heads/neworphan >expected &&
    ++=09git -C neworphan symbolic-ref HEAD >actual &&
    ++=09test_cmp expected actual
    ++'
    ++
    ++test_expect_success '"add --orphan --quiet"' '
    ++=09test_when_finished "git worktree remove -f -f orphandir" &&
    ++=09test_when_finished cat log.actual >&2 &&
    ++=09git worktree add --quiet --orphan -b neworphan orphandir 2>log.act=
ual &&
    ++=09test_must_be_empty log.actual &&
     +=09echo refs/heads/neworphan >expected &&
     +=09git -C orphandir symbolic-ref HEAD >actual &&
     +=09test_cmp expected actual
    @@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet' '
     +
     +test_expect_success '"add --orphan" fails if the branch already exist=
s' '
     +=09test_when_finished "git branch -D existingbranch" &&
    -+=09test_when_finished "git worktree remove -f -f orphandir" &&
     +=09git worktree add -b existingbranch orphandir main &&
    -+=09test_must_fail git worktree add --orphan existingbranch orphandir2=
 &&
    -+=09test_path_is_missing orphandir2
    ++=09git worktree remove orphandir &&
    ++=09test_must_fail git worktree add --orphan -b existingbranch orphand=
ir
     +'
     +
     +test_expect_success '"add --orphan" with empty repository' '
     +=09test_when_finished "rm -rf empty_repo" &&
     +=09echo refs/heads/newbranch >expected &&
     +=09GIT_DIR=3D"empty_repo" git init --bare &&
    -+=09git -C empty_repo  worktree add --orphan newbranch worktreedir &&
    ++=09git -C empty_repo  worktree add --orphan -b newbranch worktreedir =
&&
     +=09git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
     +=09test_cmp expected actual
     +'
     +
     +test_expect_success '"add" worktree with orphan branch and lock' '
    -+=09git worktree add --lock --orphan orphanbr orphan-with-lock &&
    ++=09git worktree add --lock --orphan -b orphanbr orphan-with-lock &&
     +=09test_when_finished "git worktree unlock orphan-with-lock || :" &&
     +=09test -f .git/worktrees/orphan-with-lock/locked
     +'
4:  3d76a5b6b8 ! 6:  d2800266f9 worktree add: add hint to direct users towa=
rds --orphan
    @@ Metadata
     Author: Jacob Abel <jacobabel@nullpo.dev>

      ## Commit message ##
    -    worktree add: add hint to direct users towards --orphan
    +    worktree add: introduce "try --orphan" hint

    -    Adds a new advice/hint in `git worktree add` for when the user
    +    Add a new advice/hint in `git worktree add` for when the user
         tries to create a new worktree from a reference that doesn't exist=
.

         Current Behavior:

    -    % git init --bare foo.git
    -    Initialized empty Git repository in /path/to/foo.git/
    -    % git -C foo.git worktree add main/
    -    Preparing worktree (new branch 'main')
    +    % git init foo
    +    Initialized empty Git repository in /path/to/foo/
    +    % touch file
    +    % git -C foo commit -q -a -m "test commit"
    +    % git -C foo switch --orphan norefbranch
    +    % git -C foo worktree add newbranch/
    +    Preparing worktree (new branch 'newbranch')
         fatal: invalid reference: HEAD
         %

         New Behavior:

    -    % git init --bare foo.git
    -    Initialized empty Git repository in /path/to/foo.git/
    -    % git -C foo.git worktree add main/
    -    Preparing worktree (new branch 'main')
    +    % git init --bare foo
    +    Initialized empty Git repository in /path/to/foo/
    +    % touch file
    +    % git -C foo commit -q -a -m "test commit"
    +    % git -C foo switch --orphan norefbranch
    +    % git -C foo worktree add newbranch/
    +    Preparing worktree (new branch 'newbranch')
         hint: If you meant to create a worktree containing a new orphan br=
anch
         hint: (branch with no commits) for this repository, you can do so
         hint: using the --orphan option:
         hint:
    -    hint:   git worktree add --orphan main ./main
    +    hint:   git worktree add --orphan newbranch/
    +    hint:
    +    hint: Disable this message with "git config advice.worktreeAddOrph=
an false"
    +    fatal: invalid reference: HEAD
    +    % git -C foo worktree add -b newbranch2 new_wt/
    +    Preparing worktree (new branch 'newbranch')
    +    hint: If you meant to create a worktree containing a new orphan br=
anch
    +    hint: (branch with no commits) for this repository, you can do so
    +    hint: using the --orphan option:
    +    hint:
    +    hint:   git worktree add --orphan -b newbranch2 new_wt/
         hint:
         hint: Disable this message with "git config advice.worktreeAddOrph=
an false"
         fatal: invalid reference: HEAD
    @@ advice.h: struct string_list;
      int git_default_advice_config(const char *var, const char *value);

      ## builtin/worktree.c ##
    +@@
    + #define BUILTIN_WORKTREE_UNLOCK_USAGE \
    + =09N_("git worktree unlock <worktree>")
    +
    ++#define WORKTREE_ADD_ORPHAN_WITH_DASH_B_HINT_TEXT \
    ++=09_("If you meant to create a worktree containing a new orphan branc=
h\n" \
    ++=09"(branch with no commits) for this repository, you can do so\n" \
    ++=09"using the --orphan flag:\n" \
    ++=09"\n" \
    ++=09"=09git worktree add --orphan -b %s %s\n")
    ++
    ++#define WORKTREE_ADD_ORPHAN_NO_DASH_B_HINT_TEXT \
    ++=09_("If you meant to create a worktree containing a new orphan branc=
h\n" \
    ++=09"(branch with no commits) for this repository, you can do so\n" \
    ++=09"using the --orphan flag:\n" \
    ++=09"\n" \
    ++=09"=09git worktree add --orphan %s\n")
    ++
    + static const char * const git_worktree_usage[] =3D {
    + =09BUILTIN_WORKTREE_ADD_USAGE,
    + =09BUILTIN_WORKTREE_LIST_USAGE,
    +@@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    + =09const char *opt_track =3D NULL;
    + =09const char *lock_reason =3D NULL;
    + =09int keep_locked =3D 0;
    ++=09int used_new_branch_options;
    + =09struct option options[] =3D {
    + =09=09OPT__FORCE(&opts.force,
    + =09=09=09   N_("checkout <branch> even if already checked out in othe=
r worktree"),
    +@@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    +
    + =09path =3D prefix_filename(prefix, av[0]);
    + =09branch =3D ac < 2 ? "HEAD" : av[1];
    ++=09used_new_branch_options =3D new_branch || new_branch_force;
    +
    + =09if (!strcmp(branch, "-"))
    + =09=09branch =3D "@{-1}";
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    - =09if (opts.orphan) {
    - =09=09branch =3D new_branch;
    - =09} else if (!lookup_commit_reference_by_name(branch)) {
    -+=09=09advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
    -+=09=09=09_("If you meant to create a worktree containing a new orphan=
 branch\n"
    -+=09=09=09"(branch with no commits) for this repository, you can do so=
\n"
    -+=09=09=09"using the --orphan option:\n"
    -+=09=09=09"\n"
    -+=09=09=09"=09git worktree add --orphan %s %s\n"), new_branch, path);
    + =09}
    +
    + =09if (!opts.orphan && !lookup_commit_reference_by_name(branch)) {
    ++=09=09int attempt_hint =3D !opts.quiet && (ac < 2);
    ++=09=09if (attempt_hint && used_new_branch_options) {
    ++=09=09=09advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
    ++=09=09=09=09WORKTREE_ADD_ORPHAN_WITH_DASH_B_HINT_TEXT,
    ++=09=09=09=09new_branch, path);
    ++=09=09} else if (attempt_hint) {
    ++=09=09=09advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
    ++=09=09=09=09WORKTREE_ADD_ORPHAN_NO_DASH_B_HINT_TEXT, path);
    ++=09=09}
      =09=09die(_("invalid reference: %s"), branch);
    - =09} else if (new_branch) {
    - =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
    + =09}
    +

      ## t/t2400-worktree-add.sh ##
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree with o=
rphan branch, lock, and reason' '
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree with or=
phan branch,
      '

     +# Note: Quoted arguments containing spaces are not supported.
    -+test_wt_add_empty_repo_orphan_hint () {
    ++test_wt_add_orphan_hint () {
     +=09local context=3D"$1" &&
    -+=09shift &&
    ++=09local use_branch=3D$2 &&
    ++=09shift 2 &&
     +=09local opts=3D"$*" &&
    -+=09test_expect_success "'worktree add' show orphan hint in empty repo=
 w/ $context" '
    -+=09=09test_when_finished "rm -rf empty_repo" &&
    -+=09=09GIT_DIR=3D"empty_repo" git init --bare &&
    -+=09=09test_must_fail git -C empty_repo worktree add $opts foobar/ 2>a=
ctual &&
    ++=09test_expect_success "'worktree add' show orphan hint in bad/orphan=
 HEAD w/ $context" '
    ++=09=09test_when_finished "rm -rf repo" &&
    ++=09=09git init repo &&
    ++=09=09(cd repo && test_commit commit) &&
    ++=09=09git -C repo switch --orphan noref &&
    ++=09=09test_when_finished cat actual >&2 &&
    ++=09=09test_must_fail git -C repo worktree add $opts foobar/ 2>actual =
&&
     +=09=09! grep "error: unknown switch" actual &&
    -+=09=09grep "hint: If you meant to create a worktree containing a new =
orphan branch" actual
    ++=09=09grep "hint: If you meant to create a worktree containing a new =
orphan branch" actual &&
    ++=09=09if [ $use_branch -eq 1 ]
    ++=09=09then
    ++=09=09=09grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" =
actual
    ++=09=09else
    ++=09=09=09grep -E "^hint:\s+git worktree add --orphan \S+\s*$" actual
    ++=09=09fi
    ++
     +=09'
     +}
     +
    -+test_wt_add_empty_repo_orphan_hint 'DWIM'
    -+test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch
    -+test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch
    ++test_wt_add_orphan_hint 'no opts' 0
    ++test_wt_add_orphan_hint '-b' 1 -b foobar_branch
    ++test_wt_add_orphan_hint '-B' 1 -B foobar_branch
    ++
    ++test_expect_success "'worktree add' doesn't show orphan hint in bad/o=
rphan HEAD w/ --quiet" '
    ++=09test_when_finished "rm -rf repo" &&
    ++=09git init repo &&
    ++=09(cd repo && test_commit commit) &&
    ++=09test_when_finished cat actual >&2 &&
    ++=09test_must_fail git -C repo worktree add --quiet foobar_branch foob=
ar/ 2>actual &&
    ++=09! grep "error: unknown switch" actual &&
    ++=09! grep "hint: If you meant to create a worktree containing a new o=
rphan branch" actual
    ++'
     +
      test_expect_success 'local clone from linked checkout' '
      =09git clone --local here here-clone &&
-:  ---------- > 7:  e5e139766c worktree add: extend DWIM to infer --orphan
-:  ---------- > 8:  296226ffd5 worktree add: emit warn when there is a bad=
 HEAD
--
2.39.2


