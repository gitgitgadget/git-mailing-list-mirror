Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304C8C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 06:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0795E60FBF
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 06:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhH1G5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 02:57:54 -0400
Received: from verein.lst.de ([213.95.11.211]:35820 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233362AbhH1G5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 02:57:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE90267373; Sat, 28 Aug 2021 08:57:00 +0200 (CEST)
Date:   Sat, 28 Aug 2021 08:57:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
Message-ID: <20210828065700.GA31211@lst.de>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com> <87mtp5cwpn.fsf@evledraar.gmail.com> <CANQDOdd2FDNXnXLdm2FSmxUTk3oi+mQtiW2rf3YG7MJayrexPQ@mail.gmail.com> <20210826055024.GA17178@lst.de> <CANQDOdcr0gXsdXtqfN+FFRkAumNfYmr2C3qAcdzFxY26bDPWCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANQDOdcr0gXsdXtqfN+FFRkAumNfYmr2C3qAcdzFxY26bDPWCQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 05:20:44PM -0700, Neeraj Singh wrote:
> You're right. On re-read of the man page, sync_file_range is listed as
> an "extremely dangerous"
> system call.  The opportunity in the linux kernel is to offer an
> alternative set of flags or separate
> API that allows for an application like Git to separate a metadata
> writeback request from the disk flush.

How do you want to do that?  I metadata writeback without a cache flush
is worse than useless, in fact it is generally actively harmful.

To take XFS as an example:  fsync and fdatasync do the following thing:

 1) writeback all dirty data for file to the data device
 2) flush the write cache of the data device to ensure they are really
    on disk before writing back the metadata referring to them
 3) write out the log up until the log sequence that contained the last
    modifications to the file
 4) flush the cache for the log device.
    If the data device and the log device are the same (they usually are
    for common setups) and the log device support the FUA bit that writes
    through the cache, the log writes use that bit and this step can
    be skipped.

So in general there are very few metadata writes, and it is absolutely
essential to flush the cache before that, because otherwise your metadata
could point to data that might not actually have made it to disk.

The best way to optimize such a workload is by first batching all the
data writeout for multiple fils in step one, then only doing one cache
flush and one log force (as we call it) to cover all the files.  syncfs
will do that, but without a good way to pick individual files.

> Separately, I'm hoping I can push from the Windows filesystem side to
> get a barrier primitive put into
> the NVME standard so that we can offer more useful behavior to
> applications rather than these painful
> hardware flushes.

I'm not sure what you mean with barriers, but if you mean the concept
of implying a global ordering on I/Os as we did in Linux back in the
bad old days the barrier bio flag, or badly reinvented by this paper:

  https://www.usenix.org/conference/fast18/presentation/won

they might help a little bit with single threaded operations, but will
heavily degrade I/O performance for multithreaded workloads.  As an
active member of (but not speaking for) the NVMe technical working group
with a bit of knowledge of SSD internals I also doubt it will be very
well received there.
