Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51785C54EBE
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 04:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjAGE7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 23:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAGE7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 23:59:04 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E13D714B8
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 20:59:03 -0800 (PST)
Date:   Sat, 07 Jan 2023 04:58:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673067541; x=1673326741;
        bh=Vy572uiiUTG6Qr7ICvyribkYlnzAuwJOz8LPaqOunk4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZbnrfatY1Dnf+xBLdObBpOfVmD8FyvQg3vgNqKNuFp4aqjQngf7oXZ9p4yAUF9MrC
         YrTsybsOx0RQUk98frqEvMAGEw9e2H5rxypIEe/Ok2CrjC2CNpdLXVPnmnxLbQSk8R
         iRGLxjBkPhT5sQB+KwwHZjZ/wypDXb8YFH7X8DoBL2jUDrezWjmKmYTWpvsjWFli8u
         /n0DM0QdhrPgV7qDBZlAUaVbj07oYB2NTPom0yyX4mOGXLB2nBV/69hyuQJt8EtddR
         Yr2BEPFYYHqH76Jm7qPDHLo5eDdOxSzmWsRioF10GwBTYwXhcAxBzva/+f7kmKMmWD
         WDMG5ZeVF7fWg==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v7 0/4] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20230107045757.30037-1-jacobabel@nullpo.dev>
In-Reply-To: <20221228061539.13740-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev>
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

Changes from v6:
  * Removed helper save_param_arr() introduced in v6 from t2400 (2/4) [2].
  * Reverted changes introduced in v6 to test_wt_add_excl() from t2400 (2/4=
) [3].
  * Changed test_wt_add_excl() to use `local opts=3D"$*"` (2/4) [3].
  * Added check to test_wt_add_excl() to better validate test results (2/4)=
.
  * Re-add &&-chains to test_wt_add_excl() (2/4) [4].
  * Reverted changes introduced in v6 to test_wt_add_empty_repo_orphan_hint=
()
    from t2400 (4/4) [3].
  * Changed test_wt_add_empty_repo_orphan_hint() to use `local opts=3D"$*"`=
 (4/4) [3].
  * Added check to test_wt_add_empty_repo_orphan_hint() to better validate =
test
    results (4/4).
  * Re-add &&-chains to test_wt_add_empty_repo_orphan_hint() (2/4) [4].

1. https://stackoverflow.com/a/68717229/15064705/
2. https://lore.kernel.org/git/xmqq5ydvpu1o.fsf@gitster.g/
3. https://lore.kernel.org/git/xmqqo7rbsuyh.fsf@gitster.g/
4. https://lore.kernel.org/git/221228.868risuf5x.gmgdl@evledraar.gmail.com/

Jacob Abel (4):
  worktree add: include -B in usage docs
  worktree add: refactor opt exclusion tests
  worktree add: add --orphan flag
  worktree add: add hint to direct users towards --orphan

 Documentation/config/advice.txt |  4 ++
 Documentation/git-worktree.txt  | 17 +++++-
 advice.c                        |  1 +
 advice.h                        |  1 +
 builtin/worktree.c              | 65 ++++++++++++++++++++---
 t/t2400-worktree-add.sh         | 94 +++++++++++++++++++++++++++++----
 6 files changed, 164 insertions(+), 18 deletions(-)

Range-diff against v6:
1:  a9ef3eca7b =3D 1:  a9ef3eca7b worktree add: include -B in usage docs
2:  c03c112f79 ! 2:  d124cc481c worktree add: refactor opt exclusion tests
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" no auto-vivify w=
ith --detach
     -test_expect_success '"add" -b/-B mutually exclusive' '
     -=09test_must_fail git worktree add -b poodle -B poodle bamboo main
     -'
    -+# Saves parameter sequence/array as a string so they can be safely st=
ored in a
    -+# variable and restored with `eval "set -- $arr"`. Sourced from
    -+# https://stackoverflow.com/a/27503158/15064705
    -+save_param_arr () {
    -+=09local i
    -+=09for i;
    -+=09do
    -+=09=09# For each argument:
    -+=09=09# 1. Append "\n" after each entry
    -+=09=09# 2. Convert "'" into "'\''"
    -+=09=09# 3. Prepend "'" before each entry
    -+=09=09# 4. Append " \" after each entry
    -+=09=09printf "%s\\n" "$i" | sed "
    -+=09=09=09s/'/'\\\\''/g
    -+=09=09=091s/^/'/
    -+=09=09=09\$s/\$/' \\\\/
    -+=09=09"
    -+=09done
    -+=09echo " "
    -+}
    -
    +-
     -test_expect_success '"add" -b/--detach mutually exclusive' '
     -=09test_must_fail git worktree add -b poodle --detach bamboo main
     -'
     +# Helper function to test mutually exclusive options.
    ++#
    ++# Note: Quoted arguments containing spaces are not supported.
     +test_wt_add_excl () {
    -+=09local arr=3D$(save_param_arr "$@")
    -+=09test_expect_success "'worktree add' with $* has mutually exclusive=
 options" '
    -+=09=09eval "set -- $arr" &&
    -+=09=09test_must_fail git worktree add "$@"
    ++=09local opts=3D"$*" &&
    ++=09test_expect_success "'worktree add' with '$opts' has mutually excl=
usive options" '
    ++=09=09test_must_fail git worktree add $opts 2>actual &&
    ++=09=09grep -P "fatal:( options)? .* cannot be used together" actual
     +=09'
     +}

3:  9b93e2493a =3D 3:  b66ea4d309 worktree add: add --orphan flag
4:  737fca6986 ! 4:  b779606121 worktree add: add hint to direct users towa=
rds --orphan
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree with or=
phan branch,
      =09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
      '

    ++# Note: Quoted arguments containing spaces are not supported.
     +test_wt_add_empty_repo_orphan_hint () {
    -+=09local context=3D"$1"
    -+=09shift
    -+=09local arr=3D$(save_param_arr "$@")
    ++=09local context=3D"$1" &&
    ++=09shift &&
    ++=09local opts=3D"$*" &&
     +=09test_expect_success "'worktree add' show orphan hint in empty repo=
 w/ $context" '
    -+=09=09eval "set -- $arr" &&
     +=09=09test_when_finished "rm -rf empty_repo" &&
     +=09=09GIT_DIR=3D"empty_repo" git init --bare &&
    -+=09=09test_must_fail git -C empty_repo worktree add "$@" foobar/ 2> a=
ctual &&
    ++=09=09test_must_fail git -C empty_repo worktree add $opts foobar/ 2>a=
ctual &&
    ++=09=09! grep "error: unknown switch" actual &&
     +=09=09grep "hint: If you meant to create a worktree containing a new =
orphan branch" actual
     +=09'
     +}
--
2.38.2


