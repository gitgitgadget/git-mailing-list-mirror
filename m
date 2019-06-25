Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E49CC1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 04:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfFYE6v (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 00:58:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:49380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726804AbfFYE6u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 00:58:50 -0400
Received: (qmail 26687 invoked by uid 109); 25 Jun 2019 04:58:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jun 2019 04:58:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16651 invoked by uid 111); 25 Jun 2019 04:59:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 25 Jun 2019 00:59:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Jun 2019 00:58:49 -0400
Date:   Tue, 25 Jun 2019 00:58:49 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Pedro Larroy <pedro.larroy.lists@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: git bisect should return 1 when the first bad commit is found
Message-ID: <20190625045848.GA7571@sigill.intra.peff.net>
References: <CAC_CU1iWBCTt5jLQ0Zp2HoyA0oFgG3shDB2rLfOsmC+x67NdAw@mail.gmail.com>
 <xmqq5zp9wdjb.fsf@gitster-ct.c.googlers.com>
 <CAC_CU1hHK5n4GcETbWFLBeqT_Y9LV6N32Rv0F0+OCXH2G0qg8Q@mail.gmail.com>
 <20190623224935.GD1100@sigill.intra.peff.net>
 <CAP8UFD1gWnkJZSzjOxOHdS4R3GCUSDgC9X85y_Yvc0LmyK19Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1gWnkJZSzjOxOHdS4R3GCUSDgC9X85y_Yvc0LmyK19Cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 09:16:13AM +0200, Christian Couder wrote:

> So you just need to parse stdout to detect that it found the first bad
> commit, and then you can use refs/bisect/bad.
>
> If the return code was used, how would you distinguish between a
> failure in the command (for example if you give bad information to
> `git bisect good` or `git bisect bad`) and the fact that it has not
> yet found the first bad commit? Anyway you would need to add some
> logic for that.

Right, thanks for reminding us of that ref. I did leave a suggestion
elsewhere in the thread that we might be able to avoid the exit-code
pitfalls by using a specific "result" ref.

> If it would be HEAD, it would mean that git bisect would potentially
> have to do one more checkout so that HEAD points to the first bad
> commit. This checkout would sometimes be useless, so it's more
> efficient to use something like refs/bisect/bad rather than HEAD.

I'm not too concerned with the cost of checking out a tree. After all,
we've just done a bunch of checkouts and probably some operations on the
tree itself. But I think there's a much more important reason my
suggestion may have problems.

Sometimes we _can't_ checkout another commit, because part of testing
the bisection may involve mucking with the working tree. For instance,
earlier today I was bisecting a case where git.git did not show the
breakage itself, but applying a debugging patch on top did. So I was
bisecting along the real history, adding new contents, testing, and then
cleaning up my changes before jumping to the next bisection candidate.

On the other hand, I have to clean them up anyway before running "git
bisect good" or it cannot jump to the next candidate when we are not
finished. Jumping to "bad" when we _are_ finished is no different there.
But I think it does show that there can be surprising implications to
moving HEAD around.

-Peff
