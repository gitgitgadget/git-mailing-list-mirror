Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B7C1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 03:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbdDRDmD (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 23:42:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:35052 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbdDRDmC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 23:42:02 -0400
Received: (qmail 8637 invoked by uid 109); 18 Apr 2017 03:41:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 03:41:59 +0000
Received: (qmail 8341 invoked by uid 111); 18 Apr 2017 03:42:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Apr 2017 23:42:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Apr 2017 23:41:57 -0400
Date:   Mon, 17 Apr 2017 23:41:57 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "mfick@codeaurora.org" <mfick@codeaurora.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: [PATCH] repack: respect gc.pid lock
Message-ID: <20170418034157.oi6hkg5obnca5zsa@sigill.intra.peff.net>
References: <20170413202712.22192-1-dturner@twosigma.com>
 <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
 <c6dd37238f154ccea56dda9b43f3277a@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6dd37238f154ccea56dda9b43f3277a@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 11:29:18PM +0000, David Turner wrote:

> We saw this failure in the logs multiple  times (with three different
> shas, while a gc was running):
> April 12, 2017 06:45 -> ERROR -> 'git -c repack.writeBitmaps=true repack -A -d --pack-kept-objects' in [repo] failed:
> fatal: packfile ./objects/pack/pack-[sha].pack cannot be accessed
> Possibly some other repack was also running at the time as well.
> 
> My colleague also saw it while manually doing gc (again while 
> repacks were likely to be running):

This is sort of a side question, but...why are you running other repacks
alongside git-gc? It seems like you ought to be doing one or the other.

I don't begrudge anybody with a complicated setup running their own set
of gc commands, but I'd think you would want to do locking there, and
disable auto-gc entirely. Otherwise you're going to get different
results depending on who gc'd last.

> $ git gc --aggressive
> Counting objects: 13800073, done.
> Delta compression using up to 8 threads.
> Compressing objects:  99% (11465846/11465971)   
> Compressing objects: 100% (11465971/11465971), done.
> fatal: packfile [repo]/objects/pack/pack-[sha].pack cannot be accessed

OK, so this presumably happened during the writing phase. Which seems
like the "a pack was closed, and we couldn't re-open it" problem we've
seen before.

> We have a reasonable rlimit (64k soft limit), so that failure mode is pretty 
> unlikely.  I  think we should have had 20 or so packs -- not tens of thousands.
> [...]
> Do you have any idea why this would be happening other than the rlimit thing?

Yeah, that should be enough (you could double check the return of
get_max_fd_limit() on your system if you wanted to be paranoid).

We also keep only a limited number of bytes mmap'd at one time. Normally
we don't actually close packfiles when we release their mmap windows.
But I think there is one path that might. When use_pack() maps a pack,
if the entire pack fits in a single window, then we close it; this is
due to d131b7afe (sha1_file.c: Don't retain open fds on small packs,
2011-03-02).

But if we ever unmap that window, now we have no handle to the pack.
Normally on a 64-bit system this wouldn't happen at all, since the
default core.packedGitLimit is 8GB there.

So if you have a few small packs and one very large pack (over 8GB), I
think this could trigger. We may do the small-pack thing for some of
them, and then the large pack forces us to drop the mmaps for some of
the others. When we go back to access the small pack, we find it's gone.

One solution would be to bump core.packedGitLimit to something much
higher (it's an mmap, so we're really just chewing up address space;
it's up to the OS to decide when to load pages from disk and when to
drop them).

The other alternative is to disable the small-pack closing from
d131b7afe. It might need to be configurable, or perhaps auto-tuned based
on the fd limit. Linux systems tend to have generous descriptor limits,
but I'm not sure we can rely on that. OTOH, it seems like the code to
close descriptors when needed would take care of things. So maybe we
should just revert d131b7afe entirely.

The final thing I'd ask is whether you might be on a networked
filesystem that would foil our usual "open descriptors mean packs don't
go away" logic. But after having dug into the details above, I have a
feeling the answer is simply that you have repositories >8GB.

And if that is the case, then yeah, your locking patch is definitely a
band-aid. If you fetch and repack at the same time, you'll eventually
see a racy failed fetch.

-Peff
