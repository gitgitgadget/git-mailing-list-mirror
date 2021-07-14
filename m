Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D352EC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3FD613BF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhGNUkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:40:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62081 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhGNUkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:40:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 423AC130B63;
        Wed, 14 Jul 2021 16:37:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=blPKQoAtZ68WL6pnyV8IXMSmZUXJAc8VW4zxh7
        rbN5M=; b=HjFhvCYrqR8XSKsUCTrrPU422WF2J5XPFjbyR2B2hzPDdauH/czK4h
        C8z4tWrNhRkr11DcuiDnjx6mZ22qwd2AlpX03gERmY34icn+oRV+uWzKum2DqZrH
        DDljKMwNPutozA6PQcCg/e9BD1nZ4l+7+adRIhAeG+9NwJJcMQ0As=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3AF65130B62;
        Wed, 14 Jul 2021 16:37:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9822C130B61;
        Wed, 14 Jul 2021 16:37:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v9 00/16] Sparse-index: integrate with status
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:37:25 -0700
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 14 Jul 2021 13:12:24
        +0000")
Message-ID: <xmqqim1cvdh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DA6967E-E4E3-11EB-96ED-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is the first "payoff" series in the sparse-index work. It makes 'git
> status' very fast when a sparse-index is enabled on a repository with
> cone-mode sparse-checkout (and a small populated set).

The first payoff turning out to be  a long time coming ;-)

> This is based on ds/sparse-index-protections AND mt/add-rm-sparse-checkout.
> The latter branch is needed because it changes the behavior of 'git add'
> around sparse entries, which changes the expectations of a test added in
> patch 1.
>
> The approach here is to audit the places where ensure_full_index() pops up
> while doing normal commands with pathspecs within the sparse-checkout
> definition. Each of these are checked and tested. In the end, the
> sparse-index is integrated with these features:
>
>  * git status
>  * FS Monitor index extension.

I said this alreayd but I think the approach makes sense.  One
related tangent that makes me wonder is if we can teach "ls-files"
to help scriptors with a mode that does not pretend we have the full
index (i.e. when asked to show sparse index state, "ls-files
--sparse" would show the same output as "ls-files --stage" without
expanding each tree entry in the index into its flattend list of
paths).

Thanks.
