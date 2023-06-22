Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF4FEB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 22:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjFVWyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 18:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFVWyu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 18:54:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9106B1FE9
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 15:54:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 13D1131453;
        Thu, 22 Jun 2023 18:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=D
        +MpBQC15qE9lowBF04LW5djmy8g2Xy9pGa7sHF3V9c=; b=EMSCVE7+W61AKZizQ
        aVRawsgwc1aRNGF6KAp5KwGsQpl9DwmBe9o5b2NXpa1LtS5jt3mbZclbBhQqYXVF
        Y0VJvwqEj6lp8uII5ZXu03dXHW+wODP3VKloj2R1jFzvFSLVuxFqAD7wGnSWF5Lr
        MOJRtsbCy45py+tGkwJ7vq1AHg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C9AB31452;
        Thu, 22 Jun 2023 18:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2A15331451;
        Thu, 22 Jun 2023 18:54:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] unresolve: make sure resolve-undo info is left even for
 removed paths
Date:   Thu, 22 Jun 2023 15:54:40 -0700
Message-ID: <xmqqzg4rcdlb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5B10FB0-114F-11EE-9163-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git rerere forget" requires that resolve-undo information is
correctly recorded in the index.

The current rerere machinery is not even prepared to access the
resolve-undo information for paths resolved for removal, as it first
goes to the main index entry and then finds the resolve-undo
information associated to the same pathname.  This has to be fixed
later (the codepath used by "git update-index --unresolve" shares
the same problem---unmerge_index_entry_at() is a flawed interface
that assumes that the index has the path in it after resolution, and
cannot be used when the resolution was to remove), but let's first
make sure we have the information recorded.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2030-unresolve-info.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 2d8c70b03a..c515b40e8d 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -62,6 +62,13 @@ test_expect_success setup '
 	test_commit fourth fi/le fourth &&
 	git checkout add-add &&
 	test_commit fifth add-differently &&
+	git checkout --detach initial &&
+	git rm binary &&
+	test_commit sixth del-binary &&
+	git reset --hard HEAD^ &&
+	printf "a\0c" >binary &&
+	git add binary &&
+	test_commit seventh mod-binary &&
 	git checkout main
 '
 
@@ -126,6 +133,32 @@ test_expect_success 'unmerge with plumbing' '
 	test_line_count = 3 actual
 '
 
+test_expect_success 'del-mod conflict' '
+	git reset --hard &&
+	# they delete, we modify, resolve to ours
+	git checkout --detach seventh &&
+	test_must_fail git merge sixth &&
+	git add binary &&
+	check_resolve_undo mods binary initial:binary seventh:binary ""
+'
+
+test_expect_success 'del-mod conflict' '
+	git reset --hard &&
+	# we delete, they modify, resolve to deletion
+	git checkout --detach sixth &&
+	test_must_fail git merge seventh &&
+	git rm binary &&
+	check_resolve_undo removed binary initial:binary "" seventh:binary
+'
+
+test_expect_success 'resolve 3-way conflict to deletion' '
+	git reset --hard &&
+	git checkout --detach second &&
+	test_must_fail git merge third &&
+	git rm fi/le &&
+	check_resolve_undo recorded fi/le initial:fi/le second:fi/le third:fi/le
+'
+
 test_expect_success 'rerere and rerere forget' '
 	mkdir .git/rr-cache &&
 	prime_resolve_undo &&
-- 
2.41.0-113-g6640c2d06d

