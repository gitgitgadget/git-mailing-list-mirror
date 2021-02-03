Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04573C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 23:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B3D64F4E
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 23:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhBCXhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 18:37:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:46758 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232458AbhBCXhl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 18:37:41 -0500
Received: (qmail 22398 invoked by uid 109); 3 Feb 2021 23:37:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Feb 2021 23:37:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5999 invoked by uid 111); 3 Feb 2021 23:37:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Feb 2021 18:37:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Feb 2021 18:36:59 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/2] Optimization batch 6: make full use of exact
 renames
Message-ID: <YBszm/s9na3ixUsO@coredump.intra.peff.net>
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
 <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
 <xmqqlfc4byt6.fsf@gitster.c.googlers.com>
 <CABPp-BEgwfv70NRGgyAnHnQBPx4APSyYxNCbvH9F=7WGSj4DLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEgwfv70NRGgyAnHnQBPx4APSyYxNCbvH9F=7WGSj4DLQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 03:06:26PM -0800, Elijah Newren wrote:

> >    In an early attempt, I tried to retire rename_src[j], once
> >    rename_dst[i] has been found to be a "good enough" match for it,
> >    from the pool of rename src candidates to find a good match for
> >    rename_dst[k] for i < k, but naive implementation of it would not
> >    work well for obvious reasons---rename_src[j] may match a lot
> >    better with rename_dst[k] than rename_dst[i] but we do not know
> >    that until we try to estimate similarity with rename_dst[k].
> 
> You may really like the next two series I submit.  I have a smarter
> way to find a "good enough" match (comparing to exactly one other file
> and often finding sufficient similarity), and one that'll make
> intuitive sense to users.

Here's a really old thread with an approach that may or may not be
similar to what you're thinking of:

  https://lore.kernel.org/git/596909b30710220240g665054d8hc40bc5d2234ba9e1@mail.gmail.com/

Though maybe start with this summary message:

  https://lore.kernel.org/git/596909b30710220309l1a28e646r9fd47f967dc32574@mail.gmail.com/

I remember experimenting some with it at the time, but never making
things faster. It's entirely possible (likely, even) that I was simply
not doing it well enough.

It's also been long enough since I looked at the rename code that I'm
not sure how different it is in practice. It still has a quadratic
matrix in the end. We basically do a similar strategy of
rolling-hash-fingerprint-and-see-where-things-collide, but I think we
may end up with more work during the quadratic part (again, it's been
a while, so I may just be totally off-base).

I've also wondered if something similar might be helpful for delta
compression (which is now done with an O(m*n) sliding window).

-Peff
