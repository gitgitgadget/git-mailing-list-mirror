Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51F4C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 13:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjAFNFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 08:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjAFNEy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 08:04:54 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F71718A6
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 05:04:52 -0800 (PST)
Received: (qmail 14535 invoked by uid 109); 6 Jan 2023 13:04:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jan 2023 13:04:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14391 invoked by uid 111); 6 Jan 2023 13:04:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jan 2023 08:04:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Jan 2023 08:04:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrew Hlynskyi <ahlincq@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] `git gc` or `git pack-refs` wipes all notes for `git
 notes` command
Message-ID: <Y7gcczFWyTePVjlk@coredump.intra.peff.net>
References: <CAAYtLELp4v=id-UUdGT+BoCxLuTV05Z0fFMQmPfd3Mt-yXJ9Tw@mail.gmail.com>
 <Y7Pvqk00sj3R7cZv@coredump.intra.peff.net>
 <CAAYtLE+PWK_v0cc8uqaiKnTHKghrkxuCCgfWyo9bhD23+vxK1g@mail.gmail.com>
 <Y7fikyZV1ky2modr@coredump.intra.peff.net>
 <xmqqilhjsuo9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilhjsuo9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2023 at 09:40:22PM +0900, Junio C Hamano wrote:

> > I don't think we have any fsck checks that the packed-refs file is in
> > sorted order. It might be reasonable to have them. Likewise, when
> > pack-refs rewrites the file, it should be able to cheaply double-check
> > that the input is sorted by comparing each entry against its previous.
> 
> True.  I would not mind a patch to make us do so in the code path
> where we rewrite the file and add "sorted" trait to the file.
> refs/packed-backend.c::sort_snapshot() seems to be already equipped
> to do this?

I think it may be a little trickier than that. Yes, sort_snapshot()
knows about sorting, but it only kicks in when the file isn't already
marked as sorted (and we sort on the fly so that the rest of the code
can use the same lookup routines).

And it's possible that we can just sort_snapshot() before writing, even
if the original claims to be sorted. But I'm not sure what performance
impact that might have on the normal case that everything is already in
good order. Maybe it's not a big deal; the write is already O(n), so
adding an O(n log n) might not be the end of the world.

But I was thinking more that write_with_updates() would, while iterating
through the existing entries, check that the values it gets from the
ref_iterator are indeed in sorted order. And if not, I think it needs to
actually bail, since we might already have written a partially-confused
result. And there "bail" may mean "write a warning to the user, abort
the current write, call sort_snapshot(), and then try again".

All of which is to say I don't think it's conceptually _too_ hard, but
it was not simple enough that I was comfortable dashing off a one-liner
and saying "probably something like this". ;)

> So we can conclude that this discussion thread has an
> incorrect Subject: and the symptom was caused by human error?

That's my read on it.

-Peff
