Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA82FC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 05:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8675661037
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 05:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhHZFz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 01:55:29 -0400
Received: from verein.lst.de ([213.95.11.211]:58108 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhHZFz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 01:55:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C686F6736F; Thu, 26 Aug 2021 07:54:39 +0200 (CEST)
Date:   Thu, 26 Aug 2021 07:54:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
Message-ID: <20210826055439.GA17560@lst.de>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com> <20210825053839.GA27037@lst.de> <CANQDOdf7rMyT4Swriw9=Ei7KN1iLv_dGDWSSck22Zu6AztOyjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANQDOdf7rMyT4Swriw9=Ei7KN1iLv_dGDWSSck22Zu6AztOyjg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 10:40:53AM -0700, Neeraj Singh wrote:
> I'd expect syncfs to suffer from the noisy-neighbor problem that Linus
> alluded to on the big
> thread you kicked off.

It does.  That being said I suspect in most developer workstation
use cases it will still be a win.  Maybe I'll look into implemeting
it after your series lands.

> If someone adds a more targeted bulk sync interface to the Linux
> kernel, I'm sure Git could be
> changed to use it. Maybe an fcntl(2) interface that initiates
> writeback and registers completion with an
> eventfd.

That is in general very hard to do with how the VM-level writeback
occurs.  In the file system itself it could work much better, e.g.
for XFS we write the log up to a specific sequence number and could
notify when doing that.
