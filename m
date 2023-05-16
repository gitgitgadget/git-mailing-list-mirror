Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6016C7EE22
	for <git@archiver.kernel.org>; Tue, 16 May 2023 02:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjEPCbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 22:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEPCbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 22:31:46 -0400
X-Greylist: delayed 291 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 19:31:45 PDT
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C165B80
        for <git@vger.kernel.org>; Mon, 15 May 2023 19:31:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B25D81892F4;
        Mon, 15 May 2023 22:26:54 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=rg1AOqOhOniL3BZVuPT58cf6Z
        Jeui0IMuVHMA57nwpQ=; b=hc5h8Nes5dDzE4vavN1PuQQou3OOBA22QRW8l0osi
        EvEX1xL3bvm3eacJPAaIQPDcbyB0N7OMI1UoUSIm1btyihRPDossdx4I73QL+jT4
        BJg5yJK/8zJWIH7QbWLheTn7rsDkcBlxHNWgNHA8bwqIxIHIZEwzR2ivvm0L+oxp
        eE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB2C31892F3;
        Mon, 15 May 2023 22:26:54 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 216341892F2;
        Mon, 15 May 2023 22:26:54 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] test: do not negate test_path_is_* to assert absense
Date:   Mon, 15 May 2023 19:26:46 -0700
Message-ID: <20230516022646.648123-4-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-rc0
In-Reply-To: <20230516022646.648123-1-gitster@pobox.com>
References: <20230516022646.648123-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 1F6EA760-F391-11ED-BF3E-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests use "! test_path_is_dir" or "! test_path_is_file" to
ensure that the path is not recursively checked out or "submodule
update" did not touch the working tree.

Use "test_path_is_missing" to assert that the path does not exist,
instead of negating test_path_is_* helpers; they are designed to be
loud in wrong occasions.  Besides, negating "test_path_is_dir" would
mean we would be happy if a file exists there, which is not the case
for these tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-submodule-update.sh | 2 +-
 t/t5572-pull-submodule.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index dee14992c5..9acb0d5d19 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -802,7 +802,7 @@ test_submodule_recursing_with_args_common () {
 			git branch -t no_submodule origin/no_submodule &&
 			$command no_submodule &&
 			test_superproject_content origin/no_submodule &&
-			! test_path_is_dir sub1 &&
+			test_path_is_missing sub1 &&
 			test_must_fail git config -f .git/modules/sub1/config core.worktree &=
&
 			test_must_fail git config -f .git/modules/sub1/modules/sub2/config co=
re.worktree
 		)
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 09097eff3f..4e917bf87d 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -121,7 +121,7 @@ test_expect_success "fetch.recurseSubmodules option t=
riggers recursive fetch (bu
 	sub_oid=3D$(git -C child rev-parse HEAD) &&
 	git -C super/sub cat-file -e $sub_oid &&
 	# Check that the submodule worktree did not update
-	! test_path_is_file super/sub/merge_strategy_5.t
+	test_path_is_missing super/sub/merge_strategy_5.t
 '
=20
 test_expect_success "fetch.recurseSubmodules takes precedence over submo=
dule.recurse" '
@@ -134,7 +134,7 @@ test_expect_success "fetch.recurseSubmodules takes pr=
ecedence over submodule.rec
 	sub_oid=3D$(git -C child rev-parse HEAD) &&
 	git -C super/sub cat-file -e $sub_oid &&
 	# Check that the submodule worktree did not update
-	! test_path_is_file super/sub/merge_strategy_6.t
+	test_path_is_missing super/sub/merge_strategy_6.t
 '
=20
 test_expect_success 'pull --rebase --recurse-submodules (remote superpro=
ject submodule changes, local submodule changes)' '
--=20
2.41.0-rc0

