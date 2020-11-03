Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643B3C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150C022264
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKCQIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:08:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:46188 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgKCQIT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:08:19 -0500
Received: (qmail 6439 invoked by uid 109); 3 Nov 2020 16:08:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Nov 2020 16:08:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1873 invoked by uid 111); 3 Nov 2020 16:08:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2020 11:08:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Nov 2020 11:08:18 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 03/10] hashmap: allow re-use after hashmap_free()
Message-ID: <20201103160818.GB444466@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <a686d0758a2652c91363dcf68da7726093d00c23.1602549650.git.gitgitgadget@gmail.com>
 <20201030133518.GC3277724@coredump.intra.peff.net>
 <CABPp-BHRSottxaYO+Ot5tPpNCf4scxmtwBLZicMJ4ChNEhmGHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHRSottxaYO+Ot5tPpNCf4scxmtwBLZicMJ4ChNEhmGHA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 08:37:42AM -0700, Elijah Newren wrote:

> > This part I disagree with. If we did:
> >
> >   #define HASHMAP_INIT(fn, data) = { .cmpfn = cmpfn, cmpfn_data = data }
> >
> > then many callers could avoid handling the lazy-init themselves. E.g.:
> 
> Ah, gotcha.  That makes sense to me.  Given that 43 out of 47 callers
> of hashmap_init use cmpfn_data = NULL, should I shorten it to just one
> parameter for the macro, and let the four special cases keep calling
> hashmap_init() to specify a non-NULL cmpfn_data?

I'd be fine with it either way. I actually wrote it without the data
parameter at first, then changed my mine and added it in. ;)

You could also do:

  #define HASHMAP_INIT_DATA(fn, data) { .cmpfn = cmpfn, cmpfn_data = data }
  #define HASHMAP_INIT(fn) HASHMAP_INIT_DATA(fn, NULL)

if you want to keep most callers simple.

-Peff
