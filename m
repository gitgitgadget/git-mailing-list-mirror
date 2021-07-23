Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09825C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D7F60E91
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhGWHFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:05:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:55432 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233370AbhGWHFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 03:05:20 -0400
Received: (qmail 10268 invoked by uid 109); 23 Jul 2021 07:45:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 07:45:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22996 invoked by uid 111); 23 Jul 2021 07:45:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 03:45:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 03:45:53 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 05/24] Documentation: describe MIDX-based bitmaps
Message-ID: <YPpzsU7GHpqXA/1H@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <64a260e0c6a116b7c6fa6fea2b9fd96bf416cb18.1624314293.git.me@ttaylorr.com>
 <YPf0hivipY6o5Y3B@coredump.intra.peff.net>
 <YPhfJNubkJpOn4Sm@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPhfJNubkJpOn4Sm@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 01:53:40PM -0400, Taylor Blau wrote:

> > > +	The ordering between packs is done lexicographically by the pack name,
> > > +	with the exception of the preferred pack, which sorts ahead of all other
> > > +	packs.
> >
> > Hmm, I'm not sure if this "lexicographically" part is true. Really we're
> > building on the midx .rev format here. And that says "defined by the
> > MIDX's pack list" (though I can't offhand remember if that is
> > lexicographic, or if it is in the reverse-mtime order).
> >
> > At any rate, should we just be referencing the rev documentation?
> 
> The packs are listed in lex order in the MIDX, but that is so we can
> binary search that list to determine whether a pack is included in the
> MIDX or not.
> 
> I had to check, but we do use the lex order to resolve duplicate
> objects, too. See (at the tip of this branch):
> 
>     QSORT(ctx.info, ctx.nr, pack_info_compare);
> 
> from within midx.c:write_midx_internal(). Here, ctx.info contains the
> list of packs, and pack_info_compare is a thin wrapper around
> strcmp()-ing the pack_name values of two packed_git structures.

Ah, OK, thanks for checking.

> Arguably, you'd get better EWAH compression of the bits between packs
> if we sorted packs in reverse order according to their mtime. But I
> suspect that it doesn't matter much in practice, since the number of
> objects vastly outpaces the number of packs (but I haven't measured to
> be certain, so take that with a grain of salt).

Agreed, especially when the intended use is with geometric repacking to
keep reasonable-sized packs.

Either way, I think heuristics to optimize the pack ordering can easily
come on top later. Let's keep this series focused on the fundamentals of
having midx bitmaps at all.

> In any case, I think that you're right that adding too much detail hurts
> us here, so we should really be mentioning the MIDX's .rev-file
> documentation (unfortunately, we can't linkgit it, so mentioning it by
> name will have to suffice). I plan to reroll with something like this on
> top:
> 
> diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
> index 25221c7ec8..04b3ec2178 100644
> --- a/Documentation/technical/bitmap-format.txt
> +++ b/Documentation/technical/bitmap-format.txt
> @@ -26,9 +26,8 @@ An object is uniquely described by its bit position within a bitmap:
> 
>  		o1 <= o2 <==> pack(o1) <= pack(o2) /\ offset(o1) <= offset(o2)
> 
> -	The ordering between packs is done lexicographically by the pack name,
> -	with the exception of the preferred pack, which sorts ahead of all other
> -	packs.
> +	The ordering between packs is done according to the MIDX's .rev file.
> +	Notably, the preferred pack sorts ahead of all other packs.
> 
>  The on-disk representation (described below) of a bitmap is the same regardless
>  of whether or not that bitmap belongs to a packfile or a MIDX. The only

Thanks, that looks much better. We can't linkgit, but we only build HTML
for these. So just a link to pack-format.html would work, as they'd
generally be found side-by-side in the filesystem. But since this
doesn't even really render as asciidoc, I'm not sure I care either way.
(Obviously we could also mention pack-format.txt by name, but it's
probably already obvious-ish to a human that this is where you'd find
information on the pack .rev format).

-Peff
