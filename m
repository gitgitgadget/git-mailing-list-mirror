Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AEED1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 06:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeGZHZH (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 03:25:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:59670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726560AbeGZHZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 03:25:07 -0400
Received: (qmail 19073 invoked by uid 109); 26 Jul 2018 06:09:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Jul 2018 06:09:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13815 invoked by uid 111); 26 Jul 2018 06:09:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 26 Jul 2018 02:09:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2018 02:09:51 -0400
Date:   Thu, 26 Jul 2018 02:09:51 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] pass st.st_size as hint for strbuf_readlink()
Message-ID: <20180726060951.GA25386@sigill.intra.peff.net>
References: <20180724104852.GA14638@sigill.intra.peff.net>
 <20180724105139.GE17165@sigill.intra.peff.net>
 <20180725184100.GA30961@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180725184100.GA30961@tor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 08:41:00PM +0200, Torsten Bögershausen wrote:

> On Tue, Jul 24, 2018 at 06:51:39AM -0400, Jeff King wrote:
> > When we initially added the strbuf_readlink() function in
> > b11b7e13f4 (Add generic 'strbuf_readlink()' helper function,
> > 2008-12-17), the point was that we generally have a _guess_
> > as to the correct size based on the stat information, but we
> > can't necessarily trust it.
> > 
> > Over the years, a few callers have grown up that simply pass
> > in 0, even though they have the stat information. Let's have
> > them pass in their hint for consistency (and in theory
> > efficiency, since it may avoid an extra resize/syscall loop,
> > but neither location is probably performance critical).
> > 
> > Note that st.st_size is actually an off_t, so in theory we
> > need xsize_t() here. But none of the other callsites use it,
> > and since this is just a hint, it doesn't matter either way
> > (if we wrap we'll simply start with a too-small hint and
> > then eventually complain when we cannot allocate the
> > memory).
> 
> Thanks a lot for the series.
> 
>  For the last paragraph I would actually vote the other way around -
>  how about something like this ?
>  Note that st.st_size is actually an off_t, so we should use
>  xsize_t() here. In pratise we don't expect links to be large like that,
>  but let's give a good example in the source code and use xsize_t()
>  whenever an off_t is converted into size_t.
>  This will make live easier whenever someones diggs into 32/64 bit
>  "conversion safetyness"

I actually don't mind using xsize_t(), but if we're going into I think
we should do it consistently. I.e., as a patch on top with that
explanation.

-Peff
