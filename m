Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD24DC77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 12:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjEGMGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 08:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjEGMGr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 08:06:47 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2049132AC
        for <git@vger.kernel.org>; Sun,  7 May 2023 05:06:42 -0700 (PDT)
Date:   Sun, 07 May 2023 12:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1683461201; x=1683720401;
        bh=4nVEPKu2DssMn0Q2fVQT3c0kVmSWBAPoYcTqC5AH4YI=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=jdCZw2l4W5w1lICpFBD6aXhJMbq8qkKlOccAPFTEiCjf3fSYFjxoamYsFn19kvplE
         PHlarrQl99q//FrU6IMpfmjt7PpbJPjQtO71eB5MX8Goglsv73Ry5wuBE5SJqQOQxj
         zYxZLgd2Uno7fU4Dczr4hnVncKgeqUXeibyAIX2Idk4ifEJPINpNsglZtWblG2KIJs
         gULeBglax9egi0vAnw/IJzNEp7w2z0HWOXARQSAT14vbZX8Cd2dFkV5c+yoaMjO4tb
         E9bDXouewX2dr88ip6i3Cb+ueNULoVQxrrOGjcwzA5T5Cds7oTnmE72iaSTF9QD+Ks
         oDLS1V0nyvFGw==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v10 3/8] t2400: refactor "worktree add" opt exclusion tests
Message-ID: <20230507120530.14669-4-jacobabel@nullpo.dev>
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
 t/t2400-worktree-add.sh | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index a3f108347a..0ca3ec2022 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -298,17 +298,20 @@ test_expect_success '"add" no auto-vivify with --deta=
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
+#
+# Note: Quoted arguments containing spaces are not supported.
+test_wt_add_excl () {
+=09local opts=3D"$*" &&
+=09test_expect_success "'worktree add' with '$opts' has mutually exclusive=
 options" '
+=09=09test_must_fail git worktree add $opts 2>actual &&
+=09=09grep -E "fatal:( options)? .* cannot be used together" actual
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
2.39.3


