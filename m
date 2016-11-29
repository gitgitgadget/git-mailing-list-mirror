Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9281FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 21:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756173AbcK2V4o (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 16:56:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:48782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754993AbcK2Vzl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 16:55:41 -0500
Received: (qmail 18521 invoked by uid 109); 29 Nov 2016 21:55:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 21:55:41 +0000
Received: (qmail 15795 invoked by uid 111); 29 Nov 2016 21:56:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 16:56:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2016 16:55:38 -0500
Date:   Tue, 29 Nov 2016 16:55:38 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Partial fetch?
Message-ID: <20161129215538.vhgmxpq4rasri4vm@sigill.intra.peff.net>
References: <CAOE4rSzTq6DVR2ch+as9Pbo35NjKP5b1+Ub1XZWEnwJTahqEfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOE4rSzTq6DVR2ch+as9Pbo35NjKP5b1+Ub1XZWEnwJTahqEfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2016 at 10:34:51PM +0200, Dāvis Mosāns wrote:

> I'm trying to fetch a remote repository over https but sadly it
> timeouts too soon.
> 
> $ git fetch -v upstream
> POST git-upload-pack (gzip 1148 to 641 bytes)
> POST git-upload-pack (gzip 1148 to 644 bytes)
> [...]
> Is there some way to fetch partially by smaller chunks and then repeat
> that again till everything is fetched?

Not an easy one. The series of POSTs is an indication that the fetch
negotiation is going on for a long time, which probably means you have a
lot of commits in your local repository that aren't in the remote, or
vice versa.

Here are the things I might try:

  - git v2.10.2 has commit 06b3d386e (fetch-pack: do not reset in_vain
    on non-novel acks, 2016-09-23), which may help with this.

  - HTTP, because the server is stateless, performs less well than other
    protocols. If you can fetch over ssh or git://, it will probably
    just work.

  - If this is a one-time thing to fetch unrelated history from another
    repository, you can "clone --mirror" instead of fetching,
    then fetch from the mirror locally. Subsequent fetches should be
    fast.

If you do try v2.10.2 and it improves things, I'd be interested to hear
about it as a data point.

-Peff
