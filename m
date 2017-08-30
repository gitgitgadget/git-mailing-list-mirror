Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FAA620285
	for <e@80x24.org>; Wed, 30 Aug 2017 20:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdH3ULf (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 16:11:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:53590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750998AbdH3ULf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 16:11:35 -0400
Received: (qmail 20906 invoked by uid 109); 30 Aug 2017 20:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 20:11:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23202 invoked by uid 111); 30 Aug 2017 20:12:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 16:12:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Aug 2017 16:11:32 -0400
Date:   Wed, 30 Aug 2017 16:11:32 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170830201132.kmtp5mfu6qotn5s7@sigill.intra.peff.net>
References: <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
 <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
 <3e632fd3-7db9-4c38-c524-b56a06cfaa87@alum.mit.edu>
 <20170830195320.27w5mhnrcd2uosvz@sigill.intra.peff.net>
 <20170830195731.GB50018@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170830195731.GB50018@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 12:57:31PM -0700, Brandon Williams wrote:

> > And I think we're fine there even with a doubly-linked list. It's still
> > the single update of the "next" pointer that controls that second
> > traversal.
> 
> I know it was mentioned earlier but if this is a critical section, and
> it would be bad if it was interrupted, then couldn't we turn off
> interrupts before attempting to remove an item from the list?

If we have to, that's an option. I mostly didn't want to get into the
portability headaches of signal-handling if we can avoid it.

Right now sigchain uses plain old signal(). We do use sigaction() in a
few places, but in a vanilla way. So the portability questions are:

  - can we rely on using more interesting bits of sigaction like
    sa_mask?  Probably.

  - which flags should we be setting in sa_flags to get the same
    behavior we've been getting with signal()? Or alternatively, which
    behavior do we want?

On Linux and BSD systems, at least, signal() defers repeat instances of
the handled signal. So getting two quick SIGTERMs will not interrupt the
handler to deliver the second. But getting SIGTERM followed by SIGINT would.

We could extend that protection by having sigchain_push_common() set
sa_mask to cover all of the related signals. On Linux and BSD the
current code using signal() also implies SA_RESTART. We could add that
to our flags, though I suspect in practice it doesn't matter. Whenever
we establish a handler like this our intent is to never return from it.

That just protects us from calling the _same_ handler from itself. But
that's probably enough in practice, and means handlers don't have to
worry about "critical sections". The other alternative is sigprocmask()
to block signals entirely during a section. I'm not sure if there are
portability questions there (it looks like we have a mingw wrapper
there, but it's a complete noop).

-Peff
