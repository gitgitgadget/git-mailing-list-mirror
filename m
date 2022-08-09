Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36EAC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 16:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245146AbiHIQzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245140AbiHIQzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 12:55:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043FC22B17
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 09:55:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2E6214701E;
        Tue,  9 Aug 2022 12:55:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=daQauTlG5sIpDpguMbDbJYU3IxsXuKxtTC3Soq
        pjbbU=; b=FmiwbylycPqHZXgwnsmya4ePYzHwe3/62ezrvHKjYFmV2EZL9dUkAc
        aOmpL4/uERLLTmZcSYHEkc61i0hr4SGlcyuUo1VA4ofK3FU+ZkCJ52pboFFYSi1F
        09hJhm1Jq5hJfRC2PRYhoO+VD9VbwbmYg+UCxGRrKRZBnSiSgNB60=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DB3614701C;
        Tue,  9 Aug 2022 12:55:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8763514701A;
        Tue,  9 Aug 2022 12:55:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        Emily Noneman <emily.noneman@gmail.com>,
        Paul Horn <git@knutwalker.engineer>
Subject: Re: [PATCH] revision.c: set-up "index_state.repo", don't segfault
 in pack-objects
References: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
        <patch-1.1-3ff17707481-20220805T141816Z-avarab@gmail.com>
        <b6299f8a-f75a-0e96-a6a6-55a7280584bf@github.com>
        <Yu02dOo4G8sy8tI6@coredump.intra.peff.net>
        <xmqqo7wyzlpm.fsf@gitster.g>
        <YvJZCGyhd6KJCabi@coredump.intra.peff.net>
Date:   Tue, 09 Aug 2022 09:55:03 -0700
In-Reply-To: <YvJZCGyhd6KJCabi@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 9 Aug 2022 08:54:32 -0400")
Message-ID: <xmqqedxpqrvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0414B572-1804-11ED-93E9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's the test addition you mentioned, though I'm really not sure it's
> adding much. The source lines for both the bug/fix and the spot where we
> segfault should be identical between the two cases. It's really just
> about how we ended up calling into the code.

True, but the "non-existing index file" case is rare enough that it
would be worth to document the new way to get into the state, I
would think.

I am offline every other Tuesday and today is such a day,
so please expect no changes to the public repositories.

Thanks.

>  t/t7063-status-untracked-cache.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index c1f0d95036..a0e8920ffa 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -990,4 +990,9 @@ test_expect_success 'empty repo (no index) and core.untrackedCache' '
>  	git -C emptyrepo -c core.untrackedCache=true write-tree
>  '
>  
> +test_expect_success 'empty worktree and core.untrackedCache' '
> +	git worktree add --no-checkout empty-worktree &&
> +	git -c core.untrackedCache=true gc
> +'
> +
>  test_done
