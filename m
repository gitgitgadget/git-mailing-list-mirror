Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62207C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 06:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiL1GQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 01:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiL1GQq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 01:16:46 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE932188
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 22:16:43 -0800 (PST)
Date:   Wed, 28 Dec 2022 06:16:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1672208201; x=1672467401;
        bh=XJAynt6HgoOZAgefjz0aWHbuN7Qp1sfiGcSNHZOW/Yc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=xIeIyR9iV0cvlC91KC7+YTA3Pt2jhq78jZLShKNGYksyxRICk0u+ITJ103tybZD2G
         m7k9H3jBxK14cViVMNZJpl1PiYiYKUZ18awVXRnv5AF3Bp3rH55vF8HIWMomUcwhs3
         4lNW/xysiUITHCVnTFXSkifVoTToT3dt6h6k9G1VEckKp41QZ6cEHvEBBp3wCd0RVX
         ZVMk6DWfc05pZ21aOJ1MgGFzVJJFH+PriF1lOf4IhhYA+eIiTQPNLN77EqPQvmM5k8
         JyRXcrD3gazxme4mqmhAIvetMz0wVc0+nis/5YsbgrFrQIjmy0hRI78NATYv3ziF4u
         1My6c7qCbnTUQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v6 0/4] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221228061539.13740-1-jacobabel@nullpo.dev>
In-Reply-To: <20221220023637.29042-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev>
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

This patchset has four parts:
  * adding `-B` to the usage docs (noticed during dev and it seemed too sma=
ll
    to justify a separate submission)
  * adding a helper fn to simplify testing for mutual exclusion of options
    in `t/t2400-worktree-add.sh`
  * adding orphan branch functionality (as is present in `git-switch`)
    to `git-worktree-add`
  * adding an advise for using --orphan when `git worktree add` fails due t=
o
    a bad ref.

Changes from v5:
  * Touched up commit title and message for 1/4 [2].
  * Changed `[-b | -B]` to `(-b | -B)` in 1/4 [2].
  * Add whitespace to both sides of () for test_wt_add_excl() in t2400 (2/4=
) [3].
  * Changed test_wt_add_excl() to use `$*` and `$@` instead of `$opts` (2/4=
) [3].
  * Added save_param_arr() to preserve "$@" from being reset by
    test_expect_success() in test_wt_add_excl() (2/4).
  * Reordered Signed-off-by lines in 3/4 [4].
  * Cleaned up commit message in 3/4 to better illustrate the change [4].
  * Cleaned up commit message in 4/4 to better illustrate the change.
  * Cleaned up commit title in 4/4 [5].
  * Changed test_wt_add_empty_repo_orphan_hint() to use `$@` instead
    of `$opts` (4/4) [5].

1. https://stackoverflow.com/a/68717229/15064705/
2. https://lore.kernel.org/git/xmqqo7ryyc4f.fsf@gitster.g/
3. https://lore.kernel.org/git/xmqqsfhawwqf.fsf@gitster.g/
4. https://lore.kernel.org/git/xmqqlen2wvtn.fsf@gitster.g/
5. https://lore.kernel.org/git/xmqqfsdawqbw.fsf@gitster.g/

Jacob Abel (4):
  worktree add: include -B in usage docs
  worktree add: refactor opt exclusion tests
  worktree add: add --orphan flag
  worktree add: add hint to direct users towards --orphan

 Documentation/config/advice.txt |   4 ++
 Documentation/git-worktree.txt  |  17 ++++-
 advice.c                        |   1 +
 advice.h                        |   1 +
 builtin/worktree.c              |  65 +++++++++++++++++--
 t/t2400-worktree-add.sh         | 110 +++++++++++++++++++++++++++++---
 6 files changed, 181 insertions(+), 17 deletions(-)

Range-diff against v5:
1:  05371640ad ! 1:  a9ef3eca7b worktree add: Include -B in usage docs
    @@ Metadata
     Author: Jacob Abel <jacobabel@nullpo.dev>

      ## Commit message ##
    -    worktree add: Include -B in usage docs
    +    worktree add: include -B in usage docs

    -    While -B behavior is already documented, it was not included in th=
e
    -    usage docs for either the man page or the help text. This change f=
ixes
    -    that and brings the usage docs in line with how the flags are docu=
mented
    -    in other commands such as git checkout.
    +    Document `-B` next to where `-b` is already documented to bring th=
e
    +    usage docs in line with other commands such as git checkout.

         Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>

    @@ Documentation/git-worktree.txt: SYNOPSIS
      [verse]
      'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]
     -=09=09   [-b <new-branch>] <path> [<commit-ish>]
    -+=09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
    ++=09=09   [(-b | -B) <new-branch>] <path> [<commit-ish>]
      'git worktree list' [-v | --porcelain [-z]]
      'git worktree lock' [--reason <string>] <worktree>
      'git worktree move' <worktree> <new-path>
    @@ builtin/worktree.c
      #define BUILTIN_WORKTREE_ADD_USAGE \
      =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reaso=
n <string>]]\n" \
     -=09   "                 [-b <new-branch>] <path> [<commit-ish>]")
    -+=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>=
]")
    ++=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>=
]")
      #define BUILTIN_WORKTREE_LIST_USAGE \
      =09N_("git worktree list [-v | --porcelain [-z]]")
      #define BUILTIN_WORKTREE_LOCK_USAGE \
2:  3d8b26f9d6 ! 2:  c03c112f79 worktree add: refactor opt exclusion tests
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" no auto-vivify w=
ith --detach
     -test_expect_success '"add" -b/-B mutually exclusive' '
     -=09test_must_fail git worktree add -b poodle -B poodle bamboo main
     -'
    --
    ++# Saves parameter sequence/array as a string so they can be safely st=
ored in a
    ++# variable and restored with `eval "set -- $arr"`. Sourced from
    ++# https://stackoverflow.com/a/27503158/15064705
    ++save_param_arr () {
    ++=09local i
    ++=09for i;
    ++=09do
    ++=09=09# For each argument:
    ++=09=09# 1. Append "\n" after each entry
    ++=09=09# 2. Convert "'" into "'\''"
    ++=09=09# 3. Prepend "'" before each entry
    ++=09=09# 4. Append " \" after each entry
    ++=09=09printf "%s\\n" "$i" | sed "
    ++=09=09=09s/'/'\\\\''/g
    ++=09=09=091s/^/'/
    ++=09=09=09\$s/\$/' \\\\/
    ++=09=09"
    ++=09done
    ++=09echo " "
    ++}
    +
     -test_expect_success '"add" -b/--detach mutually exclusive' '
     -=09test_must_fail git worktree add -b poodle --detach bamboo main
     -'
     +# Helper function to test mutually exclusive options.
    -+test_wt_add_excl() {
    -+=09local opts=3D"$@" &&
    -+=09test_expect_success "'worktree add' with '$opts' has mutually excl=
usive options" '
    -+=09=09test_must_fail git worktree add $opts
    ++test_wt_add_excl () {
    ++=09local arr=3D$(save_param_arr "$@")
    ++=09test_expect_success "'worktree add' with $* has mutually exclusive=
 options" '
    ++=09=09eval "set -- $arr" &&
    ++=09=09test_must_fail git worktree add "$@"
     +=09'
     +}

3:  ccae9cec2e ! 3:  9b93e2493a worktree add: add --orphan flag
    @@ Commit message
         workflow.

         Current Behavior:
    -
    -    % git init --bare foo.git
    -    Initialized empty Git repository in /path/to/foo.git/
    +    % git -C foo.git --no-pager branch -l
    +    + main
         % git -C foo.git worktree add main/
         Preparing worktree (new branch 'main')
    +    HEAD is now at 6c93a75 a commit
    +    %
    +
    +    % git init bar.git
    +    Initialized empty Git repository in /path/to/bar.git/
    +    % git -C bar.git --no-pager branch -l
    +
    +    % git -C bar.git worktree add main/
    +    Preparing worktree (new branch 'main')
         fatal: not a valid object name: 'HEAD'
         %

         New Behavior:

    -    % git init --bare foo.git
    -    Initialized empty Git repository in /path/to/foo.git/
    -    % git -C foo.git worktree add --orphan main main/
    +    % git -C foo.git --no-pager branch -l
    +    + main
    +    % git -C foo.git worktree add main/
    +    Preparing worktree (new branch 'main')
    +    HEAD is now at 6c93a75 a commit
    +    %
    +
    +    % git init --bare bar.git
    +    Initialized empty Git repository in /path/to/bar.git/
    +    % git -C bar.git --no-pager branch -l
    +
    +    % git -C bar.git worktree add main/
    +    Preparing worktree (new branch 'main')
    +    fatal: invalid reference: HEAD
    +    % git -C bar.git worktree add --orphan main main/
         Preparing worktree (new branch 'main')
         %

    -    Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
    +    Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>

      ## Documentation/git-worktree.txt ##
     @@ Documentation/git-worktree.txt: SYNOPSIS
      [verse]
      'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]
    - =09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
    + =09=09   [(-b | -B) <new-branch>] <path> [<commit-ish>]
     +'git worktree add' [-f] [--lock [--reason <string>]]
     +=09=09   --orphan <new-branch> <path>
      'git worktree list' [-v | --porcelain [-z]]
    @@ builtin/worktree.c

      #define BUILTIN_WORKTREE_ADD_USAGE \
      =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reaso=
n <string>]]\n" \
    --=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>=
]")
    -+=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>=
]"), \
    +-=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>=
]")
    ++=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>=
]"), \
     +=09N_("git worktree add [-f] [--lock [--reason <string>]]\n" \
     +=09   "                 --orphan <new-branch> <path>")
     +
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09=09strvec_push(&cp.args, "branch");

      ## t/t2400-worktree-add.sh ##
    -@@ t/t2400-worktree-add.sh: test_wt_add_excl() {
    +@@ t/t2400-worktree-add.sh: test_wt_add_excl () {
      test_wt_add_excl -b poodle -B poodle bamboo main
      test_wt_add_excl -b poodle --detach bamboo main
      test_wt_add_excl -B poodle --detach bamboo main
4:  df4c1fa469 ! 4:  737fca6986 worktree add: Add hint to use --orphan when=
 bad ref
    @@ Metadata
     Author: Jacob Abel <jacobabel@nullpo.dev>

      ## Commit message ##
    -    worktree add: Add hint to use --orphan when bad ref
    +    worktree add: add hint to direct users towards --orphan

         Adds a new advice/hint in `git worktree add` for when the user
         tries to create a new worktree from a reference that doesn't exist=
.

    +    Current Behavior:
    +
    +    % git init --bare foo.git
    +    Initialized empty Git repository in /path/to/foo.git/
    +    % git -C foo.git worktree add main/
    +    Preparing worktree (new branch 'main')
    +    fatal: invalid reference: HEAD
    +    %
    +
    +    New Behavior:
    +
    +    % git init --bare foo.git
    +    Initialized empty Git repository in /path/to/foo.git/
    +    % git -C foo.git worktree add main/
    +    Preparing worktree (new branch 'main')
    +    hint: If you meant to create a worktree containing a new orphan br=
anch
    +    hint: (branch with no commits) for this repository, you can do so
    +    hint: using the --orphan option:
    +    hint:
    +    hint:   git worktree add --orphan main ./main
    +    hint:
    +    hint: Disable this message with "git config advice.worktreeAddOrph=
an false"
    +    fatal: invalid reference: HEAD
    +    %
    +
         Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>

      ## Documentation/config/advice.txt ##
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree with or=
phan branch,
      =09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
      '

    -+test_wt_add_empty_repo_orphan_hint() {
    ++test_wt_add_empty_repo_orphan_hint () {
     +=09local context=3D"$1"
     +=09shift
    -+=09local opts=3D"$@"
    ++=09local arr=3D$(save_param_arr "$@")
     +=09test_expect_success "'worktree add' show orphan hint in empty repo=
 w/ $context" '
    ++=09=09eval "set -- $arr" &&
     +=09=09test_when_finished "rm -rf empty_repo" &&
     +=09=09GIT_DIR=3D"empty_repo" git init --bare &&
    -+=09=09test_must_fail git -C empty_repo worktree add $opts foobar/ 2> =
actual &&
    ++=09=09test_must_fail git -C empty_repo worktree add "$@" foobar/ 2> a=
ctual &&
     +=09=09grep "hint: If you meant to create a worktree containing a new =
orphan branch" actual
     +=09'
     +}
--
2.38.2


