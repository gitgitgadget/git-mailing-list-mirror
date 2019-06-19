Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C3D51F462
	for <e@80x24.org>; Wed, 19 Jun 2019 18:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFSS7g (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 14:59:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:44402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726332AbfFSS7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 14:59:36 -0400
Received: (qmail 11730 invoked by uid 109); 19 Jun 2019 18:56:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 18:56:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8320 invoked by uid 111); 19 Jun 2019 19:00:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 15:00:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 14:59:34 -0400
Date:   Wed, 19 Jun 2019 14:59:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: only run 'gc' once when fetching multiple remotes
Message-ID: <20190619185934.GC28145@sigill.intra.peff.net>
References: <20190619094630.32557-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619094630.32557-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 04:46:30PM +0700, Nguyễn Thái Ngọc Duy wrote:

> In multiple remotes mode, git-fetch is launched for n-1 remotes and the
> last remote is handled by the current process. Each of these processes
> will in turn run 'gc' at the end.
> 
> This is not really a problem because even if multiple 'gc --auto' is run
> at the same time we still handle it correctly. It does show multiple
> "auto packing in the background" messages though. And we may waste some
> resources when gc actually runs because we still do some stuff before
> checking the lock and moving it to background.
> 
> So let's try to avoid that. We should only need one 'gc' run after all
> objects and references are added anyway. Add a new option --no-auto-gc
> that will be used by those n-1 processes. 'gc --auto' will always run on
> the main fetch process (*).

Yeah, that makes sense.

I was surprised that we needed a new command-line option here, but I
guess the sub-fetch processes really have no idea that they're
subservient to a multi-remote fetch (they do get "--append", but of
course somebody could specify that independently).

Another option would be to just pass "-c gc.auto=0" to the child
processes to inhibit auto-gc. But maybe it makes sense to have a nicer
interface (after all, somebody else could be doing the same "let's do a
bunch of fetches in a row" without using the multi-fetch code).

Though there I kind of wonder if this would apply to other scripted
uses, too. E.g., if I'm doing a bunch of commits, I might want to
inhibit auto-gc and then run it myself at the end. Should we support
"GIT_AUTO_GC=0" in the environment (and a matching "git --no-auto-gc
..." option that could be used here)?

>  Documentation/fetch-options.txt |  4 ++++
>  builtin/fetch.c                 | 17 +++++++++++------
>  t/t5514-fetch-multiple.sh       |  7 +++++--
>  3 files changed, 20 insertions(+), 8 deletions(-)

My musings above aside, the patch looks correct to me.

-Peff
