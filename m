Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE84CD13DE
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjIRWqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjIRWqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:46:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D63A6
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:46:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78A421BAB59;
        Mon, 18 Sep 2023 18:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=DAhsZxZAkf6N86JW5rBKmx7lV+IGqMM9ozrJJI
        lgwtI=; b=QLBBzhIaQFNQl/J5fLwtcNHGnQuRG19GIy9WUbsGGwYvTqE6EYKjDV
        Bxe0GQ41+H7eZpPj1dOq2zDKt/LUIwiSB0Ty8wJwsvsFWP9h+qiI3+Vtwcj0sEmK
        PN9tG2wZmBiVkGUmwlYiVb/ddOsM3oI/veIYnZ3zFso5kZkcoUaHw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 717FF1BAB58;
        Mon, 18 Sep 2023 18:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE78C1BAB57;
        Mon, 18 Sep 2023 18:46:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/3] refs: push lock management into packed backend
In-Reply-To: <dea0fbb139a82fe449a7edab6a8f445ce763d0c0.1695059978.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 18 Sep 2023
        17:59:36 +0000")
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
        <dea0fbb139a82fe449a7edab6a8f445ce763d0c0.1695059978.git.gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 15:46:21 -0700
Message-ID: <xmqqa5tjje0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30F149C4-5675-11EE-8243-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	struct ref_transaction *tr;
> +	int ret = 0;
>  	assert(err);
>  
>  	CALLOC_ARRAY(tr, 1);
>  	tr->ref_store = refs;
> +
> +	if (refs->be->transaction_begin)
> +		ret = refs->be->transaction_begin(refs, tr, err);
> +	if (ret) {
> +		free(tr);
> +		return NULL;
> +	}
>  	return tr;
>  }

This looks a bit more convoluted than necessary.  Is it the same as

	if (refs->be->transaction_begin &&
	    refs->be->transaction_begin(refs, tr, err))
		FREE_AND_NULL(tr);


> +	if (backend_data->packed_transaction) { 
> +		if (backend_data->packed_transaction_needed) {
> +			ret = ref_transaction_commit(packed_transaction, err);
> +			if (ret)
> +				goto cleanup;
> +			/* TODO: leaks on error path. */
> +			ref_transaction_free(packed_transaction);
> +			packed_transaction = NULL;
> +			backend_data->packed_transaction = NULL;
> +		} else {

If it were just a matter of flipping the early return and freeing of
the transaction before going to clean-up, then that would have been
less effort than leaving the TODO: comment.  What other things are
needed to plug this leak?
