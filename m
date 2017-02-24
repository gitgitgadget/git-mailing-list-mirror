Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA2A2022F
	for <e@80x24.org>; Fri, 24 Feb 2017 04:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdBXEWb (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 23:22:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:33175 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750985AbdBXEWa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 23:22:30 -0500
Received: (qmail 14727 invoked by uid 109); 24 Feb 2017 04:22:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 04:22:30 +0000
Received: (qmail 581 invoked by uid 111); 24 Feb 2017 04:22:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 23:22:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 23:22:27 -0500
Date:   Thu, 23 Feb 2017 23:22:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] config: reject invalid VAR in 'git -c VAR=VAL command'
Message-ID: <20170224042227.2rjgf4zbiadxbrtz@sigill.intra.peff.net>
References: <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
 <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
 <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
 <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
 <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
 <20170223055831.u3yofkby3c56t7l4@sigill.intra.peff.net>
 <xmqqo9xt8jcf.fsf@gitster.mtv.corp.google.com>
 <xmqqy3ww5wbl.fsf@gitster.mtv.corp.google.com>
 <20170224004105.ayddcwlnpmq7tifu@sigill.intra.peff.net>
 <xmqqh93k5ijb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh93k5ijb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 08:17:44PM -0800, Junio C Hamano wrote:

> > Hmm. I suspect one cannot do:
> >
> >   git -c 'section.subsection with an = in it.key=foo' ...
> >
> > Definitely not a new problem, nor something that should block your
> > patch. But if we want to fix it, I suspect the problem will ultimately
> > involve parsing left-to-right to get the key first, then confirming it
> > has an =, and then the value.
> 
> Backtracking will not fundamentally "fix" parsing of
> 
> 	a.b=c=.d
> 
> between twhse two
> 
> 	[a "b="] c = ".d"
> 	[a]      b = "c=.d"
> 
> unfortunately, I think.  I do not think it is worth doing the "best
> effort" with erroring out when ambiguous, because there is no way
> for the end user to disambiguate, unless we introduce a different
> syntax, at which point we cannot use config_parse_key() anymore.

Ah, yeah, you're right. I thought the problem was just that the "split"
was too naive, but it really is that the whole syntax is badly
specified.

I guess "git config --list" suffers from the same problem. You can get
around it there with "-z", but that probably would not be very pleasant
here. :)

Probably not worth worrying too much about if nobody is complaining.

-Peff
