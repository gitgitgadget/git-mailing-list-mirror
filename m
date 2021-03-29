Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38AAC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 670E261874
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhC2MoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:44:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:35514 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231445AbhC2Mnk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:43:40 -0400
Received: (qmail 10748 invoked by uid 109); 29 Mar 2021 12:43:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 12:43:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13530 invoked by uid 111); 29 Mar 2021 12:43:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 08:43:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 08:43:39 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 13/16] pack-revindex: read multi-pack reverse indexes
Message-ID: <YGHLe0nmh7R8hsVo@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <a6ebd4be91e0ff0b31d1629c2e3a75c016d56397.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6ebd4be91e0ff0b31d1629c2e3a75c016d56397.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:05:29PM -0500, Taylor Blau wrote:

> Implement reading for multi-pack reverse indexes, as described in the
> previous patch.

Looks good overall. I found a few tiny nits below.

> +int load_midx_revindex(struct multi_pack_index *m)
> +{
> +	char *revindex_name;
> +	int ret;
> +	if (m->revindex_data)
> +		return 0;
> +
> +	revindex_name = get_midx_rev_filename(m);
> +
> +	ret = load_revindex_from_disk(revindex_name,
> +				      m->num_objects,
> +				      &m->revindex_map,
> +				      &m->revindex_len);
> +	if (ret)
> +		goto cleanup;

On error, I wondered if m->revindex_map, etc, would be modified. But it
looks like no, load_revindex_from_disk() is careful not to touch them
unless it sees a valid revindex. Good.

> +int close_midx_revindex(struct multi_pack_index *m)
> +{
> +	if (!m)
> +		return 0;
> +
> +	if (munmap((void*)m->revindex_map, m->revindex_len))
> +		return -1;
> +
> +	m->revindex_map = NULL;
> +	m->revindex_data = NULL;
> +	m->revindex_len = 0;
> +
> +	return 0;
> +}

It's hard to imagine why munmap() would fail. But if it does, we should
probably clear the struct fields anyway. I note that the matching code
for a "struct packed_git" does not bother even checking the return value
of munmap. Perhaps we should just do the same here.

The packed_git version also returned early if revindex_map is NULL. Here
the burden is placed on the caller (it's hard to tell if that matters
since there aren't any callers yet, but it probably makes sense to push
the check down into this function).

> +uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos)
> +{
> +	if (!m->revindex_data)
> +		BUG("pack_pos_to_midx: reverse index not yet loaded");
> +	if (m->num_objects <= pos)
> +		BUG("pack_pos_to_midx: out-of-bounds object at %"PRIu32, pos);
> +	return get_be32((const char *)m->revindex_data + (pos * sizeof(uint32_t)));
> +}

OK, this one is just a direct read of the .rev data, like
pack_pos_to_index() is. I think the final line can be simplified to:

  return get_be32(m->revindex_data + pos);

just like pack_pos_to_index(). (I suspect this is a leftover from the
earlier version of your .rev series where the pointer was still a "void
*").

> +int midx_to_pack_pos(struct multi_pack_index *m, uint32_t at, uint32_t *pos)
> +{
> +	struct midx_pack_key key;
> +	uint32_t *found;
> +
> +	if (!m->revindex_data)
> +		BUG("midx_to_pack_pos: reverse index not yet loaded");
> +	if (m->num_objects <= at)
> +		BUG("midx_to_pack_pos: out-of-bounds object at %"PRIu32, at);
> +
> +	key.pack = nth_midxed_pack_int_id(m, at);
> +	key.offset = nth_midxed_offset(m, at);
> +	key.midx = m;
> +	/*
> +	 * The preferred pack sorts first, so determine its identifier by
> +	 * looking at the first object in pseudo-pack order.
> +	 *
> +	 * Note that if no --preferred-pack is explicitly given when writing a
> +	 * multi-pack index, then whichever pack has the lowest identifier
> +	 * implicitly is preferred (and includes all its objects, since ties are
> +	 * broken first by pack identifier).
> +	 */
> +	key.preferred_pack = nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));
> +
> +	found = bsearch(&key, m->revindex_data, m->num_objects,
> +			sizeof(uint32_t), midx_pack_order_cmp);

OK, this one is _roughly_ equivalent to offset_to_pack_pos(), in that we
have to binary search within the pack-ordered list to find the entry.
Makes sense.

Probably sizeof(*m->revindex_data) would be slightly nicer in the
bsearch call (again, I suspect a holdover from when that was a void
pointer).

-Peff
