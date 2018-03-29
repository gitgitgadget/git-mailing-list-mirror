Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8630F1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 22:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbeC2WL0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 18:11:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:48118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751865AbeC2WLY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 18:11:24 -0400
Received: (qmail 30904 invoked by uid 109); 29 Mar 2018 22:11:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 22:11:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23103 invoked by uid 111); 29 Mar 2018 22:12:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 18:12:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 18:11:22 -0400
Date:   Thu, 29 Mar 2018 18:11:22 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: prefer `--type=bool` over `--bool`,
 etc.
Message-ID: <20180329221122.GL2939@sigill.intra.peff.net>
References: <20180328234719.595-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328234719.595-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 04:47:19PM -0700, Taylor Blau wrote:

> `git config` has long allowed the ability for callers to provide a 'type
> specifier', which instructs `git config` to (1) ensure that incoming
> values are satisfiable under that type, and (2) that outgoing values are
> canonicalized under that type.
> 
> In another series, we propose to add extend this functionality with
> `--color` and `--default` to replace `--get-color`.
> 
> However, we traditionally use `--color` to mean "colorize this output",
> instead of "this value should be treated as a color".
> 
> Currently, `git config` does not support this kind of colorization, but
> we should be careful to avoid inhabiting this option too soon, so that
> `git config` can support `--color` (in the traditional sense) in the
> future, if that is desired.
> 
> In this patch, we prefer `--type=[int|bool|bool-or-int|...]` over
> `--int`, `--bool`, and etc. This allows the aforementioned other patch
> to add `--color` (in the non-traditional sense) via `--type=color`,
> instead of `--color`.

Makes sense. I agree with promoting --type as the correct way going
forward, since it will grow new types, whereas we can stop adding
"--foo" aliases for "--type=foo".

> +Valid `[type]`'s include:
> ++
> +- 'bool': canonicalize  values as either "true" or "false".
> +- 'int': canonicalize  values as simple decimla numbers. An optional suffix of
> +  'k', 'm', or 'g' will cause the value to be multiplied by 1024, 1048576, or
> +  1073741824 prior to output.
> +- 'bool-or-int': canonicalize according to either 'bool' or 'int', as described
> +  above.
> +- 'path': canonicalize by adding a leading `~` to the value of `$HOME` and
> +  `~user` to the home directory for the specified user. This specifier has no
> +  effect when setting the value (but you can use `git config section.variable
> +  ~/` from the command line to let your shell do the expansion.)
> +- 'expiry-date': canonicalize by converting from a fixed or relative ate-string
> +  to a timestamp. This specifier has no effect when setting the value.
> ++

Yay. It's nice to have this in only one place now.

s/ate-string/d&/ :)

> +static int type_name_to_specifier(char *name)
> +{
> +	if (!(strcmp(name, "bool")))
> +		return TYPE_BOOL;

We'd usually drop the extra level of parentheses, and just write:

  if (!strcmp(name, "bool"))

> @@ -601,6 +618,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		usage_with_options(builtin_config_usage, builtin_config_options);
>  	}
>  
> +	if (type) {
> +		if (types != 0) {
> +			error("usage of --type is ambiguous");
> +			usage_with_options(builtin_config_usage, builtin_config_options);
> +		}
> +		types = type_name_to_specifier(type);
> +	}

This error message left me scratching my head for a minute. Ambiguous
how? I think this is covering the case of:

  git config --int --type=bool

So maybe "--type cannot be used with other type options" or something?

Let's take a step back, though. As part of this, should we convert the
parsing of type options to last-one-wins? The fact that they are all
OPT_BIT() is quite silly, since you cannot have more than one bit set.
So if you do:

  git config --int --bool

you get an error. Whereas normal behavior for most options would be for
--bool to override --int. And that is what happens with:

  git config --type=int --type=bool

I don't think there are any backwards compatibility issues to deal with
here; we'd be changing a case which is now always an error.

And then after that, you truly can make (and document, if we want) that
"--int" is a true synonym for "--type=int".

I think it would be pretty simple. One of:

  - convert OPT_BIT("bool") into OPT_CALLBACK("bool") and just assign
    "bool" to the "type" string, which will then later get parsed into
    TYPE_BOOL.

or

  - convert OPT_BIT("bool") into OPT_SET_INT("bool") to set TYPE_BOOL
    directly. Convert OPT_STRING("type") into OPT_CALLBACK(), and have
    it assign the result of type_name_to_specifier() directly.

I'd probably do the latter, but would be fine with either (and I'd make
the OPT_SET_INT thing its own preparatory patch).

If you really want to go all-out, I think the ACTION flags could use the
same cleanup. We treat them as bitflags, and then issue an error when
you set more than one, which is just silly.

-Peff
