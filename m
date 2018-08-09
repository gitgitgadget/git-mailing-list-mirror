Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BB01F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeHIX6p (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 19:58:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:49100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727240AbeHIX6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 19:58:45 -0400
Received: (qmail 5242 invoked by uid 109); 9 Aug 2018 21:32:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 21:32:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13868 invoked by uid 111); 9 Aug 2018 21:32:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 17:32:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 17:32:01 -0400
Date:   Thu, 9 Aug 2018 17:32:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking
 for GIT_TRACE
Message-ID: <20180809213201.GB11342@sigill.intra.peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
 <20180809194712.GC32376@sigill.intra.peff.net>
 <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com>
 <xmqqbmabb63b.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmabb63b.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 02:08:56PM -0700, Junio C Hamano wrote:

> > Correct.  But I am more worried about the "mixed/overwriting"
> > breakage, if there is one; it means we may need to be prepared for
> > systems that lack O_APPEND that works correctly.  I initially just
> > assumed that it was what Dscho was seeing, but after re-reading his
> > message, I am not sure anymore.
> >
> > I think the "do not trace the other side" approach you suggest for
> > these tests that only care about one side is more appropriate
> > solution for this particular case.  We then do not have to worry
> > about overwriting or output from both sides mixed randomly.
> 
> A concluding sentence I forgot to add, after saying "this is simpler
> and better to fix test breakage", was
> 
> 	But if we really are seeing O_APPEND breakage, a mandatory
> 	locking mechanism like this one might be necessary to work
> 	around it (I seriously hope we do not have to, though).
> 
> Sorry for an additional noise.

Yeah, my earlier email said "if we just care about this test, then...".

But if we do care about making this multiple-tracing case work all the
time, then we'd need some solution. If there's something that can work
like O_APPEND, even if we have to make some system-specific call, I'd
prefer that to locking.

I did some searching for atomic append on Windows and got mixed reports
on whether their FILE_DATA_APPEND does what we want or not. Knowing
nothing about msys, I'd _assume_ that O_APPEND would get translated to
that flag, but I got lost trying to find it in
git-for-windows/msys2-runtime.

Wouldn't it be wonderful if the solution were as simple as making sure
that flag was plumbed through? I seriously doubt it will be that easy,
though. :)

-Peff
