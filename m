Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0216CC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKDBDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKDBDq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:03:46 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFDB205C7
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:03:44 -0700 (PDT)
Date:   Fri, 04 Nov 2022 01:03:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667523823; x=1667783023;
        bh=EI/jkfRC63yeLQKrPK+H8+GsFIazDcAz8WsdciEGfu4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=EgvIDJC7+lh9BHstXkBCeTz+Z+63uZJRVUOqNHYBD167PClQ490Lm4yO2I5ggZQaF
         mInQsQ0w/wX0M9c5sXQvLDSwZ0XZILYlHvycofaCvkLgrhT9TnXFx1RgmjxoNn66PK
         iu5nLBzTFAGFAaknOlJJ8yNwTGszyDfvTIV49824nTMA4l6tt371ROI1xgNcoM2E0K
         zM+jaqjNL2lkPY7i/ilGqwenVNfDgTMlFKOBS4nWDBMwhJSOhqLryqUAztxtW6VMUN
         oFPAwvObltCmIttwr2Ul22QEOXWNnp2zzfpVYFmQHg/wS5NWZMlci28rwnGMSVdhNY
         rm3yzsW8QZ5lg==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>
Subject: [PATCH 4/4] worktree add: Add unit tests for --orphan
Message-ID: <20221104010242.11555-5-jacobabel@nullpo.dev>
In-Reply-To: <20221104010242.11555-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 t/t2400-worktree-add.sh | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..064e1336e2 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -310,6 +310,26 @@ test_expect_success '"add" -B/--detach mutually exclus=
ive' '
 =09test_must_fail git worktree add -B poodle --detach bamboo main
 '

+test_expect_success '"add" --orphan/-b mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle -b poodle bamboo main
+'
+
+test_expect_success '"add" --orphan/-B mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle -B poodle bamboo main
+'
+
+test_expect_success '"add" --orphan/--detach mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle --detach bamboo main
+'
+
+test_expect_success '"add" --orphan/--no-checkout mutually exclusive' '
+=09test_must_fail git worktree add --orphan poodle --no-checkout bamboo ma=
in
+'
+
+test_expect_success '"add" -B/--detach mutually exclusive' '
+=09test_must_fail git worktree add -B poodle --detach bamboo main
+'
+
 test_expect_success '"add -B" fails if the branch is checked out' '
 =09git rev-parse newmain >before &&
 =09test_must_fail git worktree add -B newmain bamboo main &&
@@ -330,6 +350,40 @@ test_expect_success 'add --quiet' '
 =09test_must_be_empty actual
 '

+test_expect_success '"add --orphan"' '
+=09git worktree add --orphan neworphan orphandir main &&
+=09git -C orphandir symbolic-ref HEAD >actual &&
+=09echo refs/heads/neworphan >expected &&
+=09test_cmp expected actual &&
+=09(
+=09=09cd orphandir &&
+=09=09git diff main
+=09)
+'
+
+test_expect_success '"add --orphan" fails if the branch already exists' '
+=09git worktree add -b existingbranch orphandir2 main &&
+=09test_must_fail git worktree add --orphan existingbranch orphandir3 main=
 &&
+=09[ ! -d orphandir3 ]
+'
+
+test_expect_success '"add --orphan" fails if the commit-ish doesnt exist' =
'
+=09test_must_fail git worktree add --orphan badcommitish orphandir4 eee222=
2 &&
+=09[ ! -d orphandir4 ]
+'
+
+test_expect_success '"add --orphan" with empty repository' '
+=09(
+=09=09mkdir emptyorphanrepo &&
+=09=09cd emptyorphanrepo &&
+=09=09GIT_DIR=3D".git" git init --bare &&
+=09=09git worktree add --orphan newbranch worktreedir &&
+=09=09git -C worktreedir symbolic-ref HEAD >actual &&
+=09=09echo refs/heads/newbranch >expected &&
+=09=09test_cmp expected actual
+=09)
+'
+
 test_expect_success 'local clone from linked checkout' '
 =09git clone --local here here-clone &&
 =09( cd here-clone && git fsck )
--
2.37.4


