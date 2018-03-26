Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63BC91F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 08:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeCZIer (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 04:34:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:42952 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752292AbeCZIeo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 04:34:44 -0400
Received: (qmail 7866 invoked by uid 109); 26 Mar 2018 08:34:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 08:34:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17753 invoked by uid 111); 26 Mar 2018 08:35:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 04:35:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 04:34:42 -0400
Date:   Mon, 26 Mar 2018 04:34:42 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/4] builtin/config: introduce `--default`
Message-ID: <20180326083442.GB18714@sigill.intra.peff.net>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
 <20180324005556.8145-2-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180324005556.8145-2-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 08:55:53PM -0400, Taylor Blau wrote:

> This commit (and those following it in this series) aim to eventually
> replace `--get-color` with a consistent alternative. By introducing
> `--default`, we allow the `--get-color` action to be promoted to a
> `--color` type specifier, retaining the "fallback" behavior via the
> `--default` flag introduced in this commit.
> 
> For example, we aim to replace:
> 
>   $ git config --get-color slot [default] [...]
> 
> with:
> 
>   $ git config --default default --color slot [...]
> [...]
> In subsequent commits, we will offer `--color`, which (in conjunction
> with `--default`) will be sufficient to replace `--get-color`.

Not a huge deal, but I suspect you could actually get away with less
detail here (I know, I know, I asked for more in the last review).

The motivation of "--get-color is weirdly special, and other types
should match it" is probably enough without laying out all of the future
plans in this patch (which are going to end up repeated when we actually
do add --color).

I don't think it's worth a re-roll by itself, but just a thought for
future patches.

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index e09ed5d7d..d9e389a33 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -233,8 +233,10 @@ See also <<FILES>>.
>  	using `--file`, `--global`, etc) and `on` when searching all
>  	config files.
>  
> -CONFIGURATION
> --------------
> +--default value::
> +  When using `--get`, behave as if value were the value assigned to the given
> +  slot.
> +
>  `pager.config` is only respected when listing configuration, i.e., when
>  using `--list` or any of the `--get-*` which may return multiple results.
>  The default is to use a pager.

Hmm, what's going on with the CONFIGURATION header here?

For the description of "--default" itself, do we want to say something
like:

  When using `--get` and the requested slot is not found, behave as
  if...

That is hopefully a given from the name "--default", but it seems like
an important point to mention.

> @@ -258,6 +260,16 @@ static int get_value(const char *key_, const char *regex_)
>  	config_with_options(collect_config, &values,
>  			    &given_config_source, &config_options);
>  
> +	if (!values.nr && default_value) {
> +		struct strbuf *item;
> +		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
> +		item = &values.items[values.nr++];
> +		strbuf_init(item, 0);
> +		if (format_config(item, key_, default_value) < 0) {
> +			values.nr = 0;
> +		}
> +	}

If we see an error from format_config (which AFAICT is only for a bogus
expiry date; the other formats will just die() immediately), what
happens? I guess we'd eventually report "I didn't find anything". Which
is true, but I suspect we may be better off explicitly saying "your
default value was junk" (i.e., by dying right here).

> diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
> new file mode 100755
> index 000000000..0e464c206
> --- /dev/null
> +++ b/t/t1310-config-default.sh
> @@ -0,0 +1,125 @@
> +#!/bin/sh
> +
> +test_description='Test git config in different settings (with --default)'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'clear default config' '
> +	rm -f .git/config
> +'

I know that you pulled this trick from t1300, but I think we should
avoid blowing away .git/config. With the current repo-setup code we'll
still blindly treat it as a git repository, but I'm not convinced that's
not a bug. And if we ever do tighten it, we may start rejecting the
trash directory as a repository, and this would set values in the
git.git repo's config file.

Instead, doing "git config -f file" is probably a safer bet (unless you
really do want to check the system-user-repo lookup, but I don't think
we do that at all here).

> +test_expect_success 'marshals default value as bool' '
> +	echo true >expect &&
> +	git config --default true --bool core.foo >actual &&
> +	test_cmp expect actual
> +'

Maybe "--default 1" would be a better test for --bool, since it would
actually transform the value?

> +test_expect_success 'marshals default value as int' '
> +	echo 810 >expect &&
> +	git config --default 810 --int core.foo >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'marshals default value as int (storage unit)' '
> +	echo 1048576 >expect &&
> +	git config --default 1M --int core.foo >actual &&
> +	test_cmp expect actual
> +'

I'm not sure what we're really testing in the first one. The storage
unit conversion is the interesting bit.

TBH, I'm not sure we need to separately test each possible type
conversion here. If we know that the type conversions are tested
elsewhere (and I would not be surprised if they're not, but let's assume
for a moment...) and we check that type conversions are applied to
"--default" values for some types, I don't think there's any reason to
assume that the others would not work.

> +test_expect_success 'does not allow --default with --get-all' '
> +	test_must_fail git config --default quux --get-all a >output 2>&1 &&
> +	test_i18ngrep "\-\-default is only applicable to" output
> +'
> +
> +test_expect_success 'does not allow --default with --get-regexp' '
> +	test_must_fail git config --default quux --get-regexp a >output 2>&1 &&
> +	test_i18ngrep "\-\-default is only applicable to" output
> +'

For these repeated tests, this _is_ the only place we'd test the
behavior. I do have mixed feelings on this kind of completionism,
though.  While of course any kind of bug is possible, it doesn't seem
like these are likely to catch a regression. The obvious regression IMHO
would be adding a new mode that isn't caught by the --default check. But
then, it's unlikely that somebody introducing that bug would find and
update these tests to catch it.

So I dunno. They are written and they're not that complicated. But at
some point I wonder if we want to be more judicious in adding tests just
to keep the test suite to a reasonable size.

-Peff
