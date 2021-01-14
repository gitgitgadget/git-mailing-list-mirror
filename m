Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CBCC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0002395C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbhANGna (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:43:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56364 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhANGna (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 01:43:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E71E210A0ED;
        Thu, 14 Jan 2021 01:42:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=FWeE2oviFIZin79jXvzf7+cqZCQ=; b=JhG1YTMvmU5yy9uPgqvQ
        gLHITmB73Dxt18T2tjrPTinUopATMyBi/dncLueWosiXjM77Un1nPWNMvKGy92Oo
        JK0AE/5iMhfgHzN3+vYd6QcTb0R85a3oezDFoTO2JxDF9oQLQSE1JXDASF56iR5G
        Pdvhj+caMrCbuCerghE4wqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=gOa3MsOdvBkuWL7E/ZHzFUqbfP/Ik+Nmy3z62AJkhobx+D
        ErYWqXP2hqs17SxCacNtObKuKMh6oViq0vkRBHDZEunfCi5jP47iaYnvcGGZikP2
        mZpJp+B+OuqfzfQ+q4MFtxEfoUhnGRUD040putUXemfiwEs9rs3YxXbzAdwlA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2CD110A0EC;
        Thu, 14 Jan 2021 01:42:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 177E710A0EA;
        Thu, 14 Jan 2021 01:42:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 18/20] pack-revindex: remove unused
 'find_revindex_position()'
References: <cover.1610129796.git.me@ttaylorr.com>
        <cover.1610576604.git.me@ttaylorr.com>
        <3b5c92be684b95f04cbe224c791d87657be9ff79.1610576604.git.me@ttaylorr.com>
Date:   Wed, 13 Jan 2021 22:42:45 -0800
Message-ID: <xmqqft34yq6y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B68FE710-5633-11EB-9D79-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> -int find_revindex_position(struct packed_git *p, off_t ofs)
> +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
>  {
> -	int lo = 0;
> -	int hi = p->num_objects + 1;
> -	const struct revindex_entry *revindex = p->revindex;
> +	unsigned lo, hi;
> +	const struct revindex_entry *revindex;
> +
> +	if (load_pack_revindex(p) < 0)
> +		return -1;
> +
> +	lo = 0;
> +	hi = p->num_objects + 1;
> +	revindex = p->revindex;
>  	do {
>  		const unsigned mi = lo + (hi - lo) / 2;
>  		if (revindex[mi].offset == ofs) {
> -			return mi;
> +			*pos = mi;
> +			return 0;
>  		} else if (ofs < revindex[mi].offset)
>  			hi = mi;
>  		else

OK, we can safely depend on "unsigned int" at least as wide as
"uint32_t"; unlike the original that used "int", we won't risk
losing the upper half of 4G range.

Nice.
