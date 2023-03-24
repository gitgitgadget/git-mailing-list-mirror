Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1796C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 20:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjCXUhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCXUhj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 16:37:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22B21F905
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:37:38 -0700 (PDT)
Received: (qmail 7061 invoked by uid 109); 24 Mar 2023 20:37:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Mar 2023 20:37:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5648 invoked by uid 111); 24 Mar 2023 20:37:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Mar 2023 16:37:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Mar 2023 16:37:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 5/6] pack-bitmap.c: use `bitmap_index_seek()` where
 possible
Message-ID: <20230324203737.GA549549@coredump.intra.peff.net>
References: <cover.1679342296.git.me@ttaylorr.com>
 <9a3e45b78b7810e0116848f1de80096b04285a55.1679342296.git.me@ttaylorr.com>
 <20230321180525.GG3119834@coredump.intra.peff.net>
 <8a7cf287-421c-9a7f-0788-c5e219e6a8e3@github.com>
 <20230324183514.GB536252@coredump.intra.peff.net>
 <xmqqr0tedjf1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0tedjf1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 12:43:46PM -0700, Junio C Hamano wrote:

> > But given that there is only one spot that calls these, that kind of
> > refactoring might not be worth it (right now it just uses the magic
> > number "6" right before grabbing the data).
> 
> Yeah, it seems most of the callers with SEEK_SET are "I find the
> next offset from a table and jump there in preparation for doing
> something".  I suspect callers with SEEK_CUR would fit in the
> read_X() pattern better?  From that angle, it smells that the two
> kinds of seek functions may want to be split into two different
> helpers.

Yes, I think the SEEK_SET cases really do need to be doing more
checking. AFAICT they are blindly trusting the offsets in the file
(which is locally generated, so it's more of a corruption problem than a
security one, but still). And this series improves that, which is good
(but I still think it should be a die() and not a BUG()).

The SEEK_CUR cases in theory could all look like the nice read_be32() I
showed earlier, but I think in practice there are a lot of variants
(skipping read of index_pos, advancing past size given by
ewah_read_mmap(), and so on). And the current code, while ugly, does
give more specific error messages (e.g., telling on _which_ commit we
found the truncated data). So I dunno.

Certainly there could be more consistency in the magic numbers. E.g., in
this code:

                if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
                        error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
                                oid_to_hex(&xor_item->oid));
                        goto corrupt;
                }

                bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
                xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
                bitmap = read_bitmap_1(bitmap_git);

There is an assumption that sizeof(uint32_t) + sizeof(uint8_t) is equal
to bitmap_header_size - 1. That's not wrong, but it's hard to verify
that it's doing the right thing, and it's potentially fragile to changes
(though such changes seem unlikely).

-Peff
