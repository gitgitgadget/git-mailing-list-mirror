Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACABC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F84B2395C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbhANGnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:43:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50842 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhANGnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 01:43:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BEAA10E1BD;
        Thu, 14 Jan 2021 01:42:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sc1v8lkL6EKMx212WMxHhdz/lL4=; b=BJ5faZ
        EWSGvLxOx0da+i2o4HYNitVTXBtV0wN1+HC+3l1qmMdqreu8nWfsEDe9SMXXFN78
        T6eQZRgHR6kPy/Z5atlxvlbuW4k6w+VgL0KY+vdO247OhXwvLWlb2lDREOY0AmK8
        6utZr0rsuUy59HtCoM3Ba9FyMyyzSyTpHL5uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vNAdiJjLpVz2y6A2GzOrJoJJ+Xr5ReE6
        wBh3vgH+r6RTxsnKK5H6C6aCOpgsQnityOPM1GBfTo16c8xqA+QqgB81uO7irKWG
        XLs+kBdpmHXzOEPfU0LBKbvV/cE6KOBwBvK4ZIFk1/EHDR4bAyMef9Hr9L/kHzFi
        Y/a1IzekKeQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3380C10E1BC;
        Thu, 14 Jan 2021 01:42:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 291E710E1BB;
        Thu, 14 Jan 2021 01:42:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 20/20] pack-revindex.c: avoid direct revindex access
 in 'offset_to_pack_pos()'
References: <cover.1610129796.git.me@ttaylorr.com>
        <cover.1610576604.git.me@ttaylorr.com>
        <8400ff6c9615b4c999b198c46b2e673ec0f2b14f.1610576604.git.me@ttaylorr.com>
Date:   Wed, 13 Jan 2021 22:42:29 -0800
In-Reply-To: <8400ff6c9615b4c999b198c46b2e673ec0f2b14f.1610576604.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 13 Jan 2021 17:25:10 -0500")
Message-ID: <xmqqmtxcyq7e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD115BEC-5633-11EB-87C1-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> To prepare for on-disk reverse indexes, remove a spot in
> 'offset_to_pack_pos()' that looks at the 'revindex' array in 'struct
> packed_git'.

Hmph, I somehow would have expected that this clean-up would be done
before step [18/20], but that does not matter in the end.  The end
result looks fairly clean.

I wonder if the call overhead to pack_pos_to_offset(), relative to
the direct indexing of an in-core array revindex[] followed by an
access to a member .offset that we used to do, makes a measurable
difference in this tight loop, though.

> diff --git a/pack-revindex.c b/pack-revindex.c
> index a508d5f0a4..5e69bc7372 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -177,21 +177,21 @@ int load_pack_revindex(struct packed_git *p)
>  int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
>  {
>  	unsigned lo, hi;
> -	const struct revindex_entry *revindex;
>  
>  	if (load_pack_revindex(p) < 0)
>  		return -1;
>  
>  	lo = 0;
>  	hi = p->num_objects + 1;
> -	revindex = p->revindex;
>  
>  	do {
>  		const unsigned mi = lo + (hi - lo) / 2;
> -		if (revindex[mi].offset == ofs) {
> +		off_t got = pack_pos_to_offset(p, mi);
> +
> +		if (got == ofs) {
>  			*pos = mi;
>  			return 0;
> -		} else if (ofs < revindex[mi].offset)
> +		} else if (ofs < got)
>  			hi = mi;
>  		else
>  			lo = mi + 1;
