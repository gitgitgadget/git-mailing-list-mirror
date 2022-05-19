Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F530C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 19:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbiESTvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 15:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbiESTvF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 15:51:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8933EBB
        for <git@vger.kernel.org>; Thu, 19 May 2022 12:51:01 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CA6319388F;
        Thu, 19 May 2022 15:51:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I+RPF7hVGTPLJouD3XuW2H6RqFGYpa6Ia81lBq
        Gjc8E=; b=q4Q6zI9/+zDRZFVsWG+A8Ad+0xEtWu93RKjC4yNZmEsTjMbUiWUw/G
        sDm3fYdu0AWfNANjqs410UsnhOlYaaZowevIaI8MW7HLnUddI7EszLLzpipd1wpn
        NbJ6pGkSrv2WHTgB5zipRJJDsFKKVMSNCGtl3FyyWTp6LQX6J8U1o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 651E719388B;
        Thu, 19 May 2022 15:51:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B730193875;
        Thu, 19 May 2022 15:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 03/10] sparse-index: create expand_to_pattern_list()
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <d15338573e570aebe239dacdd8c2aba275ff61b9.1652982758.git.gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 12:50:55 -0700
In-Reply-To: <d15338573e570aebe239dacdd8c2aba275ff61b9.1652982758.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 May 2022
        17:52:31 +0000")
Message-ID: <xmqqsfp5mhcw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFFB4664-D7AC-11EC-B72F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> list is NULL as that does the same as ensure_full_index(). In fact,
> ensure_full_index() is converted to a shim over
> expand_to_pattern_list().

Sounds like a natural evolution of the API that used to be
all-or-none to expand-only-those-that-match.

The old one had a sensible name to tell us that it is about the
in-core index (and "full index" implied it was about sparse-index
feature because what state other than "full" the index can be---some
are shrunk into tree entries, which by definition is the
sparse-index feature).  Contrasted to that, the name of the new one
is horrible.  It does not even have index anywhere in the name.

I wonder expand_index() would work?

> +void expand_to_pattern_list(struct index_state *istate,
> +			    struct pattern_list *pl)
>  {
>  	int i;
>  	struct index_state *full;
>  	struct strbuf base = STRBUF_INIT;
>  
> +	/*
> +	 * If the index is already full, then keep it full. We will convert
> +	 * it to a sparse index on write, if possible.
> +	 */
>  	if (!istate || !istate->sparse_index)
>  		return;
>  
> +	/*
> +	 * If our index is sparse, but our new pattern set does not use
> +	 * cone mode patterns, then we need to expand the index before we
> +	 * continue. A NULL pattern set indicates a full expansion to a
> +	 * full index.
> +	 */
> +	if (pl && !pl->use_cone_patterns)
> +		pl = NULL;
> +
>  	if (!istate->repo)
>  		istate->repo = the_repository;
>  
> -	trace2_region_enter("index", "ensure_full_index", istate->repo);
> +	/*
> +	 * A NULL pattern set indicates we are expanding a full index, so
> +	 * we use a special region name that indicates the full expansion.
> +	 * This is used by test cases, but also helps to differentiate the
> +	 * two cases.
> +	 */

Except that we lost the distinction for non-cone mode, which I am
not sure matters, but I suspect we do not have to, if we do not want
to.  Nobody used "pl" up to this point, so resetting it to NULL can
be done much later.  In later phases of this series, we add another
case where we can lose pl even if we are not using cone mode, so
this distinction may start to matter later.  I dunno.

I'd invent a separate "const char *tr2_region_label" variable and
set it at the beginning, regardless of where we clobber pl and why,
and use that label variable for trace2 calls, if I were doing this
patch.  That feels much simpler and cleaner.

> +	trace2_region_enter("index",
> +			    pl ? "expand_to_pattern_list" : "ensure_full_index",
> +			    istate->repo);

> diff --git a/sparse-index.h b/sparse-index.h
> index 633d4fb7e31..037b541f49d 100644
> --- a/sparse-index.h
> +++ b/sparse-index.h
> @@ -23,4 +23,18 @@ void expand_to_path(struct index_state *istate,
>  struct repository;
>  int set_sparse_index_config(struct repository *repo, int enable);
>  
> +struct pattern_list;
> +
> +/**
> + * Scan the given index and compare its entries to the given pattern list.
> + * If the index is sparse and the pattern list uses cone mode patterns,
> + * then modify the index to contain the all of the file entries within that
> + * new pattern list. This expands sparse directories only as far as needed.
> + *
> + * If the pattern list is NULL or does not use cone mode patterns, then the
> + * index is expanded to a full index.
> + */
> +void expand_to_pattern_list(struct index_state *istate,
> +			      struct pattern_list *pl);
> +
>  #endif
