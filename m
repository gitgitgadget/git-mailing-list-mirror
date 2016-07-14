Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E124520196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbcGNU1b (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:27:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:44949 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287AbcGNU1a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:27:30 -0400
Received: (qmail 14217 invoked by uid 102); 14 Jul 2016 20:27:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 16:27:30 -0400
Received: (qmail 8910 invoked by uid 107); 14 Jul 2016 20:27:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 16:27:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 16:27:27 -0400
Date:	Thu, 14 Jul 2016 16:27:27 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
Message-ID: <20160714202727.GA19101@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
 <20160714182108.GB16497@sigill.intra.peff.net>
 <xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
 <20160714201018.GA18372@sigill.intra.peff.net>
 <xmqqbn20otqu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbn20otqu.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 01:22:01PM -0700, Junio C Hamano wrote:

> > Also, shouldn't it be checking against 0xFFFFFFFF?
> 
> Correct.  Somehow I thought I was checking with LONG_MAX.  Will correct.
> 
> > An easier check would be "sizeof()", but I guess we can't use that in a
> > preprocessor directive.
> 
> Yes, I tried it and failed ;-)

I also found it funny that you used "==" instead "<=", but I cannot
really think of a case where it would matter. If it is "<= 0xFFFFFFFF",
that basically covers 16-bit platforms. I really hope nobody is trying
to run git on such a platform. Doing "< 0xFFFFFFFFFFFFFFFF" to check
for "less than 64-bit" would make more sense, but would probably choke
on a 32-bit preprocessor.

So that everybody is either 32- or 64-bit these days, I think it doesn't
matter in practice.

> >> -test_expect_success TAR_HUGE 'system tar can read our huge size' '
> >> +test_expect_success TAR_HUGE,64BIT 'system tar can read our huge size' '
> >
> > The 64BIT prereq is really "unsigned long is 64-bit". I wonder if we
> > should call it UL64 or something like that to make it more clear.
> >
> > That makes it unnecessarily tied-in with the implementation, but it does
> > make it more clear what we care about; the distinction matters for
> > things like LP64 vs LLP64.
> 
> I do not think any platform is weird enough to have different sizes
> for long and ulong, so I am not sure you need UL64.
> 
> But pointer size can legitimately be different, so it has a value to
> differentiate between LP64 and LLP64, if we start doing things like
> "does this platform have large virtual address space?"
> 
> LONG_IS_64BIT perhaps to be more readable?

Yeah, that is what I was trying to get at, but you stated it much more
clearly. LONG_IS_64BIT is good. I wonder if the "git version
--build-options" should be "sizeof-long", too. It's shorter, and
indicates our assumption that we are talking about all longs, not just
unsigned ones.

-Peff
