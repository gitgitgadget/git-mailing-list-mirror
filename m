Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE5561F405
	for <e@80x24.org>; Thu, 20 Dec 2018 15:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbeLTPLC (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 10:11:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:46828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730556AbeLTPLC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 10:11:02 -0500
Received: (qmail 32041 invoked by uid 109); 20 Dec 2018 15:11:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 15:11:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31368 invoked by uid 111); 20 Dec 2018 15:10:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Dec 2018 10:10:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2018 10:10:38 -0500
Date:   Thu, 20 Dec 2018 10:10:38 -0500
From:   Jeff King <peff@peff.net>
To:     Sitsofe Wheeler <sitsofe@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Periodic hang during git index-pack
Message-ID: <20181220151037.GC27361@sigill.intra.peff.net>
References: <CALjAwxiB1uDfg4iPFjh2dNibEZa5mJ0RwhCzt0R2b87NTVqWfA@mail.gmail.com>
 <20181219232200.GB21283@sigill.intra.peff.net>
 <CALjAwxg2E_48kQYt1GHkcXvVmaFyPY3PGG9rHZNMp+++UqKfow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALjAwxg2E_48kQYt1GHkcXvVmaFyPY3PGG9rHZNMp+++UqKfow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 10:03:45AM +0000, Sitsofe Wheeler wrote:

> > Check the backtrace of git-clone to see why it isn't feeding more data
> > (but note that it will generally have two threads -- one processing the
> > data from the remote, and one wait()ing for index-pack to finish).
> >
> > My guess, though, is that you'll find that git-clone is simply waiting
> > on another pipe: the one from ssh.
> 
> Ok here are backtraces from another run (with SSH multiplexing disabled):

OK, that's about what I expected. Here we have clone's sideband-demux
thread waiting to pull more packfile data from the remote:

> (gdb) thread apply all bt
> 
> Thread 2 (Thread 0x7faafbf1c700 (LWP 36586)):
> #0  0x00007faafc805384 in __libc_read (fd=fd@entry=5,
>     buf=buf@entry=0x7faafbf0ddec, nbytes=nbytes@entry=5)
>     at ../sysdeps/unix/sysv/linux/read.c:27
> #1  0x000055c8ca2f5b23 in read (__nbytes=5, __buf=0x7faafbf0ddec, __fd=5)
>     at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
> [...coming from packet_read / recv_sideband / sideband_demux...]

I assume fd=5 there is a pipe connected to ssh. You could double check
with "lsof" or similar, but I don't think it would ever be reading from
anywhere else.

And then this thread:

> Thread 1 (Thread 0x7faafce3bb80 (LWP 36584)):
> #0  0x00007faafc805384 in __libc_read (fd=fd@entry=7,
>     buf=buf@entry=0x7ffda489ef10, nbytes=nbytes@entry=46)
>     at ../sysdeps/unix/sysv/linux/read.c:27
> #1  0x000055c8ca2f5b23 in read (__nbytes=46, __buf=0x7ffda489ef10, __fd=7)
>     at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
> #2  xread (fd=fd@entry=7, buf=buf@entry=0x7ffda489ef10, len=len@entry=46)
>     at wrapper.c:260
> #3  0x000055c8ca2f5cdb in read_in_full (fd=7, buf=buf@entry=0x7ffda489ef10,
>     count=count@entry=46) at wrapper.c:318
> #4  0x000055c8ca26a54f in index_pack_lockfile (ip_out=<optimised out>)
>     at pack-write.c:297

...is us waiting on index-pack to single completion by printing out the
name of the pack's .keep file.

And then this is just index-pack:

> (gdb) thread apply all bt
> 
> Thread 1 (Thread 0x7ff8a03dab80 (LWP 36587)):
> #0  0x00007ff89fda434e in __libc_read (fd=fd@entry=0,
>     buf=buf@entry=0x5604bea43d40 <input_buffer>, nbytes=nbytes@entry=4096)
>     at ../sysdeps/unix/sysv/linux/read.c:27
> #1  0x00005604be77bb23 in read (__nbytes=4096,
>     __buf=0x5604bea43d40 <input_buffer>, __fd=0)
>     at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
> #2  xread (fd=0, buf=0x5604bea43d40 <input_buffer>, len=4096) at wrapper.c:260
> #3  0x00005604be5fb069 in fill (min=min@entry=1) at builtin/index-pack.c:255

...waiting for more data.

So though it goes back and forth between two processes, the sequence of
blocking data is linear due to the threads:

  ssh -> git-clone        -> index-pack -> git-clone
         (sideband_demux)                  (index_pack_lockfile)

with each blocking on read() from its predecessor. So you need to find
out why "ssh" is blocking. Unfortunately, short of a bug in ssh, the
likely cause is either:

  1. The git-upload-pack on the remote side stopped generating data for
     some reason. You may or may not have access on the remotehost to
     dig into that.

     It's certainly possible there's a deadlock bug between the server
     and client side of a Git conversation. But I'd find it extremely
     unlikely to find such a deadlock bug at this point in the
     conversation, because at this point the client side has nothing
     left to say to the server. The server should just be streaming out
     the packfile bytes and then closing the descriptor.

     You mentioned "Phabricator sshd scripts" running on the server.
     I don't know what Phabricator might be sticking in the middle of
     the connection, but that could be the source of the stall.

  2. It's possible the network connection dropped but ssh did not
     notice. Maybe try turning on ssh keepalives and seeing if it
     eventually times out?

-Peff
