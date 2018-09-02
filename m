Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13FF1F404
	for <e@80x24.org>; Sun,  2 Sep 2018 08:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeIBMRB (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 08:17:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:36608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726003AbeIBMRB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 08:17:01 -0400
Received: (qmail 13396 invoked by uid 109); 2 Sep 2018 08:02:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 02 Sep 2018 08:02:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16862 invoked by uid 111); 2 Sep 2018 08:02:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 02 Sep 2018 04:02:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Sep 2018 04:02:06 -0400
Date:   Sun, 2 Sep 2018 04:02:06 -0400
From:   Jeff King <peff@peff.net>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [BUG] index corruption with git commit -p
Message-ID: <20180902080205.GD18787@sigill.intra.peff.net>
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
 <87tvn8c166.fsf@evledraar.gmail.com>
 <20180902050803.GA21324@sigill.intra.peff.net>
 <20180902071204.GA2868@duynguyen.home>
 <20180902072408.GA18787@sigill.intra.peff.net>
 <20180902075351.lkfnekklnwot7lzf@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180902075351.lkfnekklnwot7lzf@ltop.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 02, 2018 at 09:53:53AM +0200, Luc Van Oostenryck wrote:

> > At any rate, I think this perfectly explains the behavior we're seeing.
> 
> Yes, this certainly make sense.
> 
> For fun (and testing) I tried to take the problem in the other direction:
> * why hasn't this be detected earlier (I'm reasonably be sure I did the
>   same operation a few times already without seeing the corruption)?
> * how easy it is to reproduce the problem?
> * Is it enough to do an interactive commit with nothing needing interactive?
> 
> So I tried the following and some variants:
>   > for i in $(seq -w 0 100); do echo $i > f$i; done
>   > git add f* && git commit -m add f* && git rm -q f* && git commit -m rm -p
> 
> but I didn't succeed to recreate the problem. So I'm still wondering
> what is special in my repository & tree that trigger the corruption.

I think the partial deletion is important, because it means that the
resulting index is going to be smaller. And the truncation problem only
matters when we go from a larger file to a smaller one (since otherwise
overwrite the old content completely).

And it doesn't seem to trigger without the interactive "-p". I think
that's not directly related, but it somehow triggers the case where we
actually need to update the cache tree in this particular order.

That's pretty hand-wavy, but I think it gives a sense of why most people
didn't run into this. I do wish I understood better what it would take
to create a minimal example for the test suite.

-Peff
