Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944461F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeDEWgX (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:36:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:55164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752666AbeDEWgW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:36:22 -0400
Received: (qmail 9948 invoked by uid 109); 5 Apr 2018 22:36:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 22:36:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20070 invoked by uid 111); 5 Apr 2018 22:37:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 18:37:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 18:36:20 -0400
Date:   Thu, 5 Apr 2018 18:36:20 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v4 3/3] builtin/config: introduce `color` type specifier
Message-ID: <20180405223620.GD29117@sigill.intra.peff.net>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
 <20180405025917.GD49902@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405025917.GD49902@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 07:59:17PM -0700, Taylor Blau wrote:

> As of this commit, the canonical way to retreive an ANSI-compatible
> color escape sequence from a configuration file is with the
> `--get-color` action.
> 
> This is to allow Git to "fall back" on a default value for the color
> should the given section not exist in the specified configuration(s).
> 
> With the addition of `--default`, this is no longer needed since:
> 
>   $ git config --default red --type=color core.section
> 
> will be have exactly as:
> 
>   $ git config --get-color core.section red
> 
> For consistency, let's introduce `--color` and encourage `--type=color`,
> `--default` together over `--get-color` alone.

In this last sentence, did you mean "let's introduce --type=color and
encourage its use with --default over --get-color alone"?

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-config.txt | 10 ++++++----
>  builtin/config.c             | 21 +++++++++++++++++++++
>  t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 620492d1e..bde702d2e 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -38,10 +38,8 @@ existing values that match the regexp are updated or unset.  If
>  you want to handle the lines that do *not* match the regex, just
>  prepend a single exclamation mark in front (see also <<EXAMPLES>>).
>  
> -A type specifier may be given as an argument to `--type` to make 'git config'
> -ensure that the variable(s) are of the given type and convert the value to the
> -canonical form. If no type specifier is passed, no checks or transformations are
> -performed on the value.
> +`color`::
> +    The value is taken as an ANSI color escape sequence.

We'd want to keep that introductory paragraph, right? And there is no
`--color`? So I think this hunk can go away (and is presumably a
leftover mistake during rebasing).

>  When reading, the values are read from the system, global and
>  repository local configuration files by default, and options
> @@ -177,6 +175,7 @@ Valid `<type>`'s include:
>    ~/` from the command line to let your shell do the expansion.)
>  - 'expiry-date': canonicalize by converting from a fixed or relative date-string
>    to a timestamp. This specifier has no effect when setting the value.
> +- 'color': canonicalize by converting to an ANSI color escape sequence.
>  +

This one is part of the --type list, so that's what we expect.

You may want to also cover the behavior when setting the value (we check
that it's sane, but store the original).

> diff --git a/builtin/config.c b/builtin/config.c
> index 1328b568b..aa3fcabe9 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -61,6 +61,7 @@ static int show_origin;
>  #define TYPE_BOOL_OR_INT	3
>  #define TYPE_PATH		4
>  #define TYPE_EXPIRY_DATE	5
> +#define TYPE_COLOR		6

Not strictly necessary for this series, but if this became an enum as
part of the de-bitifying, you wouldn't have to write the numbers
manually. :)

> @@ -203,6 +206,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
>  			if (git_config_expiry_date(&t, key_, value_) < 0)
>  				return -1;
>  			strbuf_addf(buf, "%"PRItime, t);
> +		} else if (type == TYPE_COLOR) {
> +			char v[COLOR_MAXLEN];
> +			if (git_config_color(v, key_, value_) < 0)
> +				return -1;
> +			strbuf_addstr(buf, v);
>  		} else if (value_) {
>  			strbuf_addstr(buf, value_);
>  		} else {

OK, formatting shows the converted value. Good.

> @@ -348,6 +356,19 @@ static char *normalize_value(const char *key, const char *value)
>  		else
>  			return xstrdup(v ? "true" : "false");
>  	}
> +	if (type == TYPE_COLOR) {
> +		char v[COLOR_MAXLEN];
> +		if (!git_config_color(v, key, value))
> +			/*
> +			 * The contents of `v` now contain an ANSI escape
> +			 * sequence, not suitable for including within a
> +			 * configuration file. Treat the above as a
> +			 * "sanity-check", and return the given value, which we
> +			 * know is representable as valid color code.
> +			 */
> +			return xstrdup(value);
> +		die("cannot parse color '%s'", value);
> +	}

And this returns the original. Good.

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index b25ab7b9e..c630bdc77 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh

The tests look good.

-Peff
