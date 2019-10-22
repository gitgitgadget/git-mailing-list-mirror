Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83CC1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 20:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfJVUdR (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 16:33:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:55194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730979AbfJVUdR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 16:33:17 -0400
Received: (qmail 31756 invoked by uid 109); 22 Oct 2019 20:33:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Oct 2019 20:33:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18600 invoked by uid 111); 22 Oct 2019 20:36:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Oct 2019 16:36:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Oct 2019 16:33:16 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] commit-graph: fix writing first commit-graph during
 fetch
Message-ID: <20191022203316.GC12270@sigill.intra.peff.net>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <a1e5280d4b61a972426063574f1ea890a7dab73b.1571765336.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1e5280d4b61a972426063574f1ea890a7dab73b.1571765336.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 05:28:55PM +0000, Derrick Stolee via GitGitGadget wrote:

> However, the UNINTERESTING flag is used in lots of places in the
> codebase. This flag usually means some barrier to stop a commit walk,
> such as in revision-walking to compare histories. It is not often
> cleared after the walk completes because the starting points of those
> walks do not have the UNINTERESTING flag, and clear_commit_marks() would
> stop immediately.

Oof. Nicely explained, and your fix makes sense.

The global-ness of revision flags always makes me nervous about doing
more things in-process (this isn't the first such bug we've had).

I have a dream of converting most uses of flags into using a
commit-slab. That provides cheap access to an auxiliary structure, so
each traversal, etc, could keep its own flag structure. I'm not sure if
it would have a performance impact, though. Even though it's O(1), it is
an indirect lookup, which could have some memory-access impact (though
my guess is it would be lost in the noise).

One of the sticking points is that all object types, not just commits,
use flags. But we only assign slab ids to commits. I noticed recently
that "struct object" has quite a few spare bits in it these days,
because the switch to a 32-byte oid means 64-bit machines now have an
extra 4 bytes of padding. I wonder if we could use that to store an
index field.

Anyway, that's getting far off the topic; clearly we need a fix in the
meantime, and what you have here looks good to me.

> I tested running clear_commit_marks_many() to clear the UNINTERESTING
> flag inside close_reachable(), but the tips did not have the flag, so
> that did nothing.

Another option would be clear_object_flags(), which just walks all of
the in-memory structs. Your REACHABLE solution is cheaper, though.

> Instead, I finally arrived on the conclusion that I should use a flag
> that is not used in any other part of the code. In commit-reach.c, a
> number of flags were defined for commit walk algorithms. The REACHABLE
> flag seemed like it made the most sense, and it seems it was not
> actually used in the file.

Yeah, being able to remove it from commit-reach.c surprised me for a
moment. To further add to the confusion, builtin/fsck.c has its own
REACHABLE flag (with a different bit and a totally different purpose). I
don't think there's any practical problem there, though.

> I have failed to produce a test using the file:// protocol that
> demonstrates this bug.

Hmm, from the description, it sounds like it should be easy. I might
poke at it a bit.

-Peff
