Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670F9C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 05:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiJZFmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 01:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiJZFl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 01:41:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACEF83F19
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 22:41:56 -0700 (PDT)
Received: (qmail 11106 invoked by uid 109); 26 Oct 2022 05:41:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Oct 2022 05:41:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1942 invoked by uid 111); 26 Oct 2022 05:41:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Oct 2022 01:41:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Oct 2022 01:41:55 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] midx.c: clear auxiliary MIDX files first
Message-ID: <Y1jIo1dPl0M2TSHo@coredump.intra.peff.net>
References: <bf36093cd6d7ac83b16241b0199b3a8c904e6774.1666722316.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf36093cd6d7ac83b16241b0199b3a8c904e6774.1666722316.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2022 at 02:25:20PM -0400, Taylor Blau wrote:

> Since they were added in c528e17966 (pack-bitmap: write multi-pack
> bitmaps, 2021-08-31), the routine to remove MIDXs removed the
> multi-pack-index file itself before removing its associated .bitmap and
> .rev file(s), if any.
> 
> This creates a window where a MIDX's .bitmap file exists without its
> corresponding MIDX. If a reader tries to load a MIDX bitmap during that
> time, they will get a warning, and the MIDX bitmap code will gracefully
> degrade.
> 
> Remove this window entirely by removing the MIDX last, and removing its
> auxiliary files first.

We remove that window, but don't we create a new one where a reader may
see the midx but not the bitmap? That won't generate a warning (it just
looks like a midx that never had a bitmap generated), but it will cause
the reader to follow the slow, non-bitmap path.

Ideally this would just be atomic, but short of stuffing the metadata
into the same file, we can't do that. But the replacement of the midx
file itself is atomic, and I'd think everything would (or should at
least) follow from there.

I.e., why are we reading the midx bitmap without having opened the midx
file? Ideally we'd be holding a descriptor for it.

-Peff
