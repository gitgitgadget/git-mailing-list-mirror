Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759A0C4321E
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 18:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiKPSpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 13:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbiKPSpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 13:45:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F0C63148
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 10:44:23 -0800 (PST)
Received: (qmail 21759 invoked by uid 109); 16 Nov 2022 18:44:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Nov 2022 18:44:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2824 invoked by uid 111); 16 Nov 2022 18:44:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Nov 2022 13:44:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Nov 2022 13:44:22 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] delta-islands: free island-related data after use
Message-ID: <Y3UvhsRC9uCXJJ8P@coredump.intra.peff.net>
References: <20221116105013.1777440-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221116105013.1777440-1-e@80x24.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 10:50:13AM +0000, Eric Wong wrote:

> On my use case involving 771 islands of Linux on kernel.org,
> this reduces memory usage by around 25MB.  The bulk of that
> comes from free_remote_islands, since free_island_regexes only
> saves around 40k.
> 
> This memory is saved early in the memory-intensive pack process,
> making it available for the remainder of the long process.

I think this works and is a reasonable thing to do. The non-obvious
question is whether the island data is ever used later in the process.
Certainly the island bitmaps themselves are, but the initial mapping of
refs to islands doesn't.

I do agree with Ævar that it would be a lot easier to confirm that if
these variables were given a more appropriate scope (this was mostly
just laziness on my part writing the initial delta-island code; so much
of it has to stick around for the whole process and I didn't distinguish
between the two).

>   Will try to hunt down more memory savings in the nearish future.

Yes, you've probably noticed that pack-objects does not distinguish much
between what is necessary for the various phases. A few obvious things
to look at:

  1. After the write phase, you can probably ditch the island bitmaps,
     too. In many repacks we're basically done then, but if you're
     generating bitmaps, that happens afterwards in the same process.

  2. The object traversal for pack-objects is done in-process these
     days. But after it finishes, I suspect that we do not generally
     need those object structs anymore, because all of the book-keeping
     is done in the bit object_entry array in packing_data.

     The exception would be generating bitmaps, which does need to do
     some traversal (and I think may hang on to actual "struct commit"
     pointers).

     I also don't think we have any code that clears obj_hash or
     released the pooled object pointers.

     So it's probably pretty tricky, but I suspect would yield big
     savings, since it's a per-object cost on the order of 64 bytes (so
     ~640MB on the kernel).

  3. During the bitmap phase I'm not sure if we still care about the
     object_entry struct in packing_data. It's the other big
     bytes-per-object user of memory. We need it all the way through the
     write phase for obvious reasons, but if we could ditch it for the
     bitmap phase, that may reduce peak memory during that phase.

-Peff
