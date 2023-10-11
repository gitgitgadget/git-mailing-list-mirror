Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12533CDB465
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjJKXBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJKXBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:01:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B4CA9
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:01:07 -0700 (PDT)
Received: (qmail 20415 invoked by uid 109); 11 Oct 2023 23:01:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 23:01:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11162 invoked by uid 111); 11 Oct 2023 23:01:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 19:01:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 19:01:06 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/20] commit-graph: check size of oid fanout chunk
Message-ID: <20231011230106.GH518221@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009205951.GD3282181@coredump.intra.peff.net>
 <ZSXnZXglgbfK3VYd@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSXnZXglgbfK3VYd@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 08:08:05PM -0400, Taylor Blau wrote:

> Nice. This makes sense and seems like an obvious improvement over the
> existing code.
> 
> I wonder how common this pattern is. We have read_chunk() which is for
> handling more complex scenarios than this. But the safe version of
> pair_chunk() really just wants to check that the size of the chunk is as
> expected and assign the location in the mmap to some pointer.

Sometimes yes, sometimes no. For fixed-size ones like this, that's
sufficient. For others we have to record the size and use it for later
bounds-checking. IIRC it's about 50/50 between the two.

> Do you think it would be worth changing pair_chunk() to take an expected
> size_t and handle this generically? I.e. have a version of
> chunk-format::pair_chunk_fn() that looks something like:
> 
>     static int pair_chunk_fn(const unsigned char *chunk_start,
>                              size_t chunk_size, void *data)
>     {
>         const unsigned char **p = data;
>         if (chunk_size != data->size)
>             return -1;
>         *p = chunk_start;
>         return 0;
>     }
> 
> and then our call here would be:
> 
>   if (pair_chunk(cf, GRAPH_CHUNKID_OIDFANOUT,
>                  (const unsigned char **)&graph->chunk_oid_fanout,
>                  256 * sizeof(uint32_t)) < 0)
>       return error("commit-graph oid fanout chunk is wrong size");
> 
> I dunno. It's hard to have a more concrete recomendation without having
> read the rest of the series. So it's possible that this is just complete
> nonsense ;-). But my hunch is that there are a number of callers that
> would benefit from having this built in.

I don't think it's nonsense, and I do think other callers would benefit.
On the other hand, I kind of like the notion that there is a complete
validation callback for each of these chunks. Even though it just checks
the size for now, it could handle other things. In the case of OIDF, for
example, we can check whether the entries are monotonic. It's just that
we happen to do those checks elsewhere.

Hmm, actually, looking at that again, I think I may have missed a case
in patch 6. For pack .idx files, we check the fanout table when they are
loaded. And patch 6 adds the same for commit-graph files. I thought midx
files were handled the same .idx, but looking at it again, I only see
the monotonicity check in the "multi-pack-index verify" code paths. So
it might need the same treatment.

I'm not sure how I missed that (I started by making a corrupted midx
first and couldn't get it to fail, which is when I discovered the
existing checks, but maybe I am mixing up .idx and midx in my memory).

-Peff
