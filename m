Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBF5C77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 21:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjEQVrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 17:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQVro (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 17:47:44 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99798559D
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:47:38 -0700 (PDT)
Date:   Wed, 17 May 2023 21:47:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1684360056; x=1684619256;
        bh=cJ/0hg+60IiX2KEXba3jk+VK2tZwGrrsyODi+JUZPBg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=mlk7ylXnzGLGWWx8UjcE48yt8/oD3IEsNi6ouLX0D+Ffi0lziBLwkNiuou3u7ByX8
         XC42vTjw3AABqRqqnBsPiIPQRA03lcD3lOdTZEMCWKZgEvnOQkbsb070VHHRd38pXo
         xRFcNgTxO4xx975N7qTE/FME8BvVlB1UZCx3EOI+JvIChdZ/pNLv+TtRbtxWEMEPY2
         2gDEXLX1EdCsATHLqqvzqFz/RBbxiZ4fVmJ3EuRvAmdHll3bNPR8bMoRhP1HqHDryq
         9n+tkPswjP4q08wG4IFJiQ5W33NP3kL1ZcxgA3kejLYJZyrbLuS+W8HsPe/d5NYcRz
         901ri7u6/M87w==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [RESEND PATCH v10 0/8] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20230517214711.12467-1-jacobabel@nullpo.dev>
In-Reply-To: <20230417093255.31079-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
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
initialized repositories) or on a remote (when `--guess-remote` is used).=
=20

This addresses the issue of `git worktree add` failing when attempting to c=
reate
a worktree from a newly initialized repository (which can be seen in this S=
O
question [1]).

NOTE: Resend of Patch v10 as my mail setup tampered with and broke the patc=
hset.=20
original v10 cover: <20230507120530.14669-1-jacobabel@nullpo.dev>

This patchset has eight parts:
  * adding `-B` to the usage docs (noticed during dev and it seemed too sma=
ll
    to justify a separate submission)
  * cleaning up a left-behind worktree in t2400
  * adding a helper fn to simplify testing for mutual exclusion of options
    in `t/t2400-worktree-add.sh`
  * adding additional test cases to verify both that behavior doesn't chang=
e
    when using `--quiet` and that the extraneous output is properly suppres=
sed.
  * adding the ability to create a worktree from an unborn/orphan branch
    to `git-worktree-add`
  * adding an advise for using --orphan when `git worktree add` fails due t=
o=20
    a bad ref.
  * adding functionality to DWIM when there are no existing branches and th=
e
    user likely intends to create an orphan branch.
  * updating worktree add to emit a warning (containing debug information=
=20
    about the current HEAD) when trying to use a HEAD that points to a
    non-existant (or unborn) reference and there exist other valid branches=
.

Changes from v9:
  * Revert `test_when_finished cat actual` changes in t2400 (2/8)[2].
  * Rename commit 2/8 to reflect changes.
  * Revert `test_when_finished cat actual` changes in t2400 (3/8)[3].
  * Revert `test_when_finished cat actual` changes in t2400 (4/8)[4].
  * Revert `test_when_finished cat actual` changes in t2400 (5/8).
  * Remove extraneous whitespace from command in t2400 (5/8).
  * Revert `test_when_finished cat actual` changes in t2400 (6/8).
  * Include `advice.h` in `worktree.c` to resolve missing include when=20
    applying patch on top of main (6/8).
  * Revert `test_when_finished cat actual` changes in t2400 (7/8).
  * Remove extraneous whitespace from comment in `worktree.c` (7/8).

1. https://stackoverflow.com/a/68717229/15064705/
2. https://lore.kernel.org/git/xmqq8reqkyfz.fsf@gitster.g/
3. https://lore.kernel.org/git/xmqqmt36jixr.fsf@gitster.g/
4. https://lore.kernel.org/git/xmqqfs8yjisl.fsf@gitster.g/

Jacob Abel (8):
  worktree add: include -B in usage docs
  t2400: cleanup created worktree in test
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
 builtin/worktree.c              | 227 +++++++++++++-
 t/t2400-worktree-add.sh         | 507 +++++++++++++++++++++++++++++++-
 6 files changed, 735 insertions(+), 21 deletions(-)

Range-diff against v9:
1:  91153fdb4c =3D 1:  91153fdb4c worktree add: include -B in usage docs
2:  8cfbc89dd5 ! 2:  0f30e9a9e3 t2400: print captured git output when finis=
hed
    @@ Metadata
     Author: Jacob Abel <jacobabel@nullpo.dev>
    =20
      ## Commit message ##
    -    t2400: print captured git output when finished
    -
    -    Update tests that capture stderr so that at the end of the test th=
ey
    -    print the captured text back out to stderr. This simplifies debugg=
ing
    -    when inspecting test logs after executing with `-x`.
    +    t2400: cleanup created worktree in test
    =20
         Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
    =20
    @@ t/t2400-worktree-add.sh: test_expect_success 'add -B' '
     =20
      test_expect_success 'add --quiet' '
     +=09test_when_finished "git worktree remove -f -f another-worktree" &&
    -+=09test_when_finished cat actual >&2 &&
      =09git worktree add --quiet another-worktree main 2>actual &&
      =09test_must_be_empty actual
      '
3:  ab03d92c3a ! 3:  06e8c53bc6 t2400: refactor "worktree add" opt exclusio=
n tests
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" no auto-vivify w=
ith --detach
     +test_wt_add_excl () {
     +=09local opts=3D"$*" &&
     +=09test_expect_success "'worktree add' with '$opts' has mutually excl=
usive options" '
    -+=09=09test_when_finished cat actual >&2 &&
     +=09=09test_must_fail git worktree add $opts 2>actual &&
     +=09=09grep -E "fatal:( options)? .* cannot be used together" actual
     +=09'
4:  d9a3468c93 ! 4:  d9330db91f t2400: add tests to verify --quiet
    @@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet' '
     +test_expect_success 'add --quiet -b' '
     +=09test_when_finished "git branch -D quietnewbranch" &&
     +=09test_when_finished "git worktree remove -f -f another-worktree" &&
    -+=09test_when_finished cat actual >&2 &&
     +=09git worktree add --quiet -b quietnewbranch another-worktree 2>actu=
al &&
     +=09test_must_be_empty actual
     +'
    @@ t/t2400-worktree-add.sh: test_expect_success 'git worktree add --gue=
ss-remote se
      '
     +test_expect_success 'git worktree add --guess-remote sets up tracking=
 (quiet)' '
     +=09test_when_finished rm -rf repo_a repo_b foo &&
    -+=09test_when_finished cat repo_b/actual >&2 &&
     +=09setup_remote_repo repo_a repo_b &&
     +=09(
     +=09=09cd repo_b &&
5:  8ef9587deb ! 5:  a5a78e5f53 worktree add: add --orphan flag
    @@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet -b' '
     +
     +test_expect_success '"add --orphan --quiet"' '
     +=09test_when_finished "git worktree remove -f -f orphandir" &&
    -+=09test_when_finished cat log.actual >&2 &&
     +=09git worktree add --quiet --orphan -b neworphan orphandir 2>log.act=
ual &&
     +=09test_must_be_empty log.actual &&
     +=09echo refs/heads/neworphan >expected &&
    @@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet -b' '
     +=09test_when_finished "rm -rf empty_repo" &&
     +=09echo refs/heads/newbranch >expected &&
     +=09GIT_DIR=3D"empty_repo" git init --bare &&
    -+=09git -C empty_repo  worktree add --orphan -b newbranch worktreedir =
&&
    ++=09git -C empty_repo worktree add --orphan -b newbranch worktreedir &=
&
     +=09git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
     +=09test_cmp expected actual
     +'
6:  d2800266f9 ! 6:  96b1946e64 worktree add: introduce "try --orphan" hint
    @@ advice.h: struct string_list;
      int git_default_advice_config(const char *var, const char *value);
    =20
      ## builtin/worktree.c ##
    +@@
    + #include "cache.h"
    + #include "abspath.h"
    ++#include "advice.h"
    + #include "checkout.h"
    + #include "config.h"
    + #include "builtin.h"
     @@
      #define BUILTIN_WORKTREE_UNLOCK_USAGE \
      =09N_("git worktree unlock <worktree>")
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree with or=
phan branch,
     +=09=09git init repo &&
     +=09=09(cd repo && test_commit commit) &&
     +=09=09git -C repo switch --orphan noref &&
    -+=09=09test_when_finished cat actual >&2 &&
     +=09=09test_must_fail git -C repo worktree add $opts foobar/ 2>actual =
&&
     +=09=09! grep "error: unknown switch" actual &&
     +=09=09grep "hint: If you meant to create a worktree containing a new =
orphan branch" actual &&
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree with or=
phan branch,
     +=09test_when_finished "rm -rf repo" &&
     +=09git init repo &&
     +=09(cd repo && test_commit commit) &&
    -+=09test_when_finished cat actual >&2 &&
     +=09test_must_fail git -C repo worktree add --quiet foobar_branch foob=
ar/ 2>actual &&
     +=09! grep "error: unknown switch" actual &&
     +=09! grep "hint: If you meant to create a worktree containing a new o=
rphan branch" actual
7:  e5e139766c ! 7:  52fef9672c worktree add: extend DWIM to infer --orphan
    @@ builtin/worktree.c: static void print_preparing_worktree_line(int de=
tach,
     +/**
     + * Determines whether `--orphan` should be inferred in the evaluation=
 of
     + * `worktree add path/` or `worktree add -b branch path/` and emits a=
n error
    -+ * if the supplied arguments would produce an illegal combination  wh=
en the
    ++ * if the supplied arguments would produce an illegal combination whe=
n the
     + * `--orphan` flag is included.
     + *
     + * `opts` and `opt_track` contain the other options & flags supplied =
to the
    @@ t/t2400-worktree-add.sh: test_expect_success 'git worktree --no-gues=
s-remote opt
     +=09=09then
     +=09=09=09test_when_finished git -C repo worktree remove ../foo
     +=09=09fi &&
    -+=09=09if [ $use_cd -eq 1 ]
    -+=09=09then
    -+=09=09=09test_when_finished cat "$git_ns/actual" >&2
    -+=09=09else
    -+=09=09=09test_when_finished cat actual >&2
    -+=09=09fi &&
     +=09=09(
     +=09=09=09if [ $use_cd -eq 1 ]
     +=09=09=09then
8:  296226ffd5 =3D 8:  8c3fded12b worktree add: emit warn when there is a b=
ad HEAD
--=20
2.39.3


