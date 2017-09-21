Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467B2202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 03:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdIUDE1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 23:04:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:45470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751343AbdIUDE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 23:04:26 -0400
Received: (qmail 29482 invoked by uid 109); 21 Sep 2017 03:04:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 03:04:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18369 invoked by uid 111); 21 Sep 2017 03:05:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 23:05:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 23:04:24 -0400
Date:   Wed, 20 Sep 2017 23:04:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: replace "struct cmdline_pathspec" with
 argv_array
Message-ID: <20170921030424.akqaou7tqj2updgr@sigill.intra.peff.net>
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
 <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
 <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
 <20170920224826.GH27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170920224826.GH27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 03:48:26PM -0700, Jonathan Nieder wrote:

> > Subject: [PATCH] revision: replace "struct cmdline_pathspec" with argv_array
> >
> > We assemble an array of strings in a custom struct,
> > NULL-terminate the result, and then pass it to
> > parse_pathspec().
> >
> > But then we never free the array or the individual strings
> > (nor can we do the latter, as they are heap-allocated when
> > they come from stdin but not when they come from the
> > passed-in argv).
> 
> To be devil's advocate for a moment: why don't we use UNLEAK on the
> paths passed in from stdin?
> 
> It's true that there can be an unbounded number of them, but they all
> coexist in memory anyway.  They are not generated dynamically on the
> fly.  Being able to free them doesn't have any obvious advantage over
> using exit().
>
> Except... is the idea that this allows the strings from stdin to be
> freed sooner, as soon as they have been parsed into a "struct
> pathspec"?

Well, no...the idea is that this is a function which leaks a bunch of
memory, and we shouldn't have to think hard about how often its leak can
be triggered or how severe it is. We should just fix it.

I agree with your analysis that we're likely only to leak one set of
--stdin input per program invocation (modulo some caller re-opening
stdin). And I also agree that it's a waste of memory to hold onto leaked
heap that cannot be used.

But mostly I am fundamentally against using UNLEAK() in a case like
this, because it does not match either of the properties which justified
adding UNLEAK() in the first place:

  1. We are about to exit the program, so the "leak" is only caused by
     the memory going out of scope at that exit.

     By contrast, the revision machinery may be called many times in the
     same program.

  2. The memory remains useful until around the time of program exit.

     This most certainly does not, as it would not even be reachable.

So while it may not do _too_ much harm, aside from increasing peak heap
unnecessarily, it's not a precedent I'd like to set. And certainly not
when we can fix the leak and reduce the code size at the same time.

> That sounds appealing.  The only risk would be if "struct pathspec"
> holds on to a pointer to one of these strings.
> 
> Fortunately parse_pathspec() is careful to strdup any strings it
> borrows (though it is not documented to do so).

A lot of the early interfaces in Git had really confusing
memory-ownership semantics. I think we've been slowly moving over the
years towards interfaces that spend a bit on extra copies to give simple
and consistent semantics (in fact, it was one of the reasons I added
argv_array in the first place).

So yes, it's good to double check that parse_pathspec() doesn't want to
hold on to the pointers. But I also think that should be the default
we're striving for in our APIs.

> In other words, proposed changes:
> 
>  1. Could the commit message describe what effect this would have on
>     maximum heap usage, if any?  (In qualitative terms is fine, though
>     actual numbers would be even better if it's easy to get them.)
>     That would make it easier to justify not using UNLEAK.

What wording are you looking for? It was a leak, and now it's gone.  The
size of the leak depends on how much you feed to --stdin. IMHO using
UNLEAK is totally inappropriate for this case, and doesn't even seem
like an alternative worth rejecting.

>  2. Can parse_pathspec get a comment in pathspec.h saying that it
>     defensively copies anything it needs from args so the caller is
>     free to modify or free it?  That way, it should be more obvious
>     to people in the future modifying parse_pathspec() that callers
>     may rely on that.  (The current API comment describes argv as
>     "command line arguments", which I fear would send the opposite
>     message to implementors.)

I certainly agree that the pathspec interface could use better
documentation. Patches welcome? :)

-Peff
