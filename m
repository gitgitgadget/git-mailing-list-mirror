Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197FD1F461
	for <e@80x24.org>; Mon, 20 May 2019 12:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbfETMkm (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 08:40:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:33878 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387507AbfETMkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 08:40:41 -0400
Received: (qmail 24215 invoked by uid 109); 20 May 2019 12:40:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 12:40:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3805 invoked by uid 111); 20 May 2019 12:41:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 08:41:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 08:40:39 -0400
Date:   Mon, 20 May 2019 08:40:39 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     "Eric S. Raymond" <esr@thyrsus.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190520124039.GF11212@sigill.intra.peff.net>
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <20190515233230.GA124956@thyrsus.com>
 <87woiqvic4.fsf@evledraar.gmail.com>
 <86woimox24.fsf@gmail.com>
 <20190520004559.GA41412@thyrsus.com>
 <86r28tpikt.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86r28tpikt.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 11:43:14AM +0200, Jakub Narebski wrote:

> You can receive new commits in the repository by creating them, and from
> other repository (via push or fetch).  In the second case you often get
> many commits at once.
> 
> In [1] it is described how using "bitmap index" you can avoid parsing
> commits when deciding which objects to send to the client; they can be
> directly copied to the client (added to the packfile that is sent to
> client).  Thanks to this reachability bitmap (bit vector) the time to
> clone Linux repository decreased from 57 seconds to 1.6 seconds.

No, this is mixing up sending and receiving. On the sending side, we try
very hard not to open up objects if we can avoid it (using tricks like
reachability bitmaps helps us quickly decide what to send, and reusing
the on-disk packfile data lets us send out objects without decompressing
them).

But on the receiving side, we do not trust the sender at all. The
protocol specifically does not send the sha1 of any object. The receiver
instead inflates every object it gets and computes the object hash
itself. And then on top of that, we traverse the commit graph to make
sure that the server sent us all of the objects we need to have a
complete graph.

So adding any extra object-quality checks on the receiving side would
not really change that equation.

But I do otherwise agree with your mail that the general idea of having
the receiver _change_ the incoming objects is going to lead to a world
of headaches.

-Peff
