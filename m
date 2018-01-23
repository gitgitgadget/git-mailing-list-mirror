Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B597B1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 16:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeAWQqI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 11:46:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:54540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751234AbeAWQqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 11:46:07 -0500
Received: (qmail 25309 invoked by uid 109); 23 Jan 2018 16:46:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 16:46:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17186 invoked by uid 111); 23 Jan 2018 16:46:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Jan 2018 11:46:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2018 11:46:05 -0500
Date:   Tue, 23 Jan 2018 11:46:05 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] travis-ci: don't fail if user already exists on 32
 bit Linux build job
Message-ID: <20180123164605.GH13068@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
 <20180122133220.18587-6-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180122133220.18587-6-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 02:32:20PM +0100, SZEDER Gábor wrote:

> The 32 bit Linux build job runs in a Docker container, which lends
> itself to running and debugging locally, too.  Especially during
> debugging one usually doesn't want to start with a fresh container
> every time, to save time spent on installing a bunch of dependencies.
> However, that doesn't work quite smootly, because the script running
> in the container always creates a new user, which then must be removed
> every time before subsequent executions, or the build script fails.
> 
> Make this process more convenient and don't try to create that user if
> it already exists and has the right user ID in the container, so
> developers don't have to bother with running a 'userdel' each time
> before they run the build script.

Makes sense.

> The build job on Travis CI always starts with a fresh Docker
> container, so this change doesn't make a difference there.

I wonder if that is fixable. Installing dependencies into the container
takes quite a lot of time, and is just wasted effort.

> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
> index e37e1d2d5f..13047adde3 100755
> --- a/ci/run-linux32-build.sh
> +++ b/ci/run-linux32-build.sh
> @@ -33,7 +33,13 @@ then
>  	CI_USER=root
>  else
>  	CI_USER=ci
> -	useradd -u $HOST_UID $CI_USER
> +	if test "$(id -u $CI_USER)" = $HOST_UID
> +	then
> +		: # user already exists with the right ID
> +	else
> +		useradd -u $HOST_UID $CI_USER
> +	fi

Is it worth redirecting the stderr of "id" to avoid noise when $CI_USER
does not yet exist at all? Or is that a useful log message? :)

-Peff
