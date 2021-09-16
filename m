Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCD6C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF22611CA
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhIPWq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:46:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:49566 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234282AbhIPWq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:46:56 -0400
Received: (qmail 8763 invoked by uid 109); 16 Sep 2021 22:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Sep 2021 22:45:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10076 invoked by uid 111); 16 Sep 2021 22:45:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Sep 2021 18:45:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Sep 2021 18:45:33 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 6/7] p5326: generate pack bitmaps before writing the
 MIDX bitmap
Message-ID: <YUPJDf7u8Nn5als3@coredump.intra.peff.net>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
 <040bb40548017bae807c1d349fa078c21ac46725.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <040bb40548017bae807c1d349fa078c21ac46725.1631657157.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 06:06:14PM -0400, Taylor Blau wrote:

> To help test the performance of permuting the contents of the hash-cache
> when generating a MIDX bitmap, we need a bitmap which has its hash-cache
> populated.
> 
> And since multi-pack bitmaps don't add *new* values to the hash-cache,
> we have to rely on a single-pack bitmap to generate those values for us.
> 
> Therefore, generate a pack bitmap before the MIDX one in order to ensure
> that the MIDX bitmap has entries in its hash-cache.

Makes sense. This is a little more contrived of a setup than the
original, but an utterly realistic one. If you are using midx bitmaps,
you are probably interspersing them with occasional full pack bitmaps.

It might be interesting to also do:

  rm -f .git/objects/pack/pack-*.bitmap

after generating the midx bitmap. That would confirm the further timing
tests are using the midx bitmap, and not ever "cheating" by looking at
the pack one (having poked in this direction before, I know that this
all works, so it would be a future-proofing thing).

> diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
> index a9c5499537..38557859b7 100755
> --- a/t/perf/p5326-multi-pack-bitmaps.sh
> +++ b/t/perf/p5326-multi-pack-bitmaps.sh
> @@ -13,7 +13,7 @@ test_expect_success 'create tags' '
>  '
>  
>  test_perf 'setup multi-pack index' '
> -	git repack -ad &&
> +	git repack -adb &&
>  	git multi-pack-index write --bitmap
>  '

This sort-of existed before your series, but I think is a bit "worse"
now: we are timing both "repack" and "multi-pack-index" write together.
So:

  - the timing for the midx write that we are interested in timing will
    be diluted by the much-bigger full-repack

  - we'll actually do _three_ full repacks (the default
    GIT_PERF_REPEAT_COUNT for the "run" script), since it's inside a
    test_perf()

So:

  test_expect_success 'start with bitmapped pack' '
	git repack -adb
  '

  test_perf 'setup multi-pack index' '
	git multi-pack-index write --bitmap
  '

would run faster and give us more interesting timings. Possibly you'd
want to drop the midx and its bitmaps as part of that test_perf, too.
The first run will be using the pack bitmap, and the others will use the
midx. I doubt it makes much difference either way, though.

And of course if you want to take my earlier suggestion, then it's easy
to add:

  test_expect_success 'drop pack bitmap' '
	rm -f .git/objects/pack/pack-*.bitmap
  '

afterwards; you wouldn't want to do it inside the test_perf() call
because of the repeat-count.

-Peff
