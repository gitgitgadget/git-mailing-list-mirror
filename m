Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83C8208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 10:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbdHQK5G (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 06:57:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:41570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750959AbdHQK5E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 06:57:04 -0400
Received: (qmail 9412 invoked by uid 109); 17 Aug 2017 10:57:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 10:57:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26272 invoked by uid 111); 17 Aug 2017 10:57:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 06:57:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 06:57:02 -0400
Date:   Thu, 17 Aug 2017 06:57:02 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: tsan: t5400: set_try_to_free_routine
Message-ID: <20170817105702.ma7la3xfhs7dkmy4@sigill.intra.peff.net>
References: <cover.1502780343.git.martin.agren@gmail.com>
 <939b37f809dd9e1526593c02154fae14b369c73a.1502780344.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <939b37f809dd9e1526593c02154fae14b369c73a.1502780344.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 02:53:07PM +0200, Martin Ågren wrote:

> Using SANITIZE=thread made t5400-send-pack.sh hit the potential race
> below.
> 
> This is set_try_to_free_routine in wrapper.c. The race relates to the
> reading of the "old" value. The caller doesn't care about the "old"
> value, so this should be harmless right now. But it seems that using
> this mechanism from multiple threads and restoring the earlier value
> will probably not work out every time. (Not necessarily because of the
> race in set_try_to_free_routine, but, e.g., because callers might not
> restore the function pointer in the reverse order of how they
> originally set it.)
> 
> Properly "fixing" this for thread-safety would probably require some
> redesigning, which at the time might not be warranted. I'm just posting
> this for completeness.
> 
> Martin
> 
> WARNING: ThreadSanitizer: data race (pid=21382)
>   Read of size 8 at 0x000000979970 by thread T1:
>     #0 set_try_to_free_routine wrapper.c:35 (git+0x0000006cde1c)
>     #1 prepare_trace_line trace.c:105 (git+0x0000006a3bf0)
>     #2 trace_strbuf_fl trace.c:185 (git+0x0000006a3bf0)
>     #3 packet_trace pkt-line.c:80 (git+0x0000005f9f43)
>     #4 packet_read pkt-line.c:309 (git+0x0000005fbe10)
>     #5 recv_sideband sideband.c:37 (git+0x000000684c5e)
>     #6 sideband_demux send-pack.c:216 (git+0x00000065a38c)
>     #7 run_thread run-command.c:933 (git+0x000000655a93)
>     #8 <null> <null> (libtsan.so.0+0x0000000230d9)

I was curious why the trace code would care about the free routine in
the first place. Digging in the mailing list, I didn't find a lot of
discussion. But I think the problem is basically that the trace
infrastructure wants to be thread-safe, but the default free-pack-memory
callback isn't.

It's ironic that we fix the thread-unsafety of the free-pack-memory
function by using the also-thread-unsafe set_try_to_free_routine.

Further irony: the trace routines aren't thread-safe in the first place,
as they do lazy initialization of key->fd using an "initialized" field.
In practice it probably means double-writing key->fd and leaking a
descriptor (though there are no synchronizing operations there, so it's
entirely possible a compiler could reorder the assignments to key->fd
and key->initialized and a simultaneous reader could read a garbage
key->fd value).  We also call getenv(), which isn't thread-safe with
other calls to getenv() or setenv().

I can think of a few possible directions:

  1. Make set_try_to_free_routine() skip the write if it would be a
     noop. This is racy if threads are actually changing the value, but
     in practice they aren't (the first trace of any kind will set it to
     NULL, and it will remain there).

  2. Make the free-packed routine thread-safe by taking a lock. It
     should hardly ever be called, so performance wouldn't matter. The
     big question is: _which_ lock.  pack-objects, which uses threads
     already, has a version which does this. But it knows to take the
     big program-wide "I'm accessing unsafe parts of Git" lock that the
     rest of the program uses during its multi-threaded parts.
     There's no notion in the rest of Git for "now we're going into a
     multi-threaded part, so most calls will need to take a big global
     lock before doing anything interesting".

     For parts of Git that are explicitly multi-threaded (like the
     pack-objects delta search, or index-pack's delta resolution) that's
     not so bad. But the example above is just using a sideband demuxer.
     It would be unfortunate if the entire rest of send-pack had to
     start caring about taking that lock.

  3. Is the free-pack-memory thing actually accomplishing much these
     days? It comes from 97bfeb34df (Release pack windows before
     reporting out of memory., 2006-12-24), and the primary issue is not
     actual allocated memory, but mmap'd packs clogging up the address
     space so that malloc can't find a suitable block.

     On 64-bit systems this is likely doing nothing. We have tons of
     address space. But even on 32-bit systems, the default
     core.packedGitLimit is only 256MiB (which was set around the same
     time). You can certainly come up with a corner case where freeing
     up that address space could matter. But I'd be surprised if this
     has actually helped much in practice over the years. And if you
     have a repo which is running so close to the address space limits
     of your system, the right answer is probably: upgrade to a 64-bit
     system. Even if the try-to-free thing helped in one run, it's
     likely that similar runs are not going to be so lucky, and even
     with it you're going to see sporadic out-of-memory failures.

-Peff
