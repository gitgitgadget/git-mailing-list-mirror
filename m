Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375831F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfAXVPI (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:15:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:48032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725936AbfAXVPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:15:07 -0500
Received: (qmail 15102 invoked by uid 109); 24 Jan 2019 21:15:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 21:15:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32530 invoked by uid 111); 24 Jan 2019 21:15:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 16:15:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 16:15:06 -0500
Date:   Thu, 24 Jan 2019 16:15:06 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/6] diff: clear emitted_symbols flag after use
Message-ID: <20190124211505.GA16114@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
 <20190124123240.GB11354@sigill.intra.peff.net>
 <xmqqy379hkri.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy379hkri.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 12:18:41PM -0800, Junio C Hamano wrote:

> I did not like the complexity of that "emitted symbols" conversion
> we had to do recently and never trusted the code.  There still is
> something funny in diff_flush_patch_all_file_pairs() even after this
> patch, though.
> 
>  - We first check o->color_moved and unconditionally point
>    o->emitted_symbols to &esm.
> 
>  - In an if() block we enter when o->emitted_symbols is set, there
>    is a check to see if o->color_moved is set.  This makes sense
>    only if we are trying to be prepared to handle a case where we
>    are not the one that assigned a non-NULL to o->emitted_symbols
>    due to o->color_moved.  So it certainly is possible that
>    o->emitted_symbols is set before we enter this function.

Yeah, I noticed that, too. I assumed it was preparing for a day when the
logic for "are we collecting symbols" becomes more complex than just
being equivalent to "o->color_moved".

Under that rationale, I was OK leaving it.

>  - But then, it means that o->emitted_symbols we may have had
>    non-NULL when the function is called may be overwritten if
>    o->color_moved is set.

Yeah, that is true. I think in the new world order proposed by this
patch, we'd always assume that it's NULL coming in, possibly assign it,
and re-NULL it going
out.

> The above observation does not necessarily indicate any bug; it just
> shows that the code structure is messier than necessary.

Yeah, I don't think it's a bug currently, although...

> > To fix it, we can simply restore o->emitted_symbols to NULL after
> > flushing it, so that it does not affect anything outside of
> > diff_flush_patch_all_file_pairs(). This intuitively makes sense, since
> > nobody outside of that function is going to bother flushing it, so we
> > would not want them to write to it either.
> 
> Perhaps.  I see word-diff codepath gives an allocated buffer to
> o->emitted_symbols, so assigning NULL without freeing would mean a
> leak, but I guess this helper function is not designed to be called

Hrm, I'm embarrassed to say I did not notice that it also uses the
emitted_symbols system.

I think we only do it there, though, in the sub-diff_options that
word-diff uses, in which case we make a separate emitted_diff_symbols
struct instead of re-using the one from the parent diff_options.

So I think the general idea still holds, which is that whoever assigns
the emitted_symbols flag is responsible for flushing it. For
--color-moved, that happens in a single function, but for word-diff,
it's split across the init/flush functions.

-Peff
