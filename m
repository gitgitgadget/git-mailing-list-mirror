Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F3E7203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbcGYWRH (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:17:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:48919 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754136AbcGYWRE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:17:04 -0400
Received: (qmail 18591 invoked by uid 102); 25 Jul 2016 22:17:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 18:17:04 -0400
Received: (qmail 29812 invoked by uid 107); 25 Jul 2016 22:17:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 18:17:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2016 18:17:01 -0400
Date:	Mon, 25 Jul 2016 18:17:01 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 02/16] Report bugs consistently
Message-ID: <20160725221700.GB14131@sigill.intra.peff.net>
References: <cover.1467902082.git.johannes.schindelin@gmx.de>
 <cover.1469187652.git.johannes.schindelin@gmx.de>
 <72d1d530bb0e3c96d3affd6679cb7c26026d8321.1469187652.git.johannes.schindelin@gmx.de>
 <xmqqfuqx4cli.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuqx4cli.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 02:44:25PM -0700, Junio C Hamano wrote:

> > diff --git a/imap-send.c b/imap-send.c
> > index db0fafe..67d67f8 100644
> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -506,12 +506,12 @@ static char *next_arg(char **s)
> >  
> >  static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
> >  {
> > -	int ret;
> > +	int ret = -1;
> >  	va_list va;
> >  
> >  	va_start(va, fmt);
> >  	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
> > -		die("Fatal: buffer too small. Please report a bug.");
> > +		die("BUG: buffer too small (%d < %d)", ret, blen);
> >  	va_end(va);
> >  	return ret;
> >  }
> 
> If "you gave me this size but you need at least this much" is truly
> worth reporting, then this is misleading (ret is shown as -1 but you
> do not even know how much is necessary).  In any case, this should
> be done as a separate step anyway.

Hrm, isn't "ret" going to be the necessary size? According to the
standard, it should tell us how many bytes were needed, not "-1" (this
is the "your vsnprintf is broken" case handled by the strbuf code).

I do think the numbers are reversed, though. It should be "blen < ret".

-Peff
