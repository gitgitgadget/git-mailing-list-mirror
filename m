Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3CE91F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeC3Nsb (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:48:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:48656 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751163AbeC3Nsb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:48:31 -0400
Received: (qmail 10930 invoked by uid 109); 30 Mar 2018 13:48:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 13:48:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27715 invoked by uid 111); 30 Mar 2018 13:49:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 09:49:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 09:48:29 -0400
Date:   Fri, 30 Mar 2018 09:48:29 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180330134828.GD29568@sigill.intra.peff.net>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180330052830.57251-1-me@ttaylorr.com>
 <20180330052830.57251-2-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180330052830.57251-2-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 01:28:30AM -0400, Taylor Blau wrote:

> +static int option_parse_type(const struct option *opt, const char *arg,
> +			     int unset)
> +{
> +	int *type = opt->value;
> +
> +	if (!strcmp(arg, "bool"))
> +		*type = TYPE_BOOL;
> +	else if (!strcmp(arg, "int"))
> +		*type = TYPE_INT;
> +	else if (!strcmp(arg, "bool-or-int"))
> +		*type = TYPE_BOOL_OR_INT;
> +	else if (!strcmp(arg, "path"))
> +		*type = TYPE_PATH;
> +	else if (!strcmp(arg, "expiry-date"))
> +		*type = TYPE_EXPIRY_DATE;
> +	else {
> +		die(_("unexpected --type argument, %s"), arg);
> +		return 1;
> +	}
> +	return 0;
> +}

You need to handle "unset" here, which will trigger when somebody does:

  git config --no-type

In which case you'd probably want to reset it to "0".

> @@ -1622,4 +1623,21 @@ test_expect_success 'later legacy specifiers are given precedence' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--type allows valid type specifiers' '
> +	echo "true" >expect &&
> +	git config --type=bool core.foo >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--type rejects unknown specifiers' '
> +	test_must_fail git config --type=nonsense core.foo 2>error &&
> +	test_i18ngrep "unexpected --type argument" error
> +'
> +
> +test_expect_success 'later legacy specifiers are given precedence' '
> +	git config --bool --int core.number >actual &&
> +	echo 10 > expect &&
> +	test_cmp expect actual
> +'

I think there's some rebasing funkiness with this last test, which
already exists from patch 1.

Other than those two minor issues and the typos that René noticed, this
looks good to me.

-Peff
