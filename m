Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3B1C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 04:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiFOEAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 00:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFOEAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 00:00:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066A24942
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 21:00:48 -0700 (PDT)
Received: (qmail 7217 invoked by uid 109); 15 Jun 2022 04:00:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jun 2022 04:00:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Wed, 15 Jun 2022 00:00:47 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Richard Oliver <roliver@roku.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] mktree: learn about promised objects
Message-ID: <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
 <YqkpRE8nykqVv8cn@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqkpRE8nykqVv8cn@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 08:35:16PM -0400, Taylor Blau wrote:

> On Tue, Jun 14, 2022 at 01:27:18PM -0400, Derrick Stolee wrote:
> > > Did you have any other sort of performance test in mind? The remotes we
> > > typically deal with are geographically far away and deal with a high volume
> > > of traffic so we're keen to move behaviour to the client where it makes sense
> > > to do so.
> >
> > I guess I wonder how large your promisor pack-files are in this test,
> > since your implementation depends on for_each_packed_object(), which
> > should be really inefficient if you're actually dealing with a large
> > partial clone.
> 
> I had the same thought. Storing data available in the promisor packs
> into an oid_map is going to be expensive if there are many such objects.
> 
> Is there a reason that we can't introduce a variant of
> find_kept_pack_entry() that deals only with .promisor packs and look
> these things up as-needed?

It's much worse than that. The promisor mechanism is fundamentally very
inefficient in runtime, optimizing instead for size. Imagine I have a
partial clone and I retrieve tree X, which points to a blob Y that I
don't get. I have X in a promisor pack, and asking about it is
efficient. But if I want to know about Y, I have no data structure
mentioning Y except the tree X itself. So to enumerate all of the
promisor edges, I have to walk all of the trees in the promisor pack.

So it is not just lookup, but actual tree walking that is expensive. The
flip side is that you don't have to store a complete separate list of
the promised objects. Whether that's a win depends on how many local
objects you have, versus how many are promised.

But it would be possible to cache the promisor list to make the tradeoff
separately. E.g., do the walk over the promisor trees once (perhaps at
pack creation time), and store a sorted list of fixed-length (oid, type)
records that could be binary searched. You could even put it in the
.promisor file. :)

-Peff
