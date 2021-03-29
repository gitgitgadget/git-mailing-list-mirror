Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BC5C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0E460235
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhC2MND (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:13:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:35450 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhC2MMk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:12:40 -0400
Received: (qmail 10578 invoked by uid 109); 29 Mar 2021 12:12:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 12:12:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13242 invoked by uid 111); 29 Mar 2021 12:12:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 08:12:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 08:12:39 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 12/16] Documentation/technical: describe multi-pack
 reverse indexes
Message-ID: <YGHEN6rcao2tJ006@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <4745bb8590f5cdc24445618dd63ba6bd541227b4.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4745bb8590f5cdc24445618dd63ba6bd541227b4.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:05:25PM -0500, Taylor Blau wrote:

> As a prerequisite to implementing multi-pack bitmaps, motivate and
> describe the format and ordering of the multi-pack reverse index.

Nicely written overall. I found a few typos / formatting issues.

> +One solution is to let bits occupy the same position in the oid-sorted
> +index stored by the MIDX. But because oids are effectively random, there

s/there/their/

> +Given the list of packs and their counts of objects, you can
> +na&iuml;vely reconstruct that pseudo-pack ordering (e.g., the object at

An HTML entity seems to have snuck in. The source is utf8, so we can
just say ï.

> +position 27 must be (c,1) because packs "a" and "b" consumed 25 of the
> +slots). But there's a catch. Objects may be duplicated between packs, in
> +which case the MIDX only stores one pointer to the object (and thus we'd
> +want only one slot in the bitmap).
> +
> +Callers could handle duplicates themselves by reading objects in order
> +of their bit-position, but that's linear in the number of objects, and
> +much too expensive for ordinary bitmap lookups. Building a reverse index
> +solves this, since it is the logical inverse of the index, and that
> +index has already removed duplicates. But, building a reverse index on
> +the fly can be expensive. Since we already have an on-disk format for
> +pack-based reverse indexes, let's reuse it for the MIDX's pseudo-pack,
> +too.

Yep, I think this nicely builds up the logic explaining the need for the
midx .rev file.

> +Objects from the MIDX are ordered as follows to string together the
> +pseudo-pack. Let _pack(o)_ return the pack from which _o_ was selected
> +by the MIDX, and define an ordering of packs based on their numeric ID
> +(as stored by the MIDX). Let _offset(o)_ return the object offset of _o_
> +within _pack(o)_. Then, compare _o~1~_ and _o~2~_ as follows:

I guess the asciidoc-formatted version of this makes these nicely
italicized and subscripted. Personally I think pack(o) and o1 would be
more readable in the source (which is what I would tend to read). Or
maybe backticks if you want to be fancy.

> +  - If _pack(o~1~) &ne; pack(o~2~)_, then sort the two objects in
> +    descending order based on the pack ID.
> +
> +  - Otherwise, _pack(o~1~) &equals; pack(o~2~)_, and the objects are
> +    sorted in pack-order (i.e., _o~1~_ sorts ahead of _o~2~_ exactly
> +    when _offset(o~1~) &lt; offset(o~2~)_).

A few more HTML bits in the comparison operators.

-Peff
