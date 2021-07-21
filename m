Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B824DC6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9121D6121F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhGUVjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 17:39:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62453 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhGUVjK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 17:39:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACA6FDEBD5;
        Wed, 21 Jul 2021 18:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0g0QiuSeheXEa+XLhLijqxvo11/DxA479yrS/W
        PHg84=; b=W+96K9I3aXvM88s1Gb4h2izV8Zag/eCDBxSSj5DY3JHXNowc6B7Npa
        vA/dqzuNi7g9An/U7m5Nowuj7yF5QGMapreQxKipsPGUXVN8WVNvIVDmitZMonLy
        psS+QCyicycsx454Ib43kuSmLi7lrLB/oUc1qp8IgAIw7jZpbO59I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4A25DEBD4;
        Wed, 21 Jul 2021 18:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 339E8DEBD3;
        Wed, 21 Jul 2021 18:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/5] add: allow operating on a sparse-only index
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
        <791c6c2c9ade5b065fc0f367e00c52a493d086ef.1626901619.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 15:19:44 -0700
In-Reply-To: <791c6c2c9ade5b065fc0f367e00c52a493d086ef.1626901619.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 21 Jul 2021
        21:06:56 +0000")
Message-ID: <xmqqfsw7cnsv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0D4257E-EA71-11EB-9D20-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Disable command_requires_full_index for 'git add'. This does not require
> any additional removals of ensure_full_index(). The main reason is that
> 'git add' discovers changes based on the pathspec and the worktree
> itself. These are then inserted into the index directly, and calls to
> index_name_pos() or index_file_exists() already call expand_to_path() at
> the appropriate time to support a sparse-index.

OK.  With that explained, it still is quite surprising that we only
need this change (eh, rather, doing this change is safe without
doing anything else).

> -	# This "git add folder1/a" fails with a warning
> -	# in the sparse repos, differing from the full
> -	# repo. This is intentional.
> -	test_sparse_match test_must_fail git add folder1/a &&
> -	test_sparse_match test_must_fail git add --refresh folder1/a &&
> -	test_all_match git status --porcelain=v2 &&

And nice to see a known limitation lifted.

>  	test_all_match git add . &&
>  	test_all_match git status --porcelain=v2 &&
>  	test_all_match git commit -m folder1/new &&
> @@ -635,7 +628,12 @@ test_expect_success 'sparse-index is not expanded' '
>  	git -C sparse-index reset --hard &&
>  	ensure_not_expanded checkout rename-out-to-out -- deep/deeper1 &&
>  	git -C sparse-index reset --hard &&
> -	ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1
> +	ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1 &&
> +
> +	echo >>sparse-index/README.md &&
> +	ensure_not_expanded add -A &&
> +	echo >>sparse-index/extra.txt &&
> +	ensure_not_expanded add extra.txt
>  '
>  
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
