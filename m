Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7CED1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934386AbeGJPzl (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:55:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:53802 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934293AbeGJPzi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:55:38 -0400
Received: (qmail 23621 invoked by uid 109); 10 Jul 2018 15:55:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 15:55:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27967 invoked by uid 111); 10 Jul 2018 15:55:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 11:55:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 11:55:36 -0400
Date:   Tue, 10 Jul 2018 11:55:36 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 4/9] t/t7510: check the validation of the new config
 gpg.format
Message-ID: <20180710155536.GB23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <b02154496033220897f6f773e1149a98b21ccba7.1531208187.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b02154496033220897f6f773e1149a98b21ccba7.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 10:52:26AM +0200, Henning Schild wrote:

> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 6e2015ed9..7e1e9caf4 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -227,4 +227,14 @@ test_expect_success GPG 'log.showsignature behaves like --show-signature' '
>  	grep "gpg: Good signature" actual
>  '
>  
> +test_expect_success GPG 'check config gpg.format values' '
> +	rm .git/config &&
> +	test_config gpg.format openpgp &&
> +	git commit -S --amend -m "success" &&

You shouldn't need this "rm" here. test_config will add your config, and
then delete it after the test finishes.

I know you probably saw that in t1300 or nearby tests, but IMHO they are
wrong to do so. It's a historical wart that should be cleaned up.

> +	test_config gpg.format OpEnPgP &&
> +	git commit -S --amend -m "success" &&

A bit of a funny side effect is that we'll unset gpg.format three times
at the end of the test, since each test_config doesn't know that the
earlier invocations touched the same variable.

It's probably not worth addressing, but we could do it with an explicit:

  test_when_finished "test_unconfig gpg.format" &&
  git config gpg.format openpgp &&
  ...
  git config gpg.format OpEnPgP &&

Or alternatively, this could be three independent tests, which would
give the opportunity to describe each.

> +	test_config gpg.format malformed &&
> +	test_must_fail git commit -S --amend -m "fail" 2>result
> +'

If you're not going to look at the saved "result", we are better to just
leave stderr un-redirected. It will go to /dev/null by default, or to
the user-visible output of the test is run in verbose mode.

-Peff
