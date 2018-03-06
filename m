Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9751F576
	for <e@80x24.org>; Tue,  6 Mar 2018 06:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeCFGwO (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 01:52:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:48428 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750769AbeCFGwN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 01:52:13 -0500
Received: (qmail 15443 invoked by uid 109); 6 Mar 2018 06:52:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Mar 2018 06:52:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1360 invoked by uid 111); 6 Mar 2018 06:53:04 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Mar 2018 01:53:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2018 07:52:08 +0100
Date:   Tue, 6 Mar 2018 07:52:08 +0100
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/4] builtin/config: introduce `--default`
Message-ID: <20180306065208.GB3522@sigill.intra.peff.net>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180306021729.45813-2-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306021729.45813-2-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 06:17:26PM -0800, Taylor Blau wrote:

> In an aim to replace:
> 
>   $ git config --get-color slot [default] [...]
> 
> with:
> 
>   $ git config --default default --color slot [...]
> 
> introduce `--defualt` to behave as if the given default were present and
> assigned to slot in the case that that slot does not exist.

I think this motivation skips over the beginning part of the story,
which is why we want "--color --default". :)

IMHO, the reason we want --default is two-fold:

  1. Callers have to handle parsing defaults themselves, like:

       foo=$(git config core.foo || echo 1234)

     For an integer, that's not too bad, since you can write "1048576"
     instead of "1M". For colors, it's abominable, which is why we added
     "--get-color". But as we add more types that are hard to parse
     (like --expiry-date), it would be nice for them to get the same
     defaulting feature without adding --get-expiry-date, etc.

  2. --get-color is a one-off unlike all of the other types. That's bad
     interface design, but the inconsistency also makes it harder to add
     features which treat the types uniformly (like, say, a --stdin
     query mode).

And perhaps minor, but it's also easier to correctly error-check
--default, since the "foo" example above would do the wrong thing if
git-config encountered a fatal error.

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 14da5fc15..390b49831 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -233,6 +233,10 @@ See also <<FILES>>.
>  	using `--file`, `--global`, etc) and `on` when searching all
>  	config files.
>  
> +--default value::
> +  When using `--get`, `--get-all`, and `--get-regexp`, behave as
> +  if value were the value assigned to the given slot.

I had thought about this in the context of --get, where a single value
makes sense.

For --get-all, would we want to be able to specify a list of objects?
E.g.:

  git config --default foo --default bar --get-all core.slot

and behave as if we found two entries, "foo" and "bar"?

I'm not really sure what semantics would be most useful.

Ditto for --get-regexp.

This isn't necessarily an objection. I'm just not sure what people would
expect. So it might make sense to start more limited and wait for a real
use case to pop up. But I'm also open to arguments about plausible use
cases. ;)

> diff --git a/builtin/config.c b/builtin/config.c
> index ab5f95476..76edefc07 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c

The general design of the implementation looks good. There's one funny
thing:

> +	if (!values.nr && default_value) {
> +		struct strbuf *item;
> +
> +		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
> +		item = &values.items[values.nr++];
> +		if (format_config(item, key_, default_value) < 0) {
> +			values.nr = 0;
> +		}

We never initialize the strbuf data here, and we can't count on
ALLOC_GROW to even zero it (which I suspect would work, but still isn't
how strbufs are meant to be used).

Do you need:

  strbuf_init(item, 0);

here, similar to what collect_config does?

(As an aside, it seems like this whole thing might be simpler with a
string_list, but that's certainly not a problem that you're introducing
here).

> +test_expect_success 'marshals default value as bool-or-int' '
> +	echo "1
> +true" >expect &&
> +	git config --default 1 --bool-or-int core.foo >actual &&
> +	git config --default true --bool-or-int core.foo >>actual &&
> +	test_cmp expect actual
> +'

Funny indentation. Use:

  {
	echo 1 &&
	echo true
  } >expect &&

or

  cat >expect <<-\EOF
  1
  true
  EOF

-Peff
