Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED234C46467
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 06:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiL1GRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 01:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiL1GRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 01:17:09 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20099580
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 22:17:08 -0800 (PST)
Date:   Wed, 28 Dec 2022 06:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1672208227; x=1672467427;
        bh=8rPykbAOvpEoHMH2nfi/GaajMnq1JeiJ3tN0aJOALeg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=fLxjOEpjdvn2Wp8BDmWPX9i0rudieutM6cHC/jvaXaL02wkg5PayNXVuGl9bs9Xo7
         lW7Ry6RWLMCtNW9ah8S3iAN4/m64C3W1rzkSmPFIjvPgL4QrUHnb25sg64cxKI7esh
         n34EAVwlYhERGUe8VBcrhqZcMtNhVy42EEQ42ZfpiB888E9nhp2XfUHCrM4xDku3UL
         A6n0Xx2Vpi8IsSuvFCYzGQPxmDEmEIyRsPrRlpiHi5/lVvnSTijTwy1qhTdCY07+QK
         Pgh9SJZw6CEoDpExL5Yg4RHh/dvCDwRuLA5WYPcxi8qHHrZcqYMvkAOTpKY2D89+Nq
         7Gbd7qWAbUbgQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v6 2/4] worktree add: refactor opt exclusion tests
Message-ID: <20221228061539.13740-3-jacobabel@nullpo.dev>
In-Reply-To: <20221228061539.13740-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pull duplicate test code into a function so that additional opt
combinations can be tested succinctly.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 t/t2400-worktree-add.sh | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..bfbf13d6a4 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -298,17 +298,39 @@ test_expect_success '"add" no auto-vivify with --deta=
ch and <branch> omitted' '
 =09test_must_fail git -C mish/mash symbolic-ref HEAD
 '

-test_expect_success '"add" -b/-B mutually exclusive' '
-=09test_must_fail git worktree add -b poodle -B poodle bamboo main
-'
+# Saves parameter sequence/array as a string so they can be safely stored =
in a
+# variable and restored with `eval "set -- $arr"`. Sourced from
+# https://stackoverflow.com/a/27503158/15064705
+save_param_arr () {
+=09local i
+=09for i;
+=09do
+=09=09# For each argument:
+=09=09# 1. Append "\n" after each entry
+=09=09# 2. Convert "'" into "'\''"
+=09=09# 3. Prepend "'" before each entry
+=09=09# 4. Append " \" after each entry
+=09=09printf "%s\\n" "$i" | sed "
+=09=09=09s/'/'\\\\''/g
+=09=09=091s/^/'/
+=09=09=09\$s/\$/' \\\\/
+=09=09"
+=09done
+=09echo " "
+}

-test_expect_success '"add" -b/--detach mutually exclusive' '
-=09test_must_fail git worktree add -b poodle --detach bamboo main
-'
+# Helper function to test mutually exclusive options.
+test_wt_add_excl () {
+=09local arr=3D$(save_param_arr "$@")
+=09test_expect_success "'worktree add' with $* has mutually exclusive opti=
ons" '
+=09=09eval "set -- $arr" &&
+=09=09test_must_fail git worktree add "$@"
+=09'
+}

-test_expect_success '"add" -B/--detach mutually exclusive' '
-=09test_must_fail git worktree add -B poodle --detach bamboo main
-'
+test_wt_add_excl -b poodle -B poodle bamboo main
+test_wt_add_excl -b poodle --detach bamboo main
+test_wt_add_excl -B poodle --detach bamboo main

 test_expect_success '"add -B" fails if the branch is checked out' '
 =09git rev-parse newmain >before &&
--
2.38.2


