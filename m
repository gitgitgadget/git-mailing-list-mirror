Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A87C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E923976
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbhANGrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:47:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60599 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhANGrm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 01:47:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54A14AA6A5;
        Thu, 14 Jan 2021 01:46:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=kbD5bRFCM+pDAhFTna+DRAhJnss=; b=xt02kkMGKxdlKYVAM9/U
        n7QsCaQV5JluKP0JED77LjCTplsh0yyUYEkR9msvO4bREN9Iq1OshGtP3xGW5xuD
        D2gaznAHXf3SRtCW4LRBt7F2hRqiLe2G9vVI5hOhzye3Aj1tFsVTAZDjQgineEep
        dbcuENs9EsubwVLxa/s6yQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=gL5LeIdvE7Hs7Gb5QP7z6DGLXKzwlEqj8Jm0rBvEtNhR9W
        w8KVnTAG75uEUZAs765A0krT7QQOuSK9CBb/7vC2v6hDNN9uCHnxdbUg1qgG7c+u
        3Zf4bp1phRyByOStzt7+Pc34jxCtJ+puMnY77gnan3tXqkwFXgieh3gnVP4Ts=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A400AA6A4;
        Thu, 14 Jan 2021 01:46:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7ACEAA6A3;
        Thu, 14 Jan 2021 01:46:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 01/20] pack-revindex: introduce a new API
References: <cover.1610129796.git.me@ttaylorr.com>
        <cover.1610576604.git.me@ttaylorr.com>
        <e1aa89244ad3edb52aaeb28d6934cb2b0a0dc65a.1610576604.git.me@ttaylorr.com>
Date:   Wed, 13 Jan 2021 22:46:57 -0800
Message-ID: <xmqq1reoypzy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C010388-5634-11EB-A31C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +/*
> + * offset_to_pack_pos converts an object offset to a pack position. This
> + * function returns zero on success, and a negative number otherwise. The
> + * parameter 'pos' is usable only on success.
> + *
> + * If the reverse index has not yet been loaded, this function loads it lazily,
> + * and returns an negative number if an error was encountered.

It is somewhat strange to see a function that yields a non-negative
"position" on success and a negative value to signal a failure to
have a separate pointer to the location to receive the true return
value.  Do we truly care the upper half of "uint32_t" (in other
words, do we seriously want to support more than 2G positions in a
pack)?

What I'm trying to get at is that

		int pos = offset_to_pack_pos(...);
		if (pos < 0)
			error();
		else
			use(pos);

is more natural than

		uint32_t pos;
                if (offset_to_pack_pos(..., &pos) < 0)
			error();
		else
			use(pos);

but now I wrote it down and laid it out in front of my eyes, the
latter does not look too bad.

	... later comes back after reading through the series ...

	The new callers all looked quite nice to eyes.  Because we
	discourage assignment inside if() condition, the converted
	result does not make the code more verbose than the
	original.  In fact, it makes it even clearer that we are
	checking for an error return from a function call.  

	Quite nice.

> + * This function runs in time O(log N) with the number of objects in the pack.

Is it a good idea to commit to such performance characteristics as a
promise to callers like this (the comment applies to all three
functions)?

It depends on how a developer is helped by this comment when
deciding whether to use this function, or find other ways, to
implement what s/he wants to do.

> + */
> +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos);

> +/*
> + * pack_pos_to_index converts the given pack-relative position 'pos' by
> + * returning an index-relative position.
> + *
> + * If the reverse index has not yet been loaded, or the position is out of
> + * bounds, this function aborts.
> + *
> + * This function runs in constant time.
> + */
> +uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
> +
> +/*
> + * pack_pos_to_offset converts the given pack-relative position 'pos' into a
> + * pack offset. For a pack with 'N' objects, asking for position 'N' will return
> + * the total size (in bytes) of the pack.

If we talk about "asking for 'N'" and want it to mean "one beyond
the last position", it is better to clarify that we count from 0.
But see below.

> + * If the reverse index has not yet been loaded, or the position is out of
> + * bounds, this function aborts.

I think it is easier to read if the "unlike the above function, this
allows pos that is one beyond the last object" is explained next to
"if out of bounds, it is an error", not as a part of the previous
paragraph.

> + * This function runs in constant time.
> + */
> +off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
> +
>  #endif
