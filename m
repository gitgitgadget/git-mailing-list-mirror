Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B1CC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C2661A56
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355296AbhJAU2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:28:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55185 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355306AbhJAU16 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 16:27:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 477AE153223;
        Fri,  1 Oct 2021 16:26:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/bXzgWjkqguBoZcgX8FXQe0/Htq68dOc+jlwDY
        p6GCU=; b=iPhfwt8+usB8Kf0yLggISWxgDUyS8P6wnU9EDUvOPQYIyqBH8F8uBq
        1CS+EeMEudbseUMFm8qCApk1Ev01QSFDcvQCf5aWYzvIuZ1+ePY3BIFZAUYJqU3I
        vUzJk4F+zFIpMn8y/dRDTfOGgyBD4k4TlKEfaTw9EAUcsBsAG96zw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FA63153222;
        Fri,  1 Oct 2021 16:26:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D177915321F;
        Fri,  1 Oct 2021 16:26:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 02/11] reset_head(): fix checkout
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <c8f641132160d6bbd72a5e4921f1c9f0b3d40242.1633082702.git.gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 13:26:08 -0700
In-Reply-To: <c8f641132160d6bbd72a5e4921f1c9f0b3d40242.1633082702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 01 Oct 2021 10:04:53
        +0000")
Message-ID: <xmqqee947aqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D04DD02E-22F5-11EC-AE4E-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The reset bit should only be set if flags contains RESET_HEAD_HARD.
> The test for `!deatch_head` dates back to the original implementation
> of reset_head() in ac7f467fef ("builtin/rebase: support running "git
> rebase <upstream>"", 2018-08-07) and was correct until e65123a71d
> ("builtin rebase: support `git rebase <upstream> <switch-to>`",
> 2018-09-04) started using reset_head() to checkout <switch-to> when
> fast-forwarding.

Sorry, but it is not quite clear what exactly is "fix checkout" in
the context of this change, even with the above paragraph that
describes the internals but not any end-user visible effect.

Can this step come with its own addition to t/ to demonstrate the
breakage that is fixed?

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/reset.c b/reset.c
> index 79310ae071b..fc4dae3fd2d 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -57,7 +57,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>  	unpack_tree_opts.update = 1;
>  	unpack_tree_opts.merge = 1;
>  	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
> -	if (!detach_head)
> +	if (reset_hard)
>  		unpack_tree_opts.reset = 1;
>  
>  	if (repo_read_index_unmerged(r) < 0) {
