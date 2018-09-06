Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731121F404
	for <e@80x24.org>; Thu,  6 Sep 2018 16:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIFVc0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 17:32:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:41350 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726541AbeIFVc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 17:32:26 -0400
Received: (qmail 15793 invoked by uid 109); 6 Sep 2018 16:56:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 16:56:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32234 invoked by uid 111); 6 Sep 2018 16:56:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 12:56:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 12:56:03 -0400
Date:   Thu, 6 Sep 2018 12:56:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/11] string_list: print_string_list to use trace_printf
Message-ID: <20180906165602.GA19367@sigill.intra.peff.net>
References: <20180904230149.180332-1-sbeller@google.com>
 <20180904230149.180332-2-sbeller@google.com>
 <xmqqh8j236wj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8j236wj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 09:52:28AM -0700, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > It is a debugging aid, so it should print to the debugging channel.
> 
> ... and rename it with trace_ prefix.
> 
> Use of trace_printf() is nice, as we can control its behavior at
> runtime ;-)

Yes, though...

> > -void print_string_list(const struct string_list *p, const char *text)
> > +void trace_print_string_list(const struct string_list *p, const char *text)
> >  {
> >  	int i;
> >  	if ( text )
> > -		printf("%s\n", text);
> > +		trace_printf("%s\n", text);
> >  	for (i = 0; i < p->nr; i++)
> > -		printf("%s:%p\n", p->items[i].string, p->items[i].util);
> > +		trace_printf("%s:%p\n", p->items[i].string, p->items[i].util);
> >  }

It seems funny that we'd iterate through the list checking over and over
whether tracing is enabled.

Should this do:

  if (!trace_want(&trace_default_key))
	return;

at the top? (Or possibly even take a trace key from the caller, so that
it can use whatever context makes sense for this particular list?)

-Peff
