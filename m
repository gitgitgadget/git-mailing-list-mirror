Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92153C001B2
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 02:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiLTCh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 21:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTChz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 21:37:55 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A18011A10
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 18:37:54 -0800 (PST)
Date:   Tue, 20 Dec 2022 02:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1671503872; x=1671763072;
        bh=faU8kScBoqh216ooqGRwQ5SXWm5kL5qnmX3EdUQPbFw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=r2tgELHegQu/atiet1N4l93BO9sG2ncHZ9CsNcizR8IvXnDu0i0yxV8ryn4t4oYBO
         gCt1wqdSV+8YFIBu7UgxOg/QspxWAlblk1TydQRQIAq1LS72Omr4WYoJWg+vpogQeC
         lnmiRPU4Gkffi0U+YE7CQytwyq2RjCTrhcOX6R92ScnoeDH4h57CnYpCyW86Ik2ago
         K+mWCn2JxNTiA1DEOU5a6PQmIR7AGIdDh4UGj/dK0ZhkySXblWLm1f1m+Dc45ZOqaU
         xsLlh1l/0ibz9cRrwaDEwtA0xVJrk208dzNYvHaRLhagkQusf6CpZboi6oCbyRz0+A
         Qcha78p28/EWA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v5 2/4] worktree add: refactor opt exclusion tests
Message-ID: <20221220023637.29042-3-jacobabel@nullpo.dev>
In-Reply-To: <20221220023637.29042-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev>
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
 t/t2400-worktree-add.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..f05e2483c2 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -298,17 +298,17 @@ test_expect_success '"add" no auto-vivify with --deta=
ch and <branch> omitted' '
 =09test_must_fail git -C mish/mash symbolic-ref HEAD
 '

-test_expect_success '"add" -b/-B mutually exclusive' '
-=09test_must_fail git worktree add -b poodle -B poodle bamboo main
-'
-
-test_expect_success '"add" -b/--detach mutually exclusive' '
-=09test_must_fail git worktree add -b poodle --detach bamboo main
-'
+# Helper function to test mutually exclusive options.
+test_wt_add_excl() {
+=09local opts=3D"$@" &&
+=09test_expect_success "'worktree add' with '$opts' has mutually exclusive=
 options" '
+=09=09test_must_fail git worktree add $opts
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


