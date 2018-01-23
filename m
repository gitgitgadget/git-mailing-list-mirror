Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5081F404
	for <e@80x24.org>; Tue, 23 Jan 2018 16:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeAWQnn (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 11:43:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:54508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751234AbeAWQnm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 11:43:42 -0500
Received: (qmail 25177 invoked by uid 109); 23 Jan 2018 16:43:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 16:43:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17086 invoked by uid 111); 23 Jan 2018 16:44:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Jan 2018 11:44:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2018 11:43:40 -0500
Date:   Tue, 23 Jan 2018 11:43:40 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] travis-ci: don't run the test suite as root in the
 32 bit Linux build
Message-ID: <20180123164340.GG13068@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
 <20180122133220.18587-5-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180122133220.18587-5-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 02:32:19PM +0100, SZEDER Gábor wrote:

> Travis CI runs the 32 bit Linux build job in a Docker container, where
> all commands are executed as root by default.  Therefore, ever since
> we added this build job in 88dedd5e7 (Travis: also test on 32-bit
> Linux, 2017-03-05), we have a bit of code to create a user in the
> container matching the ID of the host user and then to run the test
> suite as this user.  Matching the host user ID is important, because
> otherwise the host user would have no access to any files written by
> processes running in the container, notably the logs of failed tests
> couldn't be included in the build job's trace log.
> 
> Alas, this piece of code never worked, because it sets the variable
> holding the user name ($CI_USER) in a subshell, meaning it doesn't
> have any effect by the time we get to the point to actually use the
> variable to switch users with 'su'.  So all this time we were running
> the test suite as root.

This all makes sense to me, and the patch looks sane.

> Reorganize that piece of code in 'ci/run-linux32-build.sh' a bit to
> avoid that problematic subshell and to ensure that we switch to the
> right user.  Furthermore, make the script's optional host user ID
> option mandatory, so running the build accidentally as root will
> become harder when debugging locally.  If someone really wants to run
> the test suite as root, whatever the reasons might be, it'll still be
> possible to do so by explicitly passing '0' as host user ID.

Coincidentally, we recently set up a docker test build for our local fork
of Git. We found the whole "mount the existing git source tree" strategy
slightly annoying, exactly because of these mismatches between the host
and docker uids.

Instead, we ended up with something more like:

  git archive HEAD | docker run ...

and the in-container script starts with:

  tar -x

to extract the to-be-tested source, and ends with a dump of the failures
to stdout.

I don't know if it's worth switching strategies now, but just some food
for thought. It may be less interesting with Travis, too, because you're
also trying to carry the prove cache across runs, which does require
some filesystem interaction.

(As an aside, I'm not sure the prove cache is doing much. Running in
slow-to-fast order helps if you are trying to run massively in parallel,
but we only use -j3 for our Travis builds).

-Peff
