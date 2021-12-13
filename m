Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A4DC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 18:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbhLMSXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 13:23:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64041 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhLMSXf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 13:23:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5850BFB9F6;
        Mon, 13 Dec 2021 13:23:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oGx5FEsqzimR+wcaUcB579p2R07/0Smuy4txex
        uT/To=; b=A7U1XqozJbBGmhXkQyAb0fynYnr6Q2rnsW8M5SuykUbZCCBdiXhX2k
        i8eR89pTKR/FiWddU4DmemiTUC3zZrgemomEVWFtPHvgripyrELBsmtDxeHWZldj
        /XEujKBCHbAza4WLg2/swL2WcK2p1BELofqD6lQKe0JgWk/P+kkNY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5024DFB9F5;
        Mon, 13 Dec 2021 13:23:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2793FB9F1;
        Mon, 13 Dec 2021 13:23:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 07/10] sparse-checkout: enable reapply to take
 --[no-]{cone,sparse-index}
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <3687637915f4fdf62d15791f5cf41f9ea7838f4e.1639108573.git.gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 10:23:33 -0800
In-Reply-To: <3687637915f4fdf62d15791f5cf41f9ea7838f4e.1639108573.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 10 Dec 2021
        03:56:10 +0000")
Message-ID: <xmqq1r2ge53u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C86CB1E2-5C41-11EC-82A7-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Folks may want to switch to or from cone mode, or to or from a
> sparse-index without changing their sparsity paths.  Allow them to do so
> using the reapply command.

Interesting.

Are there certain pattern that would make sense only in one of the
modes but not the other?  If there isn't any such pattern, this
feature perfectly makes sense, I would think.

If an existing pattern changes its meaning between the old mode and
the new mode, that is very much fine---that is what the user wanted
to achieve by switching between the modes with "reapply".

Thanks.

> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
> Reviewed-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/sparse-checkout.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 1ecdc3ddd5a..9d2a05677c4 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -759,13 +759,22 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  }
>  
>  static char const * const builtin_sparse_checkout_reapply_usage[] = {
> -	N_("git sparse-checkout reapply"),
> +	N_("git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index] "),
>  	NULL
>  };
>  
> +static struct sparse_checkout_reapply_opts {
> +	int cone_mode;
> +	int sparse_index;
> +} reapply_opts;
> +
>  static int sparse_checkout_reapply(int argc, const char **argv)
>  {
>  	static struct option builtin_sparse_checkout_reapply_options[] = {
> +		OPT_BOOL(0, "cone", &reapply_opts.cone_mode,
> +			 N_("initialize the sparse-checkout in cone mode")),
> +		OPT_BOOL(0, "sparse-index", &reapply_opts.sparse_index,
> +			 N_("toggle the use of a sparse index")),
>  		OPT_END(),
>  	};
>  
> @@ -777,6 +786,13 @@ static int sparse_checkout_reapply(int argc, const char **argv)
>  			     builtin_sparse_checkout_reapply_usage, 0);
>  
>  	repo_read_index(the_repository);
> +
> +	reapply_opts.cone_mode = -1;
> +	reapply_opts.sparse_index = -1;
> +
> +	if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_index))
> +		return 1;
> +
>  	return update_working_directory(NULL);
>  }
