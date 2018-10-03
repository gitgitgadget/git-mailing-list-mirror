Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D2E1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJDCLM (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:11:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:40338 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726884AbeJDCLM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:11:12 -0400
Received: (qmail 5612 invoked by uid 109); 3 Oct 2018 19:21:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 19:21:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16667 invoked by uid 111); 3 Oct 2018 19:20:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Oct 2018 15:20:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2018 15:21:27 -0400
Date:   Wed, 3 Oct 2018 15:21:27 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181003192127.GC16666@sigill.intra.peff.net>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <20181003133650.GN23446@localhost>
 <87r2h7gmd7.fsf@evledraar.gmail.com>
 <20181003141732.GO23446@localhost>
 <87o9cbglez.fsf@evledraar.gmail.com>
 <20181003145308.GP23446@localhost>
 <CAGZ79kbyCZcMuj=_Od+C+tHg=PzzDd8QV+9RqS7iFcZS+Ht+Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbyCZcMuj=_Od+C+tHg=PzzDd8QV+9RqS7iFcZS+Ht+Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 12:08:15PM -0700, Stefan Beller wrote:

> I share these concerns in a slightly more abstract way, as
> I would bucket the actions into two separate bins:
> 
> One bin that throws away information.
> this would include removing expired reflog entries (which
> I do not think are garbage, or collection thereof), but their
> usefulness is questionable.
> 
> The other bin would be actions that optimize but
> do not throw away any information, repacking (without
> dropping files) would be part of it, or the new
> "write additional files".
> 
> Maybe we can move all actions of the second bin into a new
> "git optimize" command, and git gc would do first the "throw away
> things" and then the optimize action, whereas clone would only
> go for the second optimizing part?

One problem with that world-view is that some of the operations do
_both_, for efficiency. E.g., repacking will drop unreachable objects in
too-old packs. We could actually be more aggressive in combining things
here. For instance, a full object graph walk in linux.git takes 30-60
seconds, depending on your CPU. But we do it at least twice during a gc:
once to repack, and then again to determine reachability for pruning.

If you generate bitmaps during the repack step, you can use them during
the prune step. But by itself, the cost of generating the bitmaps
generally outweighs the extra walk. So it's not worth generating them
_just_ for this (but is an obvious optimization for a server which would
be generating them anyway).

-Peff
