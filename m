Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC27DC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 21:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjEQVtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 17:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjEQVs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 17:48:56 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE3A618E
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:48:46 -0700 (PDT)
Date:   Wed, 17 May 2023 21:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1684360125; x=1684619325;
        bh=sDL6qZVbJu2MTU515KibqkPLV8c6UEqYUtQsnGXlCEo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=xai07QvZHxjk8/6YxpaI0rrsA8QNUn9q9498PMCuAs5uSEh6EllQXhSRmdrRhZFXf
         qEq2qCBKsEHT6tT62fL7B1GPZVoJciwEummF9ujabG1rkOSk0qI/W/JkEvJBil8IXA
         kcgSrbsP1bYDRFeGgJNQ9BVwVjZzEj5qwCqP1az/GWmlbBUFIsGCUpzywXpsFmlWHD
         ku9Ej29TVO4gUaPcctPeuWN1YNBV2+OWx4b9ZdPy6Z++rKFW62RVOUCpI/LBVoSOb+
         +8NM2oVbjYk6U2G0ugr5Fp1Wojprw+vHFJCxLbreBxRFsfPuPKfVHgSpg1xKAXExeF
         YGWbH1uPRhXDA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [RESEND PATCH v10 3/8] t2400: refactor "worktree add" opt exclusion tests
Message-ID: <20230517214711.12467-4-jacobabel@nullpo.dev>
In-Reply-To: <20230517214711.12467-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <20230517214711.12467-1-jacobabel@nullpo.dev>
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
=20
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
=20
-test_expect_success '"add" -B/--detach mutually exclusive' '
-=09test_must_fail git worktree add -B poodle --detach bamboo main
-'
+test_wt_add_excl -b poodle -B poodle bamboo main
+test_wt_add_excl -b poodle --detach bamboo main
+test_wt_add_excl -B poodle --detach bamboo main
=20
 test_expect_success '"add -B" fails if the branch is checked out' '
 =09git rev-parse newmain >before &&
--=20
2.39.3


