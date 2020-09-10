Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2786C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 20:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D56221E5
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 20:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgIJUri (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:47:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:53988 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbgIJU1C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 16:27:02 -0400
Received: (qmail 24575 invoked by uid 109); 10 Sep 2020 20:26:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2020 20:26:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23214 invoked by uid 111); 10 Sep 2020 20:26:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2020 16:26:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Sep 2020 16:26:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] quote_path: give flags parameter to quote_path()
Message-ID: <20200910202655.GA1938792@coredump.intra.peff.net>
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
 <20200908205224.4126551-1-gitster@pobox.com>
 <20200908205224.4126551-3-gitster@pobox.com>
 <20200910122111.GA57925@coredump.intra.peff.net>
 <xmqqo8mdr7ve.fsf@gitster.c.googlers.com>
 <xmqq7dt1r78z.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dt1r78z.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 08:17:32AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Of course none of the above becomes unnecessary if we scan the whole
> > string for SP before the main loop in quote-c-style-counted, but the
> > function was written to process the input in a single pass and such
> > a change defeats its design.  If we need to do it in two passes, we
> > can have the caller do so anyway, at least for now.  That thinking
> > lead to the final organization of the series, with two steps that
> > used to be preparatory for passing the flag down thru to the bottom
> > layer rebased out as a discardable appendix at the end.
> 
> Actually, this made me realize that another variant is possible.
> It might be easier to read, or it might not.  Since I cannot tell
> without actually writing one, let's see ...

Vger seems to be delivering slowly and out-of-order the last day or two,
so I got rather confused to receive this after seeing your v2. :)

> I don't know if this is easier to follow or not.  I do think so
> right now but that is only because it is still fresh in my brain.

I do think it is easier to read than the original.

One minor nit with your analysis, though: the current code is actually
two-pass already. One pass finds the next quoted character, but then we
have to take another pass to copy it into place. That second pass can be
done with a memcpy(), which helps.

If you know you are quoting, you can do a true single-pass
character-by-character. But of course part of our task is to find out
_if_ we are quoting. And even if that were not the case, on modern
processors it is not always true that single-pass is going to be faster.
This code is definitely not such a hot-spot that it's worth doing that
kind of micro-optimization.

  Aside: We _do_ have spots where that is not true. When I looked at
  replacing xdiff's hash the sticking point was that we compute the
  newlines _and_ hash in a single pass. Most "fast" hash functions are
  optimized to take bigger sequences of data, but splitting out the
  newline-finding eliminated any gains.

-Peff


