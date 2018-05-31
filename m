Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C0E1F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbeEaFn6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:43:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:57414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751660AbeEaFn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:43:57 -0400
Received: (qmail 12544 invoked by uid 109); 31 May 2018 05:43:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 05:43:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9373 invoked by uid 111); 31 May 2018 05:44:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 01:44:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 01:43:55 -0400
Date:   Thu, 31 May 2018 01:43:55 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Bracey <kevin@bracey.fi>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Weird revision walk behaviour
Message-ID: <20180531054355.GA17344@sigill.intra.peff.net>
References: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
 <20180523173246.GA10299@sigill.intra.peff.net>
 <20180523173523.GB10299@sigill.intra.peff.net>
 <869a4045-0527-3dcf-33b3-90de2a45cd51@bracey.fi>
 <cb1d7c86-a989-300a-01d2-923e9c29e834@bracey.fi>
 <20180528220651.20287-1-szeder.dev@gmail.com>
 <20180529210434.GA3857@sigill.intra.peff.net>
 <97644280-2187-d314-37ce-2c79935a63bc@bracey.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97644280-2187-d314-37ce-2c79935a63bc@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 11:20:40AM +0300, Kevin Bracey wrote:

> On 30/05/2018 00:04, Jeff King wrote:
> > 
> > Do we even need to do the parent rewriting here? By definition those
> > parents aren't interesting, and we're TREESAME to whatever is in
> > treesame_parents. So conceptually it seems like we just need a flag "I
> > found a treesame parent", but we only convert that into a TREESAME flag
> > if there are no relevant parents.
> 
> I think it's necessary to make the rules consistent. To mark the commit as
> TREESAME here when it's not TREESAME to all its parents would be
> inconsistent with the definition of the TREESAME flag used everywhere else:
> 
> * Original definition: "A commit is TREESAME if it is treesame to any
> parent"
> * d0af66 definition: "A commit is TREESAME if it is treesame to all parents"
> * Current 4d8266 definition: "A commit is TREESAME if it is treesame to all
> relevant parents; if no relevant parents then if it is treesame to all
> (irrelevant) parents."
> 
> The current problem is that the node is not marked TREESAME, but that's
> consistent with the definition. I think we do have to rewrite the commit so
> it is TREESAME as per the definition. Not flag it as TREESAME in violation
> of it.

If there are zero parents (neither relevant nor irrelevant), is it still
TREESAME? I would say in theory yes. So what I was proposing would be to
rewrite the parents to the empty set.

But anyway, I agree with you that the first-treesame-parent strategy is
not any more complex than the boolean, and is probably less likely to
cause unintended headaches later on.

What next here? It looks like we have a proposed solution. Do you want
to try to work up a set of tests based on what you wrote earlier?

I'd also love to hear from Junio as the expert in this area, but I think
he's been a bit busy with maintainer stuff recently. So maybe I should
just be patient. :)

-Peff
