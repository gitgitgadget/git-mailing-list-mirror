Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A74E1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfAXVSq (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:18:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:48066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725913AbfAXVSq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:18:46 -0500
Received: (qmail 15297 invoked by uid 109); 24 Jan 2019 21:18:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 21:18:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32641 invoked by uid 111); 24 Jan 2019 21:18:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 16:18:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 16:18:44 -0500
Date:   Thu, 24 Jan 2019 16:18:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joey Hess <id@joeyh.name>, git <git@vger.kernel.org>
Subject: Re: [PATCH] avoid unncessary malloc of whole file size
Message-ID: <20190124211844.GC16114@sigill.intra.peff.net>
References: <20190122220714.GA6176@kitenet.net>
 <20190124121037.GA4949@sigill.intra.peff.net>
 <20190124183810.GC29200@kitenet.net>
 <20190124191836.GA31073@sigill.intra.peff.net>
 <20190124203639.GA17595@kitenet.net>
 <xmqqlg39hia8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlg39hia8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 01:12:15PM -0800, Junio C Hamano wrote:

> Joey Hess <id@joeyh.name> writes:
> 
> > When a worktree file is larger than the available memory, and a clean
> > filter is in use, this avoids mallocing a buffer the whole size of the
> > file when reading from the clean filter, which caused commands like git
> > status and git commit to OOM.
> >
> > Often in this situation the clean filter will produce a short identifier
> > for the file, so such a large buffer is not needed.
> >
> > When the clean filter does output something around the same size as the
> > worktree file, the buffer will need to be reallocated until it fits,
> > starting at 8192 and doubling in size. Benchmarking indicates that
> > reallocation is not a significant overhead for outputs up to a
> > few MB in size.
> 
> Problem description first, then solultion.  "... this avoids ..." is
> already talking about solution while forcing the readers to know
> what the problem is.
> 
>     When a worktree file is ... filter is in use, we allocate a
>     buffer for the whole size of the file when reading from the
>     clean filter.  This can force us to overallocate if the clean
>     filter is used to radically shrink a huge file and replace it
>     with a small token (e.g. git-annex or git-lfs) and lead to OOM
>     at the worst case.  Reading from the filter and growing the
>     buffer as we go would avoid such an unnecessary OOM.
> 
>     When the clean filter does output ...
>     ... few MB in size.
> 
> perhaps.

Yeah, I agree that organization is nicer. Other than that, the patch
looks good to me.

-Peff
