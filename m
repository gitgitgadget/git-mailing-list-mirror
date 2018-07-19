Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4311F597
	for <e@80x24.org>; Thu, 19 Jul 2018 05:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeGSGZr (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 02:25:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:52190 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725934AbeGSGZr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 02:25:47 -0400
Received: (qmail 9478 invoked by uid 109); 19 Jul 2018 05:44:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 05:44:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7456 invoked by uid 111); 19 Jul 2018 05:44:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 01:44:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 01:44:24 -0400
Date:   Thu, 19 Jul 2018 01:44:24 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
Message-ID: <20180719054424.GB23884@sigill.intra.peff.net>
References: <20180718225110.17639-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718225110.17639-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 03:51:08PM -0700, Elijah Newren wrote:

> I had a user report some poor behavior of 'git gc --aggressive' on a
> certain repo (which I sadly cannot share).  Turns out that on this
> repo, this operation takes about 60% longer and produces a pack
> roughly twice the expected size.
> 
> Naturally, bisecting takes a while but it points to this commit:

Thanks for finding and bisecting.

> To put some numbers behind this, I got on a very beefy box (40 cores,
> 160GB RAM) and ran some comparisons:
> 
> Version  Pack (MB)  MaxRSS(kB)  Time (s)
> -------  ---------  ----------  --------
>  2.17.0     5498     43513628    2494.85
>  2.18.0    10531     40449596    4168.94
>  fix-v1     5509     42509784    2480.74
>  fiv-v2     5509     41644104    2468.25
> 
> where fix-v1 and fix-v2 are different patches on top of git-2.18.0
> that I'll follow up to this email with.  The patches are just meant as
> discussion starters.  I'll add signoffs and proper commit messages if
> folks actually want those fixes, but I suspect they're just starting
> points for discussion.

Hmm. So what's the mechanism causing the issue here? Looking at the
patch from 0aca34e826 (pack-objects: shrink delta_size field in struct
object_entry, 2018-04-14), it should _mostly_ be about how we store data
in memory, and should not impact the deltas we find.

But reading the patch and looking at your v2, it seems clear that this
hunk is the culprit:

@@ -2006,10 +2008,14 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
        delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
        if (!delta_buf)
                return 0;
+       if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
+               free(delta_buf);
+               return 0;
+       }

So we're punting on large deltas, and presumably your test case has some
files that are large but delta well (and we miss those opportunities,
which wastes further time in the delta search and creates a lousy pack).

I'm not sure why we need this hunk, though. Eventually we'd hit
SET_DELTA_SIZE(), and I thought the point is that it should handle large
sizes with some kind of fallback (the commit message even mentions an
"overflow bit"). Looking at oe_set_delta_size(), though, I don't think
the fallback would really work here; we'd hid the BUG().

At any rate, it should be easy to construct a test case.

-Peff
