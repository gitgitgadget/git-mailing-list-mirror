Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455A9C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbhLPXLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:11:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51962 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbhLPXLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:11:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88B1CFC007;
        Thu, 16 Dec 2021 18:11:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JDu8r9V85rix/mEjnRcJaNiSRIhswICTUIrJfr
        ZcgTs=; b=WsyYJsSfODd8PhXntNId0fsGVz26z5P+1L+EAqeh3kbQohKiZyCQTg
        a/QXvjHrHhhpV3VjQeRcDgUyAKR8qUkkUa4Kh9T1wVRlFAOxgFkXbrUn0hU88mrU
        LBZlmOuo89rICXJYgsyi8ALvON+bpEeB4dLPN1rjT9l2mXH2i4kYY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FA61FC006;
        Thu, 16 Dec 2021 18:11:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E67B1FC005;
        Thu, 16 Dec 2021 18:11:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] t4204 is not sanitizer clean at all
References: <20211213220327.16042-1-jerry@skydio.com>
        <20211213220327.16042-2-jerry@skydio.com> <xmqqee6dz5s9.fsf@gitster.g>
Date:   Thu, 16 Dec 2021 15:11:12 -0800
In-Reply-To: <xmqqee6dz5s9.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        15 Dec 2021 17:40:06 -0800")
Message-ID: <xmqqtuf86t7z.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76FF129C-5EC5-11EC-A517-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier we marked that this patch-id test is leak-sanitizer clean,
but if we read the test script carefully, it is merely because we
have too many invocations of commands in the "git log" family on the
upstream side of the pipe, hiding breakages from them.

Split the pipeline so that breakages from these commands can be
caught (not limited to aborts due to leak-sanitizer) and unmark
the script as not passing the test with leak-sanitizer in effect.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 A quick grep tells me that tests 3302, 3303, 3305, 4020 and 6236
 all use "git log" and still are marked as passing tests with
 leak-sanitizer in effect.  I've taken a deep look at none of them,
 but I suspect they share the same kind of breakage.

 t/t4204-patch-id.sh | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git i/t/t4204-patch-id.sh w/t/t4204-patch-id.sh
index e78d8097f3..80f4a65b28 100755
--- i/t/t4204-patch-id.sh
+++ w/t/t4204-patch-id.sh
@@ -5,7 +5,6 @@ test_description='git patch-id'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
@@ -28,7 +27,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'patch-id output is well-formed' '
-	git log -p -1 | git patch-id >output &&
+	git log -p -1 >log.output &&
+	git patch-id <log.output >output &&
 	grep "^$OID_REGEX $(git rev-parse HEAD)$" output
 '
 
@@ -36,8 +36,8 @@ test_expect_success 'patch-id output is well-formed' '
 calc_patch_id () {
 	patch_name="$1"
 	shift
-	git patch-id "$@" |
-	sed "s/ .*//" >patch-id_"$patch_name" &&
+	git patch-id "$@" >patch-id.output &&
+	sed "s/ .*//" patch-id.output >patch-id_"$patch_name" &&
 	test_line_count -gt 0 patch-id_"$patch_name"
 }
 
@@ -46,7 +46,8 @@ get_top_diff () {
 }
 
 get_patch_id () {
-	get_top_diff "$1" | calc_patch_id "$@"
+	get_top_diff "$1" >top-diff.output &&
+	calc_patch_id <top-diff.output "$@"
 }
 
 test_expect_success 'patch-id detects equality' '
@@ -64,16 +65,18 @@ test_expect_success 'patch-id detects inequality' '
 test_expect_success 'patch-id supports git-format-patch output' '
 	get_patch_id main &&
 	git checkout same &&
-	git format-patch -1 --stdout | calc_patch_id same &&
+	git format-patch -1 --stdout >format-patch.output &&
+	calc_patch_id same <format-patch.output &&
 	test_cmp patch-id_main patch-id_same &&
-	set $(git format-patch -1 --stdout | git patch-id) &&
+	set $(git patch-id <format-patch.output) &&
 	test "$2" = $(git rev-parse HEAD)
 '
 
 test_expect_success 'whitespace is irrelevant in footer' '
 	get_patch_id main &&
 	git checkout same &&
-	git format-patch -1 --stdout | sed "s/ \$//" | calc_patch_id same &&
+	git format-patch -1 --stdout >format-patch.output &&
+	sed "s/ \$//" format-patch.output | calc_patch_id same &&
 	test_cmp patch-id_main patch-id_same
 '
 
@@ -92,10 +95,11 @@ test_patch_id_file_order () {
 	shift
 	name="order-${1}-$relevant"
 	shift
-	get_top_diff "main" | calc_patch_id "$name" "$@" &&
+	get_top_diff "main" >top-diff.output &&
+	calc_patch_id <top-diff.output "$name" "$@" &&
 	git checkout same &&
-	git format-patch -1 --stdout -O foo-then-bar |
-		calc_patch_id "ordered-$name" "$@" &&
+	git format-patch -1 --stdout -O foo-then-bar >format-patch.output &&
+	calc_patch_id <format-patch.output "ordered-$name" "$@" &&
 	cmp_patch_id $relevant "$name" "ordered-$name"
 
 }
@@ -143,7 +147,8 @@ test_expect_success '--stable overrides patchid.stable = false' '
 test_expect_success 'patch-id supports git-format-patch MIME output' '
 	get_patch_id main &&
 	git checkout same &&
-	git format-patch -1 --attach --stdout | calc_patch_id same &&
+	git format-patch -1 --attach --stdout >format-patch.output &&
+	calc_patch_id <format-patch.output same &&
 	test_cmp patch-id_main patch-id_same
 '
 
