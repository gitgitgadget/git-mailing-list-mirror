Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A57941F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 09:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeCZJQs (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 05:16:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:42978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750989AbeCZJQr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 05:16:47 -0400
Received: (qmail 10706 invoked by uid 109); 26 Mar 2018 09:16:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 09:16:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17820 invoked by uid 111); 26 Mar 2018 09:17:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 05:17:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 05:16:45 -0400
Date:   Mon, 26 Mar 2018 05:16:45 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 4/4] builtin/config: introduce `--color` type specifier
Message-ID: <20180326091645.GD18714@sigill.intra.peff.net>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
 <20180324005556.8145-5-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180324005556.8145-5-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 08:55:56PM -0400, Taylor Blau wrote:

> As of this commit, the canonical way to retreive an ANSI-compatible
> color escape sequence from a configuration file is with the
> `--get-color` action.

s/retreive/retrieve/

> This is to allow Git to "fall back" on a default value for the color
> should the given section not exist in the specified configuration(s).
> 
> With the addition of `--default`, this is no longer needed since:
> 
>   $ git config --default red --color core.section
> 
> will be have exactly as:
> 
>   $ git config --get-color core.section red
> 
> For consistency, let's introduce `--color` and encourage `--color`,
> `--default` together over `--get-color` alone.

I don't think we'll ever get rid of --get-color (at the very least, we'd
need a deprecation period). But it's probably worth adding a note under
the --get-color description to mention that it's a historical synonym,
and that using "--default" should be preferred.

> @@ -90,6 +91,7 @@ static struct option builtin_config_options[] = {
>  	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
>  	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
>  	OPT_BIT(0, "expiry-date", &types, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
> +	OPT_BIT(0, "color", &types, N_("value is a color"), TYPE_COLOR),
>  	OPT_GROUP(N_("Other")),
>  	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
>  	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),

I just had a funny thought. Normally in Git the "--color" option means
"colorize the output". And we are diverging from that here. I wonder if
anybody would be confused by that, or if we would ever want to later add
an option to colorize git-config output. Would we regret squatting on
--color?

I'm not sure what else to name it. Anything _except_ "--color" would
diverge from the existing scheme of "--<type>".

If we were designing from scratch, I'd consider:

  git config --type=int ...
  git config --type=color ...

etc. I'm not sure if it's worth trying to switch now (on the other hand,
it resolves the documentation issue I mentioned earlier, since that
would naturally group all of the types ;) ).

It would be pretty easy to declare "--type" as the Right Way, and list
"--int" as a historical synonym for "--type=int".

> @@ -175,6 +177,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
>  			if (git_config_expiry_date(&t, key_, value_) < 0)
>  				return -1;
>  			strbuf_addf(buf, "%"PRItime, t);
> +		} else if (types == TYPE_COLOR) {
> +			char v[COLOR_MAXLEN];
> +			if (git_config_color(v, key_, value_) < 0)
> +				return -1;
> +			strbuf_addstr(buf, v);

Looks good.

> @@ -320,6 +327,12 @@ static char *normalize_value(const char *key, const char *value)
>  		else
>  			return xstrdup(v ? "true" : "false");
>  	}
> +	if (types == TYPE_COLOR) {
> +		char v[COLOR_MAXLEN];
> +		if (!git_config_color(v, key, value))
> +			return xstrdup(value);
> +		die("cannot parse color '%s'", value);
> +	}

Interesting. This doesn't actually normalize anything, since we always
pass back the original value (or die). I think that's the right thing to
do, since otherwise you'd end up with ANSI codes in your config file.

I wondered at first if this should go in the "noop" normalization that
TYPE_PATH undergoes. But I like that it actually sanity-checks the
value. We should probably have a comment here explaining that yes, we
parse and then throw away the value (similar to the one near TYPE_PATH).

I suspect that TYPE_EXPIRY_DATE should do the same thing (parse and
complain if you fed nonsense, but always keep the original value).

> +test_expect_success 'get --color' '
> +	rm .git/config &&
> +	git config foo.color "red" &&
> +	git config --get --color foo.color | test_decode_color >actual &&
> +	echo "<RED>" >expect &&
> +	test_cmp expect actual
> +'

We should probably write this as:

  git config --get --color foo.color >actual.raw &&
  test_decode_color <actual.raw >actual

to catch failures from git-config itself (there's a lot of old tests
which pipe, but we've been trying to convert them to be more careful).

> +test_expect_success 'set --color' '
> +	rm .git/config &&
> +	git config --color foo.color "red" &&
> +	test_cmp expect .git/config
> +'
> +
> +test_expect_success 'get --color barfs on non-color' '
> +	echo "[foo]bar=not-a-color" >.git/config &&
> +	test_must_fail git config --get --color foo.bar
> +'

After reading the normalize bits above, I think there's one more case to
cover:

  test_must_fail git config --color foo.color not-a-color

> diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
> index 0e464c206..0ebece7d2 100755
> --- a/t/t1310-config-default.sh
> +++ b/t/t1310-config-default.sh
> @@ -62,6 +62,12 @@ test_expect_success 'marshal default value as expiry-date' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'marshal default value as color' '
> +	echo "\033[31m" >expect &&
> +	git config --default red --color core.foo >actual &&
> +	test_cmp expect actual
> +'

I don't offhand recall whether octal escapes with "echo" are portable.
It _is_ in POSIX, but only for XSI. I think using "printf" would be
portable.

-Peff
