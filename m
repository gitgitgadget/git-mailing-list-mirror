Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE245C43214
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98EC60FD8
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhH3U7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:59:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:34270 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236230AbhH3U7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:59:30 -0400
Received: (qmail 1531 invoked by uid 109); 30 Aug 2021 20:58:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Aug 2021 20:58:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10309 invoked by uid 111); 30 Aug 2021 20:58:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Aug 2021 16:58:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Aug 2021 16:58:34 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] pack-objects: simplify
 add_objects_in_unpacked_packs()
Message-ID: <YS1GemF3aKTe//Tn@coredump.intra.peff.net>
References: <cover.1630291682.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630291682.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 29, 2021 at 10:48:43PM -0400, Taylor Blau wrote:

> This short series is extracted from mine and Peff's work on cruft packs. These
> three patches focus on cleaning up add_objects_in_unpacked_packs(), which is
> used to implement `git repack -k`.
> 
> The pay-off for this clean-up is significant, though: we net -50 lines of code,
> and the result is much more readable, at least in my opinion.
> 
> The changes are described in detail in the patch messages, but essentially we
> are replacing a loop over get_all_packs() with for_each_packed_object() after
> adding a couple of new flags necessary to make the switch. And once we are done
> with that, the third patch removes a bit from the object flag allocation table.

Thanks for extracting these from that other work. I gave them all an
extra read-through and didn't find anything wrong.

>  builtin/pack-objects.c | 85 ++++++------------------------------------
>  object-store.h         |  6 +++
>  object.h               |  1 -
>  packfile.c             |  6 +++
>  4 files changed, 24 insertions(+), 74 deletions(-)

Of course I love this diffstat, and I _really_ love dropping the one-off
bit from the flag allocation table. But I wanted to also give some
numbers for the lookup_unknown_object() part of the final patch.

Those unknown objects cost 72 bytes of heap each (the same size as a
commit, since it's the biggest struct and the unknown object is a
union). We've seen some real-world cases where there are 40M+
unreachable objects. So that's almost 3GB of wasted RAM during
pack-objects just to store those "did I see it already" bits. :)

Of course, we are already spending 96 bytes per object in "struct
object_entry", but at least that's doing more useful stuff. :)

(And the more obvious question is: why not delete those objects. The
answer thus far has been: because git's pruning is racy, and thus we
don't run it as part of our automatic maintenance).

-Peff
