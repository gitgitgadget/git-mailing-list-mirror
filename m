Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B031FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 21:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966314AbcKXVIy (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 16:08:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:46959 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966219AbcKXVIy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 16:08:54 -0500
Received: (qmail 16011 invoked by uid 109); 24 Nov 2016 21:08:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Nov 2016 21:08:43 +0000
Received: (qmail 13600 invoked by uid 111); 24 Nov 2016 21:09:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Nov 2016 16:09:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2016 16:08:41 -0500
Date:   Thu, 24 Nov 2016 16:08:41 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
References: <cover.1479938494.git.johannes.schindelin@gmx.de>
 <cover.1480019834.git.johannes.schindelin@gmx.de>
 <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2016 at 09:55:07PM +0100, Johannes Schindelin wrote:

> +/*
> + * NEEDSWORK: this function can go once the legacy-difftool Perl script is
> + * retired.
> + *
> + * We intentionally avoid reading the config directly here, to avoid messing up
> + * the GIT_* environment variables when we need to fall back to exec()ing the
> + * Perl script.
> + */
> +static int use_builtin_difftool(void) {
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	int ret;
> +
> +	argv_array_pushl(&cp.args,
> +			 "config", "--bool", "difftool.usebuiltin", NULL);
> +	cp.git_cmd = 1;
> +	if (capture_command(&cp, &out, 6))
> +		return 0;
> +	strbuf_trim(&out);
> +	ret = !strcmp("true", out.buf);
> +	strbuf_release(&out);
> +	return ret;
> +}

FWIW, it should mostly Just Work to use the internal config functions
these days, with the caveat that they will not read repo-level config if
you haven't done repo setup yet.

I think it would probably be OK to ship with that caveat (people would
probably use --global config, or "git -c" for a quick override), but if
you really wanted to address it, you can do something like what
pager.c:read_early_config() does.

Of course, your method here is fine, too; I just know you are sensitive
to forking extra processes.

Also, a minor nit: capture_command() might return data in "out" with a
non-zero exit if the command both generates stdout and exits non-zero
itself. I'm not sure that's possible with git-config, though, so it
might not be worth worrying about.

-Peff
