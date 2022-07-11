Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBED6C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 17:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiGKRuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiGKRuE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 13:50:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F4915A38
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 10:50:03 -0700 (PDT)
Received: (qmail 8617 invoked by uid 109); 11 Jul 2022 17:50:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Jul 2022 17:50:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21846 invoked by uid 111); 11 Jul 2022 17:50:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Jul 2022 13:50:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Jul 2022 13:50:02 -0400
From:   Jeff King <peff@peff.net>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     git@vger.kernel.org
Subject: Re: git tag triggers out-of-memory killer
Message-ID: <Ysxiyn0w/4oTQ7ks@coredump.intra.peff.net>
References: <20220711153135.35b1b135.olaf@aepfle.de>
 <YswuaPx6Mk7YkIim@coredump.intra.peff.net>
 <20220711171537.19d058da.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220711171537.19d058da.olaf@aepfle.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2022 at 05:15:37PM +0200, Olaf Hering wrote:

> I ran top(1), all the git processes were competing for memory.
> There was most of the time no memory shared, according to top.

OK, that makes sense if they really are allocating a lot of heap. They
_would_ be sharing mmap'd pages, but the memory pressure causes the OS
to evict as many of those as possible.

> This tool to process a single repository exists since a few years.
> In the past I ran it on a 12cpu/64GB machine. Today it was running the
> first time on a 96cpu/64GB machine. There is a slim chance the issue did
> not show up because the 12 processes always had access to enough memory.
> 
> I will try your suggestions.

In case you haven't seen it, read the end of:

  https://lore.kernel.org/git/YsxiSwQGvLhzNQrt@coredump.intra.peff.net/

I realized my reproduction on linux.git was not traversing a wide enough
chunk of history. Fixing that, I do see ~1GB of heap allocation. My
patch drops that substantially, but you will still be much better off
building a commit-graph file.

-Peff
