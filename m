Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7A21F454
	for <e@80x24.org>; Wed,  6 Nov 2019 20:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfKFU7J (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 15:59:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:40992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727351AbfKFU7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 15:59:09 -0500
Received: (qmail 25008 invoked by uid 109); 6 Nov 2019 20:59:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Nov 2019 20:59:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27179 invoked by uid 111); 6 Nov 2019 21:02:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2019 16:02:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Nov 2019 15:59:07 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] "fatal: bad object .alternate" during fetch with alternates
Message-ID: <20191106205907.GA4122@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1911041053190.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911041053190.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 08:48:05PM +0100, Johannes Schindelin wrote:

> Now, I think the two factors that trigger this bug over here are:
> 
> - I had all the objects locally already, as I had pushed from a topic
>   branch to `master` [*1*].
> 
> - My worktree's `.git/objects` is connected to an alternate that is
>   connected to the current Git repository (yes, it is circular, long
>   story...) and has refs pointing to commits its alternate that have
>   been gc'ed away.

I think this second one is the crux of the issue. Your alternate is a
corrupt repository, and I don't think that's something we ought to be
worried about supporting in general.

That said, those alternate objects should be used as UNINTERESTING
traversal tips. And rev-list usually tries to avoid bailing out for
missing UNINTERESTING objects. I suspect it's less aggressive about
doing so for the actual tips (because usually for_each_ref()'s internal
logic would skip broken refs entirely).

> So I see two problems with this error message:
> 
> - It is not helpful. It should not say `.alternate`, it should mention
>   the ref itself, and ideally even the path of the alternate.

It doesn't know the refname. The data transfer between the alternate and
the borrowing repo was tightened to just pass over object names. We
could probably pass the alternate path, though.

> - Shouldn't the code be made smart enough to simply ignore (maybe with a
>   warning) refs that point to gc'ed commits?

I'll take a look at the rev-list thing I mentioned above.

-Peff
