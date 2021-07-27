Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC85C432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0666056B
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhG0Rzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:55:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:58946 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhG0Rzx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:55:53 -0400
Received: (qmail 31160 invoked by uid 109); 27 Jul 2021 17:55:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jul 2021 17:55:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1253 invoked by uid 111); 27 Jul 2021 17:55:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jul 2021 13:55:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jul 2021 13:55:52 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YQBIqO5j0VHXL6V7@coredump.intra.peff.net>
References: <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
 <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
 <YPhz+iOMu4Q7zjY4@nand.local>
 <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
 <YP8F9ttlMXwNZBam@nand.local>
 <YP8zsR+W8JeCWc1Q@nand.local>
 <YQBCjSmdOPfrnNnK@coredump.intra.peff.net>
 <YQBEIrRfcq5dhpZn@nand.local>
 <YQBFi70c1wfXdKQf@coredump.intra.peff.net>
 <YQBGvEQoZpw49Z7L@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQBGvEQoZpw49Z7L@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 01:47:40PM -0400, Taylor Blau wrote:

> > BTW, yet another weirdness: close_object_store() will call close_midx()
> > on the outermost midx struct, ignoring o->multi_pack_index->next
> > entirely. So that's a leak, but also means we may not be closing the
> > midx we're interested in (since write_midx_internal() takes an
> > object-dir parameter, and we could be pointing to some other
> > object-dir's midx).
> 
> Yuck, this is a mess. I'm tempted to say that we should be closing the
> MIDX that we're operating on inside of write_midx_internal() so we can
> write, but then declaring the whole object store to be bunk and calling
> close_object_store() before leaving the function. Of course, one of
> those steps should be closing the inner-most MIDX before closing the
> next one and so on.

That gets even weirder when you look at other callers of
write_midx_internal(). For instance, expire_midx_packs() is calling
load_multi_pack_index() directly, and then passing it to
write_midx_internal().

So closing the whole object store there is likewise weird.

I actually think having write_midx_internal() open up a new midx is
reasonable-ish. It's just that:

  - it's weird when it stuffs duplicate packs into the
    r->objects->packed_git list. But AFAICT that's not actually hurting
    anything?

  - we do need to make sure that the midx is closed (not just our copy,
    but any other open copies that happen to be in the same process) in
    order for things to work on Windows.

So I guess because of the second point, the internal midx write probably
needs to be calling close_object_store(). But because other callers use
load_multi_pack_index(), it probably needs to be closing the one that is
passed in, too! But of course not double-closing it if it did come from
the regular object store. One easy easy way to avoid that is to just
open a separate one.

I have some spicy takes on how midx's should have been designed, but I
think it's probably not productive to rant about it at this point. ;)

-Peff
