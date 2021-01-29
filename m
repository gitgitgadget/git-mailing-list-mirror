Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FA6C433E6
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 19:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B023B64E0B
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhA2Tcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 14:32:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:40718 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232727AbhA2Tcl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 14:32:41 -0500
Received: (qmail 3465 invoked by uid 109); 29 Jan 2021 19:31:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 19:31:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8266 invoked by uid 111); 29 Jan 2021 19:32:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 14:32:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 14:31:59 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 01/10] packfile: introduce 'find_kept_pack_entry()'
Message-ID: <YBRirz8xAB4Swf8X@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <dc7fa4c7a61f657e779e10385d3e8076d6dac36c.1611098616.git.me@ttaylorr.com>
 <xmqqwnvwtqu1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnvwtqu1.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 06:33:10PM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > Future callers will want a function to fill a 'struct pack_entry' for a
> > given object id but _only_ from its position in any kept pack(s). They
> > could accomplish this by calling 'find_pack_entry()' and checking
> > whether the found pack is kept or not, but this is insufficient, since
> > there may be duplicate objects (and the mru cache makes it unpredictable
> > which variant we'll get).
> 
> I wonder if we eventually need a callback interface to walk _all_
> pack entries for a given object, so that "I am only interested in
> instances in kept packs" will be under total control of the callers.
> As it stands, it is "just grab any one that is in a kept pack, any
> one of them is fine", which is almost just of as narrow utility as
> the original's "just grab the first one---any one of them is fine",
> the latter of which is "insufficient" as the log message says.

We do that already in pack-objects, and that's the problem: it's really
slow. So if you have few kept packs, but a lot of other ones, you'd like
to pre-split the packs into two lists, and not bother walking the one
you know won't turn up interesting results.

I think the commit message here doesn't emphasize that reasoning enough.
It talks about using "find_pack_entry()", and that is definitely not
sufficient for our purposes. But the interesting part is replacing the
existing "walk all packs and see if any were kept" logic, which happens
in patch 6.

So the more compelling argument, I think, is something like:

  - you sometimes want to know if object X is any kept packs

  - you can't use find_pack_entry(), because it only gives you the first
    pack it finds

  - you can walk over all packs and look for the object in each.
    pack-objects does this. But it's slow, because you are looking in
    packs you don't care about.

  - so it's helpful for the lookup to know up front which packs are
    interesting to find objects in and which are not, to avoid looking
    in the uninteresting ones

-Peff
