Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B4CC433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 17:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357299AbiBNR7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:59:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242182AbiBNR7k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 12:59:40 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B560DBD
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:59:32 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E5801811B9;
        Mon, 14 Feb 2022 12:59:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=93kO6c2F9vs/i5YRvKptasNLNK7rEkvE/lSjB0
        BMN9Q=; b=Ns4svExjwryJ+KY7hvDP6pP+efAJCODyJrdeKa6Ngol5Wy760t2U6P
        Xm99YQzo5SU5EItZtDTtSqJ/4naokl5273Tdu6RqVODu1RO3H0ixZjClEi08tz8H
        Z63FjnLnVk07tsRkFit2pEbOOBwH+7n501tdt1IT8P18DpRfuEZt4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 429791811B7;
        Mon, 14 Feb 2022 12:59:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 643E41811B6;
        Mon, 14 Feb 2022 12:59:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/7] sparse-checkout: reject non-cone-mode patterns
 starting with a '#'
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
        <265cbe36b2df5a9a076877fe3ddc3880a64a9217.1644712798.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Feb 2022 09:59:28 -0800
In-Reply-To: <265cbe36b2df5a9a076877fe3ddc3880a64a9217.1644712798.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 13 Feb 2022
        00:39:55 +0000")
Message-ID: <xmqqsfsl2utb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB0228C8-8DBF-11EC-A6F1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (!core_sparse_checkout_cone)
> +		for (i = 0; i < argc; i++)
> +			if (argv[i][0] == '#')
> +				die(_("paths beginning with a '#' must be preceeded by a backslash"));
> +

Whenever I see an error message like this, where it is clear that
the command knows the only viable solution is to the issue, and yet
still refuses to do-what-the-user-clearly-meant-to-do (is there a
valid reason to copy and paste "# comment" line, which clearly is
not about choosing which paths to use/ignore, from an existing file
and feed it to the command?), I question if it should be solved the
opposite way.

That is, to pretend as if "\" + argv[i] was given and then give the
user either a warning saying what we did, or an unsquelcheable advice
message (no need for advice.* config---the user can avoid triggering
it by learning what the advice message would say, which is to use \#
when they mean to give a pattern that begins with a pound).


>  	for (i = 0; i < argc; i++) {
>  		struct cache_entry *ce;
>  		struct index_state *index = the_repository->index;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 1d95fa47258..32b77415679 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -857,4 +857,10 @@ test_expect_success 'by default, non-cone mode will warn on individual files' '
>  	grep "passing directories or less specific patterns is recommended" warning
>  '
>  
> +test_expect_success 'paths starting with hash must be escaped in non-cone mode' '
> +	test_must_fail git -C repo sparse-checkout set --no-cone "#funny-path" 2>error &&
> +
> +	grep "paths beginning.*#.*must be preceeded by a backslash" error
> +'
> +
>  test_done
