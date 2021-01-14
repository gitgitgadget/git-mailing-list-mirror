Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00287C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2BD239A4
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbhANToG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 14:44:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:56358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbhANToG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 14:44:06 -0500
Received: (qmail 17263 invoked by uid 109); 14 Jan 2021 19:43:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jan 2021 19:43:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17394 invoked by uid 111); 14 Jan 2021 19:43:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jan 2021 14:43:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jan 2021 14:43:24 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 16/20] builtin/gc.c: guess the size of the revindex
Message-ID: <YACe3KBgdRmIZA3b@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <a500311e33a2f7e11a539dd0718ed946f4bd6bc8.1610576604.git.me@ttaylorr.com>
 <xmqqwnwgyqn6.fsf@gitster.c.googlers.com>
 <YAB3E6lgOQdNgGOr@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAB3E6lgOQdNgGOr@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 11:53:39AM -0500, Taylor Blau wrote:

> On Wed, Jan 13, 2021 at 10:33:01PM -0800, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > 'estimate_repack_memory()' takes into account the amount of memory
> > > required to load the reverse index in memory by multiplying the assumed
> > > number of objects by the size of the 'revindex_entry' struct.
> > >
> > > Prepare for hiding the definition of 'struct revindex_entry' by removing
> > > a 'sizeof()' of that type from outside of pack-revindex.c. Instead,
> > > guess that one off_t and one uint32_t are required per object. Strictly
> > > speaking, this is a worse guess than asking for 'sizeof(struct
> > > revindex_entry)' directly, since the true size of this struct is 16
> > > bytes with padding on the end of the struct in order to align the offset
> > > field.
> >
> > Meaning that we under-estimate by 25%?
> 
> In this area, yes. I'm skeptical that this estimate is all that
> important, since it doesn't seem to take into account the memory
> required to select delta/base candidates [1].

It has many other inaccuracies:

  - it assumes half of all objects are blobs, which is not really
    accurate (linux.git is more like 60% trees, 12% commits, 28% blobs).
    This underestimates because blobs are the smallest struct.

  - since we moved a bunch of stuff out of "struct object_entry" into
    lazily-initialized auxiliary structures, we are under-counting the
    per-object cost when we have to spill into this structures

So I'm rather skeptical that this number is close to accurate. But
since there's a bunch of leeway (we are looking to use half of the
system memory) I suspect it doesn't matter all that much. But I
definitely don't think it's worth trying to micro-optimize its accuracy.

-Peff
