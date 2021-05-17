Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D83C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 21:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6426E611ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 21:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbhEQVrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 17:47:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60700 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhEQVrT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 17:47:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D71D0134340;
        Mon, 17 May 2021 17:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8KZ0hY6UUZGks1lA0fDpLrXS3vQGR0rSWs/G5w
        TKVbk=; b=RDqR6tyjaNoCoGv9UWOS5YLeCRcDYldSYIx7bhqrHX9KRdvDP2Z2j3
        ZswIHuVYFIpeBHp4U/o5gUz0ViRExdl7VjjocP8gGfkkKW5EJWXtkucfB3Xp5xMe
        mfYmHNztJXpn4VLnvD38ohlEs+UTrmMbSRQrusbZaXOtKXMYmouWI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF83E13433F;
        Mon, 17 May 2021 17:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0439113433C;
        Mon, 17 May 2021 17:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] sparse-index: fix uninitialized jump
References: <pull.953.git.1621254137590.gitgitgadget@gmail.com>
Date:   Tue, 18 May 2021 06:45:57 +0900
In-Reply-To: <pull.953.git.1621254137590.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 17 May 2021 12:22:17
        +0000")
Message-ID: <xmqqo8d9590q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4445911E-B759-11EB-8464-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> While testing the sparse-index, I verified a test with --valgrind and it
> complained about an uninitialized value being used in a jump in the
> path_matches_pattern_list() method. The line was this one:
>
> 	if (*dtype == DT_UNKNOWN)
>
> In the call stack, the culprit was the initialization of the dtype
> variable in convert_to_sparse_rec().
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

Looks good.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-953%2Fderrickstolee%2Fsparse-index%2Funinitialized-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-953/derrickstolee/sparse-index/uninitialized-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/953
>
>  sparse-index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index b0d5dc5f081b..affc4048f279 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -34,7 +34,7 @@ static int convert_to_sparse_rec(struct index_state *istate,
>  	int i, can_convert = 1;
>  	int start_converted = num_converted;
>  	enum pattern_match_result match;
> -	int dtype;
> +	int dtype = DT_UNKNOWN;
>  	struct strbuf child_path = STRBUF_INIT;
>  	struct pattern_list *pl = istate->sparse_checkout_patterns;
>  
>
> base-commit: bf949ade81106fbda068c1fdb2c6fd1cb1babe7e
