Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F5E20A29
	for <e@80x24.org>; Wed, 20 Sep 2017 18:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdITSuv (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 14:50:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:44912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751365AbdITSuu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 14:50:50 -0400
Received: (qmail 7784 invoked by uid 109); 20 Sep 2017 18:50:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 18:50:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15163 invoked by uid 111); 20 Sep 2017 18:51:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 14:51:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 14:50:47 -0400
Date:   Wed, 20 Sep 2017 14:50:47 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 14/21] read_packed_refs(): ensure that references are
 ordered when read
Message-ID: <20170920185047.6fzuspaseofb7r5x@sigill.intra.peff.net>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <5bb362d9cb74c7386cd072e3ecd49b22cea1d8d2.1505799700.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5bb362d9cb74c7386cd072e3ecd49b22cea1d8d2.1505799700.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 08:22:22AM +0200, Michael Haggerty wrote:

> If `packed-refs` was already sorted, then (if the system allows it) we
> can use the mmapped file contents directly. But if the system doesn't
> allow a file that is currently mmapped to be replaced using
> `rename()`, then it would be bad for us to keep the file mmapped for
> any longer than necessary. So, on such systems, always make a copy of
> the file contents, either as part of the sorting process, or
> afterwards.

So this sort-of answers my question from the previous commit (why we
care about the distinction between NONE and TEMPORARY), since we now
start treating them differently.

But I'm a bit confused why there's any advantage in the TEMPORARY case
to doing the mmap-and-copy versus just treating it like NONE and reading
it directly.

Hmm, I guess it comes down to the double-allocation thing again? Let me
see if I have this right:

  1. For NO_MMAP, we'd read the buffer once. If it's sorted, good. If
     not, then we temporarily hold it in memory twice while we copy it
     into the new sorted buffer.

  2. For TEMPORARY, we mmap once. If it's sorted, then we make a single
     copy. If it's not sorted, then we do the copy+sort as a single
     step.

  3. For MMAP_OK, if it's sorted, we're done. Otherwise, we do the
     single copy.

So this is really there to help the TEMPORARY case reading an old
unsorted file avoid needing to use double-the-ram during the copy?

That seems like a good reason (and it does not seem to add too much
complexity).

-Peff
