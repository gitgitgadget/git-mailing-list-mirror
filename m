Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BD1C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424D360E99
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhGWUkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:40:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61795 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWUka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 16:40:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2B5613B2DA;
        Fri, 23 Jul 2021 17:21:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BGFkyZQUeYAFyGpbc41/HiM4MidKgAh1AcyBFO
        9hMQE=; b=b5vdJepUXhhhf55lEIwD8cCeUHx9czSZ4LCPjy0vnQBMrYN2Wq+QVT
        gp0CqGLiu0IB+6fiL7SV2UokIvoW+M9eR4gPC5b2GlIY84fhCj/m7/aY6vmLj2sx
        huzBnvwKJ0+A0Miusl8Xn+m9bZAgX1JY8A0fYT8qYD4SAEn+wMsuU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DBB4A13B2D8;
        Fri, 23 Jul 2021 17:21:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 284C413B2D5;
        Fri, 23 Jul 2021 17:21:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] cache-tree: prefetch in partial clone read-tree
References: <cover.1627066238.git.jonathantanmy@google.com>
        <f4881b7455b9d33c8a53a91eda7fbdfc5d11382c.1627066238.git.jonathantanmy@google.com>
Date:   Fri, 23 Jul 2021 14:20:59 -0700
In-Reply-To: <f4881b7455b9d33c8a53a91eda7fbdfc5d11382c.1627066238.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 23 Jul 2021 11:52:23 -0700")
Message-ID: <xmqqsg04loas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E128E888-EBFB-11EB-A307-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -466,6 +470,9 @@ int cache_tree_update(struct index_state *istate, int flags)
>  	if (!istate->cache_tree)
>  		istate->cache_tree = cache_tree();
>  
> +	if (!(flags & WRITE_TREE_MISSING_OK) && has_promisor_remote())
> +		prefetch_cache_entries(istate, must_check_existence);
> +

It's so nice when a "fix" to an issue can be this simple.

Thanks; will queue.

>  	trace_performance_enter();
>  	trace2_region_enter("cache_tree", "update", the_repository);
>  	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
> diff --git a/t/t1022-read-tree-partial-clone.sh b/t/t1022-read-tree-partial-clone.sh
> new file mode 100755
> index 0000000000..a763e27c7d
> --- /dev/null
> +++ b/t/t1022-read-tree-partial-clone.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +test_description='git read-tree in partial clones'
> +
> +TEST_NO_CREATE_REPO=1
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'read-tree in partial clone prefetches in one batch' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	git init server &&
> +	echo foo >server/one &&
> +	echo bar >server/two &&
> +	git -C server add one two &&
> +	git -C server commit -m "initial commit" &&
> +	TREE=$(git -C server rev-parse HEAD^{tree}) &&
> +
> +	git -C server config uploadpack.allowfilter 1 &&
> +	git -C server config uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=blob:none "file://$(pwd)/server" client &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client read-tree $TREE &&
> +
> +	# "done" marks the end of negotiation (once per fetch). Expect that
> +	# only one fetch occurs.
> +	grep "fetch> done" trace >donelines &&
> +	test_line_count = 1 donelines
> +'
> +
> +test_done
