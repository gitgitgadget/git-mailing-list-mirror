Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661B2C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F0020727
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgENWDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 18:03:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:46942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726126AbgENWDr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 18:03:47 -0400
Received: (qmail 17765 invoked by uid 109); 14 May 2020 22:03:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 May 2020 22:03:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5003 invoked by uid 111); 14 May 2020 22:03:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 May 2020 18:03:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 May 2020 18:03:46 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t0300: workaround bug in FreeBSD < 10 sh
Message-ID: <20200514220346.GA3074610@coredump.intra.peff.net>
References: <20200514210518.56101-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200514210518.56101-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 02:05:18PM -0700, Carlo Marcelo Arenas Belón wrote:

> 4c5971e18a (credential: treat "?" and "#" in URLs as end of host,
> 2020-04-14) introduces check_host_and_path to t0300 and some tests that
> use it, but fail in at least FreeBSD 9.3.
> 
> The variables in the here-doc fail to be expanded until they are used as
> part of the eval in check(), resulting in (ex: url=fill) instead of what
> was expected.

Wow, that's very surprising.

Just to be clear, if you run:

foo() {
  for i in "$@"; do
    echo "arg:$i"
  done
  sed s/^/stdin:/
}
set -- outer
foo inner <<EOF
$1
EOF

do you get:

arg:inner
stdin:inner

? (on dash and bash, I get stdin:outer as expected). I don't think the
fact that check() uses eval() should matter, because we'd be
interpreting that here-doc earlier as part of read_chunk().

> While at it, make sure all of the parameters which potentially sensitive
> characters (ex: ?#), are quote protected.

I don't mind more quoting, but...

> -test_expect_success 'url parser handles bare query marker' '
> -	check_host_and_path https://example.com?foo.git example.com ?foo.git
> -'
> +test_expect_success 'url parser handles bare query marker' "
> +	check_host_and_path 'https://example.com?foo.git' \
> +		example.com '?foo.git'
> +"

...please don't invert the double and single quotes. In either case the
metacharacter is subject to double-quote expansion, and by putting
the double-quotes on the outside, you've left a trap for somebody adding
more lines to the test (the shell snippet will now be interpolated
before being eval'd, which is contrary to how most of our tests run).

-Peff
