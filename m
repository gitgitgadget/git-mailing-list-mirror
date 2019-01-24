Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDAB41F453
	for <e@80x24.org>; Thu, 24 Jan 2019 20:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfAXUJX (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 15:09:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:47810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730534AbfAXT2d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:28:33 -0500
Received: (qmail 10671 invoked by uid 109); 24 Jan 2019 19:28:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 19:28:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31547 invoked by uid 111); 24 Jan 2019 19:28:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 14:28:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 14:28:31 -0500
Date:   Thu, 24 Jan 2019 14:28:31 -0500
From:   Jeff King <peff@peff.net>
To:     Joey Hess <id@joeyh.name>
Cc:     git <git@vger.kernel.org>
Subject: Re: git status OOM on mmap of large file
Message-ID: <20190124192831.GA14201@sigill.intra.peff.net>
References: <20190122220714.GA6176@kitenet.net>
 <20190124121037.GA4949@sigill.intra.peff.net>
 <20190124183810.GC29200@kitenet.net>
 <20190124191836.GA31073@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124191836.GA31073@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 02:18:36PM -0500, Jeff King wrote:

> > I did some benchmarking, using cat as the clean filter:
> > [...]
> > From this, it looks like the file has to be quite large before the
> > preallocation makes a sizable improvement to runtime, and the
> > smudge/clean filters have to be used for actual content filtering
> > (not for hash generation purposes as git-annex and git-lfs use it).
> > An unusual edge case I think. So hint == 0 seems fine.
> 
> Thanks for these timings! I agree that "hint == 0" is probably
> reasonable, then.

One other minor point to consider: on some systems over-allocating
actually isn't that expensive, because pages are actually allocated
until we write to them, and malloc() is perfectly happy to overcommit
memory.  Your case would only run into problems on Linux when malloc()
actually refuses the allocation (so limiting ourselves to "too large but
still reasonable" is a valid strategy there).

But I doubt that's something we should be relying on in general. There
are many systems that don't overcommit.

-Peff
