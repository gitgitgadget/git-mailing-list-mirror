Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AF7C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 22:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiDYWkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 18:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiDYWk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 18:40:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42B12E9FF
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 15:37:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48A3B17942D;
        Mon, 25 Apr 2022 18:37:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C13Vzb/sOr4TMuGQ5omf5JHARRRvCDIcizJG7A
        K+JC8=; b=KIXCipJJ6p/vbeAxLwIWoK46nVbTOB6ZBSQjaiVFMaU5DTzPgvpson
        qnu/uKp+HN7TZGwXRzFBYB73f1HTRk589cyNF/otIXGWVe6n6BQP9wz5xFPN13Y7
        0Df5FuDkAdZMfJGjAIj6vJHuJYqUkPfWLNfz3jp1Gg6wSvXUDIASo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 293A417942C;
        Mon, 25 Apr 2022 18:37:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 959AF17942A;
        Mon, 25 Apr 2022 18:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: [PATCH] t4013: diff-tree --stdin with pathspec
References: <xmqqh76j3i3r.fsf@gitster.g> <xmqqbkwpvyyc.fsf@gitster.g>
Date:   Mon, 25 Apr 2022 15:37:17 -0700
In-Reply-To: <xmqqbkwpvyyc.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        25 Apr 2022 10:45:47 -0700")
Message-ID: <xmqqpml4u6w2.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 438B47A8-C4E8-11EC-B086-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test that feeds "diff-tree --stdin <pathspec>" with list of
revisions, in a way very similar to how "gitk" drives it.  If we had
such a test, we would have caught the recent regression.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * On top of that "revert" change.

 t/t4013-diff-various.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 750aee17ea..628b01f355 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -542,6 +542,20 @@ test_expect_success 'diff-tree --stdin with log formatting' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff-tree --stdin with pathspec' '
+	cat >expect <<-EOF &&
+	Third
+
+	dir/sub
+	Second
+
+	dir/sub
+	EOF
+	git rev-list master^ |
+	git diff-tree -r --stdin --name-only --format=%s dir >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'diff -I<regex>: setup' '
 	git checkout master &&
 	test_seq 50 >file0 &&
-- 
2.36.0-200-g3c19986797

