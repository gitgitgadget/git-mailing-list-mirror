Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89FEC433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 20:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhLOU4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 15:56:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56995 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhLOU4T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 15:56:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 384A0171979;
        Wed, 15 Dec 2021 15:56:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HhHhYHnAuV8DFi6OBw1iL3Y4Z2f59Mvmona8ok
        F8OPg=; b=fUiDj4bwQwlQFXqO+fOIVirlNeHxrDrNzlF3W4P1EU0S3rueFhxAPE
        uHbdzRUxzG8ak619uj0+RyqXQL9ukwo/IOpEmtkMS1E0ihXRC3Br9I3d6tnpGawQ
        jgbqm8VaQoMw/IFQu6U8ef4KVw3NZslBKPDO+2iCcamhTsZqqUvTU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F9A6171978;
        Wed, 15 Dec 2021 15:56:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85CAE171977;
        Wed, 15 Dec 2021 15:56:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        vdye@github.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/3] sparse-checkout: fix segfault on malformed patterns
References: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
        <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
        <1744a26845fbe4d7dbc80f387be1d842b5f8fe94.1639575968.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Dec 2021 12:56:13 -0800
In-Reply-To: <1744a26845fbe4d7dbc80f387be1d842b5f8fe94.1639575968.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 15 Dec 2021
        13:46:06 +0000")
Message-ID: <xmqqv8zp4mfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 718FDAB2-5DE9-11EC-87D1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Then core.sparseCheckoutCone is enabled, the sparse-checkout patterns are
> used to populate two hashsets that accelerate pattern matching. If the user
> modifies the sparse-checkout file outside of the 'sparse-checkout' builtin,
> then strange patterns can happen, triggering some error checks.
>
> One of these error checks is possible to hit when some special characters
> exist in a line. A warning message is correctly written to stderr, but then
> there is additional logic that attempts to remove the line from the hashset
> and free the data.

Makes sense.

> This leads to a segfault in the 'git sparse-checkout
> list' command because it iterates over the contents of the hashset, which is
> now invalid.

Understandable.

> The fix here is to stop trying to remove from the hashset. Better to leave
> bad data in the sparse-checkout matching logic (with a warning) than to
> segfault.

True, as long as it won't make the situation worse by depending on
that bad data to further damage working tree data or in-repo data
when damaged working tree data gets committed.  And "list segfaults
with freed/NULLed data---so leave the bad ones in to print these bad
ones" feels OK-ish.  

As long as the user is not transporting the listed output to another
repository, which may fall into "making the situation worse"
category by spreading an existing breakage, that is.

In other words, this may paper over the segfault, and it may be safe
only for "sparse-checkout list", but is it safe for other operations
that actually use this bad data to further affect other things in
the repository?  If not, I wonder if we want to hard die to lock the
repository down before the issue is fixed to avoid spreading the
damage?

> diff --git a/dir.c b/dir.c
> index 5aa6fbad0b7..0693c7cb3ee 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -819,9 +819,6 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
>  		/* we already included this at the parent level */
>  		warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
>  			given->pattern);
> -		hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
> -		free(data);
> -		free(translated);
>  	}
>  
>  	return;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 272ba1b566b..c72b8ee2e7b 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -708,4 +708,19 @@ test_expect_success 'cone mode clears ignored subdirectories' '
>  	test_cmp expect out
>  '
>  
> +test_expect_success 'malformed cone-mode patterns' '
> +	git -C repo sparse-checkout init --cone &&
> +	mkdir -p repo/foo/bar &&
> +	touch repo/foo/bar/x repo/foo/y &&
> +	cat >repo/.git/info/sparse-checkout <<-\EOF &&
> +	/*
> +	!/*/
> +	/foo/
> +	!/foo/*/
> +	/foo/\*/
> +	EOF
> +	cat repo/.git/info/sparse-checkout &&

Stray debugging output?

> +	git -C repo sparse-checkout list

And we are happy as long as the command does not segfault, and we do
not care what the output is.

> +'
> +
>  test_done

Will queue, but not convinced yet.
