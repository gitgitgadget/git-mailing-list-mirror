Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3153020195
	for <e@80x24.org>; Thu, 14 Jul 2016 08:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbcGNIPN (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 04:15:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:44516 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750862AbcGNIPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 04:15:08 -0400
Received: (qmail 13895 invoked by uid 102); 14 Jul 2016 08:15:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 04:15:09 -0400
Received: (qmail 2704 invoked by uid 107); 14 Jul 2016 08:15:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 04:15:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 04:15:04 -0400
Date:	Thu, 14 Jul 2016 04:15:04 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160714081503.GA12946@sigill.intra.peff.net>
References: <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox>
 <20160712073912.GA26431@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607121257450.6426@virtualbox>
 <xmqqbn2267zq.fsf@gitster.mtv.corp.google.com>
 <20160713020132.GA13918@sigill.intra.peff.net>
 <xmqqh9bt34n1.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607132048370.6426@virtualbox>
 <xmqq8tx51hmx.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607140913470.6426@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607140913470.6426@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

tl;dr I don't really care which fix goes in. They are both fine with me,
and in practice I cannot imagine either causing a big problem. But here
are my thoughts because I know you want them.

On Thu, Jul 14, 2016 at 09:45:12AM +0200, Johannes Schindelin wrote:

> > Hmm, sorry, I do not see much upside here (iow, the 2038 test you
> > came up with is as robust).
> 
> Unless you, or Peff, performed a thorough analysis whether the dates are
> always cut off at 2038 holds true, I am highly doubtful that the previous
> tes is robust at all. I certainly only tested on Windows and never
> investigated how that 2038 came about. For what I know, it might be a
> platform-dependent behavior of strtoul().

I think that when a long is 32-bit signed, you will always get 2038 from
strtol.  There could be systems where that is the case, though, and
time_t is of a different size. I'm not sure how much it would be worth
caring about them.

One nice thing about looking for "if we got 2038, we know we can skip"
as opposed to "did we correctly format this to 2286" is that we err on
the side of failing the test. So if we did ever find such an oddball
platform, the test would fail and we could address it then.

> > When the internal time representation is updated from "unsigned long" to
> > a signed and wider type [*1*], test-date has to stop reading the
> > second-from-epoch input with strtol(),
> 
> It's strtoul(), actually.

I think both you and Junio are mistaken in the quoted text. :)

The code in question is in t/helper/test-date.c:show_dates(), and _does_
call the signed strtol(). However, it is storing it not in an "unsigned
long" (which would be utterly silly), but in a time_t.

And the value is clamped to LONG_MAX there, so the representation
elsewhere does not matter at all, as long as it big enough to store
LONG_MAX. By definition, "unsigned long" should be. In practice, I'd
guess time_t is, though perhaps one could come up with a case of
compiling a 64-bit program against a 32-bit ABI? I don't know if that's
possible.

That also explains why we get 2038 here, and not our usual sentinel
value of "(time_t)0". We _do_ have overflow checks when formatting
pretty-printed dates from commits (see show_ident_date), but the test
helper isn't using them.

> Please also note that ULONG_MAX is not required to be either 2^32-1 or
> 2^64-1. Which means that the 2038 test is really not robust.

Of course not; but as I mentioned above, I think the test can be written
to complain in the unlikely case that it is not one of those, and we can
deal with it then.

> Also note that the 640bit test is very explicit, and hence robust. As a
> consequence it would skip the absurd dates on systems switching to
> int128_t for time_t.

Actually, I think that is a bad thing. The case that the test in
question was added for was not about overflowing "unsigned long", but
about having a far-future date that tm_to_time_t() could not handle. And
that maxes out at 2100. Testing it on a 128-bit system would be
completely appropriate.

-Peff
