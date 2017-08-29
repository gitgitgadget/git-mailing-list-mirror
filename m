Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE751F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 19:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbdH2TMU (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 15:12:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:52278 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751231AbdH2TMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 15:12:19 -0400
Received: (qmail 2439 invoked by uid 109); 29 Aug 2017 19:12:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 19:12:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13560 invoked by uid 111); 29 Aug 2017 19:12:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 15:12:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 15:12:17 -0400
Date:   Tue, 29 Aug 2017 15:12:17 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170829190928.GD131745@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 12:09:28PM -0700, Brandon Williams wrote:

> > -- >8 --
> > Subject: [PATCH] config: use a static lock_file struct
> > 
> > When modifying git config, we xcalloc() a struct lock_file
> > but never free it. This is necessary because the tempfile
> > code (upon which the locking code is built) requires that
> > the resulting struct remain valid through the life of the
> > program. However, it also confuses leak-checkers like
> > valgrind because only the inner "struct tempfile" is still
> > reachable; no pointer to the outer lock_file is kept.
> 
> Is this just due to a limitation in the tempfile code?  Would it be
> possible to improve the tempfile code such that we don't need to require
> that a tempfile, once created, is required to exist for the remaining
> life of the program?

Yes. Like I wrote below:

> > ---
> > In the long run we may want to drop the "tempfiles must remain forever"
> > rule. This is certainly not the first time it has caused confusion or
> > leaks. And I don't think it's a fundamental issue, just the way the code
> > is written. But in the interim, this fix is probably worth doing.

The main issue is that the caller needs to make sure they're removed
from the list (via commit or rollback) before being freed.

As far as I know anyway. This restriction dates back to the very early
days of the lockfile code and has been carried through the various
tempfile-cleanup refactorings over the years (mostly because each was
afraid to make functional changes).

+cc Michael, who did most comprehensive cleanup of that code.

-Peff
