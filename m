Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1411F576
	for <e@80x24.org>; Tue,  6 Mar 2018 07:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbeCFHBD (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 02:01:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:48458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750838AbeCFHBC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 02:01:02 -0500
Received: (qmail 15817 invoked by uid 109); 6 Mar 2018 07:01:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Mar 2018 07:01:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1460 invoked by uid 111); 6 Mar 2018 07:01:53 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Mar 2018 02:01:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2018 08:00:57 +0100
Date:   Tue, 6 Mar 2018 08:00:57 +0100
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 4/4] builtin/config: introduce `--color` type specifier
Message-ID: <20180306070057.GE3522@sigill.intra.peff.net>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180306021729.45813-5-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306021729.45813-5-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 06:17:29PM -0800, Taylor Blau wrote:

> As of this commit, the cannonical way to retreive an ANSI-compatible
> color escape sequence from a configuration file is with the
> `--get-color` action.
> 
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

Sounds good. Do we want to explicitly mark "--get-color" as historical
and/or deprecated in the git-config manpage? We won't remove it for a
long time, but this would start the cycle.

> @@ -168,6 +170,12 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
>  			if (git_config_expiry_date(&t, key_, value_) < 0)
>  				return -1;
>  			strbuf_addf(buf, "%"PRItime, t);
> +		} else if (types == TYPE_COLOR) {
> +			char *v = xmalloc(COLOR_MAXLEN);
> +			if (git_config_color(&v, key_, value_) < 0)
> +				return -1;
> +			strbuf_addstr(buf, v);
> +			free((char *) v);

No need to cast the argument to free, unless you're getting rid of a
"const" (but here "v" already has type "char *").

However, do we need heap allocation here at all? I think:

  char v[COLOR_MAXLEN];
  if (git_config_color(v, key_, value_) < 0)
	return -1;
  strbuf_addstr(buf, v);

would suffice (and would also fix the leak when we return on error).

Ditto for the call in normalize_value().

> @@ -313,6 +321,15 @@ static char *normalize_value(const char *key, const char *value)
>  		else
>  			return xstrdup(v ? "true" : "false");
>  	}
> +	if (types == TYPE_COLOR) {
> +		char *v = xmalloc(COLOR_MAXLEN);
> +		if (!git_config_color(&v, key, value)) {
> +			free((char *) v);
> +			return xstrdup(value);
> +		}
> +		free((char *) v);
> +		die("cannot parse color '%s'", value);
> +	}
>  
>  	die("BUG: cannot normalize type %d", types);
>  }
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 4f8e6f5fd..c03f54fbe 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -931,6 +931,22 @@ test_expect_success 'get --expiry-date' '
>  	test_must_fail git config --expiry-date date.invalid1
>  '
>  
> +cat >expect <<EOF
> +[foo]
> +	color = red
> +EOF
> +
> +test_expect_success 'get --color' '
> +	rm .git/config &&
> +	git config --color foo.color "red" &&
> +	test_cmp expect .git/config
> +'
> +
> +test_expect_success 'get --color barfs on non-color' '
> +	echo "[foo]bar=not-a-color" >.git/config &&
> +	test_must_fail git config --get --color foo.bar
> +'

Looks good. The out-of-block setup of expect violates our modern style,
but matches the surrounding code.

-Peff
