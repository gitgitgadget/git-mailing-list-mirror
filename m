Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01E720286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdIMRxl (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:53:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:37308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751125AbdIMRxk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:53:40 -0400
Received: (qmail 25424 invoked by uid 109); 13 Sep 2017 17:53:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 17:53:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17992 invoked by uid 111); 13 Sep 2017 17:54:15 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 13:54:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 13:53:38 -0400
Date:   Wed, 13 Sep 2017 13:53:38 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/7] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
Message-ID: <20170913175338.tsq4hmgmmybp43dw@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
 <20170913174728.GB27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913174728.GB27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 10:47:28AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > I scoured the code base for cases of this, but it turns out
> > that these two in git_config_set_multivar_in_file_gently()
> > are the only ones. This case is actually quite interesting:
> > we don't have a size_t, but rather use the subtraction of
> > two pointers. Which you might think would be a signed
> > ptrdiff_t, but clearly both gcc and clang treat it as
> > unsigned (possibly because the conditional just above
> > guarantees that the result is greater than zero).
> 
> Do you have more detail about this?  I get worried when I read
> something like this that sounds like a compiler bug.
> 
> C99 sayeth:
> 
> 	When two pointers are subtracted, both shall point to elements
> 	of the same array object, or one past the last element of the
> 	array object; the result is the difference of the subscripts
> 	of the two array elements. The size of the result is
> 	implementation-defined, and its type (a signed integer type)
> 	is ptrdiff_t defined in the <stddef.h> header.

I'm not sure if it's a compiler bug or not. I read the bits about
ptrdiff_t, and it wasn't entirely clear to me if a pointer difference
_is_ an actual ptrdiff_t, or if it can generally be stored in one. Right
below that text it also says:

  If the result is not representable in an object of that type, the
  behavior is undefined.

That said, I might be wrong that unsigned promotion is the culprit. I
didn't look at the generated assembly. But I also can't see what else
would be causing the problem here. We're clearly returning "-1" and the
condition doesn't trigger.

> How can I reproduce the problem?

I gave a recipe in the commit message, which is the best I came up with.
You could probably use a fault-injection library to convince write() to
fail. Or just tweak the source code to have write_in_full() return -1.

> > There's no addition to the test suite here, since you need
> > to convince write() to fail in order to see the problem. The
> > simplest reproduction recipe I came up with is to trigger
> > ENOSPC (this only works on Linux, obviously):
> 
> Does /dev/full make it simpler to reproduce?

I don't think so, because the write() failure is to the lockfile, which
is created with O_EXCL. So even if you could convince "config.lock" to
be the right device type, the open() would fail.

-Peff
