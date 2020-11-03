Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A464BC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62659223AB
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgKCQMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:12:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:46220 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKCQMl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:12:41 -0500
Received: (qmail 6472 invoked by uid 109); 3 Nov 2020 16:12:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Nov 2020 16:12:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1961 invoked by uid 111); 3 Nov 2020 16:12:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2020 11:12:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Nov 2020 11:12:39 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 06/10] strmap: add more utility functions
Message-ID: <20201103161239.GD444466@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <61b5bf11103a7bd12de8fd066e128c469da3a0a4.1602549650.git.gitgitgadget@gmail.com>
 <20201030142350.GF3277724@coredump.intra.peff.net>
 <CABPp-BEBQ0kAQVRuXRoZnRAm_BmAXUKv9XtC+R4UH0VDZBw6Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEBQ0kAQVRuXRoZnRAm_BmAXUKv9XtC+R4UH0VDZBw6Sg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 09:43:33AM -0700, Elijah Newren wrote:

> > I suspect we need the same "var = NULL" that hashmap recently got in
> > 0ad621f61e (hashmap_for_each_entry(): workaround MSVC's runtime check
> > failure #3, 2020-09-30). Alternatively, I think you could drop
> > OFFSETOF_VAR completely in favor offsetof(struct strmap_entry, ent).
> >
> > In fact, since we know the correct type for "var", we _could_ declare it
> > ourselves in a new block enclosing the loop. But that is probably making
> > the code too magic; people reading the code would say "huh? where is
> > entry declared?".
> 
> Actually, since we know ent is the first entry in strmap, the offset
> is always 0.  So can't we just avoid OFFSETOF_VAR() and offsetof()
> entirely, by just using hashmap_iter_first() and hashmap_iter_next()?
> I'm going to try that.

Yes, I think that would work fine. You may want to add a comment to the
struct indicating that it's important for the hashmap_entry to be at the
front of the struct. Using offsetof() means that it's impossible to get
it wrong, though.

-Peff
