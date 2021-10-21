Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63638C4332F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3E26147F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhJUQ5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:57:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54911 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhJUQ5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:57:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F39AA161314;
        Thu, 21 Oct 2021 12:54:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FrtHYvCFfgO+x6ey+4rmcN2iDeVr9StgkBAxnM
        I1iXo=; b=HLexp32zxxCJZQh7OXtkpfy/HinHC4HVUPFaygKzTa7v34uPudVVxV
        7B51Ni57CANfWCp8Ge/579Te2Hp4pf9CgZLKykhgwnDMSXMm3iMkkFu2lOuwObIp
        UsD1ZCh/XRs3TMgg8sG7kFPdW2UcgHCRPgmrpviHvj5/oQI9jXkcw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBFAE161312;
        Thu, 21 Oct 2021 12:54:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 47B48161310;
        Thu, 21 Oct 2021 12:54:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 07/11] pack-bitmap.c: avoid leaking via
 midx_bitmap_filename()
References: <cover.1634787555.git.me@ttaylorr.com>
        <f3897c3afc0e47933289025c269a4d5f248241ef.1634787555.git.me@ttaylorr.com>
Date:   Thu, 21 Oct 2021 09:54:39 -0700
In-Reply-To: <f3897c3afc0e47933289025c269a4d5f248241ef.1634787555.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 20 Oct 2021 23:40:02 -0400")
Message-ID: <xmqqcznymi7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9597B0CC-328F-11EC-9936-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> But that intermediate allocation feels wasteful. Since this function is
> simple enough, we can instead "inline" its implementation into the
> xstrfmt call itself. That is a little gross, but arguably better than
> allocating memory unnecessarily.

The function being "simple enough" does not help maintenance burden
this change brings in at all, does it?  Unless it is accompanied by
a comment "the template string used here must be kept in sync with
what is used in the get_midx_filename() defined elsewhere" near the
lines this patch touches, perhaps in big red letters, that is.

Without this caller, get_midx_filename() could be file-scope static
in midx.c and can be eliminated from midx.h, it seems.  If there are
many other filenames like midx_bitmap that are derrived from
midx_filename, it might be worth extending get_midx_filename to take
an extra format parameter (i.e. "I want midx-related filename for
this object directory, but I am getting this .bitmap kind").  Another
remedy may be to move this function to midx.c and make it sit next
to what this function must be always in sync with.

Or use a C preprocessor macro for "%s/pack/multi-pack-index" in
midx.h and use it here and there to make sure they will stay in
sync.

But after reading all the users of get_midx_filename(), especially
given that it is mostly internal implementation detail inside
midx.c, I think rewriting

	f() {
	char *midx = get_midx_filename(...);

	... use midx ...

	cleanup:
	free(midx);
	}

into

	f() {
	struct strbuf midx;

	get_midx_filename(&midx, ...);

	... use midx.buf ...

	cleanup:
	strbuf_release(&midx);
	}

is not too bad a fix for this.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index f47a0a7db4..d292e81af1 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -292,8 +292,8 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
>  
>  char *midx_bitmap_filename(struct multi_pack_index *midx)
>  {
> -	return xstrfmt("%s-%s.bitmap",
> -		       get_midx_filename(midx->object_dir),
> +	return xstrfmt("%s/pack/multi-pack-index-%s.bitmap",
> +		       midx->object_dir,
>  		       hash_to_hex(get_midx_checksum(midx)));
>  }
