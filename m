Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85CEB1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfJ2UJh (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:09:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:33244 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726104AbfJ2UJh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:09:37 -0400
Received: (qmail 2365 invoked by uid 109); 29 Oct 2019 20:09:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Oct 2019 20:09:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12502 invoked by uid 111); 29 Oct 2019 20:12:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Oct 2019 16:12:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Oct 2019 16:09:36 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] vreportf(): avoid relying on stdio buffering
Message-ID: <20191029200936.GA12337@sigill.intra.peff.net>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
 <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
 <e426627e1494e31e548fe044c1c1806ff59340cf.1572356272.git.gitgitgadget@gmail.com>
 <1a6119b4-b44f-0edd-da18-46b7d31a274f@syntevo.com>
 <nycvar.QRO.7.76.6.1910292049530.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910292049530.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 29, 2019 at 08:57:33PM +0100, Johannes Schindelin wrote:

> > On 29.10.2019 14:37, Johannes Schindelin via GitGitGadget wrote:
> >
> > > -	vsnprintf(msg, sizeof(msg), err, params);
> > > -	for (p = msg; *p; p++) {
> > > +	p = msg + off < pend ? msg + off : pend - 1;
> >
> > According to my understanding, this is undefined behavior:
> 
> It is not entirely obvious to me what exactly you mean by "this",
> assuming that you refer to comparing two pointers via `<`, I agree that
> this is not the best idea, I changed it to `off < pend - msg`. If my
> assumption is correct, however, we are still talking about C, so I
> wonder how this C++ document you linked could bear any relevance:

I think the issue is not the comparison, but rather that forming the
pointer "msg + off" is undefined, since its point outside of any object
(including the "one past" rule). And this is illegal in both C and C++,
though of course it works fine in practice most of the time.

Doing "off < pend - msg" is legal. Or note that "pend" is just
"msg + sizeof(msg)", subtract out the common term and end up with
"off < sizeof(msg)". :)

> > Can you please preserve the research text about fprintf() behavior on
> > different platforms that I provided before? Change formatting to what you
> > think fits best.
> 
> Quite honestly, I purposefully refrained from copying that information.
> While even the following paragraphs are incomplete by necessity (there
> are many more standard C libraries we try to work against, e.g. musl and
> newlibc, and it would be insanity to try to cover them all in an
> analysis of stdio buffering), the only finding that is relevant to the
> patch under discussion is that MSVC's runtime outputs to `stderr` byte
> by byte (or more correctly, character by character, I guess), and I did
> mention this in the commit message (in the part you quoted).

One other case is impacted, which is:

> > 1) If `stderr` is fully buffered:
> >    the ordering of `stdout` and `stderr` messages could be wrong,
> >    because `stderr` output waits for the buffer to become full.

We'll now output the stderr message closer to its time-of-printing,
which is a good thing (it may still be in a weird place with respect to
a buffered stdout, but getting the error message out ASAP is the best we
can do there).

I agree that the rest of the research is not especially relevant to the
code change (though I'm glad it is available in the list archive).

-Peff
