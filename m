Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439ACC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 04:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE92964E2A
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 04:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBCExE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 23:53:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:45658 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhBCExD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 23:53:03 -0500
Received: (qmail 17578 invoked by uid 109); 3 Feb 2021 04:52:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Feb 2021 04:52:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12147 invoked by uid 111); 3 Feb 2021 04:52:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 23:52:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 23:52:22 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 02/14] pkt-line: promote static buffer in
 packet_write_gently() to callers
Message-ID: <YBosBuyCmBzYiRfv@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <3b03a8ff7a72c101f82a685cc6f34a5dd37a9c4b.1612208747.git.gitgitgadget@gmail.com>
 <YBkeYSA5UfQP1m/x@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2102022340460.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2102022340460.54@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 11:54:43PM +0100, Johannes Schindelin wrote:

> > Would it really be so bad to do:
> >
> >   char header[4];
> >   set_packet_header(header, packet_size);
> >   if (write_in_full(fd_out, header, 4) < 0 ||
> >       write_in_full(fd_out, buf, size) < 0)
> >           return error(...);
> 
> There must have been a reason why the original code went out of its way to
> copy the data. At least that's what I _assume_.

Having looked at the history, including the original mailing list
threads, it doesn't seem to be.

> I could see, for example, that these extra round-trips just for the
> header, really have a negative impact on network operations.

Keep in mind these won't be network round-trips. They're just syscall
round-trips. The OS would keep writing without an ACK while filling a
TCP window. The worst case may be an extra packet on the wire, though
the OS may end up coalescing the writes into a single packet anyway.

> > I doubt that two syscalls is breaking the bank here, but if people are
> > really concerned, using writev() would be a much better solution.
> 
> No, because there is no equivalent for that on Windows. And since Windows
> is the primary target of our Simple IPC/FSMonitor work, that would break
> the bank.

Are you concerned about the performance implications, or just
portability? Falling back to two writes (and wrapping that in a
function) would be easy for the latter. For the former, there's WSASend,
but I have no idea what kind of difficulties/caveats we might run into.

> > The other direction is that callers could be using a correctly-sized
> > buffer in the first place. I.e., something like:
> >
> >   struct packet_buffer {
> >           char full_packet[LARGE_PACKET_MAX];
> >   };
> >   static inline char *packet_data(struct packet_buffer *pb)
> >   {
> > 	return pb->full_packet + 4;
> >   }
> 
> Or we change it to
> 
> 	struct packet_buffer {
> 		char count[4];
> 		char payload[LARGE_PACKET_MAX - 4];
> 	};
> 
> and then ask the callers to allocate one of those beauties
> Not sure how well we can guarantee that the compiler won't pad this,
> though.

Yeah, I almost suggested the same, but wasn't sure about padding. I
think the standard allows there to be arbitrary padding between the two,
so it's really up to the ABI to define. I'd be surprised if this struct
is a problem in practice (we already have some structs which assume
4-byte alignment, and nobody seems to have complained).

> And then there is `write_packetized_from_buf()` whose `src` parameter can
> come from `convert_to_git()` that _definitely_ would not be of the desired
> form.

Yep. It really does need to either use two writes or to copy, because
it's slicing up a much larger buffer (it wouldn't be the end of the
world for it to allocate a single LARGE_PACKET_MAX heap buffer for the
duration of its run, though).

> So I guess if we can get away with the 2-syscall version, that's kind of
> better than that.

I do prefer it, because then the whole thing just becomes an
implementation detail that callers don't need to care about.

-Peff
