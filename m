Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD1C433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 01:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9AF61179
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 01:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhJRBR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 21:17:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62208 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhJRBR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 21:17:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 034B114623C;
        Sun, 17 Oct 2021 21:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+WQTjw+yFeAcxAbZzZk3ir3EA1QdBR0XQBHSGU
        j5b80=; b=gvgvoo+PfsoxI33XBRxEX/YsJyzn9ATOGZ2D3J9ez0MOFjIjLOlsnP
        qST3yOnCdqt6GO/dGGncPceCDYXcmzqs6J/g/pu/evNvzqfXBN1DRhZ7Df6So0Xw
        LqsDLNUgT3mko7BOSQfwYsAriw6yOImRy5UA7/tTxYZJOB9wVh+vI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F01A714623B;
        Sun, 17 Oct 2021 21:15:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5AF0814623A;
        Sun, 17 Oct 2021 21:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/2] sparse-index: update index read to consider
 index.sparse config
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
        <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
        <xmqqh7di3qfu.fsf@gitster.g>
        <e17b7e0f-edf0-0770-9b9b-dd092a8a7a41@gmail.com>
        <xmqq5ytw19ck.fsf@gitster.g>
        <8c148f7d-f175-7dc5-51a0-eef48aa98c3d@gmail.com>
Date:   Sun, 17 Oct 2021 18:15:12 -0700
In-Reply-To: <8c148f7d-f175-7dc5-51a0-eef48aa98c3d@gmail.com> (Derrick
        Stolee's message of "Sun, 17 Oct 2021 15:33:58 -0400")
Message-ID: <xmqqczo3yvz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8747358-2FB0-11EC-B30E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>     * In addition, with these patches, if index.sparse=false, a
>>       sparse index will be expaned to full upon reading, and if it
>>       is true, a non-sparse index will be shrunk to sparse upon
>>       reading
>
> This is only half true. If "index.sparse=false", then a sparse
> index will be expanded to full upon reading. If "index.sparse=true"
> then nothing special will happen to an index on reading.

OK.  I somehow got the impression that we convert in both ways from
the patch text under discussion, specifically this part in
do_read_index():

> -	if (istate->repo->settings.command_requires_full_index)
> +	if (!istate->repo->settings.sparse_index ||
> +	    istate->repo->settings.command_requires_full_index)
>  		ensure_full_index(istate);
> +	else if (!istate->sparse_index)
> +		convert_to_sparse(istate, 0);
>  
>  	return istate->cache_nr;

We used to say "when we know we are running a command that is not
sparse ready, expand it here" and nothing else.

We now added a bit more condition for expansion, i.e. "when we are
told that the repository does not want sparse index, or when the
command is not sparse ready".

But the patch goes one more step.  "If we didn't find a reason to
expand to full, and if the in-core index we read is not sparse, then
call convert_to_sparse() on it".  So if the repo settings tells us
that the repository wants a sparse index, and the index we read was
not sparse, what does convert_to_sparse() without MEM_ONLY flag bit
do?  Nothing special?

It internally checks the repo->settings.sparse_index again and
refrains from shrinking the entries, but we are talking about the
case where that repo settings is set to "true", so wouldn't we end
up getting the originally full in-core index turned into sparse?

It is a confusing piece of code.

I see many unconditional calls to convert_to_sparse(istate, 0) on
the write code paths, where I instead would expect "if the repo
wants sparse, call convert_to_sparse(), and if the repo does not
want sparse, call ensure_full_index()", before actualy writing the
entries out.  These also are setting traps to confuse readers.

Perhaps we want a helper function "ensure_right_sparsity(istate)"
that would be called where we have

	if (condition)
		convert_to_sparse();
	else
		ensure_full_index();

or an unconditonal call to convert_to_sparse() to unconfuse readers?

Still puzzled...

Thanks.
