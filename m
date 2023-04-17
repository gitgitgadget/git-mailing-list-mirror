Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598FFC77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDQJgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjDQJfx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:35:53 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE5035A4
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:35:14 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681724054; x=1681983254;
        bh=aBiVHdDsHi7BmU3F2GCbI/dj6+93w9h45avpchtYU7U=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=gfPf/2UZG/5ztCCfEDpyia4HBquwrihJULLtJA52E1ZcCE54AMAr18cjMqdWYxwrf
         HxKgU7hdY7wIYtOLl/io9a1QuRkpJE69k24U7ekHAPuUJ0plF040yvIZfGCv4mEcAc
         /Yc4bRcacyCqTzacltn0cEGljU09D4qoav0ijejVhALWUyQTbE7NFdZ2zeJ+fo9Cuw
         C9mwlQ4CmS4e3/oQEVpNASK1MnmtsxFB8HOmM4AQ5ZhGxEMsMdloSFW2PpQkMQZtsw
         6jT5aUQ+xGfWiLylyhZeGfSA9Z4W0wfKFIrikVKKnzW69NjqHwg/jh4u/7nLYIYxnM
         t8EBui43dlT/g==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v9 4/8] t2400: add tests to verify --quiet
Message-ID: <20230417093255.31079-5-jacobabel@nullpo.dev>
In-Reply-To: <20230417093255.31079-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
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
 t/t2400-worktree-add.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 6822be4666..18831c4d93 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -336,6 +336,14 @@ test_expect_success 'add --quiet' '
 =09test_must_be_empty actual
 '

+test_expect_success 'add --quiet -b' '
+=09test_when_finished "git branch -D quietnewbranch" &&
+=09test_when_finished "git worktree remove -f -f another-worktree" &&
+=09test_when_finished cat actual >&2 &&
+=09git worktree add --quiet -b quietnewbranch another-worktree 2>actual &&
+=09test_must_be_empty actual
+'
+
 test_expect_success 'local clone from linked checkout' '
 =09git clone --local here here-clone &&
 =09( cd here-clone && git fsck )
@@ -534,6 +542,36 @@ test_expect_success 'git worktree add --guess-remote s=
ets up tracking' '
 =09=09test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
 =09)
 '
+test_expect_success 'git worktree add --guess-remote sets up tracking (qui=
et)' '
+=09test_when_finished rm -rf repo_a repo_b foo &&
+=09test_when_finished cat repo_b/actual >&2 &&
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

 test_expect_success 'git worktree add with worktree.guessRemote sets up tr=
acking' '
 =09test_when_finished rm -rf repo_a repo_b foo &&
--
2.39.2


