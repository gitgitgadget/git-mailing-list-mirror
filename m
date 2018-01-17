Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634CB1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 22:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeAQWVq (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 17:21:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:47152 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752901AbeAQWVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 17:21:45 -0500
Received: (qmail 21447 invoked by uid 109); 17 Jan 2018 22:21:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Jan 2018 22:21:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6280 invoked by uid 111); 17 Jan 2018 22:22:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Jan 2018 17:22:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jan 2018 17:21:43 -0500
Date:   Wed, 17 Jan 2018 17:21:43 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 4/7] trace.c: introduce trace_run_command()
Message-ID: <20180117222143.GA15317@sigill.intra.peff.net>
References: <20180113064949.6043-1-pclouds@gmail.com>
 <20180115105949.18328-1-pclouds@gmail.com>
 <20180115105949.18328-5-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180115105949.18328-5-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 15, 2018 at 05:59:46PM +0700, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/trace.c b/trace.c
> index 7f3b08e148..da3db301e7 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -23,6 +23,7 @@
>  
>  #include "cache.h"
>  #include "quote.h"
> +#include "run-command.h"
>  
>  struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
>  struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
> @@ -275,6 +276,21 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
>  #endif /* HAVE_VARIADIC_MACROS */
>  
>  
> +void trace_run_command(const struct child_process *cp)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (!prepare_trace_line(__FILE__, __LINE__,
> +				&trace_default_key, &buf))
> +		return;

I think technically this should be TRACE_CONTEXT instead of __FILE__,
though I wonder if anybody has ever set that (there is not even a
Makefile knob for it, so you'd have to -DTRACE_CONTEXT manually).

I actually wonder if it would be nicer to keep this whole thing in
run-command.c, and just prepare it all in a buffer. That's basically
what we're doing here anyway, and then we could get rid of the funny
__FILE__ stuff. I.e., something like:

  struct strbuf buf = STRBUF_INIT;

  if (!trace_want(&trace_default_key))
	return;

  strbuf_addf(&buf, "trace: run_command: ");
  sq_quote_argv_pretty(&buf, cp->argv);

  trace_printf("%s", buf.buf);
  strbuf_release(&buf);

AFAICT we aren't really using any internals of trace.c in our new
function.  That would get rid of this __FILE__ bit, it would eliminate
the need for trace.h to know about "struct child_process", and it would
mean the output still says "run-command.c" in it.

-Peff
