Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C0C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 08:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE879611C0
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 08:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhKJIjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 03:39:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:56442 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhKJIjr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 03:39:47 -0500
Received: (qmail 27300 invoked by uid 109); 10 Nov 2021 08:37:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Nov 2021 08:37:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11110 invoked by uid 111); 10 Nov 2021 08:37:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Nov 2021 03:37:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Nov 2021 03:36:59 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <neerajsi@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <YYuEq42toR6mycem@coredump.intra.peff.net>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <YYTYJpyrxtyR8yYZ@coredump.intra.peff.net>
 <YYTaiIlEKxHRVdCy@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111051010070.56@tvgsbejvaqbjf.bet>
 <YYT6tDyfBbwot2br@coredump.intra.peff.net>
 <YYpauqpBDVzOo+Px@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYpauqpBDVzOo+Px@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 12:25:46PM +0100, Patrick Steinhardt wrote:

> So I've finally found the time to have another look at massaging this
> into the ref_transaction mechanism. If we do want to batch the fsync(3P)
> calls, then we basically have two different alternatives:
> 
>     1. We first lock all loose refs by creating the respective lock
>        files and writing the updated ref into that file. We keep the
>        file descriptor open such that we can then flush them all in one
>        go.
> 
>     2. Same as before, we lock all refs and write the updated pointers
>        into the lockfiles, but this time we close each lockfile after
>        having written to it. Later, we reopen them all to fsync(3P) them
>        to disk.
> 
> I'm afraid both alternatives aren't any good: the first alternative
> risks running out of file descriptors if you queue up lots of refs. And
> the second alternative is going to be slow, especially so on Windows if
> I'm not mistaken.

I agree the first is a dead end. I had imagined something like the
second, but I agree that we'd have to measure the cost of re-opening.
It's too bad there is not a syscall to sync a particular set of paths
(or even better, a directory tree recursively).

There is another option, though: the batch-fsync code for objects does a
"cheap" fsync while we have the descriptor open, and then later triggers
a to-disk sync on a separate file. My understanding is that this works
because modern filesystems will make sure the data write is in the
journal on the cheap sync, and then the separate-file sync makes sure
the journal goes to disk.

We could do something like that here. In fact, if you don't care about
durability and just filesystem corruption, then you only care about the
first sync (because the bad case is when the rename gets journaled but
the data write doesn't).

In fact, even if you did choose to re-open and fsync each one, that's
still sequential. We'd need some way to tell the kernel to sync them all
at once. The batch-fsync trickery above is one such way (I haven't
tried, but I wonder if making a bunch of fsync calls in parallel would
work similarly).

> So with both not being feasible, we'll likely have to come up with a
> more complex scheme if we want to batch-sync files. One idea would be to
> fsync(3P) all lockfiles every $n refs, but it adds complexity in a place
> where I'd really like to have things as simple as possible. It also
> raises the question what $n would have to be.

I do think syncing every $n would not be too hard to implement. It could
all be hidden behind a state machine API that collects lock files and
flushes when it sees fit. You'd just call a magic "batch_fsync_and_close"
instead of "fsync() and close()", though you would have to remember to
do a final flush call to tell it there are no more coming.

-Peff
