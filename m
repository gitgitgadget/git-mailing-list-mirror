Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B904BC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 07:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhK3H0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 02:26:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:39982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhK3H0z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 02:26:55 -0500
Received: (qmail 11886 invoked by uid 109); 30 Nov 2021 07:23:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Nov 2021 07:23:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12389 invoked by uid 111); 30 Nov 2021 07:23:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Nov 2021 02:23:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Nov 2021 02:23:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
Message-ID: <YaXRd2YBQR+ifNTE@coredump.intra.peff.net>
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <xmqqtufu2pll.fsf@gitster.g>
 <YaXPUe9Sz3JBlzYL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YaXPUe9Sz3JBlzYL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 02:14:25AM -0500, Jeff King wrote:

>   - flushing causes us to block. This implies our stdout is connected to
>     a pipe or socket, and the other side is not expecting to read. A
>     plausible case here is a client sending us a big input which we find
>     to be bogus (maybe index-pack checking an incoming pack). We call
>     die() to complain about the input, but the client is still writing.
>     In the current code, we'd write out our error and then exit; the
>     client would get SIGPIPE or a write() error and abort. But with a
>     flush here, we could block writing back to the client, and now we're
>     in a deadlock; they are trying to write to us but we are no longer
>     reading, and we are blocked trying to get out a little bit of
>     irrelevant stdout data.
> 
>     I _think_ we're probably OK here. The scenario above means that the
>     caller is already doing asynchronous I/O via stdio and is subject to
>     deadlock. Because the segment of buffer we try to flush here _could_
>     have been flushed already under the hood, which would have caused
>     the same blocking. A careful caller might be using select() or
>     similar to decide when it is OK to write, but I find it highly
>     unlikely they'd be using stdio in that case.
> 
> Of the two, the deadlock case worries me more, just because it would be
> quiet subtle and racy. As I said, I think we may be OK, but my reasoning
> there is pretty hand-wavy.

Thinking on this a bit more: I guess as soon as we exit libc would call
the equivalent of fflush(NULL) anyway, and try that same flush. So in a
sense this is just ordering a bit differently, and not introducing any
new problems. (Unless libc is clever enough to avoid blocking, but that
doesn't seem like something we could or should rely on in general).

-Peff
