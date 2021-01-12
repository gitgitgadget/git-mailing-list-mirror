Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227DEC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C1D22E00
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405581AbhALImK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:42:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:52964 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392373AbhALImK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:42:10 -0500
Received: (qmail 5814 invoked by uid 109); 12 Jan 2021 08:41:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 08:41:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10523 invoked by uid 111); 12 Jan 2021 08:41:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 03:41:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 03:41:28 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 01/20] pack-revindex: introduce a new API
Message-ID: <X/1guCOGWybOzIS7@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <fa6b8309088fd04410ca7276c5cf14db0fb82fb2.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa6b8309088fd04410ca7276c5cf14db0fb82fb2.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:16:43PM -0500, Taylor Blau wrote:

> In the next several patches, we will prepare for loading a reverse index
> either in memory, or from a yet-to-be-introduced on-disk format. To do
> that, we'll introduce an API that avoids the caller explicitly indexing
> the revindex pointer in the packed_git structure.

This API looks good to me. Here are a few extra thoughts:

> There are four ways to interact with the reverse index. Accordingly,
> four functions will be exported from 'pack-revindex.h' by the time that
> the existing API is removed. A caller may:

This tells us what the new API functions do. That's useful, but should
it be in the header file itself, documenting each function?

Likewise, I think we'd want to define the concepts in that
documentation. Something like:


  /*
   * A revindex allows converting efficiently between three properties
   * of an object within a pack:
   *
   *  - index position: the numeric position within the list of
   *    sorted object ids found in the .idx file
   *
   *  - pack position: the numeric position within the list of objects
   *    in their order within the actual .pack file (i.e., 0 is the
   *    first object in the .pack, 1 is the second, and so on)
   *
   *  - offset: the byte offset within the .pack file at which the
   *    object contents can be found
   */

And then above each function we can just say that it converts X to Y
(like you have in the commit message). It may also be worth indicating
the run-time of each (some of them are constant-time once you have a
revindex, and some are log(n)).

> +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)

The types here make sense. off_t is clearly needed for a pack offset,
and uint32_t is correct for the position fields, because packs have a
4-byte object count.

Separating the error return from the out-parameter makes the interface
slightly more awkward, but is needed to use the properly-sized types.
Makes sense.

> +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
> +{
> +	int ret;
> +
> +	if (load_pack_revindex(p) < 0)
> +		return -1;

This one lazy-loads the revindex for us, which seems handy...

> +uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
> +{
> +	if (!p->revindex)
> +		BUG("pack_pos_to_index: reverse index not yet loaded");
> +	if (pos >= p->num_objects)
> +		BUG("pack_pos_to_index: out-of-bounds object at %"PRIu32, pos);
> +	return p->revindex[pos].nr;
> +}

But these ones don't. I'm glad we at least catch it with a BUG(), but it
makes the API a little funny. Returning an error here would require a
similarly awkward out-parameter, I guess.

-Peff
