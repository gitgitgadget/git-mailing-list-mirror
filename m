Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19618C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 17:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjAIRdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjAIRcs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 12:32:48 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3242F4
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 09:32:46 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:32:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673285565; x=1673544765;
        bh=79l3LjIsNwC94lJDY6yEux3C2rX5+dJjOrDymDDFcrc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ohz9rH3PCo//4sjgdcMQH+x96GsvrHxoavFYuNHABRZTC8ZJpcHncGI4I3SEUKois
         Dr4PdeikZI9luS5dpcqmfWn7UwfRJQnE2SwULiuovc3ywZOTycCHNcKj2tWx38bURU
         j8XpK5rBa3mT4wzJG4QKStfWNzVcZXTJFpyiLGffLARPeE8piOQmtpTDQdWF4Yj11P
         Vm+0hctaSUDrR8JZpHDotWOsXRichiDSgnGdLUhJJ1jikYzvjefOtY0qQwyLY9RV1y
         /tXEnqelZc8SZpKoMcm3cj1Dr3Sht83FNovknYcZjfUSCXXdWS+c6f47fYntO2R9UI
         LY/KCn1HKDJ5A==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v8 0/4] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20230109173227.29264-1-jacobabel@nullpo.dev>
In-Reply-To: <20230107045757.30037-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev>
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

Changes from v7:
  * Changed test_wt_add_excl() to use `grep -E` instead of `grep -P` (2/4) =
[2][3].

1. https://stackoverflow.com/a/68717229/15064705/
2. https://lore.kernel.org/git/xmqq7cxxzefp.fsf@gitster.g/
3. https://lore.kernel.org/git/230109.86r0w328nu.gmgdl@evledraar.gmail.com/

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

Range-diff against v7:
1:  a9ef3eca7b =3D 1:  a9ef3eca7b worktree add: include -B in usage docs
2:  d124cc481c ! 2:  4b447a597c worktree add: refactor opt exclusion tests
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" no auto-vivify w=
ith --detach
     +=09local opts=3D"$*" &&
     +=09test_expect_success "'worktree add' with '$opts' has mutually excl=
usive options" '
     +=09=09test_must_fail git worktree add $opts 2>actual &&
    -+=09=09grep -P "fatal:( options)? .* cannot be used together" actual
    ++=09=09grep -E "fatal:( options)? .* cannot be used together" actual
     +=09'
     +}

3:  b66ea4d309 =3D 3:  7574f425f4 worktree add: add --orphan flag
4:  b779606121 =3D 4:  31ae93ba7a worktree add: add hint to direct users to=
wards --orphan
--
2.38.2


