Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A79C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA32F610A3
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhJUWXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:23:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60676 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhJUWXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:23:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 796E3FE291;
        Thu, 21 Oct 2021 18:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wFabfkMYBIxePPnvDJwiNogruMxDnHd+h5SCtI
        8Hlxg=; b=u0dv/IyISgO/0Ino29nAFpuFHBp01b1oetdGcCnOl/zPIJwNWdkuuH
        T+RtGF6Zp/nBkeyTk6dz0/me6RYoL5dtURv0coel/nguKDfBgkQvrCSkFuZUuoH6
        vbO+CG7Oe3BMqpITeD+D7XEsYm5eBhrwQvfLoGq06t6oJBqSN4azI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 710A6FE290;
        Thu, 21 Oct 2021 18:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9909FE28F;
        Thu, 21 Oct 2021 18:20:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 2/3] sparse-index: add ensure_correct_sparsity function
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
        <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
        <0b6e6633bb2b9f21a79625ace6db9509c48bd819.1634849307.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 15:20:50 -0700
In-Reply-To: <0b6e6633bb2b9f21a79625ace6db9509c48bd819.1634849307.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Thu, 21 Oct 2021 20:48:25
        +0000")
Message-ID: <xmqqy26mhvel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 268A1DEA-32BD-11EC-AF3C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -int convert_to_sparse(struct index_state *istate, int flags)
> +static int can_convert_to_sparse(struct index_state *istate, int flags)
>  {
>  	int test_env;

May not be a problem with this patch, but this variable does not
need to be in this large a scope.

> -	if (istate->sparse_index || !istate->cache_nr ||
> -	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
> +	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
>  		return 0;
>  
>  	if (!istate->repo)
> @@ -187,6 +186,30 @@ int convert_to_sparse(struct index_state *istate, int flags)
>  	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
>  		return 0;
>  
> +	return 1;
> +}
> +
> +int convert_to_sparse(struct index_state *istate, int flags)
> +{
> +	int verify = flags & SPARSE_INDEX_VERIFY_ALLOWED;
> +
> +	/*
> +	 * If validating with strict checks against whether the sparse index is
> +	 * allowed, we want to check `can_convert_to_sparse` *before* exiting
> +	 * early due to an already sparse or empty index.
> +	 *
> +	 * If not performing strict validation, the order is reversed to avoid
> +	 * the more expensive checks in `can_convert_to_sparse` whenver possible.
> +	 */
> +	if (verify) {
> +		if (!can_convert_to_sparse(istate, flags))
> +			return -1;
> +		else if (istate->sparse_index || !istate->cache_nr)
> +			return 0;
> +	} else if (istate->sparse_index || !istate->cache_nr ||
> +		   !can_convert_to_sparse(istate, flags))
> +		return 0;
> +
>  	remove_fsmonitor(istate);
>  
>  	trace2_region_enter("index", "convert_to_sparse", istate->repo);
> @@ -313,6 +336,19 @@ void ensure_full_index(struct index_state *istate)
>  	trace2_region_leave("index", "ensure_full_index", istate->repo);
>  }
>  
> +void ensure_correct_sparsity(struct index_state *istate)
> +{
> +	/*
> +	 * First check whether the index can be converted to sparse by attempting
> +	 * to convert it with the SPARSE_INDEX_VERIFY_ALLOWED flag. If the
> +	 * SPARSE_INDEX_VERIFY_ALLOWED checks indicate that the index cannot
> +	 * be converted because repository settings and/or index properties
> +	 * do not allow it, expand the index to full.
> +	 */

The logic may be OK, but the need to give this long description is a
sign that the meaning of the value returned from the function is not
clear from the name of the function.

> +	if (convert_to_sparse(istate, SPARSE_INDEX_VERIFY_ALLOWED))
> +		ensure_full_index(istate);

It might make it more straight-forward to 

 (1) drop the "if (verify)" part in convert_to_sparse(), which would
     mean that for all callers convert_to_sparse() will retain the
     same behaviour as before;

 (2) make a call to can_convert_to_sparse() here, and if that
     returns true, make a call to ensure_full_index(); this would
     behave identically to what this patch does when can_convert is
     false; and

 (3) correct the can_convert_to_sparse() function to not blow away
     the cache_tree unconditionally and recompute, so that calling
     it twice in a row will not be costly.
