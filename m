Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895C0C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 06:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJRGzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 02:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJRGy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 02:54:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE20552831
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 23:54:57 -0700 (PDT)
Received: (qmail 29971 invoked by uid 109); 18 Oct 2022 06:54:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 06:54:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16427 invoked by uid 111); 18 Oct 2022 06:54:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Oct 2022 02:54:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Oct 2022 02:54:56 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH] repack: don't remove .keep packs with
 `--pack-kept-objects`
Message-ID: <Y05NwIfY/906b2Vd@coredump.intra.peff.net>
References: <6a012cd625c1d197ede91c85299cbfb37adf356b.1666059872.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a012cd625c1d197ede91c85299cbfb37adf356b.1666059872.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 10:26:06PM -0400, Taylor Blau wrote:

> But when `--pack-kept-objects` is given, things can go awry. Namely,
> when a kept pack is included in the list of packs tracked by the
> `pack_geometry` struct *and* part of the pack roll-up, we will delete
> the `.keep` pack when we shouldn't.

Oops. Your explanation makes sense, and this is an easy case to miss.

After reading the message but before seeing the patch, I'd guess we just
need to add "if (!this_pack_is_kept)" to the removal loop.

And indeed, it's close to that:

> diff --git a/builtin/repack.c b/builtin/repack.c
> index a5bacc7797..f71909696d 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1089,6 +1089,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  				strbuf_addstr(&buf, pack_basename(p));
>  				strbuf_strip_suffix(&buf, ".pack");
> 
> +				if ((p->pack_keep) ||
> +				    (string_list_has_string(&existing_kept_packs,
> +							    buf.buf)))
> +					continue;
> +
>  				remove_redundant_pack(packdir, buf.buf);
>  			}
>  			strbuf_release(&buf);

but what is the difference between p->pack_keep, and being in the
existing_kept_packs list? From the similar logic in
init_pack_geometry():

         /*
          * Any pack that has its pack_keep bit set will appear
          * in existing_kept_packs below, but this saves us from
          * doing a more expensive check.
          */
         if (p->pack_keep)
                 continue;

         /*
          * The pack may be kept via the --keep-pack option;
          * check 'existing_kept_packs' to determine whether to
          * ignore it.
          */
         strbuf_reset(&buf);
         strbuf_addstr(&buf, pack_basename(p));
         strbuf_strip_suffix(&buf, ".pack");

         if (string_list_has_string(existing_kept_packs, buf.buf))
                  continue;

it looks like one is a superset of the other, but checking p->pack_keep
is just slightly cheaper, so we do it first. And checking just
p->pack_keep isn't sufficient; the list has extra packs from the
--keep-pack command-line. So your new code checking both is correct.

But one thing to note. In that existing logic, the two checks are split
apart, since in the fast path (i.e., when p->pack_keep is set) we can
skip the extra work to form the pack string. We could do that here, but
I doubt it matters much:

  1. It's really not that expensive. It's a little extra string
     manipulation and a binary-search lookup for each pack.

  2. Normally most packs aren't kept, so we'd end up in the "slow" path
     most of the time anyway.

So I suspect that existing code is premature optimization, and you
really could just look in existing_kept_packs (both there and in this
patch).

But I don't mind this patch copying the existing logic in the meantime.
It's exactly this kind of "while we are in the area" cleanup where you
end up surprised that the p->pack_keep check really was covering some
subtle corner case. ;)

So the patch looks good to me as-is (and sorry for the verbose review;
we've just had enough tricky corner cases in this repack code that I
wanted to make sure I understood all the implications).

> This had mostly been a mystery that didn't occur at high enough volume
> to justify looking into. But it went away entirely after merging in
> v2.36.x, which contains e4d0c11c04.
> 
> Some investigating with Victoria today led to the patch above, which is
> still relevant since e4d0c11c04 papers over an existing bug.

Thank you both for digging into this. Because of the scale, GitHub has a
unique opportunity to trigger these kind of weird corner cases and races
that would otherwise go unreported and just cause occasional
head-scratching among people running sane-sized Git servers.

-Peff
