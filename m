Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D821F406
	for <e@80x24.org>; Fri, 12 Jan 2018 13:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbeALNLE (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 08:11:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:42040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932797AbeALNLE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 08:11:04 -0500
Received: (qmail 3278 invoked by uid 109); 12 Jan 2018 13:11:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 13:11:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30620 invoked by uid 111); 12 Jan 2018 13:11:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 08:11:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 08:11:02 -0500
Date:   Fri, 12 Jan 2018 08:11:02 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 1/4] trace.c: introduce trace_run_command()
Message-ID: <20180112131101.GA7880@sigill.intra.peff.net>
References: <20180111094712.2551-1-pclouds@gmail.com>
 <20180112095607.18293-1-pclouds@gmail.com>
 <20180112095607.18293-2-pclouds@gmail.com>
 <20180112130522.GB27499@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180112130522.GB27499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 08:05:22AM -0500, Jeff King wrote:

> > +void trace_run_command(const struct child_process *cp)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +
> > +	if (!prepare_trace_line(__FILE__, __LINE__,
> > +				&trace_default_key, &buf))
> > +		return;
> > +
> > +	strbuf_addf(&buf, "trace: run_command:");
> > +
> > +	sq_quote_argv(&buf, cp->argv, 0);
> > +	print_trace_line(&trace_default_key, &buf);
> > +}
> 
> It looks like this leaks "buf".
> 
> If prepare_trace_line() returns 0, I think it's safe to assume that
> nothing was allocated. So we'd just need a strbuf_release() at the end.
> 
> Looking at the other trace functions, it looks like a bunch of them have
> the same problem.

Never mind, I got fooled by print_trace_line(), which does quite a bit
more than its name says. :)

This call (and the existing ones) are all fine.
