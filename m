Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD4C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjDQJgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjDQJgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:36:33 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7501A5270
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:35:50 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:33:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681724042; x=1681983242;
        bh=P1xg6yj8okoWGv7OpoeTO1kuEztET7PfgyrR1Rgs4c0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=BY+p422M3Rcoyzo0TE0LCq7sEQOaLEYrP7bftROnVvU5EBIJseqpFR0eNh9gDwNOj
         PtQmWjdQF+1eizmel29zsN9IJGiZ77eDpwrRXVkbrKbaYXm65LTYt/tTuV1fT9d7+O
         qpCPHACdD0e+MDIbAez5ejYAqAAwf/bRGQmus5LIGXFilNrBbCDZAXM3uvsdu/Z8dx
         4iimPRxKmBXzAnzBQjOG1RGwHd4jQzBQnKSq/I9sZ4B+1KqAHu+BCwDHmDQ6BuhEiA
         hy7KtM7ZQWFRAyt7pNuIXRnKslUSf/p/Esd8HNqCB/HhXBfhXNG6HqJgx0i5gZhU+4
         HW+PT0Ra95mFg==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v9 3/8] t2400: refactor "worktree add" opt exclusion tests
Message-ID: <20230417093255.31079-4-jacobabel@nullpo.dev>
In-Reply-To: <20230417093255.31079-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
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
 t/t2400-worktree-add.sh | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 9bc3db20e4..6822be4666 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -298,17 +298,21 @@ test_expect_success '"add" no auto-vivify with --deta=
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
+=09=09test_when_finished cat actual >&2 &&
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
2.39.2


