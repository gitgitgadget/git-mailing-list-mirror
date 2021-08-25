Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46ECC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 05:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD1861368
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 05:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhHYFj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 01:39:28 -0400
Received: from verein.lst.de ([213.95.11.211]:54782 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232146AbhHYFj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 01:39:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E92086736F; Wed, 25 Aug 2021 07:38:39 +0200 (CEST)
Date:   Wed, 25 Aug 2021 07:38:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
Message-ID: <20210825053839.GA27037@lst.de>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 01:51:32AM +0000, Neeraj Singh via GitGitGadget wrote:
> From: Neeraj Singh <neerajsi@microsoft.com>
> 
> When adding many objects to a repo with core.fsyncObjectFiles set to
> true, the cost of fsync'ing each object file can become prohibitive.
> 
> One major source of the cost of fsync is the implied flush of the
> hardware writeback cache within the disk drive. Fortunately, Windows,
> MacOS, and Linux each offer mechanisms to write data from the filesystem
> page cache without initiating a hardware flush.
> 
> This patch introduces a new 'core.fsyncObjectFiles = 2' option that
> takes advantage of the bulk-checkin infrastructure to batch up hardware
> flushes.

Another interesting way to flush on linux would be the syncfs call,
which syncs all files on a file system.  Once you write more than
handful or two of files that tends to win out over a batch of fsync
calls.
