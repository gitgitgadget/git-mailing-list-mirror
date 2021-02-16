Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B795C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 21:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2699064E6B
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 21:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBPVnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 16:43:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:35004 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhBPVnU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 16:43:20 -0500
Received: (qmail 15046 invoked by uid 109); 16 Feb 2021 21:42:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 21:42:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29737 invoked by uid 111); 16 Feb 2021 21:42:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 16:42:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 16:42:38 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 1/8] packfile: introduce 'find_kept_pack_entry()'
Message-ID: <YCw8TmDdEfcnZSOo@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <f7186147ebb0b2d01d8f1e0f742f367204d7d9c9.1612411123.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7186147ebb0b2d01d8f1e0f742f367204d7d9c9.1612411123.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 10:58:50PM -0500, Taylor Blau wrote:

> Future callers will want a function to fill a 'struct pack_entry' for a
> given object id but _only_ from its position in any kept pack(s).
> 
> In particular, an new 'git repack' mode which ensures the resulting

Nit (not worth re-rolling): s/an new/a new/

> There is a gotcha when looking up objects that are duplicated in kept
> and non-kept packs, particularly when the MIDX stores the non-kept
> version and the caller asked for kept objects only. This could be
> resolved by teaching the MIDX to resolve duplicates by always favoring
> the kept pack (if one exists), but this breaks an assumption in existing
> MIDXs, and so it would require a format change.

I don't think this would be possible without a major rethink of how
midxs work. The "keep" property of a pack is not set in stone when the
midx is created. You could add a ".keep" file to one of its packs later,
or even mark one as an in-core keep on the fly. But the duplicate
resolution happens at creation.

So maybe your "breaks an assumption" is the notion that we do not store
duplicate information at all in the midx. If so, then I agree. :) But
I'd also call fixing that more than just a format change.

(None of which changes your point, which isn't that it isn't worth
pursuing that direction).

-Peff
