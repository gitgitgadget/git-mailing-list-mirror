Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D786BC4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 06:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiL2GjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 01:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiL2GjW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 01:39:22 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7460F3
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 22:38:52 -0800 (PST)
Date:   Thu, 29 Dec 2022 06:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1672295929; x=1672555129;
        bh=Ii8GtoaC2pbZNsVItsm2jP8SCrbFgEdwn6Rjo+7m3zY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=vCLqoqDQm3zykyToV6Zy7eZeN2QbkJkFJT1hyVBgA/BmJYGbJOSkex3IeFS012iZo
         4Lb9hPQLu/AnPC00+wiyTIoKYonBiqxlGb1nraNGi1362BIUaxHFHsSvOrKtt9/cM+
         wcwIH3ndLoRDeigJCzB1VgqneWwkABy23wHyP8koZWo5umXSi3RLL5utC6aHL+pI0u
         +/ybuWg1Dx/K11hmY+LBHP1WwQ1iMqr6/+zG4qeoQH71N712vSocpnRTDaOdcgbia+
         Hswu3eBEvcsrkNuxlWEZJhgbT1RIxB3cXdWMC5GPkBiqMzcrYRdHcbA8X+FJcJ/vLw
         QD8MLFwjwj+Yg==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 0/4] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221229063823.ij3jjuaar2fsayju@phi>
In-Reply-To: <221228.868risuf5x.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <221228.868risuf5x.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/28 09:01AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Wed, Dec 28 2022, Jacob Abel wrote:
>
> >   * Added save_param_arr() to preserve "$@" from being reset by
> >     test_expect_success() in test_wt_add_excl() (2/4).
> > [...]
> > 2:  3d8b26f9d6 ! 2:  c03c112f79 worktree add: refactor opt exclusion te=
sts
> >     @@ t/t2400-worktree-add.sh: test_expect_success '"add" no auto-vivi=
fy with --detach
> >      -test_expect_success '"add" -b/-B mutually exclusive' '
> >      -=09test_must_fail git worktree add -b poodle -B poodle bamboo mai=
n
> >      -'
> >     --
> >     ++# Saves parameter sequence/array as a string so they can be safel=
y stored in a
> >     ++# variable and restored with `eval "set -- $arr"`. Sourced from
> >     ++# https://stackoverflow.com/a/27503158/15064705
> >     ++save_param_arr () {
> >     ++=09local i
> >     ++=09for i;
> >     ++=09do
> >     ++=09=09# For each argument:
> >     ++=09=09# 1. Append "\n" after each entry
> >     ++=09=09# 2. Convert "'" into "'\''"
> >     ++=09=09# 3. Prepend "'" before each entry
> >     ++=09=09# 4. Append " \" after each entry
> >     ++=09=09printf "%s\\n" "$i" | sed "
> >     ++=09=09=09s/'/'\\\\''/g
> >     ++=09=09=091s/^/'/
> >     ++=09=09=09\$s/\$/' \\\\/
> >     ++=09=09"
> >     ++=09done
> >     ++=09echo " "
> >     ++}
> >     +
> > [...]
> >       ## Documentation/config/advice.txt ##
> >     @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree wit=
h orphan branch,
> >       =09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
> >       '
> >
> >     -+test_wt_add_empty_repo_orphan_hint() {
> >     ++test_wt_add_empty_repo_orphan_hint () {
> >      +=09local context=3D"$1"
> >      +=09shift
> >     -+=09local opts=3D"$@"
> >     ++=09local arr=3D$(save_param_arr "$@")
> >      +=09test_expect_success "'worktree add' show orphan hint in empty =
repo w/ $context" '
> >     ++=09=09eval "set -- $arr" &&
> >      +=09=09test_when_finished "rm -rf empty_repo" &&
> >      +=09=09GIT_DIR=3D"empty_repo" git init --bare &&
> >     -+=09=09test_must_fail git -C empty_repo worktree add $opts foobar/=
 2> actual &&
> >     ++=09=09test_must_fail git -C empty_repo worktree add "$@" foobar/ =
2> actual &&
> >      +=09=09grep "hint: If you meant to create a worktree containing a =
new orphan branch" actual
> >      +=09'
> >      +}
>
> The rest of this looks good to me, but this bit looks like you went down
> the rabbit hole of responding to Junio's feedback in
> https://lore.kernel.org/git/xmqqsfhawwqf.fsf@gitster.g/
>
> I think as we're not dealing with any quoted arguments here it's not
> worth copy/pasting some code to do shell quoting from StackOverflow,
> i.e. for this series this squashed at the tip passes all the tests:

Understood.

>
> =09diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> =09index f43de591173..e5b01583cf2 100755
> =09--- a/t/t2400-worktree-add.sh
> =09+++ b/t/t2400-worktree-add.sh
> =09@@ -298,33 +298,11 @@ test_expect_success '"add" no auto-vivify with -=
-detach and <branch> omitted' '
> =09 =09test_must_fail git -C mish/mash symbolic-ref HEAD
> =09 '
>
> =09-# Saves parameter sequence/array as a string so they can be safely st=
ored in a
> =09-# variable and restored with `eval "set -- $arr"`. Sourced from
> =09-# https://stackoverflow.com/a/27503158/15064705
> =09-save_param_arr () {
> =09-=09local i
> =09-=09for i;
> =09-=09do
> =09-=09=09# For each argument:
> =09-=09=09# 1. Append "\n" after each entry
> =09-=09=09# 2. Convert "'" into "'\''"
> =09-=09=09# 3. Prepend "'" before each entry
> =09-=09=09# 4. Append " \" after each entry
> =09-=09=09printf "%s\\n" "$i" | sed "
> =09-=09=09=09s/'/'\\\\''/g
> =09-=09=09=091s/^/'/
> =09-=09=09=09\$s/\$/' \\\\/
> =09-=09=09"
> =09-=09done
> =09-=09echo " "
> =09-}
> =09-
> =09 # Helper function to test mutually exclusive options.
> =09 test_wt_add_excl () {
> =09-=09local arr=3D$(save_param_arr "$@")
> =09-=09test_expect_success "'worktree add' with $* has mutually exclusive=
 options" '
> =09-=09=09eval "set -- $arr" &&
> =09-=09=09test_must_fail git worktree add "$@"
> =09+=09local args=3D"$@" &&
> =09+=09test_expect_success "'worktree add' with '$args' has mutually excl=
usive options" '
> =09+=09=09test_must_fail git worktree add $args
> =09 =09'
> =09 }
>
> =09@@ -398,21 +376,20 @@ test_expect_success '"add" worktree with orphan =
branch, lock, and reason' '
> =09 '
>
> =09 test_wt_add_empty_repo_orphan_hint () {
> =09-=09local context=3D"$1"
> =09-=09shift
> =09-=09local arr=3D$(save_param_arr "$@")
> =09+=09local context=3D"$1" &&
> =09+=09shift &&
> =09+=09local args=3D"$@" &&
> =09 =09test_expect_success "'worktree add' show orphan hint in empty repo=
 w/ $context" '
> =09-=09=09eval "set -- $arr" &&
> =09 =09=09test_when_finished "rm -rf empty_repo" &&
> =09 =09=09GIT_DIR=3D"empty_repo" git init --bare &&
> =09-=09=09test_must_fail git -C empty_repo worktree add "$@" foobar/ 2> a=
ctual &&
> =09+=09=09test_must_fail git -C empty_repo worktree add $args foobar/ 2> =
actual &&
> =09 =09=09grep "hint: If you meant to create a worktree containing a new =
orphan branch" actual
> =09 =09'
> =09 }
>
> =09-test_wt_add_empty_repo_orphan_hint 'DWIM'
> =09-test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch
> =09-test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch
> =09+test_wt_add_empty_repo_orphan_hint DWIM
> =09+test_wt_add_empty_repo_orphan_hint -b -b foobar_branch
> =09+test_wt_add_empty_repo_orphan_hint -B -B foobar_branch
>
> =09 test_expect_success 'local clone from linked checkout' '
> =09 =09git clone --local here here-clone &&
>
> Note also that you lost the &&-chaining.

Ah yes. Apologies. Fixed.

>
> If we do want to be slightly paranoid about it, doesn't just creating a:
>
> =09local args_str=3D"$*" &&
>
> And then using that in the description argument to test_expect_success()
> also address Junio's feedback, without the need for this quoting helper?

Below is what I have come up with while still not needing the
quoting helper. Could this work as an alternative?

It doesn't handle quotes properly without a bit of help from the
test author but it can handle them as long as you double escape the string.

The diff also includes slight tweaks to the tests themselves to better veri=
fy
the behavior.

Note: The two extra tests added in the diff wouldn't be in the next revisio=
n but they
are there to demonstrate that things work as expected with this change.

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index f43de59117..1d5843c956 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -298,36 +298,18 @@ test_expect_success '"add" no auto-vivify with --deta=
ch and <branch> omitted' '
 =09test_must_fail git -C mish/mash symbolic-ref HEAD
 '

-# Saves parameter sequence/array as a string so they can be safely stored =
in a
-# variable and restored with `eval "set -- $arr"`. Sourced from
-# https://stackoverflow.com/a/27503158/15064705
-save_param_arr () {
-=09local i
-=09for i;
-=09do
-=09=09# For each argument:
-=09=09# 1. Append "\n" after each entry
-=09=09# 2. Convert "'" into "'\''"
-=09=09# 3. Prepend "'" before each entry
-=09=09# 4. Append " \" after each entry
-=09=09printf "%s\\n" "$i" | sed "
-=09=09=09s/'/'\\\\''/g
-=09=09=091s/^/'/
-=09=09=09\$s/\$/' \\\\/
-=09=09"
-=09done
-=09echo " "
-}
-
 # Helper function to test mutually exclusive options.
+#
+# Note: Any arguments that contain spaces must be double and single quoted=
, ex:
+# test_wt_add_excl -b poodle --detach bamboo --lock --reason "'the reason'=
" main
 test_wt_add_excl () {
-=09local arr=3D$(save_param_arr "$@")
-=09test_expect_success "'worktree add' with $* has mutually exclusive opti=
ons" '
-=09=09eval "set -- $arr" &&
-=09=09test_must_fail git worktree add "$@"
-=09'
+=09test_expect_success "'worktree add' with $* has mutually exclusive opti=
ons" "
+=09=09test_must_fail git worktree add $* 2>actual &&
+=09=09grep -P 'fatal:( options)? .* cannot be used together' actual
+=09"
 }

+test_wt_add_excl -b poodle --detach bamboo --lock --reason "'the reason'" =
main
 test_wt_add_excl -b poodle -B poodle bamboo main
 test_wt_add_excl -b poodle --detach bamboo main
 test_wt_add_excl -B poodle --detach bamboo main
@@ -397,19 +379,22 @@ test_expect_success '"add" worktree with orphan branc=
h, lock, and reason' '
 =09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
 '

+# Note: Any arguments (except the first argument) that contain spaces must=
 be
+# double and single quoted, ex:
+# test_wt_add_empty_repo_orphan_hint 'the context' --lock --reason "'the r=
eason'"
 test_wt_add_empty_repo_orphan_hint () {
-=09local context=3D"$1"
-=09shift
-=09local arr=3D$(save_param_arr "$@")
-=09test_expect_success "'worktree add' show orphan hint in empty repo w/ $=
context" '
-=09=09eval "set -- $arr" &&
-=09=09test_when_finished "rm -rf empty_repo" &&
-=09=09GIT_DIR=3D"empty_repo" git init --bare &&
-=09=09test_must_fail git -C empty_repo worktree add "$@" foobar/ 2> actual=
 &&
-=09=09grep "hint: If you meant to create a worktree containing a new orpha=
n branch" actual
-=09'
+=09local context=3D"$1" &&
+=09shift &&
+=09test_expect_success "'worktree add' show orphan hint in empty repo w/ $=
context" "
+=09=09test_when_finished 'rm -rf empty_repo' &&
+=09=09GIT_DIR=3D'empty_repo' git init --bare &&
+=09=09test_must_fail git -C empty_repo worktree add $* foobar/ 2>actual &&
+=09=09! grep 'error: unknown switch' actual &&
+=09=09grep 'hint: If you meant to create a worktree containing a new orpha=
n branch' actual
+=09"
 }

+test_wt_add_empty_repo_orphan_hint 'the context' --lock --reason "'the rea=
son'"
 test_wt_add_empty_repo_orphan_hint 'DWIM'
 test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch
 test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch
--
2.38.2

And the results of running `cd t/ && sh ./t2400-worktree-add.sh -x -r 1,32,=
49`:

    Initialized empty Git repository in /path/to/git/repo/t/trash directory=
.t2400-worktree-add/.git/
    expecting success of 2400.1 'setup':
        test_commit init

    ++ test_commit init
    ++ local notick=3D
    ++ local echo=3Decho
    ++ local append=3D
    ++ local author=3D
    ++ local signoff=3D
    ++ local indir=3D
    ++ local tag=3Dlight
    ++ test 1 '!=3D' 0
    ++ case "$1" in
    ++ break
    ++ indir=3D
    ++ local file=3Dinit.t
    ++ test -n ''
    ++ echo init
    ++ git add -- init.t
    ++ test -z ''
    ++ test_tick
    ++ test -z ''
    ++ test_tick=3D1112911993
    ++ GIT_COMMITTER_DATE=3D'1112911993 -0700'
    ++ GIT_AUTHOR_DATE=3D'1112911993 -0700'
    ++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
    ++ git commit -m init
    [main (root-commit) 2519212] init
     Author: A U Thor <author@example.com>
     1 file changed, 1 insertion(+)
     create mode 100644 init.t
    ++ case "$tag" in
    ++ git tag init
    ok 1 - setup

    ok 2 # skip "add" an existing worktree (--run)

    ok 3 # skip "add" an existing empty worktree (--run)

    ok 4 # skip "add" using shorthand - fails when no previous branch (--ru=
n)

    ok 5 # skip "add" using - shorthand (--run)

    ok 6 # skip "add" refuses to checkout locked branch (--run)

    ok 7 # skip checking out paths not complaining about linked checkouts (=
--run)

    ok 8 # skip "add" worktree (--run)

    ok 9 # skip "add" worktree with lock (--run)

    ok 10 # skip "add" worktree with lock and reason (--run)

    ok 11 # skip "add" worktree with reason but no lock (--run)

    ok 12 # skip "add" worktree from a subdir (--run)

    ok 13 # skip "add" from a linked checkout (--run)

    ok 14 # skip "add" worktree creating new branch (--run)

    ok 15 # skip die the same branch is already checked out (--run)

    ok 16 # skip die the same branch is already checked out (symlink) (--ru=
n)

    ok 17 # skip not die the same branch is already checked out (--run)

    ok 18 # skip not die on re-checking out current branch (--run)

    ok 19 # skip "add" from a bare repo (--run)

    ok 20 # skip checkout from a bare repo without "add" (--run)

    ok 21 # skip "add" default branch of a bare repo (--run)

    ok 22 # skip "add" to bare repo with worktree config (--run)

    ok 23 # skip checkout with grafts (--run)

    ok 24 # skip "add" from relative HEAD (--run)

    ok 25 # skip "add -b" with <branch> omitted (--run)

    ok 26 # skip "add --detach" with <branch> omitted (--run)

    ok 27 # skip "add" with <branch> omitted (--run)

    ok 28 # skip "add" checks out existing branch of dwimd name (--run)

    ok 29 # skip "add <path>" dwim fails with checked out branch (--run)

    ok 30 # skip "add --force" with existing dwimd name doesnt die (--run)

    ok 31 # skip "add" no auto-vivify with --detach and <branch> omitted (-=
-run)

    expecting success of 2400.32 ''worktree add' with -b poodle --detach ba=
mboo --lock --reason 'the reason' main has mutually exclusive options':
            test_must_fail git worktree add -b poodle --detach bamboo --loc=
k --reason 'the reason' main 2>actual &&
            grep -P 'fatal:( options)? .* cannot be used together' actual

    ++ test_must_fail git worktree add -b poodle --detach bamboo --lock --r=
eason 'the reason' main
    ++ case "$1" in
    ++ _test_ok=3D
    ++ test_must_fail_acceptable git worktree add -b poodle --detach bamboo=
 --lock --reason 'the reason' main
    ++ test git =3D env
    ++ case "$1" in
    ++ return 0
    ++ git worktree add -b poodle --detach bamboo --lock --reason 'the reas=
on' main
    ++ exit_code=3D128
    ++ test 128 -eq 0
    ++ test_match_signal 13 128
    ++ test 128 =3D 141
    ++ test 128 =3D 269
    ++ return 1
    ++ test 128 -gt 129
    ++ test 128 -eq 127
    ++ test 128 -eq 126
    ++ return 0
    ++ grep -P 'fatal:( options)? .* cannot be used together' actual
    fatal: options '-b', '-B', and '--detach' cannot be used together
    ok 32 - 'worktree add' with -b poodle --detach bamboo --lock --reason '=
the reason' main has mutually exclusive options

    ok 33 # skip 'worktree add' with -b poodle -B poodle bamboo main has mu=
tually exclusive options (--run)

    ok 34 # skip 'worktree add' with -b poodle --detach bamboo main has mut=
ually exclusive options (--run)

    ok 35 # skip 'worktree add' with -B poodle --detach bamboo main has mut=
ually exclusive options (--run)

    ok 36 # skip 'worktree add' with -B poodle --orphan poodle bamboo has m=
utually exclusive options (--run)

    ok 37 # skip 'worktree add' with -b poodle --orphan poodle bamboo has m=
utually exclusive options (--run)

    ok 38 # skip 'worktree add' with --orphan poodle --detach bamboo has mu=
tually exclusive options (--run)

    ok 39 # skip 'worktree add' with --orphan poodle --no-checkout bamboo h=
as mutually exclusive options (--run)

    ok 40 # skip 'worktree add' with --orphan poodle bamboo main has mutual=
ly exclusive options (--run)

    ok 41 # skip "add -B" fails if the branch is checked out (--run)

    ok 42 # skip add -B (--run)

    ok 43 # skip add --quiet (--run)

    ok 44 # skip "add --orphan" (--run)

    ok 45 # skip "add --orphan" fails if the branch already exists (--run)

    ok 46 # skip "add --orphan" with empty repository (--run)

    ok 47 # skip "add" worktree with orphan branch and lock (--run)

    ok 48 # skip "add" worktree with orphan branch, lock, and reason (--run=
)

    expecting success of 2400.49 ''worktree add' show orphan hint in empty =
repo w/ the context':
            test_when_finished 'rm -rf empty_repo' &&
            GIT_DIR=3D'empty_repo' git init --bare &&
            test_must_fail git -C empty_repo worktree add --lock --reason '=
the reason' foobar/ 2>actual &&
            ! grep 'error: unknown switch' actual &&
            grep 'hint: If you meant to create a worktree containing a new =
orphan branch' actual

    ++ test_when_finished 'rm -rf empty_repo'
    ++ test 0 =3D 0
    ++ test_cleanup=3D'{ rm -rf empty_repo
            } && (exit "$eval_ret"); eval_ret=3D$?; :'
    ++ GIT_DIR=3Dempty_repo
    ++ git init --bare
    Initialized empty Git repository in /path/to/git/repo/t/trash directory=
.t2400-worktree-add/empty_repo/
    ++ test_must_fail git -C empty_repo worktree add --lock --reason 'the r=
eason' foobar/
    ++ case "$1" in
    ++ _test_ok=3D
    ++ test_must_fail_acceptable git -C empty_repo worktree add --lock --re=
ason 'the reason' foobar/
    ++ test git =3D env
    ++ case "$1" in
    ++ return 0
    ++ git -C empty_repo worktree add --lock --reason 'the reason' foobar/
    ++ exit_code=3D128
    ++ test 128 -eq 0
    ++ test_match_signal 13 128
    ++ test 128 =3D 141
    ++ test 128 =3D 269
    ++ return 1
    ++ test 128 -gt 129
    ++ test 128 -eq 127
    ++ test 128 -eq 126
    ++ return 0
    ++ grep 'error: unknown switch' actual
    ++ grep 'hint: If you meant to create a worktree containing a new orpha=
n branch' actual
    hint: If you meant to create a worktree containing a new orphan branch
    ++ rm -rf empty_repo
    ++ exit 0
    ++ eval_ret=3D0
    ++ :
    ok 49 - 'worktree add' show orphan hint in empty repo w/ the context

    ok 50 # skip 'worktree add' show orphan hint in empty repo w/ DWIM (--r=
un)

    ok 51 # skip 'worktree add' show orphan hint in empty repo w/ -b (--run=
)

    ok 52 # skip 'worktree add' show orphan hint in empty repo w/ -B (--run=
)

    ok 53 # skip local clone from linked checkout (--run)

    ok 54 # skip local clone --shared from linked checkout (--run)

    ok 55 # skip "add" worktree with --no-checkout (--run)

    ok 56 # skip "add" worktree with --checkout (--run)

    ok 57 # skip put a worktree under rebase (--run)

    ok 58 # skip add a worktree, checking out a rebased branch (--run)

    ok 59 # skip checking out a rebased branch from another worktree (--run=
)

    ok 60 # skip not allow to delete a branch under rebase (--run)

    ok 61 # skip rename a branch under rebase not allowed (--run)

    ok 62 # skip check out from current worktree branch ok (--run)

    ok 63 # skip checkout a branch under bisect (--run)

    ok 64 # skip rename a branch under bisect not allowed (--run)

    ok 65 # skip --track sets up tracking (--run)

    ok 66 # skip "add" <path> <remote/branch> w/ no HEAD (--run)

    ok 67 # skip --no-track avoids setting up tracking (--run)

    ok 68 # skip "add" <path> <non-existent-branch> fails (--run)

    ok 69 # skip "add" <path> <branch> dwims (--run)

    ok 70 # skip "add" <path> <branch> dwims with checkout.defaultRemote (-=
-run)

    ok 71 # skip git worktree add does not match remote (--run)

    ok 72 # skip git worktree add --guess-remote sets up tracking (--run)

    ok 73 # skip git worktree add with worktree.guessRemote sets up trackin=
g (--run)

    ok 74 # skip git worktree --no-guess-remote option overrides config (--=
run)

    ok 75 # skip "add" invokes post-checkout hook (branch) (--run)

    ok 76 # skip "add" invokes post-checkout hook (detached) (--run)

    ok 77 # skip "add --no-checkout" suppresses post-checkout hook (--run)

    ok 78 # skip "add" in other worktree invokes post-checkout hook (--run)

    ok 79 # skip "add" in bare repo invokes post-checkout hook (--run)

    ok 80 # skip "add" an existing but missing worktree (--run)

    ok 81 # skip "add" an existing locked but missing worktree (--run)

    ok 82 # skip "add" not tripped up by magic worktree matching" (--run)

    ok 83 # skip sanitize generated worktree name (--run)

    ok 84 # skip "add" should not fail because of another bad worktree (--r=
un)

    ok 85 # skip "add" with uninitialized submodule, with submodule.recurse=
 unset (--run)

    ok 86 # skip "add" with uninitialized submodule, with submodule.recurse=
 set (--run)

    ok 87 # skip "add" with initialized submodule, with submodule.recurse u=
nset (--run)

    ok 88 # skip "add" with initialized submodule, with submodule.recurse s=
et (--run)

    # passed all 88 test(s)
    1..88

