Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10684201A7
	for <e@80x24.org>; Sat, 13 May 2017 03:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbdEMDzG (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 23:55:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:50662 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbdEMDzG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 23:55:06 -0400
Received: (qmail 8119 invoked by uid 109); 13 May 2017 03:55:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 03:55:06 +0000
Received: (qmail 29221 invoked by uid 111); 13 May 2017 03:55:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 23:55:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 23:55:03 -0400
Date:   Fri, 12 May 2017 23:55:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Hagins <hagins.josh@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] usage.c: add BUG() function
Message-ID: <20170513035503.cubqhzcvhifp54yg@sigill.intra.peff.net>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
 <20170513032850.zeru4cm2l7i23rkc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170513032850.zeru4cm2l7i23rkc@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 11:28:50PM -0400, Jeff King wrote:

> +static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
> +{
> +	char prefix[256];
> +
> +	/* truncation via snprintf is OK here */
> +	if (file)
> +		snprintf(prefix, sizeof(prefix), "BUG: %s:%d: ", file, line);
> +	else
> +		snprintf(prefix, sizeof(prefix), "BUG: ");
> +
> +	vreportf(prefix, fmt, params);
> +	abort();
> +}

I used vreportf() here to match die(). But the two things that function
does are:

  1. Respect error_handle. But after bw/forking-and-threading is merged,
     nobody will ever set error_handle (and I just sent a patch to drop
     it entirely).

  2. Quotes non-printable characters. I don't know how useful this is.
     Most of the assertion messages are pretty vanilla (because anything
     that relies on user input probably should be a regular die, not an
     assertion failure). But a few of them do actually print arbitrary
     strings in a reasonable way (e.g., a BUG() which is handling user
     string which was supposed to be vetted by an earlier function is
     still a reasonable assertion, but it's useful to show the string).

So an alternative would be just:

  fprintf(stderr, "BUG: ");
  if (file)
	fprintf(stderr, "%s:%d ", file, line);
  vfprintf(stderr, fmt, params);
  fputc('\n', stderr);

which is perhaps a bit simpler (not much in lines of code, but there's
no extra buffer to reason about). But given the discussion in (2) above,
it's probably worth continuing to use vreportf.

-Peff
