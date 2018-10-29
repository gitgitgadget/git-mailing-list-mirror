Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE4D1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJ2X6s (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 19:58:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:59122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726094AbeJ2X6r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 19:58:47 -0400
Received: (qmail 22160 invoked by uid 109); 29 Oct 2018 15:09:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 15:09:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18373 invoked by uid 111); 29 Oct 2018 15:09:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 11:09:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 11:09:44 -0400
Date:   Mon, 29 Oct 2018 11:09:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Jansen, Geert" <gerardu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181029150943.GI17668@sigill.intra.peff.net>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029150453.GH17668@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 11:04:53AM -0400, Jeff King wrote:

> > Even if someone wants to make the argument that this is behavior that we
> > absolutely *MUST* keep and not make configurable, there's still much
> > smarter ways to do it.
> 
> I don't have any real object to a configuration like this, if people
> want to experiment with it. But in contrast, the patch I showed earlier:
> 
>   - is safe enough to just turn on all the time, without the user having
>     to configure anything nor make a safety tradeoff
> 
>   - speeds up all the other spots that use OBJECT_INFO_QUICK (like
>     fetch's tag-following, or what appears to be the exact same
>     optimization done manually inside mark_complete_and_common-ref()).

One thing I forgot to add. We're focusing here on the case where the
objects _aren't_ present, and we're primarily trying to get rid of the
stat call.

But when we actually do see a duplicate, we open up the object and
actually compare the bytes. Eliminating the collision check entirely
would save that work, which is obviously something that can't be
improved by just caching the existence of loose objects.

I'm not sure how often that case happens in a normal repository. We see
it a fair on GitHub servers because of the way we use alternates (i.e.,
we often already have the object you pushed up because it's present in
another fork and available via objects/info/alternates).

-Peff
