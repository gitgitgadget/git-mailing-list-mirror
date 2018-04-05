Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230F61F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbeDEW3w (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:29:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:55150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752666AbeDEW3v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:29:51 -0400
Received: (qmail 9690 invoked by uid 109); 5 Apr 2018 22:29:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 22:29:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20049 invoked by uid 111); 5 Apr 2018 22:30:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 18:30:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 18:29:49 -0400
Date:   Thu, 5 Apr 2018 18:29:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v4 1/3] builtin/config: introduce `--default`
Message-ID: <20180405222949.GC29117@sigill.intra.peff.net>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
 <20180405025912.GB49902@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405025912.GB49902@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 07:59:12PM -0700, Taylor Blau wrote:

> @@ -286,6 +288,16 @@ static int get_value(const char *key_, const char *regex_)
>  	config_with_options(collect_config, &values,
>  			    &given_config_source, &config_options);
>  
> +	if (!values.nr && default_value) {
> +		struct strbuf *item;
> +		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
> +		item = &values.items[values.nr++];
> +		strbuf_init(item, 0);
> +		if (format_config(item, key_, default_value) < 0) {
> +			exit(1);
> +		}
> +	}

Calling exit() explicitly is unusual for our code. Usually we would
either die() or propagate the error. Most of the types in
format_config() would die on bogus input, but a few code paths will
return an error.

What happens if a non-default value has a bogus format? E.g.:

  $ git config foo.bar '~NoSuchUser'
  $ git config --path foo.bar
  fatal: failed to expand user dir in: '~NoSuchUser'

Oops. Despite us checking for an error return from
git_config_pathname(), it will always either return 0 or die(). So
that's not a good example. ;)

Let's try expiry-date:

  $ git config foo.bar 'the first of octember'
  $ git config --expiry-date foo.bar
  error: 'the first of octember' for 'foo.bar' is not a valid timestamp
  fatal: bad config line 7 in file .git/config

OK. So we call format_config() there from the actual collect_config()
callback, and the error gets propagated back to the config parser, which
then gives us an informative die(). What happens with your new code:

  $ ./git config --default 'the first of octember' --type=expiry-date no.such.key
  error: 'the first of octember' for 'no.such.key' is not a valid timestamp

It's obvious in this toy example, but that config call may be buried
deep in a script. It'd probably be nicer for that exit(1) to be
something like:

  die(_("failed to format default config value"));

> +test_expect_success 'does not allow --default without --get' '
> +	test_must_fail git config --default quux --unset a >output 2>&1 &&
> +	test_i18ngrep "\-\-default is only applicable to" output
> +'

I think "a" here needs to be "a.section". I get:

  error: key does not contain a section: a

-Peff
