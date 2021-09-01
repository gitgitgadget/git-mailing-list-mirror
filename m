Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEEDC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 05:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2F160C3E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 05:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbhIAFKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:10:36 -0400
Received: from verein.lst.de ([213.95.11.211]:46044 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhIAFKe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 01:10:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C1F568B05; Wed,  1 Sep 2021 07:09:35 +0200 (CEST)
Date:   Wed, 1 Sep 2021 07:09:35 +0200
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
Message-ID: <20210901050935.GA13949@lst.de>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com> <87mtp5cwpn.fsf@evledraar.gmail.com> <CANQDOdd2FDNXnXLdm2FSmxUTk3oi+mQtiW2rf3YG7MJayrexPQ@mail.gmail.com> <20210826055024.GA17178@lst.de> <CANQDOdcr0gXsdXtqfN+FFRkAumNfYmr2C3qAcdzFxY26bDPWCQ@mail.gmail.com> <20210828065700.GA31211@lst.de> <CANQDOdfV3omEBHOAq1b2P4Wb5=FCtrtsy22VvRu+FneFx9o9Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANQDOdfV3omEBHOAq1b2P4Wb5=FCtrtsy22VvRu+FneFx9o9Gw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 12:59:14PM -0700, Neeraj Singh wrote:
> > So in general there are very few metadata writes, and it is absolutely
> > essential to flush the cache before that, because otherwise your metadata
> > could point to data that might not actually have made it to disk.
> >
> > The best way to optimize such a workload is by first batching all the
> > data writeout for multiple fils in step one, then only doing one cache
> > flush and one log force (as we call it) to cover all the files.  syncfs
> > will do that, but without a good way to pick individual files.
> 
> Yes, I think we want to do step (1) of your sequence for all of the files, then
> issue steps (2-4) for all files as a group.  Of course, if the log
> fills up then we
> can flush the intermediate steps.  The unfortunate thing is that
> there's no Linux interface
> to do step (1) and to also ensure that the relevant data is in the log
> stream or is
> otherwise available to be part of the durable metadata.

There is also no interface to do 2-4 separately, mostly because they
are so hard to separate.  The only API I could envision is one that takes
an array of file descriptors and has the semantics of doing a fsync/
fdatasync for all of them, allowing the implementation to optimize
the order.  It would be implementable, but not quite as efficient
as syncfs.  I'm also pretty sure we've seen a few attempts at it in
the past that ran into various issues and didn't really make it far.

> I looked at that paper and definitely agree with you about the questionable
> implementation strategy they picked. I don't (yet) have detailed knowledge of
> SSD internals, but it's surprising to me that there is little value to
> barrier semantics
> within the drive as opposed to a full durability sync. At least for
> Windows, we have
> a database (the Registry) for which any single-threaded latency
> improvement would
> be welcome.

The major issue with barrier like in the paper above or as historic
Linux 2.6 kernels had it is that it enforces a global ordering.  For
software-only implementation like the Linux one this was already bad
enough, but a hardware/firmware implementation in nvme would mean you'd
have to add global serialize to a storage interface standard and its
implementations, while these are very much about offering parallelisms.
In fact we'd also have very similar issues with the modern Linux block
layer, which has applied some similar ideas.
