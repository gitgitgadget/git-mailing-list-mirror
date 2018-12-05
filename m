Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1942211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 05:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeLEFRL (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 00:17:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:59362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726037AbeLEFRL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 00:17:11 -0500
Received: (qmail 31646 invoked by uid 109); 5 Dec 2018 05:17:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 05:17:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28063 invoked by uid 111); 5 Dec 2018 05:16:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 00:16:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 00:17:09 -0500
Date:   Wed, 5 Dec 2018 00:17:09 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] test-lib-functions: introduce the 'test_set_port'
 helper function
Message-ID: <20181205051709.GD12284@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181204163457.15717-3-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 05:34:56PM +0100, SZEDER Gábor wrote:

> Several test scripts run daemons like 'git-daemon' or Apache, and
> communicate with them through TCP sockets.  To have unique ports where
> these daemons are accessible, the ports are usually the number of the
> corresponding test scripts, unless the user overrides them via
> environment variables, and thus all those tests and test libs contain
> more or less the same bit of one-liner boilerplate code to find out
> the port.  The last patch in this series will make this a bit more
> complicated.
> 
> Factor out finding the port for a daemon into the common helper
> function 'test_set_port' to avoid repeating ourselves.

OK. Looks like this should keep the same port numbers for all of the
existing tests, which I think is good. As nice as choosing random high
port numbers might be for some cases, it can also be confusing when
there are random conflicts.

I've also run into non-random conflicts, but at least once you figure
them out they're predictable (the most confusing I've seen is that adb,
the android debugger, sometimes but not always leaves a daemon hanging
around on port 5561).

> Take special care of test scripts with "low" numbers:
> 
>   - Test numbers below 1024 would result in a port that's only usable
>     as root, so set their port to '10000 + test-nr' to make sure it
>     doesn't interfere with other tests in the test suite.  This makes
>     the hardcoded port number in 't0410-partial-clone.sh' unnecessary,
>     remove it.

This part is what made me think a bit more about conflicting with
dynamically allocated ports. Arguably the http parts of t0410 ought to
be in a much higher-numbered script, but I don't know that we've held
over the years very well to the idea that scripts should only depend on
the bits from lower numbered scripts.

> ---
>  t/lib-git-daemon.sh      |  2 +-
>  t/lib-git-p4.sh          |  9 +--------
>  t/lib-git-svn.sh         |  2 +-
>  t/lib-httpd.sh           |  2 +-
>  t/t0410-partial-clone.sh |  1 -
>  t/t5512-ls-remote.sh     |  2 +-
>  t/test-lib-functions.sh  | 36 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 41 insertions(+), 13 deletions(-)

The patch itself looks good to me.

> +	eval port=\"\${$var}\"
> +	case "$port" in

The quotes in the eval'd variable assignment aren't necessary. Usually I
don't mind them in a simple:

  FOO="$bar"

even though they're redundant (and there were a few instances in the
prior patch, I think). But here the escaping makes it harder to read,
compared to:

  eval port=\$$var

It might be worth simplifying, but I don't feel strongly about it (we'd
run into problems if $var contained spaces with either variant, but I
don't think that's worth caring about).

-Peff
