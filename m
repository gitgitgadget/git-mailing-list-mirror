Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28DCC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C74F24654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="moBUUwCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBSUwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:52:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57546 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUwT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 15:52:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13FC04868C;
        Wed, 19 Feb 2020 15:52:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S4tyOp0qVTBQXW8op8+SjGQMfuM=; b=moBUUw
        Cj0nVlhpiFTbYZKvSoNlTg0EUpz+J8/m5So9b0AEiG32YYvoeNu7vSp0JCIilJRb
        6h1X3N8TmefifllQXM4TIkkNAG+NrBQjWUZf4vD7hUeR2wtscmp5C+Fcqy/UgclH
        VboZ9PqAWUeHuCjjnndvkkyLSqDjrXOr6hl44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pggij023omYpdTZI1rtZ32ohecLN2v9s
        G+GAwEaTQrAhC35wvTa6FsyZKJebbwZ6iKdH0lab5Y3EyehVTilfuhZQPUgY7IRp
        4NMwi13U5OceMEtBoLAsBvP9lReTNjQer09PEsSlw9Eivux//nv6Q+IctUGypBlD
        kSUXdSoH+pc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AFC24868B;
        Wed, 19 Feb 2020 15:52:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 632BF48687;
        Wed, 19 Feb 2020 15:52:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] partial-clone: demonstrate bugs in partial fetch
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
        <dbc1bdcae16f8b9941add514264b0fe04cda48c0.1582129312.git.gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 12:52:14 -0800
In-Reply-To: <dbc1bdcae16f8b9941add514264b0fe04cda48c0.1582129312.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 19 Feb 2020
        16:21:51 +0000")
Message-ID: <xmqqimk2e1vl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B65293FC-5359-11EA-B647-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index fea56cda6d3..ed2ef45c37a 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -374,6 +374,32 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
>  	grep "want $(cat hash)" trace
>  '
>  
> +test_expect_failure 'verify fetch succeeds when asking for new tags' '
> +	git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
> +	for i in I J K
> +	do
> +		test_commit -C src $i &&
> +		git -C src branch $i
> +	done &&
> +	git -C srv.bare fetch --tags origin +refs/heads/*:refs/heads/* &&
> +	git -C tag-test fetch --tags origin
> +'

Is this about an ultra-recent regresssion?  When applied directly on
top of v2.25.0, this one seems to pass already without any change.

> +test_expect_failure 'verify fetch downloads only one pack when updating refs' '
> +	git clone --filter=blob:none "file://$(pwd)/srv.bare" pack-test &&
> +	ls pack-test/.git/objects/pack/*pack >pack-list &&
> +	test_line_count = 2 pack-list &&
> +	for i in A B C
> +	do
> +		test_commit -C src $i &&
> +		git -C src branch $i
> +	done &&
> +	git -C srv.bare fetch origin +refs/heads/*:refs/heads/* &&
> +	git -C pack-test fetch origin &&
> +	ls pack-test/.git/objects/pack/*pack >pack-list &&
> +	test_line_count = 3 pack-list
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
