Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F06C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 21:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E0964FAB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 21:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCJVkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:40:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:59228 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhCJVjX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 16:39:23 -0500
Received: (qmail 7089 invoked by uid 109); 10 Mar 2021 21:39:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Mar 2021 21:39:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26060 invoked by uid 111); 10 Mar 2021 21:39:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Mar 2021 16:39:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Mar 2021 16:39:22 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/7] rev-parse: implement object type filter
Message-ID: <YEk8iiDf/FMxzhIF@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614600555.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 01, 2021 at 01:20:26PM +0100, Patrick Steinhardt wrote:

> Altogether, this ends up with the following queries, both of which have
> been executed in a well-packed linux.git repository:
> 
>     # Previous query which uses object names as a heuristic to filter
>     # non-blob objects, which bars us from using bitmap indices because
>     # they cannot print paths.
>     $ time git rev-list --objects --filter=blob:limit=200 \
>         --object-names --all | sed -r '/^.{,41}$/d' | wc -l
>     4502300
> 
>     real 1m23.872s
>     user 1m30.076s
>     sys  0m6.002s
> 
>     # New query.
>     $ time git rev-list --objects --filter-provided \
>         --filter=object:type=blob --filter=blob:limit=200 \
>         --use-bitmap-index --all | wc -l
>     22585
> 
>     real 0m19.216s
>     user 0m16.768s
>     sys  0m2.450s

Those produce very different answers. I guess because in the first one,
you still have a bunch of tree objects, too. You'd do much better to get
the actual types from cat-file, and filter on that. That also lets you
use bitmaps for the traversal portion. E.g.:

  $ time git rev-list --use-bitmap-index --objects --filter=blob:limit=200 --all |
         git cat-file --buffer --batch-check='%(objecttype) %(objectname)' |
	 perl -lne 'print $1 if /^blob (.*)/' | wc -l
  14966
  
  real	0m6.248s
  user	0m7.810s
  sys	0m0.440s

which is faster than what you showed above (this is on linux.git, but my
result is different; maybe you have more refs than me?). But we should
be able to do better purely internally, so I suspect my computer is just
faster (or maybe your extra refs just aren't well-covered by bitmaps).
Running with your patches I get:

  $ time git rev-list --objects --use-bitmap-index --all \
             --filter-provided --filter=object:type=blob \
	     --filter=blob:limit=200 | wc -l
  16339

  real	0m1.309s
  user	0m1.234s
  sys	0m0.079s

which is indeed faster. It's quite curious that the answer is not the
same, though! I think yours has some bugs. If I sort and diff the
results, I see some commits mentioned in the output. Perhaps this is
--filter-provided not working, as they all seem to be ref tips.

> To be able to more efficiently answer this query, I've implemented
> multiple things:
> 
> - A new object type filter `--filter=object:type=<type>` for
>   git-rev-list(1), which is implemented both for normal graph walks and
>   for the packfile bitmap index.
> 
> - Given that above usecase requires two filters (the object type
>   and blob size filters), bitmap filters were extended to support
>   combined filters.

That's probably reasonable, especially because it lets us use bitmaps. I
do have a dream that we'll eventually be able to support more extensive
formatting via log/rev-list, which would allow:

  git rev-list --use-bitmap-index --objects --all \
               --format=%(objecttype) %(objectname) |
  perl -ne 'print $1 if /^blob (.*)/'

That should be faster than the separate cat-file (which has to re-lookup
each object, in addition to the extra pipe overhead), but I expect the
--filter solution should always be faster still, as it can very quickly
eliminate the majority of the objects at the bitmap level.

> - git-rev-list(1) doesn't filter user-provided objects and always prints
>   them. I don't want the listed commits though and only their referenced
>   potential LFS blobs. So I've added a new flag `--filter-provided`
>   which marks all provided objects as not-user-provided such that they
>   get filtered the same as all the other objects.

Yeah, this "user-provided" behavior was quite a surprise to me when I
started implementing the bitmap versions of the existing filters. It's
nice to have the option to specify which you want.

-Peff
