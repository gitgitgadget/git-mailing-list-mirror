Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34BFC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 19:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244227AbiESTAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 15:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244228AbiESTAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 15:00:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E28AE267
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:59:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4ED37193833;
        Thu, 19 May 2022 14:59:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=xYcueuXMFUY4rHANsbS6MJT16BtZyPgrfqRWtMkIJEA=; b=fT1DdJZqn+TX
        +Csgynu4GYKyQ8hmd0MfvZevGPKuCmSCPMmC0eZAPYQoWNEAmgZo5UNmscWYDjm9
        W/s0Q/+7exPy8ElTYwBes/4R9vgPqqCtf317+zkTB0OGlnkXBmO67g7w7nIWe1oT
        iQu0AziVPtMLQNx8hgkJUahndy6xOF0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47796193832;
        Thu, 19 May 2022 14:59:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E0E36193831;
        Thu, 19 May 2022 14:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] t6424: make sure a failed merge preserves local changes
cc:     Elijah Newren <newren@gmail.com>
Date:   Thu, 19 May 2022 11:59:53 -0700
Message-ID: <xmqqbkvtnyae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DECF589C-D7A5-11EC-A9C7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do make sure that an attempt to merge with various forms of local
changes will "fail", but the point of stopping the merge is so that
we refrain from discarding uncommitted local changes that could be
precious.  Add a few more checks for each case to make sure the
local changes are left intact.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * A recent "should failing 'git merge' clean the mess _it_
   created?" topic was over-eager to clean _all_ local changes, but
   we didn't seem to have any test to protect against such breakage.

 t/t6424-merge-unrelated-index-changes.sh | 32 ++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 89dd544f38..b6e424a427 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -71,7 +71,9 @@ test_expect_success 'ff update' '
 	git merge E^0 &&
 
 	test_must_fail git rev-parse HEAD:random_file &&
-	test "$(git diff --name-only --cached E)" = "random_file"
+	test "$(git diff --name-only --cached E)" = "random_file" &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file
 '
 
 test_expect_success 'ff update, important file modified' '
@@ -83,6 +85,8 @@ test_expect_success 'ff update, important file modified' '
 	git add subdir/e &&
 
 	test_must_fail git merge E^0 &&
+	test_path_is_file subdir/e &&
+	git rev-parse --verify :subdir/e &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -93,6 +97,8 @@ test_expect_success 'resolve, trivial' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge -s resolve C^0 &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -103,6 +109,8 @@ test_expect_success 'resolve, non-trivial' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge -s resolve D^0 &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -113,6 +121,8 @@ test_expect_success 'recursive' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge -s recursive C^0 &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -145,9 +155,12 @@ test_expect_success 'recursive, when file has staged changes not matching HEAD n
 	mkdir subdir &&
 	test_seq 1 10 >subdir/a &&
 	git add subdir/a &&
+	git rev-parse --verify :subdir/a >expect &&
 
 	# We have staged changes; merge should error out
 	test_must_fail git merge -s recursive E^0 2>err &&
+	git rev-parse --verify :subdir/a >actual &&
+	test_cmp expect actual &&
 	test_i18ngrep "changes to the following files would be overwritten" err
 '
 
@@ -158,9 +171,12 @@ test_expect_success 'recursive, when file has staged changes matching what a mer
 	mkdir subdir &&
 	test_seq 1 11 >subdir/a &&
 	git add subdir/a &&
+	git rev-parse --verify :subdir/a >expect &&
 
 	# We have staged changes; merge should error out
 	test_must_fail git merge -s recursive E^0 2>err &&
+	git rev-parse --verify :subdir/a >actual &&
+	test_cmp expect actual &&
 	test_i18ngrep "changes to the following files would be overwritten" err
 '
 
@@ -171,7 +187,9 @@ test_expect_success 'octopus, unrelated file touched' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge C^0 D^0 &&
-	test_path_is_missing .git/MERGE_HEAD
+	test_path_is_missing .git/MERGE_HEAD &&
+	git rev-parse --verify :random_file &&
+	test_path_exists random_file
 '
 
 test_expect_success 'octopus, related file removed' '
@@ -181,6 +199,8 @@ test_expect_success 'octopus, related file removed' '
 	git rm b &&
 
 	test_must_fail git merge C^0 D^0 &&
+	test_path_is_missing b &&
+	test_must_fail git rev-parse --verify :b &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -189,8 +209,12 @@ test_expect_success 'octopus, related file modified' '
 	git checkout B^0 &&
 
 	echo 12 >>a && git add a &&
+	git rev-parse --verify :a >expect &&
 
 	test_must_fail git merge C^0 D^0 &&
+	test_path_is_file a &&
+	git rev-parse --verify :a >actual &&
+	test_cmp expect actual &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -201,6 +225,8 @@ test_expect_success 'ours' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge -s ours C^0 &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -211,6 +237,8 @@ test_expect_success 'subtree' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge -s subtree E^0 &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
-- 
2.36.1-387-g2cf831bf19

