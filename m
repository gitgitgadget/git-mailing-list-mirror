Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7D2C7EE23
	for <git@archiver.kernel.org>; Wed, 17 May 2023 21:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEQVtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 17:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjEQVs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 17:48:56 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA559EE
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:48:51 -0700 (PDT)
Date:   Wed, 17 May 2023 21:48:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1684360129; x=1684619329;
        bh=xb9vWYEGGATAkMFazVLJlInr+q/oIX5OhWkqeKiG6nA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=U0a0IXk4pY+yT0XVe81HxopZ2y+WGumrZCS/w6BAtvWKevdZrztaOTpn/GTarzv+R
         ZwBTcCcOj5K006s16dwmZhMttsa0yk15m+TJ1GnAJdlY8CUenNuv4TRB3jlnMuOMsc
         pESti675unezUZfKB61oR9subg5OjrApENmOvbg05sb7A21nLS4wfDV1fpZte+X5nB
         Vgkv42QvvCqe7tWRzGk9NpaWBptCEQKj1ZXyHHe6gDLPnBtN0TewHn27JcdzvUJYyI
         92yQYhIgtGC8ajM7UAGvFttQCtcmj742R4kYbgsvGqGIg5ZB2yq1iEx3U2PcFy3IwJ
         0YGjOmRUoj95g==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [RESEND PATCH v10 4/8] t2400: add tests to verify --quiet
Message-ID: <20230517214711.12467-5-jacobabel@nullpo.dev>
In-Reply-To: <20230517214711.12467-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <20230517214711.12467-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to verify that the command performs operations the same with
`--quiet` as without it. Additionally verifies that all non-fatal output
is suppressed.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 t/t2400-worktree-add.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 0ca3ec2022..841f15f59e 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -334,6 +334,13 @@ test_expect_success 'add --quiet' '
 =09test_must_be_empty actual
 '
=20
+test_expect_success 'add --quiet -b' '
+=09test_when_finished "git branch -D quietnewbranch" &&
+=09test_when_finished "git worktree remove -f -f another-worktree" &&
+=09git worktree add --quiet -b quietnewbranch another-worktree 2>actual &&
+=09test_must_be_empty actual
+'
+
 test_expect_success 'local clone from linked checkout' '
 =09git clone --local here here-clone &&
 =09( cd here-clone && git fsck )
@@ -532,6 +539,35 @@ test_expect_success 'git worktree add --guess-remote s=
ets up tracking' '
 =09=09test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
 =09)
 '
+test_expect_success 'git worktree add --guess-remote sets up tracking (qui=
et)' '
+=09test_when_finished rm -rf repo_a repo_b foo &&
+=09setup_remote_repo repo_a repo_b &&
+=09(
+=09=09cd repo_b &&
+=09=09git worktree add --quiet --guess-remote ../foo 2>actual &&
+=09=09test_must_be_empty actual
+=09) &&
+=09(
+=09=09cd foo &&
+=09=09test_branch_upstream foo repo_a foo &&
+=09=09test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+=09)
+'
+
+test_expect_success 'git worktree --no-guess-remote (quiet)' '
+=09test_when_finished rm -rf repo_a repo_b foo &&
+=09setup_remote_repo repo_a repo_b &&
+=09(
+=09=09cd repo_b &&
+=09=09git worktree add --quiet --no-guess-remote ../foo
+=09) &&
+=09(
+=09=09cd foo &&
+=09=09test_must_fail git config "branch.foo.remote" &&
+=09=09test_must_fail git config "branch.foo.merge" &&
+=09=09test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
+=09)
+'
=20
 test_expect_success 'git worktree add with worktree.guessRemote sets up tr=
acking' '
 =09test_when_finished rm -rf repo_a repo_b foo &&
--=20
2.39.3


