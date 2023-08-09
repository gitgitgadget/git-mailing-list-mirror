Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1745C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 23:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjHIXiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIXit (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 19:38:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182B3E74
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 16:38:48 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56E7018AFF1;
        Wed,  9 Aug 2023 19:38:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TZEbFfq8y3y1N2zxCBRABtzi2d/iUKBfkgGHYk
        Xlk5E=; b=U4AF4onA/Vi8cb8PLjz8R3YlGLWUvcSNZYAwiaL/StdxcaiCJ4Dw8J
        lC1Ei42JlDzCqLv8+WL8oUsF4CKmXxYQOjNKhyDCpQeponw9RD5dZAPT4LB2fi98
        8JPmZSDfx/QGxP5TTr1Q015Ek/tnzNc7VS6v86qfa12+g8podN0Kw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ED1518AFF0;
        Wed,  9 Aug 2023 19:38:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA24A18AFEF;
        Wed,  9 Aug 2023 19:38:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230705060812.2865188-1-christian.couder@gmail.com>
        <20230705060812.2865188-6-christian.couder@gmail.com>
        <xmqqh6qi1byn.fsf@gitster.g>
        <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
        <xmqqila9p3j8.fsf@gitster.g>
        <CAP8UFD3b6gCog5P7WKzTuPQV2Lhf51=xO7ys+W7o0pGewJMcFg@mail.gmail.com>
        <xmqqcz0fnbs8.fsf@gitster.g> <xmqqo7jzh9mh.fsf@gitster.g>
        <CAP8UFD1eX8JMd91Say_sC7h_V08oRq32Wu9RM+SFtAQnhRPO2w@mail.gmail.com>
        <xmqqy1ijkezm.fsf@gitster.g>
Date:   Wed, 09 Aug 2023 16:38:45 -0700
In-Reply-To: <xmqqy1ijkezm.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        09 Aug 2023 15:50:05 -0700")
Message-ID: <xmqqttt7kcqi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E26A91C4-370D-11EE-9DC8-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It does seem that this topic directly queued on 'master' by itself
> without any other topics do break the CI quite badly.  Almost
> nothing passes:
>
>   https://github.com/git/git/actions/runs/5812873987
>
> but it may be something as silly as failing test lint.  I didn't
> check very closely.

And a bit further digging reveals that it is the case.

https://github.com/git/git/actions/runs/5812873987/job/15759211568#step:4:787

Locally you should be able to reproduce it by

    make
    make -C t test-lint

before sending your patches out.

I've queued a squashable fix-up on top of the topic.

Thanks.

---
 t/t7700-repack.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 9b1e189a62..48e92aa6f7 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -342,8 +342,9 @@ test_expect_success 'repacking with a filter works' '
 '
 
 test_expect_success '--filter fails with --write-bitmap-index' '
-	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 test_must_fail git -C bare.git repack \
-		-a -d --write-bitmap-index --filter=blob:none
+	test_must_fail \
+		env GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -C bare.git repack -a -d --write-bitmap-index --filter=blob:none
 '
 
 test_expect_success 'repacking with two filters works' '
-- 
2.42.0-rc1

