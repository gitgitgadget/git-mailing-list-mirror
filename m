Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801F21F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 08:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757979AbcIHIWw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 04:22:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:40068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757160AbcIHIWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 04:22:50 -0400
Received: (qmail 4072 invoked by uid 109); 8 Sep 2016 08:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 08:22:49 +0000
Received: (qmail 13110 invoked by uid 111); 8 Sep 2016 08:22:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 04:22:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 04:22:46 -0400
Date:   Thu, 8 Sep 2016 04:22:46 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
Message-ID: <20160908082246.saf7vlw2xgjo7jvg@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de>
 <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609061613270.129229@virtualbox>
 <20160906184143.55a5zoa2mj6c2e5m@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609080933470.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609080933470.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 09:49:38AM +0200, Johannes Schindelin wrote:

> > > diff --git a/diff.c b/diff.c
> > > index 534c12e..2c5a360 100644
> > > --- a/diff.c
> > > +++ b/diff.c
> > > @@ -951,7 +951,13 @@ static int find_word_boundaries(mmfile_t *buffer,
> > > regex_t *word_regex,
> > >  {
> > >  	if (word_regex && *begin < buffer->size) {
> > >  		regmatch_t match[1];
> > > -		if (!regexec(word_regex, buffer->ptr + *begin, 1, match,
> > > 		0)) {
> > > +		int f = 0;
> > > +#ifdef REG_STARTEND
> > > +		match[0].rm_so = 0;
> > > +		match[0].rm_eo = *end - *begin;
> > > +		f = REG_STARTEND;
> > > +#endif
> > > +		if (!regexec(word_regex, buffer->ptr + *begin, 1, match,
> > > f)) {
> 
> Heh. You introduced the same bug I did. Or maybe you just fetched my
> mmap-regexec branch and looked at an intermediate iteration?

I do not think I introduced anything.  The quoted text is what you
sent. Which is perhaps why it has your bug. :)

> > But I much prefer this approach to copying the data just to add a NUL.
> 
> I think it is not worth the burden. The only regex implementation in
> semi-widespread use that do not support REG_STARTEND seems to be musl.
> 
> I'd rather not spend *so much* effort just to support an obscure platform.
> Not when the users of that obscure platform could spend that effort
> themselves. And probably won't, because we only copy data to add a NUL on
> those platforms when regexec() is called on an mmfile_t.

I'm confused about what you think I'm proposing. I was saying I _like_
something like regexec_buf() instead of copying the data. Which seems
like the simpler thing to me (and presumably to you). Or do you mean
using compat/regex to build on re_search() consistently? I do not think
that is all that complex; the question is only whether people really
want to use their own regex libraries.

Between the two options for regexec_buf(), I think you have convinced me
that REG_STARTEND is better than just using compat/regex everywhere. I
do think the fallback for platforms like musl should be "use
compat/regex" and not doing an expensive copy (which in most cases is
not even necessary).

-Peff
