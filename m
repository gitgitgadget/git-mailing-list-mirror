Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A83DC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1761D6191C
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhEKVId (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 17:08:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:51336 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhEKVIc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 17:08:32 -0400
Received: (qmail 24556 invoked by uid 109); 11 May 2021 21:07:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 21:07:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28136 invoked by uid 111); 11 May 2021 21:07:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 17:07:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 17:07:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
Message-ID: <YJryDGSliWvvABDB@coredump.intra.peff.net>
References: <20200404142131.GA679473@coredump.intra.peff.net>
 <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2105051623230.50@tvgsbejvaqbjf.bet>
 <xmqqv97w1wl1.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2105062229270.50@tvgsbejvaqbjf.bet>
 <xmqqh7jfy3du.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2105111632380.57@tvgsbejvaqbjf.bet>
 <YJrGOqjS10Z/WkE8@coredump.intra.peff.net>
 <xmqqlf8lkmwo.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlf8lkmwo.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 05:58:47AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, May 11, 2021 at 04:34:49PM +0200, Johannes Schindelin wrote:
> >
> >> On Fri, 7 May 2021, Junio C Hamano wrote:
> >> 
> >> > 		/* GCC thinks socket()/connect() might fail to set errno */
> >> > 		return errno ? errno : EIO;
> >> >
> >> > If a compiler thinks errno may *not* be set, can 'errno' be reliably
> >> > used to decide if it can be returned as-is or a fallback value EIO
> >> > should be used, without triggering the same (incorrect) working in
> >> > the first place?
> >> 
> >> Oh, I guess I mistook the problem for something else, then.
> >> 
> >> If the problem is that `errno` is not set in case of failure, the
> >> resolution is easy (and even recommended in the manual page of `errno`):
> >> simply set it to 0 before the syscall (or in the function that relies on
> >> `errno == 0` means success).
> >
> > I don't think that is the problem. According to the standard, errno is
> > always set to a non-zero value after a syscall failure.
> >
> > The problem is only that the compiler does not incorporate that special
> > knowledge of the variable, so it generates a warning even though we can
> > reason that the situation it describes is impossible.
> 
> Yes, that is what I tried to say (i.e. if the compiler does not know
> errno has a defined value at certain places in our code and
> complain, then "return errno ? errno : EIO" would get the same
> warning because bases its outcome on the value of errno the compiler
> thinks is possibly undefined at that point), but apparently I failed
> to convey that clearly enough.

One thing in what you said puzzles me, though. The problem is not that
the compiler thinks errno is not set at all (i.e., undefined). It simply
does not know whether it is non-zero or not after the call.

So switching to "return errno ? errno : EIO" does indeed work here,
because the compiler now knows that the result of that return will
always be non-zero.

It must assume that "errno" is always defined to _something_, because
it's a global (so there's no undefined behavior here). It was only it's
zero/non-zero implication that let to code-paths were "fd" could be
used uninitialized.

-Peff
