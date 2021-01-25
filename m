Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E4C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D079623100
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbhAYS16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:27:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:37974 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbhAYS1u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 13:27:50 -0500
Received: (qmail 7619 invoked by uid 109); 25 Jan 2021 18:27:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Jan 2021 18:27:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19241 invoked by uid 111); 25 Jan 2021 18:27:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Jan 2021 13:27:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Jan 2021 13:27:00 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
Message-ID: <YA8NdHJloTf15qXf@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
 <YAtXmie2kHNrcBwY@coredump.intra.peff.net>
 <YA8DlQwSzNZXq+AU@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YA8DlQwSzNZXq+AU@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 12:44:53PM -0500, Taylor Blau wrote:

> Thanks for including a compelling argument in favor of the approach that
> I took in this patch.
> 
> I added something along the lines of what you suggested to the final
> paragraph, so now it concludes nicely instead of ending in a comma. I
> briefly considered whether I should add something about how these
> operations scale and how the warming efforts are really amortized across
> all of the objects, but I decided against it.
> 
> I think that this argument is already documented here, and that there's
> no way to concisely state it in an already long patch. Interested
> readers will easily be able to find our discussion here, which is good.

That sounds good. It is sort of arguing against a strawman anyway.

> > It mostly looks good to me. I agree with Junio that "compute" is a
> > better verb than "load" for generating the in-memory revindex.
> 
> Yeah, I settled on load_pack_revindex() either calling
> "create_pack_revindex_in_memory()" or "load_pack_revindex_from_disk()".

Perfect.

> > If p->revindex_data were "const uint32_t *", then this line would just
> > be:
> >
> >   return get_be32(p->revindex_data + pos);
> >
> > Not a huge deal either way since the whole point is to abstract this
> > behind a function where it only has to be written once. I don't think
> > there is any downside from the compiler's view (and we already use this
> > trick for the bitmap name-hash cache).
> 
> Honestly, I'm not a huge fan of implicitly scaling pos by
> sizeof(*p->revindex_data), but I can understand why it reads more
> clearly here. I don't really feel strongly either way, so I'm happy to
> change it in favor of your suggestion.
> 
> Of course, since RIDX_HEADER_SIZE is in bytes, not uint32_t's (and it
> has to be, since it's also used in the RIDX_MIN_SIZE macro, which is
> compared against the st_size of stating the .rev file), you have to do
> gross stuff like:
> 
>   p->revindex_data = (const uint32_t *)((const char *)p->revindex_map + RIDX_HEADER_SIZE);
> 
> But I guess the tradeoff is worth it, since the readers are easier to
> parse.

Yeah, that is definitely a downside. Perhaps keeping everything in bytes
makes things a bit more obvious. In which case I might suggest that
revindex_data just be a "const char *". You'd have to scale any pointer
computations at the point of use then, but you'd avoid needing to do any
extra casting.

-Peff
