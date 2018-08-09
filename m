Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288BD1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeHJAAy (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:00:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:49112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727240AbeHJAAy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:00:54 -0400
Received: (qmail 5330 invoked by uid 109); 9 Aug 2018 21:34:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 21:34:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13887 invoked by uid 111); 9 Aug 2018 21:34:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 17:34:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 17:34:09 -0400
Date:   Thu, 9 Aug 2018 17:34:09 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, pawelparuzel95@gmail.com,
        sandals@crustytoothpaste.net, Elijah Newren <newren@gmail.com>,
        tboegi@web.de
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180809213409.GC11342@sigill.intra.peff.net>
References: <20180730152756.15012-1-pclouds@gmail.com>
 <20180807190110.16216-1-pclouds@gmail.com>
 <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
 <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
 <20180808223139.GA3902@sigill.intra.peff.net>
 <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com>
 <20180809142333.GB1439@sigill.intra.peff.net>
 <34b22185-a0bc-f712-b5e5-fc5e2697dcc2@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34b22185-a0bc-f712-b5e5-fc5e2697dcc2@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 05:14:16PM -0400, Jeff Hostetler wrote:

> > Clever. You might still run into false positives when there is
> > duplicated content in the repository (especially, say, zero-length
> > files).  But the fact that you only do the hashing on known duplicates
> > helps with that.
> > 
> 
> I worry that the false positives make this a non-starter.  I mean, if
> clone creates files 'A' and 'B' (both equal) and then tries to create
> 'b', would the collision code reports that 'b' collided with 'A' because
> that was the first OID match?  Ideally with this scheme we'd have to
> search the entire index prior to 'b' and then report that 'b' collided
> with either 'A' or 'B'.  Neither message instills confidence.  And
> there's no way to prefer answer 'B' over 'A' without using knowledge
> of the FS name mangling/aliasing rules -- unless we want to just assume
> ignore-case for this iteration.

Yeah. If we can get usable unique ids (inode or otherwise) of some form
on each system, I think I prefer that. It's much easier to reason about.

> Sorry to be paranoid, but I have an index with 3.5M entries, the word
> "quadratic" rings all kinds of alarm bells for me.  :-)
> 
> Granted, we expect the number of collisions to be small, but searching
> back for each collision over the already-populated portion of the index
> could be expensive.

Heh. Yeah, it's really O(n*m), and we expect a small "m". But of course
the two are equal in the worst case.

-Peff
