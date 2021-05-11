Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4CAC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0916B6186A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhEKSBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:01:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:50864 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhEKSBe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:01:34 -0400
Received: (qmail 23877 invoked by uid 109); 11 May 2021 18:00:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 18:00:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26014 invoked by uid 111); 11 May 2021 18:00:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 14:00:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 14:00:26 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
Message-ID: <YJrGOqjS10Z/WkE8@coredump.intra.peff.net>
References: <20200404142131.GA679473@coredump.intra.peff.net>
 <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2105051623230.50@tvgsbejvaqbjf.bet>
 <xmqqv97w1wl1.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2105062229270.50@tvgsbejvaqbjf.bet>
 <xmqqh7jfy3du.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2105111632380.57@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2105111632380.57@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 04:34:49PM +0200, Johannes Schindelin wrote:

> On Fri, 7 May 2021, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > >> Otherwise I'd strongly prefer to see a word that hints that this is
> > >> an otherwise unneeded workaround for comiplers.  Your suggested
> > >> title instead hints that it is wrong to assume that errno will be
> > >> set to non-zero after a syscall.  I do not think that is the message
> > >> we want to send to our readers.
> > >
> > > Right, the oneline I suggested was only for the original patch, with which
> > > I disagreed.
> >
> > I actually do not know how your rewrite could be better, though.
> >
> > 		/* GCC thinks socket()/connect() might fail to set errno */
> > 		return errno ? errno : EIO;
> >
> > If a compiler thinks errno may *not* be set, can 'errno' be reliably
> > used to decide if it can be returned as-is or a fallback value EIO
> > should be used, without triggering the same (incorrect) working in
> > the first place?
> 
> Oh, I guess I mistook the problem for something else, then.
> 
> If the problem is that `errno` is not set in case of failure, the
> resolution is easy (and even recommended in the manual page of `errno`):
> simply set it to 0 before the syscall (or in the function that relies on
> `errno == 0` means success).

I don't think that is the problem. According to the standard, errno is
always set to a non-zero value after a syscall failure.

The problem is only that the compiler does not incorporate that special
knowledge of the variable, so it generates a warning even though we can
reason that the situation it describes is impossible.

-Peff
