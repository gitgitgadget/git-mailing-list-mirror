Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9FDE20248
	for <e@80x24.org>; Fri, 15 Mar 2019 03:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCODRH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 23:17:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:51856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725991AbfCODRH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 23:17:07 -0400
Received: (qmail 14494 invoked by uid 109); 15 Mar 2019 03:17:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 03:17:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28619 invoked by uid 111); 15 Mar 2019 03:16:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Mar 2019 23:16:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2019 23:15:53 -0400
Date:   Thu, 14 Mar 2019 23:15:53 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] parse-options: make OPT_ARGUMENT()  more useful
Message-ID: <20190315031553.GB28943@sigill.intra.peff.net>
References: <pull.163.git.gitgitgadget@gmail.com>
 <pull.163.v2.git.gitgitgadget@gmail.com>
 <10775638ad8f2ef9b64b8dbaf71b80d8546e81d8.1552562701.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10775638ad8f2ef9b64b8dbaf71b80d8546e81d8.1552562701.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 04:25:04AM -0700, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 2b036d7838..2e2e7c10c6 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -198,8 +198,10 @@ There are some macros to easily define options:
>  	The filename will be prefixed by passing the filename along with
>  	the prefix argument of `parse_options()` to `prefix_filename()`.
>  
> -`OPT_ARGUMENT(long, description)`::
> +`OPT_ARGUMENT(long, &int_var, description)`::
>  	Introduce a long-option argument that will be kept in `argv[]`.
> +	If this option was seen, `int_var` will be set to one (except
> +	if a `NULL` pointer was passed).

So this effectively makes it into a "bool" that we keep. I think that's
fine. It always uses NOARG, so it is not like we would ever need to see
"we got --foo, and this is the argument it had".

I did wonder if it was possible for "--no-foo" to trigger this (leaving
the caller who looks at the int unsure if they saw "--foo" or
"--no-foo"), but it seems that the parse-options code checks for
OPTION_ARGUMENT before it ever looks at negation.

Curiously, it also checks it before doing the usual prefix-matching
magic. So you could otherwise say "--no-inde", but OPT_ARGUMENT() will
not allow it. I think that's probably sane and not worth thinking
further about, but it is an interesting quirk that a user could possibly
run into.

> diff --git a/parse-options.c b/parse-options.c
> index cec74522e5..1d57802da0 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -286,6 +286,8 @@ static enum parse_opt_result parse_long_opt(
>  					     optname(options, flags));
>  			if (*rest)
>  				continue;
> +			if (options->value)
> +				*(int *)options->value = options->defval;

Cute. You could actually assign any defval you like, though of course
the convenient OPT_ARGUMENT() macro just always uses 1.

I wondered if you might need another cast for defval itself, but it's an
intptr_t (so it's the types that use it as a string that need to cast to
"const char *").

This looks very clean overall, and I agree it's much nicer than the
alternatives for your use case.

-Peff
