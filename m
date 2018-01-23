Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED4C1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeAWQal (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 11:30:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:54452 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751545AbeAWQak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 11:30:40 -0500
Received: (qmail 24536 invoked by uid 109); 23 Jan 2018 16:30:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 16:30:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16962 invoked by uid 111); 23 Jan 2018 16:31:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Jan 2018 11:31:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2018 11:30:38 -0500
Date:   Tue, 23 Jan 2018 11:30:38 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] travis-ci: don't repeat the path of the cache
 directory
Message-ID: <20180123163038.GF13068@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
 <20180122133220.18587-4-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180122133220.18587-4-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 02:32:18PM +0100, SZEDER Gábor wrote:

> Some of our 'ci/*' scripts repeat the name or full path of the Travis
> CI cache directory, and the following patches will add new places
> using that path.
> 
> Use a variable to refer to the path of the cache directory instead, so
> it's hard-coded only in a single place.
> 
> Pay extra attention to the 32 bit Linux build: it runs in a Docker
> container, so pass the path of the cache directory from the host to
> the container in an environment variable.  Furthermore, use the
> variable in the container only if it's set, to prevent errors when
> someone is running or debugging the Docker build locally, because in
> that case the variable won't be set as there won't be any Travis CI
> cache.

Makes sense that we need to pass it down, but...

> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
> index 248183982b..c9476d6598 100755
> --- a/ci/run-linux32-build.sh
> +++ b/ci/run-linux32-build.sh
> @@ -25,10 +25,10 @@ CI_USER=$USER
>  test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER)
>  
>  # Build and test
> -linux32 --32bit i386 su -m -l $CI_USER -c '
> +linux32 --32bit i386 su -m -l $CI_USER -c "
>  	set -ex
>  	cd /usr/src/git
> -	ln -s /tmp/travis-cache/.prove t/.prove
> +	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
>  	make --jobs=2
>  	make --quiet test
> -'
> +"

This interpolates $cache_dir while generating the snippet. You've stuck
it in single-quotes, which prevents most quoting problems, but obviously
it's an issue if the variable itself contains a single-quote. Is there
a reason not to just export $cache_dir in the environment and access it
directly from the snippet?

Probably not a _big_ deal, since we control the contents of the
variable, but it just seems like a fragile practice to avoid.

-Peff
