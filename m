Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CCEC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbjIGUFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjIGUFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:05:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9BE1BD0
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:05:10 -0700 (PDT)
Received: (qmail 27610 invoked by uid 109); 7 Sep 2023 08:58:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 08:58:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24780 invoked by uid 111); 7 Sep 2023 08:58:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 04:58:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 04:58:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 7/8] builtin/repack.c: drop `DELETE_PACK` macro
Message-ID: <20230907085828.GG1260718@coredump.intra.peff.net>
References: <cover.1693946195.git.me@ttaylorr.com>
 <559b487e2ab056c79367a673188764e4cdce3c96.1693946195.git.me@ttaylorr.com>
 <xmqqh6o7nsf2.fsf@gitster.g>
 <ZPi1c98o2fKB/U+e@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPi1c98o2fKB/U+e@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 06, 2023 at 01:22:59PM -0400, Taylor Blau wrote:

> --- 8< ---
> Subject: [PATCH] builtin/repack.c: treat string_list_item util as booleans
> 
> The `->util` field corresponding to each string_list_item used to track
> the existence of some pack at the beginning of a repack operation was
> originally intended to be used as a bitfield.
> 
> This bitfield tracked:
> 
>   - (1 << 0): whether or not the pack should be deleted
>   - (1 << 1): whether or not the pack is cruft
> 
> The previous commit removed the use of the second bit, meaning that we
> can treat this field as a boolean instead of a bitset.

I do think the boolean is syntactically a little nicer than the bit-set,
just because of the casting we have to with the void pointer). After
reading the earlier parts, I was hoping the culmination of this series
would be dropping the use of util entirely (presumably in favor of
separate lists). But maybe that would be too disruptive; I didn't try
it.

> -#define DELETE_PACK 1
> +#define DELETE_PACK ((void*)(uintptr_t)1)
> [...]
> @@ -130,7 +134,7 @@ static void mark_packs_for_deletion_1(struct string_list *names,
>  		 * (if `-d` was given).
>  		 */
>  		if (!string_list_has_string(names, sha1))
> -			item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
> +			item->util = DELETE_PACK;
>  	}
>  }

I do like the use of the macro here to make the meaning of the boolean
more plain, since the name "util" is totally meaningless (but we are
stuck with it).

But on the other side, things get more mysterious:

> @@ -158,7 +162,7 @@ static void remove_redundant_packs_1(struct string_list *packs)
>  {
>  	struct string_list_item *item;
>  	for_each_string_list_item(item, packs) {
> -		if (!((uintptr_t)item->util & DELETE_PACK))
> +		if (!item->util)
>  			continue;

This is syntactically much nicer, but the meaning of "util" as a boolean
for "we should delete this" is lost.

So I dunno. The end result of this patch is more readable syntactically,
but arguably less so semantically. Unless we have a good reason to ditch
the bit-set entirely, I wonder if we could have the best of both with
some macro helpers. Or even a set of matching helper functions like:

  void pack_mark_for_deletion(struct string_list_item *item)
  {
	(uintptr_t)item->util = 1;
  }

  int pack_should_deleted(const struct string_list_item *item)
  {
	return item->util;
  }

which could be a bool or a bit-set; the callers no longer need to care
and get to use human-readable names.

I dunno. It is a file-local convention and there aren't that many spots,
so maybe it is not worth worrying too much about. I'm pretty sure that I
got confused by the use of "util" here when looking at the code before,
as it did not have the DELETE_PACK name until your 72263ffc32
(builtin/repack.c: use named flags for existing_packs, 2022-05-20). But
maybe the comment that you added is sufficient.

If we had generic pointer-bitset macros, then perhaps other string-list
users could benefit, too. I thought maybe fast-export could use this for
its mark_to_ptr() stuff, but that is storing a whole 32-bit value, not a
bitset. So maybe this is just a weird localized thing.

A more radical idea is that we don't care very much about the data
structure as long as it is ordered. So we could just do:

  struct existing_pack {
          struct list_head list;
          int to_delete;
          char name[FLEX_ARRAY];
  };

and ditch string-list entirely. That lets us use "to_delete" in a
natural way. Though I suspect it makes all the _other_ code unreadable,
as we have to allocate them, deal with list_entry(), and so on.

So I guess I'm fine with any path (including the one in this patch).

-Peff
