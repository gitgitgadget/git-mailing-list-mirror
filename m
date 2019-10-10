Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B89F1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfJJQh5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:37:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:44604 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725909AbfJJQh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:37:57 -0400
Received: (qmail 3837 invoked by uid 109); 10 Oct 2019 16:37:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Oct 2019 16:37:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24529 invoked by uid 111); 10 Oct 2019 16:40:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Oct 2019 12:40:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Oct 2019 12:37:56 -0400
From:   Jeff King <peff@peff.net>
To:     Toon Claes <toon@iotcl.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
Message-ID: <20191010163755.GA12756@sigill.intra.peff.net>
References: <20191008074935.10972-1-toon@iotcl.com>
 <20191009014039.GA10802@szeder.dev>
 <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
 <20191009203105.GA7007@sigill.intra.peff.net>
 <87sgo1q92k.fsf@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sgo1q92k.fsf@iotcl.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 10:49:23AM +0200, Toon Claes wrote:

> > Yeah, I'd agree that we should start first with a generic trailer line.
> 
> IIUC you are suggesting something like this?
> 
>  git commit --trailer="Co-authored-by: <coauthor>"
> 
> I really want to consider this, but I do not understand how that improves
> the user experience compared to adding that trailer manually when typing the
> commit message in your $EDITOR?

I agree that it's a lot worse to type than "--coauthor". And I don't
really have a problem with us ending up with "--coauthor". My reasoning
in starting with a generic form was mostly:

  - by having _any_ way to do this on the command-line, it makes it
    possible to use in aliases, etc.

  - having a generic form, even if we later add syntactic sugar on
    top, lets people easily experiment with their own trailers

> > There might be some advantage to building trailer-specific intelligence
> > on top of that (for instance, it would be nice for coauthor trailers to
> > expand names the way --author does). But that can come after, and might
> > not even be in the form of specific command-line options. E.g., if the
> > coauthor trailer could be marked in config as "this is an ident", then
> > we we would know to expand it. And the same could apply to acked,
> > reported, etc.
> 
> Wouldn't making it a generic --trailer option make this more complex? I can
> image users might even want to use the --trailer argument to indicate which
> issue the commit closes:
> 
>  git commit --trailer="Closes: $BUGNUMBER"
> 
> So, how can we make the config understand it has to expand Co-authored-by
> and not Closes?

We already have config blocks for specific trailers to describe how they
should be parsed or added. I was thinking that you'd set an option like
"trailer.co-authored-by.ident" to "true". And possibly that could be
used in other places, too (e.g., interpret-trailers code could make sure
it's syntactically valid, but I didn't really think through the
implications there).

And of course we could bake in the defaults for particular trailers if
we wanted to (I think we already do for trailer.signoff.*).

> > I wonder how we are supposed to use this trailer in the Git project, in
> > particular in combination with Signed-off-by. Should all (co)authors
> > sign off as well?  Or will Co-authored-by imply Signed-off-by?
> 
> For this purpose I think it's useful git understands what "Co-authored-by"
> means, so when you run:
> 
>  git commit -s --coauthor=<coauthor>
> 
> The following trailer will be added:
> 
>  Co-authored-by: <coauthor>
>  Signed-off-by: <author>
>  Signed-off-by: <coauthor>
> 
> So I'm still pro of adding a --co-author option, but I do understand the
> concerns to avoid adding an option for all the possible trailers found in
> the link above.

Yes, I agree that ordering and de-duplication rules are useful, too.
Some of that can be expressed already in trailer.* config, but I don't
know if it would be capable enough to do everything you want (though
again, it would be really nice to _make_ it capable enough so that other
types besides co-authored-by can make use of them).

I don't have a hard belief that we have to do it that way (generic
before specific), and I can believe that when you get down to the
details that it might be hard to express some of this stuff in config
rather than C code. But I think we should at least take a look at
whether it's possible, because the benefits of having a generic solution
are nice.

-Peff
