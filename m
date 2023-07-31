Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CBBC001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 22:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjGaWpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjGaWpF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 18:45:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2E31BF3
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 15:44:44 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB5403221F;
        Mon, 31 Jul 2023 18:44:27 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=HQNV6vK4fBKyPQxRKvsKN6Kii
        LcYeSYMaHhTyuWugjA=; b=Pc5mnt68+3J3hOqMVzzjlrNgj9/ONzX2oUApS+1Wt
        U+vh8KGX5GgnF7nJCznrBTfI1TLZydRKF5Ouy+3Bs3ITL7/lE0CtSg3+UHekV8Zw
        snqtwjQ7I48ic8n4WMp8ZYXEqKh8m1G3Wh/VespUJjc4Pr2jb5AlaaaLpzCsgsoj
        UQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3B403221E;
        Mon, 31 Jul 2023 18:44:27 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4671D3221D;
        Mon, 31 Jul 2023 18:44:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 6/7] checkout/restore: add basic tests for --merge
Date:   Mon, 31 Jul 2023 15:44:08 -0700
Message-ID: <20230731224409.4181277-7-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-478-gee48e70a82
In-Reply-To: <20230731224409.4181277-1-gitster@pobox.com>
References: <20230731224409.4181277-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: CC1CF2DE-2FF3-11EE-9036-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
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
@@ -137,6 +137,70 @@ test_expect_success 'restore --staged invalidates ca=
che tree for deletions' '
 	test_must_fail git rev-parse HEAD:new1
 '
=20
+test_expect_success 'restore --merge to unresolve' '
+	O=3D$(echo original | git hash-object -w --stdin) &&
+	A=3D$(echo ourside | git hash-object -w --stdin) &&
+	B=3D$(echo theirside | git hash-object -w --stdin) &&
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
+	=3D=3D=3D=3D=3D=3D=3D
+	theirside
+	>>>>>>> theirs
+	EOF
+	test_cmp expect file
+'
+
+test_expect_success 'restore --merge to unresolve after (mistaken) resol=
ution' '
+	O=3D$(echo original | git hash-object -w --stdin) &&
+	A=3D$(echo ourside | git hash-object -w --stdin) &&
+	B=3D$(echo theirside | git hash-object -w --stdin) &&
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
+	=3D=3D=3D=3D=3D=3D=3D
+	theirside
+	>>>>>>> theirs
+	EOF
+	test_cmp expect file
+'
+
+test_expect_failure 'restore --merge to unresolve after (mistaken) resol=
ution' '
+	O=3D$(echo original | git hash-object -w --stdin) &&
+	A=3D$(echo ourside | git hash-object -w --stdin) &&
+	B=3D$(echo theirside | git hash-object -w --stdin) &&
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
+	=3D=3D=3D=3D=3D=3D=3D
+	theirside
+	>>>>>>> theirs
+	EOF
+	test_cmp expect file
+'
+
 test_expect_success 'restore with merge options are incompatible with ce=
rtain options' '
 	for opts in \
 		"--staged --ours" \
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 23d4dadbcc..4b07a26c14 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -522,6 +522,48 @@ test_expect_success 'checkout with --merge' '
 	test_cmp merged file
 '
=20
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
+		echo "=3D=3D=3D=3D=3D=3D=3D" &&
+		echo theirside &&
+		echo ">>>>>>> theirs"
+	} >merged &&
+	test_cmp expect fild &&
+	test_cmp expect filf &&
+	test_cmp merged file
+'
+
+test_expect_failure 'checkout -m works after (mistaken) resolution to re=
move' '
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
+		echo "=3D=3D=3D=3D=3D=3D=3D" &&
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
--=20
2.41.0-478-gee48e70a82

