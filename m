Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D277FC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 00:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BA26103C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 00:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbhJGAeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 20:34:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:34608 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhJGAeC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 20:34:02 -0400
Received: (qmail 27435 invoked by uid 109); 7 Oct 2021 00:32:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Oct 2021 00:32:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5001 invoked by uid 111); 7 Oct 2021 00:32:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Oct 2021 20:32:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Oct 2021 20:32:08 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] cat-file replace handling and optimization
Message-ID: <YV5ACD79cZZkIhPP@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <1139fb26-5b93-0181-f908-6f9d7449bc62@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1139fb26-5b93-0181-f908-6f9d7449bc62@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 06, 2021 at 04:41:26PM -0400, Derrick Stolee wrote:

> On 10/5/2021 4:29 PM, Jeff King wrote:
> > This started as an optimization to have cat-file use the pack/offset
> > info it gets during --batch-all-objects to avoid extra object lookups.
> > And that does happen in the final patch.
> > 
> > But there was an interesting interaction with replace refs there, which
> > led me to patch 3.
> > 
> > The other patches are relevant prep/cleanup.
> > 
> >   [1/5]: t1006: clean up broken objects
> >   [2/5]: cat-file: mention --unordered along with --batch-all-objects
> >   [3/5]: cat-file: disable refs/replace with --batch-all-objects
> >   [4/5]: cat-file: split ordered/unordered batch-all-objects callbacks
> >   [5/5]: cat-file: use packed_object_info() for --batch-all-objects
> 
> I took a close read through this series and it was easy to understand.
> 
> LGTM. Nice ~2x speedup in patch 5.

Thanks. I was actually surprise at the speedup in the final patch. It's
a bit less impressive on a smaller repo like git.git (I think it was
like 250ms versus 180ms). That kind of makes sense, though. For a repo
with N objects, we're cutting out N lookups at a cost of log(N) each. So
we'd expect it to be a better than linear improvement as the number of
objects increases. (Of course it's not N(log(N)) over all because we're
only cutting out _some_ of the work the process is doing).

Still, I'm a fan of easy wins. :)

-Peff
