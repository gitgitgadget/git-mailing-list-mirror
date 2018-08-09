Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA301F405
	for <e@80x24.org>; Thu,  9 Aug 2018 14:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbeHIQsn (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 12:48:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:48374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730839AbeHIQsn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 12:48:43 -0400
Received: (qmail 21105 invoked by uid 109); 9 Aug 2018 14:23:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 14:23:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9392 invoked by uid 111); 9 Aug 2018 14:23:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 10:23:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 10:23:34 -0400
Date:   Thu, 9 Aug 2018 10:23:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, pawelparuzel95@gmail.com,
        sandals@crustytoothpaste.net, Elijah Newren <newren@gmail.com>,
        tboegi@web.de
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180809142333.GB1439@sigill.intra.peff.net>
References: <20180730152756.15012-1-pclouds@gmail.com>
 <20180807190110.16216-1-pclouds@gmail.com>
 <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
 <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
 <20180808223139.GA3902@sigill.intra.peff.net>
 <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 08, 2018 at 05:41:10PM -0700, Junio C Hamano wrote:

> > If we have an equivalence-class hashmap and feed it inodes (or again,
> > some system equivalent) as the keys, we should get buckets of
> > collisions.
> 
> I guess one way to get "some system equivalent" that can be used as
> the last resort, when there absolutely is no inum equivalent, is to
> rehash the working tree file that shouldn't be there when we detect
> a collision.
> 
> If we found that there is something when we tried to write out
> "Foo.txt", if we open "Foo.txt" on the working tree and hash-object
> it, we should find the matching blob somewhere in the index _before_
> "Foo.txt".  On a case-insensitive filesytem, it may well be
> "foo.txt", but we do not even have to know "foo.txt" and "Foo.txt"
> only differ in case.

Clever. You might still run into false positives when there is
duplicated content in the repository (especially, say, zero-length
files).  But the fact that you only do the hashing on known duplicates
helps with that.

One of the things I did like about the equivalence-class approach is
that it can be done in a single linear pass in the worst case. Whereas
anything that searches when we see a collision is quite likely to be
quadratic. But as I said before, it may not be worth worrying too much
about that for an error code path where we expect the number of
collisions to be small.

-Peff
