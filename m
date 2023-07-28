Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EF5EB64DD
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 22:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjG1WHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjG1WHn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 18:07:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CCDE48
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 15:07:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DA202BBE9;
        Fri, 28 Jul 2023 18:07:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JrrqiA+K24t54hwBT9EI0Z74SCQOjR79M/70R2
        sAzww=; b=vqJ0AI646M/XhHmeOIujg6QZ+njleAnuRW9HQjPuHAQ9ZNiIifkgiV
        mkxNXiRflk8gu6IxdEpXCDR2h9OzTn2OoisU6e826+A9pI+gGejTVXo/18zP8Wx2
        5IkIBS/RnleZO0zpM8r/rYmwgXsejWI67ftJIvd9W1D87d9x+wWZk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27ADC2BBE8;
        Fri, 28 Jul 2023 18:07:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B23E52BBE7;
        Fri, 28 Jul 2023 18:07:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] checkout/restore: add basic tests for --merge
References: <xmqqedkr4rod.fsf@gitster.g>
Date:   Fri, 28 Jul 2023 15:07:37 -0700
In-Reply-To: <xmqqedkr4rod.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        28 Jul 2023 15:06:26 -0700")
Message-ID: <xmqq7cqj4rme.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A41AA3E-2D93-11EE-8F4B-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though "checkout --merge -- paths" had some tests, we never
made sure it worked to recreate the conflicted state _after_ the
resolution was recorded in the index.  Also "restore --merge" did
not even have any tests.

Currently these commands use the unmerge_marked_index() interface
that cannot handle paths that have been resolved as removal, and
tests for that case are marked with test_expect_failure; these
should eventually be fixed, but not in this patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2070-restore.sh | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t7201-co.sh      | 42 ++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index fd775807e7..d97ecc2483 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -137,6 +137,70 @@ test_expect_success 'restore --staged invalidates cache tree for deletions' '
 	test_must_fail git rev-parse HEAD:new1
 '
 
+test_expect_success 'restore --merge to unresolve' '
+	O=$(echo original | git hash-object -w --stdin) &&
+	A=$(echo ourside | git hash-object -w --stdin) &&
+	B=$(echo theirside | git hash-object -w --stdin) &&
+	{
+		echo "100644 $O 1	file" &&
+		echo "100644 $A 2	file" &&
+		echo "100644 $B 3	file"
+	} | git update-index --index-info &&
+	echo nothing >file &&
+	git restore --worktree --merge file &&
+	cat >expect <<-\EOF &&
+	<<<<<<< ours
+	ourside
+	=======
+	theirside
+	>>>>>>> theirs
+	EOF
+	test_cmp expect file
+'
+
+test_expect_success 'restore --merge to unresolve after (mistaken) resolution' '
+	O=$(echo original | git hash-object -w --stdin) &&
+	A=$(echo ourside | git hash-object -w --stdin) &&
+	B=$(echo theirside | git hash-object -w --stdin) &&
+	{
+		echo "100644 $O 1	file" &&
+		echo "100644 $A 2	file" &&
+		echo "100644 $B 3	file"
+	} | git update-index --index-info &&
+	echo nothing >file &&
+	git add file &&
+	git restore --worktree --merge file &&
+	cat >expect <<-\EOF &&
+	<<<<<<< ours
+	ourside
+	=======
+	theirside
+	>>>>>>> theirs
+	EOF
+	test_cmp expect file
+'
+
+test_expect_failure 'restore --merge to unresolve after (mistaken) resolution' '
+	O=$(echo original | git hash-object -w --stdin) &&
+	A=$(echo ourside | git hash-object -w --stdin) &&
+	B=$(echo theirside | git hash-object -w --stdin) &&
+	{
+		echo "100644 $O 1	file" &&
+		echo "100644 $A 2	file" &&
+		echo "100644 $B 3	file"
+	} | git update-index --index-info &&
+	git rm -f file &&
+	git restore --worktree --merge file &&
+	cat >expect <<-\EOF &&
+	<<<<<<< ours
+	ourside
+	=======
+	theirside
+	>>>>>>> theirs
+	EOF
+	test_cmp expect file
+'
+
 test_expect_success 'restore with merge options are incompatible with certain options' '
 	for opts in \
 		"--staged --ours" \
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 23d4dadbcc..4b07a26c14 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -522,6 +522,48 @@ test_expect_success 'checkout with --merge' '
 	test_cmp merged file
 '
 
+test_expect_success 'checkout -m works after (mistaken) resolution' '
+	setup_conflicting_index &&
+	echo "none of the above" >sample &&
+	cat sample >fild &&
+	cat sample >file &&
+	cat sample >filf &&
+	# resolve to something
+	git add file &&
+	git checkout --merge -- fild file filf &&
+	{
+		echo "<<<<<<< ours" &&
+		echo ourside &&
+		echo "=======" &&
+		echo theirside &&
+		echo ">>>>>>> theirs"
+	} >merged &&
+	test_cmp expect fild &&
+	test_cmp expect filf &&
+	test_cmp merged file
+'
+
+test_expect_failure 'checkout -m works after (mistaken) resolution to remove' '
+	setup_conflicting_index &&
+	echo "none of the above" >sample &&
+	cat sample >fild &&
+	cat sample >file &&
+	cat sample >filf &&
+	# resolve to remove
+	git rm file &&
+	git checkout --merge -- fild file filf &&
+	{
+		echo "<<<<<<< ours" &&
+		echo ourside &&
+		echo "=======" &&
+		echo theirside &&
+		echo ">>>>>>> theirs"
+	} >merged &&
+	test_cmp expect fild &&
+	test_cmp expect filf &&
+	test_cmp merged file
+'
+
 test_expect_success 'checkout with --merge, in diff3 -m style' '
 	git config merge.conflictstyle diff3 &&
 	setup_conflicting_index &&
-- 
2.41.0-478-gee48e70a82

