Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03185C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B644E22CA1
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392614AbhALJdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:33:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:53156 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390802AbhALJdV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 04:33:21 -0500
Received: (qmail 7232 invoked by uid 109); 12 Jan 2021 09:32:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 09:32:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11290 invoked by uid 111); 12 Jan 2021 09:32:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 04:32:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 04:32:39 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 18/20] pack-revindex: remove unused
 'find_revindex_position()'
Message-ID: <X/1st6SrJXysoejt@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <d60411d524656f4680ac578765b2a8704325a060.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d60411d524656f4680ac578765b2a8704325a060.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:17:57PM -0500, Taylor Blau wrote:

> Now that all 'find_revindex_position()' callers have been removed (and
> converted to the more descriptive 'offset_to_pack_pos()'), it is almost
> safe to get rid of 'find_revindex_position()' entirely. Almost, except
> for the fact that 'offset_to_pack_pos()' calls
> 'find_revindex_position()'.
> 
> Inline 'find_revindex_position()' into 'offset_to_pack_pos()', and
> then remove 'find_revindex_position()' entirely.

Sounds good.

> This is a straightforward refactoring with one minor snag.
> 'offset_to_pack_pos()' used to load the index before calling
> 'find_revindex_position()'. That means that by the time
> 'find_revindex_position()' starts executing, 'p->num_objects' can be
> safely read. After inlining, be careful to not read 'p->num_objects'
> until _after_ 'load_pack_revindex()' (which loads the index as a
> side-effect) has been called.

Good catch. We might want to drop the initialization of "lo":

>  	int lo = 0;
> -	int hi = p->num_objects + 1;

down to here:

> +	hi = p->num_objects + 1;

to maintain symmetry (though it's quite a minor point).

I notice these are signed ints, but we've taken care to use uint32_t
elsewhere for positions. Shouldn't these be uint32_t, also (or at least
unsigned)?

-Peff
