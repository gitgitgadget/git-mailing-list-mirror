Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D4E20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeLKK6O (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:58:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:38000 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726527AbeLKK6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:58:14 -0500
Received: (qmail 15161 invoked by uid 109); 11 Dec 2018 10:58:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 10:58:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4076 invoked by uid 111); 11 Dec 2018 10:57:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 05:57:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 05:57:50 -0500
Date:   Tue, 11 Dec 2018 05:57:50 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/7] test-lib: translate SIGTERM and SIGHUP to an exit
Message-ID: <20181211105750.GB8452@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181209225628.22216-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181209225628.22216-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 09, 2018 at 11:56:22PM +0100, SZEDER Gábor wrote:

> Right now if a test script receives SIGTERM or SIGHUP (e.g., because a
> test was hanging and the user 'kill'-ed it or simply closed the
> terminal window the test was running in), the shell exits immediately.
> This can be annoying if the test script did any global setup, like
> starting apache or git-daemon, as it will not have an opportunity to
> clean up after itself. A subsequent run of the test won't be able to
> start its own daemon, and will either fail or skip the tests.
> 
> Instead, let's trap SIGTERM and SIGHUP as well to make sure we do a
> clean shutdown, and just chain it to a normal exit (which will trigger
> any cleanup).
> 
> This patch follows suit of da706545f7 (t: translate SIGINT to an exit,
> 2015-03-13), and even stole its commit message as well.

No wonder it was so nicely explained. ;)

I think this is quite a reasonable thing to do. Since we're trying to
clean up, in theory we would like to hook any signal death, but these
three are the common ones in practice. We handle QUIT and PIPE as well
in our C code; the latter isn't an issue here. SIGQUIT is a possibility,
I guess, but seems rather unlikely.

-Peff
