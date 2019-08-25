Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A352A1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 07:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfHYH2L (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 03:28:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:54770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725809AbfHYH2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 03:28:11 -0400
Received: (qmail 10025 invoked by uid 109); 25 Aug 2019 07:28:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 25 Aug 2019 07:28:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9986 invoked by uid 111); 25 Aug 2019 07:29:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 25 Aug 2019 03:29:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 25 Aug 2019 03:28:10 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] fast-import: Reinitialize command_buf rather than detach
 it.
Message-ID: <20190825072809.GD23806@sigill.intra.peff.net>
References: <20190825041348.31835-1-mh@glandium.org>
 <20190825065747.GA23806@sigill.intra.peff.net>
 <20190825072031.2m2go6ssshww6tup@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190825072031.2m2go6ssshww6tup@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 04:20:31PM +0900, Mike Hommey wrote:

> > I think this is stronger than just "most of the time". It's an invariant
> > for strbufs to have a NUL, so the only case where detaching isn't a noop
> > is the empty slopbuf case you mention.
> 
> If it's an invariant, why does detach actively tries to realloc and set
> the nul terminator as if it can happen in more cases than when using the
> slopbuf?

It calls strbuf_grow() to handle the slopbuf case (we can't hand off the
slopbuf, since the caller expects an allocated buffer). It just doesn't
bother to distinguish that case itself, and lets strbuf_grow() handle
it.

I think it would be equally correct for strbuf_detach() to do:

  if (!sb->alloc)
	strbuf_grow(0);

> > Splitting hairs, perhaps, but I think with that explanation, we could
> > probably argue that this case will never come up: strbuf_getline will
> > either have allocated a buffer or will have returned EOF.
> 
> Note that the slopbuf case _does_ come up, and we always leak a 1 byte
> buffer.

Hmm, I suppose so, on the very first call before we've read anything
(and likewise if parse_data() reset it then got an EOF, and we then
tried to read another command).

> I do agree the way fast-import works between cmd_hist and command_buf is
> very brittle, as you've shown. I didn't feel like digging into it
> though. Thanks for having gone further than I did.

I'll see if I can shape my rambling into a patch.

-Peff
