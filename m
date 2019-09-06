Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 423A01F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbfIFRv0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:51:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:42304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387514AbfIFRv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:51:26 -0400
Received: (qmail 21537 invoked by uid 109); 6 Sep 2019 17:51:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 17:51:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5881 invoked by uid 111); 6 Sep 2019 17:53:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 13:53:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 13:51:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Sperling <stsp@stsp.name>,
        Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH 1/2] tag: factor out get_tagged_oid()
Message-ID: <20190906175124.GG23181@sigill.intra.peff.net>
References: <1385c954-d9ef-7ef6-6185-0dad885531ec@web.de>
 <20190906071320.GA14343@sigill.intra.peff.net>
 <f44b7abc-cab1-0bd4-029a-1c84cf36ec7b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f44b7abc-cab1-0bd4-029a-1c84cf36ec7b@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 05:05:11PM +0200, René Scharfe wrote:

> > This approach seems to pretty reasonable. As somebody who's been
> > thinking about this, I'd be curious to hear your thoughts on:
> >
> >   https://public-inbox.org/git/20190906065606.GC5122@sigill.intra.peff.net/
> >
> > which _in theory_ means tag->tagged would never be NULL (we'd catch it
> > at the parsing stage and consider that an error). But we'd still
> > potentially want to protect ourselves as you do here for code paths
> > which don't necessarily check the parse result.
> 
> A tag referencing an unknown object sounds strange to me.  I imagine we
> might get such a thing when the referenced object is lost (broken repo)
> or purpose-built from an attacker.  Could such a tag still be used for
> anything?  Are there other possible causes?  I suspect the answer to
> both questions is "no", and then it makes sense to reject it as early
> as possible.

I don't think there's really a valid case. Keep in mind that this isn't
checking for the object on-disk at all. It's only checking:

  - were we able to parse the tag at all (i.e., is it syntactically
    valid)

  - does it have a type we know about

  - were we able to create an in-memory struct, meaning we did not see
    the same oid with a different type elsewhere in the same process

The first and middle imply a corruption or malicious attack. The second
could mean forward-compatibility is a concern, but I think this is the
tip of the iceberg. You really need a Git that understands the object
types you're working with, or basically everything is going to fail.

So I'm not too concerned with tightening this code. The question to me
is whether to do it in parse_tag(), or when accessing tag->tagged, or
both.

> But I may be missing something.  In particular I'm confused by these
> patches from February 2008, which seem to suggest that such tags should
> not be reported in all cases, but sometimes just silently ignored:
> 
>    9684afd967 revision.c: handle tag->tagged == NULL
>    cc36934791 process_tag: handle tag->tagged == NULL
>    24e8a3c946 deref_tag: handle tag->tagged = NULL
> 
> So is there perhaps a use case for them after all?

There's not much discussion on the list from that thread, but searching
for messages from Martin around that the main goal was protecting
against corruptions. So I think these NULL checks were attempting to do
the same thing we're doing here, just in a less centralized way.

> Leaving that aside: The parsed flag means we saw and checked the object
> already.  That is true also for broken objects.  Clearing the flag can
> cause the same error to be reported multiple times.  How about setting
> it at the start as before, but returning -1 from parse_tag_buffer() if
> .parsed == 1 && .tagged == NULL?

That wouldn't cover all of the other reasons that we might have seen a
parse failure (so it fixes "tagged == NULL", but means that a subsequent
parse_tag() will silently return success).

I think the multiple error messages may be OK given that this is
explicitly covering a corrupt situation. But the more robust way is
adding an extra bit to say "I parsed this already, and it was corrupt"
to cause parse_tag() to return an error reliably.

-Peff
