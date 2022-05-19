Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD2C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 20:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiESUTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 16:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbiESUTO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 16:19:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43400762AD
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:19:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A12B811C2DA;
        Thu, 19 May 2022 16:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BD0FKIGfzf6JAiCxujc1vEhmEyAHI7CzDBRmVW
        higng=; b=fQvedf/59Tya9KnvZLaRMOTwcPCCtgqKurAd/WI246hdQ/6DEdxJoa
        r8Nj642wssDf1pjaoZEmQ8LNzLdu3CwLicOPxyPQbgX0k8QuD++2Drb+6oK6r2oy
        EfUKHC8o7JOKMzRsxr9wGEY0QEjfpKYydNwjFUX/QXLmq0SNcLfVM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 996F911C2D9;
        Thu, 19 May 2022 16:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07D0611C2D8;
        Thu, 19 May 2022 16:19:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 06/10] sparse-checkout: --no-sparse-index needs a
 full index
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <e42463de0d218b63bf0c786590708b1be32257f0.1652982759.git.gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 13:19:10 -0700
In-Reply-To: <e42463de0d218b63bf0c786590708b1be32257f0.1652982759.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 May 2022
        17:52:34 +0000")
Message-ID: <xmqq8rqxmg1t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2466D1A-D7B0-11EC-9605-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When the --no-sparse-index option is supplied, the sparse-checkout
> builtin should explicitly ask to expand a sparse index to a full one.
> This is currently done implicitly due to the command_requires_full_index
> protection, but that will be removed in an upcoming change.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/sparse-checkout.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 88eea069ad4..cbff6ad00b0 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -413,6 +413,9 @@ static int update_modes(int *cone_mode, int *sparse_index)
>  		/* force an index rewrite */
>  		repo_read_index(the_repository);
>  		the_repository->index->updated_workdir = 1;
> +
> +		if (!*sparse_index)
> +			ensure_full_index(the_repository->index);

init_opts.sparse_index is initialized to -1 (unknown) and parse_options()
may set it to 0 (false) or 1 (true).  We call ensure_full only when
the caller explicitly asks with --no-sparse-index.

Makes sense.

>  	}
>  
>  	return 0;
