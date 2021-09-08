Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA1FC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF7A61154
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347717AbhIHQet (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:34:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54376 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbhIHQeo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:34:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBF7BE676D;
        Wed,  8 Sep 2021 12:33:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lrxoofBfaDcPXWM4VYNs1kVfQZyvKftkCT8b+m
        0R9VY=; b=xLghjy6EJ7JPhoMs6pDKZnvgkb40qQ9a4n0SkeeZdHbqO6z6VduQzg
        CgPAzOA0/wg4CSbVUWwSVoCCNFXWQF27smNrmQM5UsenNqT+O9uepO9wU5xpldWV
        48Xat8SJAxVC7B3SS6gY/j+1U6mcXy3KJmQw7foe+BLS/XJ0NdvTg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D319DE676C;
        Wed,  8 Sep 2021 12:33:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4AE09E6769;
        Wed,  8 Sep 2021 12:33:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] am: fix incorrect exit status on am fail to abort
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
        <5fa7daf264b75fc5419e829683be2e6d83191908.1631067429.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:33:34 -0700
In-Reply-To: <5fa7daf264b75fc5419e829683be2e6d83191908.1631067429.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 08 Sep 2021
        02:17:09 +0000")
Message-ID: <xmqqwnnr3u3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 833DE94E-10C2-11EC-82DF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Obviously correct.

>  builtin/am.c        | 3 ++-
>  t/t4151-am-abort.sh | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 0c2ad96b70e..c79e0167e98 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2106,7 +2106,8 @@ static void am_abort(struct am_state *state)
>  	if (!has_orig_head)
>  		oidcpy(&orig_head, the_hash_algo->empty_tree);
>  
> -	clean_index(&curr_head, &orig_head);
> +	if (clean_index(&curr_head, &orig_head))
> +		die(_("failed to clean index"));
>  
>  	if (has_orig_head)
>  		update_ref("am --abort", "HEAD", &orig_head,
> diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> index 501a7a9d211..f889f25a98f 100755
> --- a/t/t4151-am-abort.sh
> +++ b/t/t4151-am-abort.sh
> @@ -195,7 +195,7 @@ test_expect_success 'am --abort leaves index stat info alone' '
>  	git diff-files --exit-code --quiet
>  '
>  
> -test_expect_failure 'git am --abort return failed exit status when it fails' '
> +test_expect_success 'git am --abort return failed exit status when it fails' '
>  	test_when_finished "rm -rf file-2/ && git reset --hard" &&
>  	git checkout changes &&
>  	git format-patch -1 --stdout conflicting >changes.mbox &&
