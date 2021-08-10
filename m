Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EC2C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0A160F02
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhHJSyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:54:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:43494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhHJSyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:54:12 -0400
Received: (qmail 12173 invoked by uid 109); 10 Aug 2021 18:53:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Aug 2021 18:53:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2233 invoked by uid 111); 10 Aug 2021 18:53:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Aug 2021 14:53:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Aug 2021 14:53:48 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Xingman Chen <xichixingman@gmail.com>
Subject: Re: [PATCH] apply: keep buffer/size pair in sync when parsing binary
 hunks
Message-ID: <YRLLPPANZhhTNUTT@coredump.intra.peff.net>
References: <YRHQAFDXs5xvyDND@coredump.intra.peff.net>
 <CAPUEsphWN_-BWyfF9mnPhL56RSnmPZfmvh_QwhjoAb3xin8V-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEsphWN_-BWyfF9mnPhL56RSnmPZfmvh_QwhjoAb3xin8V-w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 09, 2021 at 10:26:51PM -0700, Carlo Arenas wrote:

> On Mon, Aug 9, 2021 at 9:24 PM Jeff King <peff@peff.net> wrote:
> > diff --git a/apply.c b/apply.c
> > index 44bc31d6eb..4ed4b27169 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -1917,6 +1917,7 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
> >
> >         state->linenr++;
> >         buffer += llen;
> > +       size -= llen;
> >         while (1) {
> 
> Ironically, I was looking at this code because of your previous
> patch[1] that you suggested was ugly
> and because I was going to suggest moving from a for to a while loop
> to avoid the overly long line.
> 
> It is interesting to note though, that having a for (and obviously
> removing the last 2 lines from the loop) with a comma separated
> increment instead would
> have made this issue IMHO more obvious, and also why I decided against
> that; would it be a good idea to fix that as well?
> 
>   for (; ; buffer += llen, size -= llen) {

That wouldn't have fixed this issue, since it was actually before the
start of the loop that where the problem was. It might have made it more
obvious if the two parts were next to each other, but I'm not so sure.
There are lots of reasons why the stuff before a loop may not be
symmetric with the loop increment.

We could also initialize it like this:

  for (buffer += llen, size -= llen; ; buffer += llen, size -= llen)

but IMHO that is harder to read. The increment at the start is not part
of the loop initialization. It is really a "finishing" of the earlier
parsing that occurred (in fact, if I were writing this from scratch, I'd
probably have put extra whitespace before the start of the loop).

I did consider moving that other case to a while-loop, but then you have
to manually catch all of the loop continuations (which is verbose and
error-prone). So I dunno. There is no free lunch. ;)

-Peff
