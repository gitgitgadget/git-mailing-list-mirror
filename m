Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 708331F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 13:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfJ2Ntd (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 09:49:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:32870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725776AbfJ2Ntd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 09:49:33 -0400
Received: (qmail 31646 invoked by uid 109); 29 Oct 2019 13:49:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Oct 2019 13:49:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9748 invoked by uid 111); 29 Oct 2019 13:52:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Oct 2019 09:52:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Oct 2019 09:49:32 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of
 unbuffered one
Message-ID: <20191029134932.GA2843@sigill.intra.peff.net>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
 <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com>
 <xmqqeeyw6xyr.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910291222500.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910291222500.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 29, 2019 at 01:30:51PM +0100, Johannes Schindelin wrote:

> > Also, this is only to help output from us that goes via vreportf() and
> > other codepaths in us that use stdio to write to the standard error
> > stream can still get mixed on Windows (I think the answer is yes,
> > because we wouldn't need fflush() in this patch if we are covering all
> > writes to the standard error stream)?
> 
> Yes, `write()` can get interrupted, so there is still a slight chance of
> interleaving.
> 
> However, with `fprintf()`, apparently the MSVC runtime essentially
> writes and flushes one character at a time, which will make it _much_
> more likely that two competing processes write interleaved messages to
> `stderr`.

Wow, they have truly taken "unbuffered" to a whole new level.

I don't mind seeing this for all platforms, though. I can't think of any
downside, and having one less moving part to contend with in our
error-reporting code seems like a good thing.

> > > -	vsnprintf(msg, sizeof(msg), err, params);
> > > +	size_t off = strlcpy(msg, prefix, sizeof(msg));
> >
> > Like snprintf(3) the strlcpy() and strlcat() functions return the
> > total length of the string they tried to create.  For strlcpy() that
> > means the length of src.
> 
> True (I misread `compat/strlcpy.c` and forgot to consult the
> documentation). This length can be longer than `msg`, of course.

I'd recommend xsnprintf() here. If we have a prefix longer than our
vreportf() buffer, I think a BUG() is the right outcome.

> I `git grep`ed and saw that only very short `prefix`es are hard-coded.
> So that is a hypothetical concern.
> 
> However, Alex also indicated his discomfort with this, so I will change
> the code to account for a `prefix` that is too long (the entire error
> message will be clipped away in that case, which is unfortunate, but to
> be expected).

I'd disagree here. Any caller sending an arbitrarily-large prefix is
holding it wrong, and we'd probably want to know as soon as possible
(and a BUG() is our best bet there).

-Peff
