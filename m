Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8BFC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBC761101
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 16:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhKCQuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:50:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55188 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhKCQuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 12:50:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99487E32BB;
        Wed,  3 Nov 2021 12:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Opz2AEhluaLwA7lHGPdjDlafkqkqCDuhZnmFwC
        JBy88=; b=gqgbYG6bvRM6fE0XkpnRLwcabkWlpaW6/gSaNboS8/dXTr8F/NrSNt
        tsicQgu9nj5ghoD7GIISXMA7/XOtUTumbGbetiuV20dbbRCT1CaiBjTgyunQcxgz
        uiQ024sToNaLBIYVjonDonfcd9pS/dUB0WcsVpqA89UvrqW+dfCfo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B574E32BA;
        Wed,  3 Nov 2021 12:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E315BE32B8;
        Wed,  3 Nov 2021 12:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v3 2/2] blame: enable and test the sparse index
References: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
        <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <cfdd33129ec6860cbec0cb20302598429db1115e.1635802069.git.gitgitgadget@gmail.com>
Date:   Wed, 03 Nov 2021 09:47:23 -0700
In-Reply-To: <cfdd33129ec6860cbec0cb20302598429db1115e.1635802069.git.gitgitgadget@gmail.com>
        (Lessley Dennington via GitGitGadget's message of "Mon, 01 Nov 2021
        21:27:49 +0000")
Message-ID: <xmqqh7ct89us.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8DEEDC6-3CC5-11EC-AE8D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> We do not include paths outside the sparse checkout cone because blame
> currently does not support blaming files outside of the sparse definition.
> Attempting to do so fails with the following error:
>
>   fatal: no such path '<path outside sparse definition>' in HEAD

Does this indicate that we need to update how the command line
safety in verify_working_tree_path() works in a sparsely checked out
working tree?  If foo/bar is outside the sparse definition,

    git blame HEAD foo/bar

may get such a message, but shouldn't

    git blame HEAD -- foo/bar

make it work?

> -# TODO: blame currently does not support blaming files outside of the
> -# sparse definition. It complains that the file doesn't exist locally.
> -test_expect_failure 'blame with pathspec outside sparse definition' '
> +# Blame does not support blaming files outside of the sparse
> +# definition, so we verify this scenario.

IOW, why is it a good idea to drop the "TODO" and "currently" and pretend
as if the current behaviour is the desirable one?

> +test_expect_success 'blame with pathspec outside sparse definition' '
>  	init_repos &&
> +	test_sparse_match git sparse-checkout set &&
>  
> -	test_all_match git blame folder1/a &&
> -	test_all_match git blame folder2/a &&
> -	test_all_match git blame deep/deeper2/a &&
> -	test_all_match git blame deep/deeper2/deepest/a
> +	for file in a \
> +			deep/a \
> +			deep/deeper1/a \
> +			deep/deeper1/deepest/a
> +	do
> +		test_sparse_match test_must_fail git blame $file &&
> +		cat >expect <<-EOF &&
> +		fatal: Cannot lstat '"'"'$file'"'"': No such file or directory
> +		EOF
> +		# We compare sparse-checkout-err and sparse-index-err in
> +		# `test_sparse_match`. Given we know they are the same, we
> +		# only check the content of sparse-index-err here.
> +		test_cmp expect sparse-index-err
> +	done
>  '
>  
>  test_expect_success 'checkout and reset (mixed)' '
> @@ -878,6 +892,18 @@ test_expect_success 'sparse index is not expanded: diff' '
>  	ensure_not_expanded diff --staged
>  '
>  
> +test_expect_success 'sparse index is not expanded: blame' '
> +	init_repos &&
> +
> +	for file in a \
> +			deep/a \
> +			deep/deeper1/a \
> +			deep/deeper1/deepest/a
> +	do
> +		ensure_not_expanded blame $file
> +	done
> +'
> +
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>  # in this scenario, but it shouldn't.
>  test_expect_success 'reset mixed and checkout orphan' '
