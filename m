Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE86C4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 22:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65D62220F
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 22:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgLCWBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 17:01:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52607 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgLCWBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 17:01:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A5248975B;
        Thu,  3 Dec 2020 17:00:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CB4J20YoYnSrrfNDtiXGJTzsKm8=; b=NFKBWU
        VZ0pGWkoysAYe2scUQQLfg8wMyGpNzvjb2lIVbnVDQkTVEy8Sk1/+AtW21jeHZEw
        tIhK2p1p6cDtxp1jtkg3aDwJVM5sIsN03//viDEtz7a95gT0orzzJKD3UUsYA2jk
        2pPtEoK+n+wtlFqaVgu+q+1Y18/PIWAESF75s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h9pzth6bKrcLo4YhmhT448YTEBttlknv
        HI/yk8N5n9AdmWUmF7YiK+wm3A1MDJduN0F3hnhLRZvJw4NDxlkpTpzR4gkqJeVC
        gj9Dlvx7ThHlqQ0vsDJb2qPbaA9OkhN1j+7VQsRycuG+Ek2gJ1UsQpATl6scyADC
        PcIWIxPGmGM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 623258975A;
        Thu,  3 Dec 2020 17:00:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E22FC89758;
        Thu,  3 Dec 2020 17:00:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 11/15] midx: use 64-bit multiplication for chunk sizes
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
        <c6a433efba3214e83a7265e53c24cb4001345f14.1607012215.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 14:00:50 -0800
In-Reply-To: <c6a433efba3214e83a7265e53c24cb4001345f14.1607012215.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 03 Dec 2020
        16:16:50 +0000")
Message-ID: <xmqqa6uuh7n1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01BBA504-35B3-11EB-8BC3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When calculating the sizes of certain chunks, we should use 64-bit
> multiplication always. This allows us to properly predict the chunk
> sizes without risk of overflow.

That's quite an obvious fix, applicable even before this entire
series.  I think we saw quite similar bugfixes in different parts of
the codebase recently.

So far, everything looks good.


> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 0548266bea..47f5f60fcd 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -946,12 +946,12 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	chunks[2].write_fn = write_midx_oid_lookup;
>  
>  	chunks[3].id = MIDX_CHUNKID_OBJECTOFFSETS;
> -	chunks[3].size = ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH;
> +	chunks[3].size = (uint64_t)ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH;
>  	chunks[3].write_fn = write_midx_object_offsets;
>  
>  	if (ctx.large_offsets_needed) {
>  		chunks[4].id = MIDX_CHUNKID_LARGEOFFSETS;
> -		chunks[4].size = ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
> +		chunks[4].size = (uint64_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
>  		chunks[4].write_fn = write_midx_large_offsets;
>  	}
