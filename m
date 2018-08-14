Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592D21F404
	for <e@80x24.org>; Tue, 14 Aug 2018 14:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbeHNRlQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 13:41:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:54618 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731985AbeHNRlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 13:41:16 -0400
Received: (qmail 24586 invoked by uid 109); 14 Aug 2018 14:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 14:53:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22838 invoked by uid 111); 14 Aug 2018 14:53:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 10:53:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 10:53:44 -0400
Date:   Tue, 14 Aug 2018 10:53:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
Message-ID: <20180814145344.GC3441@sigill.intra.peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
 <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
 <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
 <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
 <xmqqr2j23tnb.fsf@gitster-ct.c.googlers.com>
 <84c749fd-23d2-0bc5-225b-74f8d31502b6@kdbg.org>
 <87eff2rmgt.fsf@evledraar.gmail.com>
 <20180813223701.GC16006@sigill.intra.peff.net>
 <87a7pprred.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7pprred.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 03:47:54PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The relevant POSIX docs are here:
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/write.html
> 
>     Write requests of {PIPE_BUF} bytes or less shall not be interleaved
>     with data from other processes doing writes on the same pipe. Writes
>     of greater than {PIPE_BUF} bytes may have data interleaved, on
>     arbitrary boundaries, with writes by other processes, whether or not
>     the O_NONBLOCK flag of the file status flags is set.

Right, this is the part I've seen, but it's pretty clearly only about
pipes, not regular files.

> > Certainly atomic writes to _pipes_ are determined by PIPE_BUF (which
> > IIRC is not even a constant on Linux, but can be changed at run-time).
> > But is it relevant for regular-file writes?
> 
> I believe it's hardcoded at PIPE_BUF which is defined as PAGE_SIZE on
> linux. I think you may be thinking of /proc/sys/fs/pipe-max-pages which
> is the number of pages that a pipe will take before filling up, but I
> may be wrong.

Yeah, you're probably right.

> > So obviously this is all a bit of a tangent. I'd be fine declaring that
> > trace output is generally small enough not to worry about this in the
> > first place. But those results show that it shouldn't matter even if
> > we're writing 1MB trace lines on Linux. I wouldn't be at all surprised
> > to see different results on other operating systems, though.
> 
> I don't know how this works internally in the kernel, but I'd be very
> careful to make that assertion. Most likely this in practice depends on
> what FS you're using, its mount options, whether fsync() is involved,
> I/O pressure etc.

Definitely it depends on the filesystem (and I'm pretty sure that at
least old versions of NFS could not possibly do O_APPEND correctly,
because the protocol did not support an atomic seek+write).

I agree that the experiment I did doesn't really tell us anything for
sure. It _seems_ to work, but the machine was not under any kind of
memory or I/O pressure.

I'd feel pretty confident that writes under a page are always going to
be fine, but anything else is "seems to work". To me that's enough for
tracing, as the absolute worst case is jumbled output, not an on-disk
corruption.

> FWIW this is something I've ran into in the past on Linux as a practical
> matter, but that was many kernel versions ago, so maybe the semantics
> changed.
> 
> We had an ad-hoc file format with each chunk a "<start
> marker><length><content><end marker>\n" format (and the <content> was
> guaranteed not to contain "\n"). These would be written to the same file
> by N workers. We would get corrupt data because of this in cases where
> we were writing more than PIPE_BUF, e.g. start markers for unrelated
> payloads interleaved with content, lines that were incorrectly formed
> etc.

Interesting. I wonder if it is because of PIPE_BUF, or it is simply the
page size, which also happens to be the value of PIPE_BUF.

> But yeah, whether this is a practical concern for git trace output is
> another matter. I just wanted to chime in to note that atomic appends to
> files are only portable on POSIX up to PIPE_BUF.

I still think POSIX doesn't say anything either way here. The PIPE_BUF
bits are _just_ about pipes. At any rate, I think we have a decent
handle on what systems actually _do_, which is more important than POSIX
anyway.

-Peff
