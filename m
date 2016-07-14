Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6715220196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcGNUKX (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:10:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:44915 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751285AbcGNUKV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:10:21 -0400
Received: (qmail 13444 invoked by uid 102); 14 Jul 2016 20:10:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 16:10:21 -0400
Received: (qmail 8623 invoked by uid 107); 14 Jul 2016 20:10:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 16:10:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 16:10:18 -0400
Date:	Thu, 14 Jul 2016 16:10:18 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
Message-ID: <20160714201018.GA18372@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
 <20160714182108.GB16497@sigill.intra.peff.net>
 <xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 01:00:08PM -0700, Junio C Hamano wrote:

> > There's tons of discussion in:
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/297409
> >
> > but frankly it is not worth your time to read it. These tests are about
> > overflowing the tar limits, which can only happen with times and sizes
> > greater than 32-bits. The right thing to do is to skip the tests
> > entirely on systems where sizeof(unsigned long) is less than 8 (the
> > actual value is 64GB+1, so technically a 37-bit system would work, but I
> > think it is OK for the test-skipping to be less specific).
> 
> OK, how about this on top of a replacement for js/t0006-for-v2.9.2
> that I'll send out as a reply to this message?

Yeah, I think the patch here mostly makes sense. I tried to think what
could go wrong in this hunk:

> diff --git a/archive-tar.c b/archive-tar.c
> index 7ea4e90..4d2832c 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -25,8 +25,13 @@ static int write_tar_filter_archive(const struct archiver *ar,
>   *
>   * Likewise for the mtime (which happens to use a buffer of the same size).
>   */
> +#if ULONG_MAX == 0x7FFFFFFF
> +#define USTAR_MAX_SIZE ULONG_MAX
> +#define USTAR_MAX_MTIME ULONG_MAX
> +#else
>  #define USTAR_MAX_SIZE 077777777777UL
>  #define USTAR_MAX_MTIME 077777777777UL
> +#endif
>  
>  /* writes out the whole block, but only if it is full */
>  static void write_if_needed(void)

If for some reason we are wrong that objects cannot be larger than
ULONG_MAX (e.g., later on we convert everything to size_t, and 64-bit
LLP platforms handle large objects just fine), then we would prematurely
switch to extended headers on those platforms.

I think that's OK. This would just need cleaned up as part of the
conversion from "unsigned long" to "size_t" (the correct check would
then be against the max size_t).

Also, shouldn't it be checking against 0xFFFFFFFF?

An easier check would be "sizeof()", but I guess we can't use that in a
preprocessor directive.

> -test_expect_success TAR_HUGE 'system tar can read our huge size' '
> +test_expect_success TAR_HUGE,64BIT 'system tar can read our huge size' '

The 64BIT prereq is really "unsigned long is 64-bit". I wonder if we
should call it UL64 or something like that to make it more clear.

That makes it unnecessarily tied-in with the implementation, but it does
make it more clear what we care about; the distinction matters for
things like LP64 vs LLP64.

-Peff
