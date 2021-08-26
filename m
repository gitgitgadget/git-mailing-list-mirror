Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18098C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 05:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CC261037
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 05:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhHZFvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 01:51:14 -0400
Received: from verein.lst.de ([213.95.11.211]:58097 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhHZFvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 01:51:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD9FC6736F; Thu, 26 Aug 2021 07:50:24 +0200 (CEST)
Date:   Thu, 26 Aug 2021 07:50:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
Message-ID: <20210826055024.GA17178@lst.de>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com> <87mtp5cwpn.fsf@evledraar.gmail.com> <CANQDOdd2FDNXnXLdm2FSmxUTk3oi+mQtiW2rf3YG7MJayrexPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANQDOdd2FDNXnXLdm2FSmxUTk3oi+mQtiW2rf3YG7MJayrexPQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 05:49:45PM -0700, Neeraj Singh wrote:
> Unfortunately my perusal of the man pages and documentation I could find doesn't
> give me this level of confidence on typical Linux filesystems. For
> instance, the notion of having to
> fsync the parent directory in order to render an inode's link findable
> eliminates a lot of the
> advantage of this change, though we could batch those and would have
> to do at most 256.
> 
> This thread is somewhat instructive, but inconclusive:
> https://lwn.net/ml/linux-fsdevel/1552418820-18102-1-git-send-email-jaya@cs.utexas.edu/.

fsync/fdatasync only guarantees consistency for the file handle they
are called on.  The first linked document mentioned an implementation
artifact that file systems with metadata logging tend to force their
log out until the last modified transaction and thus force out metadata
changes done earlier.  This won't help with actual data writes at all,
as for them the fact of writing back data will often generate new
metadata changes., and in general is not a property to rely on if you
care about data integrity.  It is nice to optimize the order of the
fsync calls for metadata only workloads, as then often the later fsync
calls on earlier modified file handles will be no-ops.

> One conclusion from reviewing that thread is that as of then,
> sync_file_ranges isn't actually enough
> to make a hard guarantee about writeout occurring. See
> https://lore.kernel.org/linux-fsdevel/20190319204330.GY26298@dastard/.
> My hope is that the Linux FS developers have rectified that shortcoming by now.

I'm not sure what shortcoming you mean.  sync_file_ranges is a system
call that only causes data writeback.  It never performs metadata write
back and thus is not an integrity operation at all.  That is also very
clearly documented in the man page.

> I think my updated version of the documentation for "= false" is
> accurate and more helpful
> from a user perspective ("up to OS policy when your data becomes durable in
> the event of an unclean shutdown").  "= true" also has a reasonable
> description, though I
> might add some verbiage indicating that this setting could be costly.

Your version is much better.  In fact it almost still too nice as in
general it will not be durable and you do end up with a corrupted
repository in that case.  Note that even for bad old ext3 that was
usually the case.
