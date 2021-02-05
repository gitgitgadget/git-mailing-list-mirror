Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D3DC433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 00:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52EF064FB3
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 00:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhBEABJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 19:01:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51069 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhBEABH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 19:01:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B293912497A;
        Thu,  4 Feb 2021 19:00:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JlT1dxu7d94J0ziowxGl9LJ5uD8=; b=YiAxli
        BaSOhuKpAN+8uZuClVqQPo4YCusEymZMx9nVxkVT+oMiS4h0nIJCyHRWPOJTxUsp
        tCIn7sEdwojZ1BsrPK0YIgbLIqawmEAlL5w7Qjqg98bRyLGcQN2A/LqRzQER4JWw
        SzZqf/4xZJlhN6ZobKRDiwEw1nJmk/d8mp0P0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YrNoCqteRi2vl1oBUtmC8+MCP2Gy23A8
        IWa1RYDUDI3OuJgYIour9gLgyfYVJ2Miny0d22GPL9yOPZZMGYKhCw+9ebIZtZlo
        Djem53/O38U8+1W5et8zrJtrbmZU4P+572RvvhKIpevQ0S3SWnpE018ycsE7hGDR
        Qnw1riQYVpk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB537124979;
        Thu,  4 Feb 2021 19:00:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDAC2124978;
        Thu,  4 Feb 2021 19:00:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 15/17] midx: use 64-bit multiplication for chunk sizes
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <83d292532a0fa3f3a0ad343421be4a99a03471d0.1611759716.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 16:00:19 -0800
In-Reply-To: <83d292532a0fa3f3a0ad343421be4a99a03471d0.1611759716.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 27 Jan 2021
        15:01:54 +0000")
Message-ID: <xmqq8s834c4s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23706DC4-6745-11EB-BACA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When calculating the sizes of certain chunks, we should use 64-bit
> multiplication always. This allows us to properly predict the chunk
> sizes without risk of overflow.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This one I find somewhat questionable for multiple reasons.

 * the fourth parameter of add_chunk() is of size_t, not uint64_t;
   shouldn't the multiplication be done in type size_t instead?

 * these mutiplications were introduced in "midx: use chunk-format
   API in write_midx_internal()"; that step should use the
   arithmetic with cast (if necessary) from the start, no?

 * There is "ctx.entries_nr * MIDX_CHUNKID_OFFSET_WIDTH" passed to
   add_chunk(), in the post-context of the first hunk.  Shouldn't
   that be covered as well?  I didn't grep for all uses of
   add_chunk(), but I wouldn't be surprised if this patch missed
   some of the calls that need the same treatment.

> diff --git a/midx.c b/midx.c
> index e94dcd34b7f..a365dac6bbc 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -913,7 +913,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT,
>  		  write_midx_oid_fanout, MIDX_CHUNK_FANOUT_SIZE);
>  	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
> -		  write_midx_oid_lookup, ctx.entries_nr * the_hash_algo->rawsz);
> +		  write_midx_oid_lookup, (uint64_t)ctx.entries_nr * the_hash_algo->rawsz);
>  	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
>  		  write_midx_object_offsets,
>  		  ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH);
> @@ -921,7 +921,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	if (ctx.large_offsets_needed)
>  		add_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS,
>  			write_midx_large_offsets,
> -			ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH);
> +			(uint64_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH);
>  
>  	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
>  	write_chunkfile(cf, &ctx);
