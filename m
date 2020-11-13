Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891C6C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 23:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4109322258
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 23:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKMXD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 18:03:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:58034 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgKMXDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 18:03:25 -0500
Received: (qmail 27978 invoked by uid 109); 13 Nov 2020 23:03:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 23:03:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18089 invoked by uid 111); 13 Nov 2020 23:03:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Nov 2020 18:03:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Nov 2020 18:03:24 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 17/23] pack-bitmap-write: build fewer intermediate bitmaps
Message-ID: <20201113230324.GA784144@coredump.intra.peff.net>
References: <cover.1605123652.git.me@ttaylorr.com>
 <ab64354851e2aa61e901e37814b2ae33d8f855d1.1605123653.git.me@ttaylorr.com>
 <20201113222328.GA8033@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113222328.GA8033@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 11:23:28PM +0100, SZEDER Gábor wrote:

> This patch breaks the test 'truncated bitmap fails gracefully (ewah)'
> when run with GIT_TEST_DEFAULT_HASH=sha256:

Thanks for reporting. It's mostly unluckiness that is unrelated to this
commit.

We're corrupting the bitmap by truncating it:

>           test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
>           mv -f $bitmap.tmp $bitmap &&

and then expecting to notice the problem. But it really depends on which
bitmaps we try to look at, and exactly where the truncation is. And this
commit just happens to rearrange the exact bytes we write to the bitmap
file.

If I do this:

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 68badd63cb..a83e7a93fb 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -436,7 +436,7 @@ test_expect_success 'truncated bitmap fails gracefully (ewah)' '
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
 	test_when_finished "rm -f $bitmap" &&
-	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
+	test_copy_bytes 270 <$bitmap >$bitmap.tmp &&
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&

then it passes with both sha1 and sha256.

But what's slightly disturbing is this output:

>   --- expect      2020-11-13 22:20:39.246355100 +0000
>   +++ actual      2020-11-13 22:20:39.254355294 +0000
>   @@ -1 +1 @@
>   -239
>   +236
>   error: last command exited with $?=1

We're actually producing the wrong answer here, which implies that
ewah_read_mmap() is not being careful enough. Or possibly we are feeding
it extra bytes (e.g., letting it run over into the name-hash cache or
into the trailer checksum).

I think we'll have to dig further into this, probably running the sha256
case in a debugger to see what offsets we actually end up reading.

-Peff
