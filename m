Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7BBD20966
	for <e@80x24.org>; Mon, 10 Apr 2017 13:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbdDJN6k (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 09:58:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:59175 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752760AbdDJN6k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 09:58:40 -0400
Received: (qmail 32413 invoked by uid 109); 10 Apr 2017 13:58:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 13:58:39 +0000
Received: (qmail 25090 invoked by uid 111); 10 Apr 2017 13:58:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 09:58:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 09:58:37 -0400
Date:   Mon, 10 Apr 2017 09:58:37 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test
 script
Message-ID: <20170410135837.2ukgksfxdlcfqldy@sigill.intra.peff.net>
References: <20170410125911.6800-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170410125911.6800-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 02:59:11PM +0200, SZEDER Gábor wrote:

> While this change doesn't completely eliminate the possibility of
> this race, it significantly and seemingly sufficiently reduces its
> probability.  Running t6500 in a loop while my box was under heavy CPU
> and I/O load usually triggered the error under 15 seconds, but with
> this patch it run overnight without incident.
> 
> (Alternatively, we could check the presence of the gc.pid file after
> starting the detached auto gc, and wait while it's there.  However,
> this would create a different race: the auto gc process creates the
> pid file after it goes to the background, so our check in the
> foreground might racily look for the pid file before it's even
> created, and thus would not wait for the background gc to finish.
> Furthermore, this would open up the possibility of the test hanging if
> something were to go wrong with the gc process and the pid file were
> not removed.)

Could we just leave open a pipe descriptor that the child inherits, and
wait for it to close?

Something like:

  git gc --auto 9>&1 | read

should wait until the background gc process finishes. It depends on our
daemonize() not closing descriptors beyond 0/1/2, but that is certainly
the case now.

It also loses the exit status of the main "git gc", but that can be
fixed with shell hackery:

  code=$(sh -c 'git gc --auto; echo $?' 9>&1)
  test "$code" = 0

-Peff
