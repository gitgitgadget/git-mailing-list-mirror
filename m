Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329B0CCA47D
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 19:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiFMTmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245754AbiFMTlr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 15:41:47 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786C73564
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 11:12:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44F1A133544;
        Mon, 13 Jun 2022 14:12:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y+JrCuImM8nK5PQdUO/6ssye8AkmXHw0BewABX
        53Aek=; b=sYpzvkGaDX4OuGO7oDAxDFzHKCSjJlJGMcejSw8Tw345UzmRgpRuft
        8b0ZN8g47gNJkfKNSr+QsNRNb60c5Fxr8lq2td1a6x5J/6MvBOo2N0QNrjFvJt0X
        sFS/PBGEZTamL0cAPXQr8S2neF1xBeCBxYxZduZAGjeloufoeI+ZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BA40133543;
        Mon, 13 Jun 2022 14:12:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 847D4133542;
        Mon, 13 Jun 2022 14:12:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive
 filesystems
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
        <xmqqr13t8np7.fsf@gitster.g>
Date:   Mon, 13 Jun 2022 11:12:31 -0700
In-Reply-To: <xmqqr13t8np7.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        12 Jun 2022 16:30:12 -0700")
Message-ID: <xmqqo7yw77qo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64F392CE-EB44-11EC-AF5D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> And then, you could use --cached (not --index) to bypass the working
> tree altogether, which is a good way to test the feature without
> getting affected by the underlying filesystem.  Check both case
> sensitive and case insensitive cases:
> ...
> Likewise, try both sensitive and insensitive one.

As I already wrote tests for basic cases, I'm sending them out,

so that you may extend them with your new cases so that new code you
write can be checked.

Thanks.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 13 Jun 2022 11:05:54 -0700
Subject: [PATCH] t4141: test "git apply" with core.ignorecase

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4141-apply-icase.sh | 128 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100755 t/t4141-apply-icase.sh

diff --git a/t/t4141-apply-icase.sh b/t/t4141-apply-icase.sh
new file mode 100755
index 0000000000..9b70ff82c3
--- /dev/null
+++ b/t/t4141-apply-icase.sh
@@ -0,0 +1,128 @@
+#!/bin/sh
+
+test_description='git apply with core.ignorecase'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	# initial commit has file0 only
+	test_commit "initial" file0 "initial commit with file0" initial &&
+
+	# current commit has file1 as well
+	test_commit "current" file1 "initial content of file1" current &&
+	file0blob=$(git rev-parse :file0) &&
+	file1blob=$(git rev-parse :file1) &&
+
+	# prepare sample patches
+	# file0 is modified
+	echo modification to file0 >file0 &&
+	git add file0 &&
+	modifiedfile0blob=$(git rev-parse :file0) &&
+
+	# file1 is removed and then ...
+	git rm --cached file1 &&
+	# ... identical copies are placed at File1 and file2
+	git update-index --add --cacheinfo 100644,$file1blob,file2 &&
+	git update-index --add --cacheinfo 100644,$file1blob,File1 &&
+
+	# then various patches to do basic things
+	git diff HEAD^ HEAD -- file1 >creation-patch &&
+	git diff HEAD HEAD^ -- file1 >deletion-patch &&
+	git diff --cached HEAD -- file1 file2 >rename-file1-to-file2-patch &&
+	git diff --cached HEAD -- file1 File1 >rename-file1-to-File1-patch &&
+	git diff --cached HEAD -- file0 >modify-file0-patch
+'
+
+# Basic creation, deletion, modification and renaming.
+test_expect_success 'creation and deletion' '
+	# start at "initial" with file0 only
+	git reset --hard initial &&
+
+	# add file1
+	git -c core.ignorecase=false apply --cached creation-patch &&
+	test_cmp_rev :file1 "$file1blob" &&
+
+	# remove file1
+	git -c core.ignorecase=false apply --cached deletion-patch &&
+	test_must_fail git rev-parse --verify :file1 &&
+
+	# do the same with ignorecase
+	git -c core.ignorecase=true apply --cached creation-patch &&
+	test_cmp_rev :file1 "$file1blob" &&
+	git -c core.ignorecase=true apply --cached deletion-patch &&
+	test_must_fail git rev-parse --verify :file1
+'
+
+test_expect_success 'modificaiton' '
+	# start at "initial" with file0 only
+	git reset --hard initial &&
+
+	# modify file0
+	git -c core.ignorecase=false apply --cached modify-file0-patch &&
+	test_cmp_rev :file0 "$modifiedfile0blob" &&
+	git -c core.ignorecase=false apply --cached -R modify-file0-patch &&
+	test_cmp_rev :file0 "$file0blob" &&
+
+	# do the same with ignorecase
+	git -c core.ignorecase=true apply --cached modify-file0-patch &&
+	test_cmp_rev :file0 "$modifiedfile0blob" &&
+	git -c core.ignorecase=true apply --cached -R modify-file0-patch &&
+	test_cmp_rev :file0 "$file0blob"
+'
+
+test_expect_success 'rename file1 to file2' '
+	# start from file0 and file1
+	git reset --hard current &&
+
+	# rename file1 to file2
+	git -c core.ignorecase=false apply --cached rename-file1-to-file2-patch &&
+	test_must_fail git rev-parse --verify :file1 &&
+	test_cmp_rev :file2 "$file1blob" &&
+	git -c core.ignorecase=false apply --cached -R rename-file1-to-file2-patch &&
+	test_must_fail git rev-parse --verify :file2 &&
+	test_cmp_rev :file1 "$file1blob" &&
+
+	# do the same with ignorecase
+	git -c core.ignorecase=true apply --cached rename-file1-to-file2-patch &&
+	test_must_fail git rev-parse --verify :file1 &&
+	test_cmp_rev :file2 "$file1blob" &&
+	git -c core.ignorecase=true apply --cached -R rename-file1-to-file2-patch &&
+	test_must_fail git rev-parse --verify :file2 &&
+	test_cmp_rev :file1 "$file1blob"
+'
+
+test_expect_success 'rename file1 to file2' '
+	# start from file0 and file1
+	git reset --hard current &&
+
+	# rename file1 to File1
+	git -c core.ignorecase=false apply --cached rename-file1-to-File1-patch &&
+	test_must_fail git rev-parse --verify :file1 &&
+	test_cmp_rev :File1 "$file1blob" &&
+	git -c core.ignorecase=false apply --cached -R rename-file1-to-File1-patch &&
+	test_must_fail git rev-parse --verify :File1 &&
+	test_cmp_rev :file1 "$file1blob" &&
+
+	# do the same with ignorecase
+	git -c core.ignorecase=true apply --cached rename-file1-to-File1-patch &&
+	test_must_fail git rev-parse --verify :file1 &&
+	test_cmp_rev :File1 "$file1blob" &&
+	git -c core.ignorecase=true apply --cached -R rename-file1-to-File1-patch &&
+	test_must_fail git rev-parse --verify :File1 &&
+	test_cmp_rev :file1 "$file1blob"
+'
+
+# We may want to add tests with working tree here, without "--cached" and
+# with and without "--index" here.  For example, should modify-file0-patch
+# apply cleanly if we have File0 with $file0blob in the index and the working
+# tree if core.icase is set?
+
+test_expect_success CASE_INSENSITIVE_FS 'a test only for icase fs' '
+	: sample
+'
+
+test_expect_success !CASE_INSENSITIVE_FS 'a test only for !icase fs' '
+	: sample
+'
+
+test_done
-- 
2.36.1-513-gd2306e2395

