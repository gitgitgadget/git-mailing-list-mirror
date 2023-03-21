Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B64CC74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjCURiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCURiS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:38:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03D012594
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:37:17 -0700 (PDT)
Received: (qmail 27746 invoked by uid 109); 21 Mar 2023 17:35:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 17:35:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2330 invoked by uid 111); 21 Mar 2023 17:35:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 13:35:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 13:35:56 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/6] pack-bitmap.c: hide bitmap internals in `read_u8()`
Message-ID: <20230321173556.GD3119834@coredump.intra.peff.net>
References: <cover.1679342296.git.me@ttaylorr.com>
 <8c70c94a3f5f0463041dbaaa542fd69bd159428b.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c70c94a3f5f0463041dbaaa542fd69bd159428b.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 04:02:40PM -0400, Taylor Blau wrote:

> So b5007211b6 got rid of the above convention and replaced it by reading
> individual fields of that structure with a `read_u8()` helper that reads
> from the region of memory pointed to by `->map`, and updates the
> `->map_pos` pointer accordingly.
> 
> But this forces callers to be intimately aware of `bitmap_git->map` and
> `bitmap_git->map_pos`. Instead, teach `read_u8()` to take a `struct
> bitmap_index *` directly, and avoid having callers deal with the
> internals themselves.

OK. I always felt like this read_u8() and read_be32() were trying to
match get_be32(), etc, just with an auto-incrementing "pos" pointer. And
this patch makes them a lot less generic.

But that is probably OK. They are static-local to the bitmap file, and
we have not found another caller who wanted them in the intervening
years. Arguably they could be given more descriptive names, like
read_bitmap_u8() or something, but again, being static-local to the
file, the generic names are fine.

-Peff
