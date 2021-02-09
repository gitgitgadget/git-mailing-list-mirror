Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C41C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5AE64D9D
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhBIQd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:33:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:55014 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhBIQdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 11:33:25 -0500
Received: (qmail 26918 invoked by uid 109); 9 Feb 2021 16:32:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Feb 2021 16:32:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7414 invoked by uid 111); 9 Feb 2021 16:32:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Feb 2021 11:32:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Feb 2021 11:32:43 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 11/14] unix-socket: add options to unix_stream_listen()
Message-ID: <YCK5K/nK4tGnTvou@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <7a6a69dfc20c6ff190cb020931c46bf4d88bab59.1612208747.git.gitgitgadget@gmail.com>
 <YBkmD14Nqqxe4pxG@coredump.intra.peff.net>
 <b7a6f741-c52a-db24-3349-dc69610ce21f@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7a6f741-c52a-db24-3349-dc69610ce21f@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 05, 2021 at 06:28:13PM -0500, Jeff Hostetler wrote:

> > OK. I'm still not sure of the endgame here for writing non-racy code to
> > establish the socket (which is going to require either some atomic
> > renaming or some dot-locking in the caller).  But it's plausible to me
> > that this option will be a useful primitive.
> 
> In part 14/14 in `ipc-unix-sockets.c:create_listener_socket()` I have
> code in the calling layer to (try to) handle both the startup races
> and basic collisions with existing long-running servers already using
> the socket.

There you make a temp socket and then try to rename it into place.  But
because rename() overwrites the destination, it still seems like two
creating processes can race each other. Something like:

  0. There's no "foo" socket (or maybe there is a stale one that
     nobody's listening on).

  1. Process A wants to become the listener. So it creates foo.A.

  2. Process B likewise. It creates foo.B.

  3. Process A renames foo.A to foo. It believes it will now service
     clients.

  4. Process B renames foo.B to foo. Now process A is stranded but
     doesn't realize it.

I.e., I don't think this is much different than an unlink+create
strategy. You've eliminated the window where a process C shows up during
steps 3 and 4 and sees no socket (because somebody else is in the midst
of a non-atomic unlink+create operation). But there's no atomicity
between the "ping the socket" and "create the socket" steps.

> But you're right, it might be good to revisit that as a primitive at
> this layer.  We only have 1 other caller right now and I don't know
> enough about `credential-cache--daemon` to know if it would benefit
> from this or not.

Yeah, having seen patch 14, it looks like your only new caller always
sets the new unlink option to 1. So it might not be worth making it
optional if you don't need it (especially because the rename trick,
assuming it's portable, is superior to unlink+create; and you'd always
be fine with an unlink on the temp socket).

The call in credential-cache--daemon is definitely racy. It's pretty
much the same thing: it pings the socket to see if it's alive, but is
still susceptible to the problem above. I was was never too concerned
about it, since the whole point of the daemon is to hang around until
its contents expire. If it loses the race and nobody contacts it, the
worst case is it waits 30 seconds for somebody to give it data before
exiting. It would benefit slightly from switching to the rename
strategy, but the bigger race would remain.

-Peff
