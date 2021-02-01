Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1490C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD97F64E8F
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhBAS4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:56:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50927 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhBAS4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 13:56:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1A01120743;
        Mon,  1 Feb 2021 13:55:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lyh25bqGe8UEblJh8e4HDL+9gTw=; b=wf/pAS
        W1eOmDxTVO3CqDBkaHVbSbZZqpfCpoxO5x01UNPPU6GbxzyhDYpaR1IkLiEGTn2r
        LizwY8OekNcYcawDJ6+lctrAl5OPo88hx6zzvgtcPZ0VkCyAni0uSdZB6GyvjInF
        7kSXiZvvr5k8jKqMBxcwaVK4vfwcnpuglLA2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H1yW2gol0ht/m0Malkro2UQfaA29637s
        g0LnzJSL9R4K94cRajjaerexLs1WXU2EGJ3fH5+rk6ItHlQdyaqFbBQ7MAcPdKwf
        mpBeT5Yd8dq6dK9Mdo4CmemeTk2xye9MEGMs3rTjuXZxv8Qs7NvaQ6XRKMbHypw7
        voWaAHzdk3w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E97DA120742;
        Mon,  1 Feb 2021 13:55:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3C7EF120741;
        Mon,  1 Feb 2021 13:55:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gister@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/5] commit-graph: be extra careful about mixed generations
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <b267a9653a7560d1e59708f20106ef054d140a9f.1612199707.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 10:55:49 -0800
In-Reply-To: <b267a9653a7560d1e59708f20106ef054d140a9f.1612199707.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 01 Feb 2021
        17:15:06 +0000")
Message-ID: <xmqqv9bbliru.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A979660-64BF-11EB-9419-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When upgrading to a commit-graph with corrected commit dates from
> one without, there are a few things that need to be considered.
>
> When computing generation numbers for the new commit-graph file that
> expects to add the generation_data chunk with corrected commit
> dates, we need to ensure that the 'generation' member of the
> commit_graph_data struct is set to zero for these commits.
>
> Unfortunately, the fallback to use topological level for generation
> number when corrected commit dates are not available are causing us
> harm here: parsing commits notices that read_generation_data is
> false and populates 'generation' with the topological level.
>
> The solution is to iterate through the commits, parse the commits
> to populate initial values, then reset the generation values to
> zero to trigger recalculation. This loop only occurs when the
> existing commit-graph data has no corrected commit dates.
>
> While this improves our situation somewhat, we have not completely
> solved the issue for correctly computing generation numbers for mixes

"mixed"? (will not touch locally).

> layers. That follows in the next change.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)

The hunks that mention trust_generation_numbers match what the
commit log message says what the patch does, but other two hunks
that make sure that some code that used to run regardless of the
value of "ctx->write_generation_data" are now run only when the
member is nonzero smells like an unrelated change.

Thanks.

