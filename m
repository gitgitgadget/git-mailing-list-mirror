Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8946CC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 06:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbhLVGmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 01:42:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56264 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhLVGmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 01:42:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB095109318;
        Wed, 22 Dec 2021 01:42:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kvbd2pzvaiWoSwHw9q6xxt1l5vblKzvoxd71Kr
        /KC3I=; b=x7Uzkm1t2t2ig4FzGb51dHyP9Nd9s+NuIGXu0p6M6HNVFPGJ76ulH6
        DrlI7bGRFOWPQ30aBlIl114275dOPblSeqgNlQwkL7CfAsgP9+fJWqn3dfadwiS0
        OsCuTJFCmgEoni8/BHpPtZ8F60QkZ5IUmlXM82pH6GHXM2lxro8LM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C34B5109317;
        Wed, 22 Dec 2021 01:42:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28773109316;
        Wed, 22 Dec 2021 01:42:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/3] builtin/fetch: skip unnecessary tasks when using
 --negotiate-only
References: <20211217000235.68996-1-chooglen@google.com>
        <20211222001134.28933-1-chooglen@google.com>
        <20211222001134.28933-3-chooglen@google.com>
Date:   Tue, 21 Dec 2021 22:42:44 -0800
In-Reply-To: <20211222001134.28933-3-chooglen@google.com> (Glen Choo's message
        of "Tue, 21 Dec 2021 16:11:33 -0800")
Message-ID: <xmqqa6gtkumz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F4833E6-62F2-11EC-9D55-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> @@ -2113,6 +2122,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		result = fetch_multiple(&list, max_children);
>  	}
>  
> +	/*
> +	 * Skip irrelevant tasks because we know objects were not
> +	 * fetched.
> +	 *
> +	 * NEEDSWORK: as a future optimization, we can return early
> +	 * whenever objects were not fetched e.g. if we already have all
> +	 * of them.
> +	 */
> +	if (negotiate_only)
> +		goto cleanup;

Sorry if I did not mention this in the review of the earlier round,
but I think the location this patch places the jump is wrong,
especially with the NEEDSWORK comment.

When we are not under negotiate_only, if our earlier call to
transport_fetch_refs() learns to tell us that that we did not add
any new objects, we would be able to jump to the clean-up label,
making the above code to:

	if (negotiate_only || !num_fetched_objects)
		goto cleanup;

But such a future enhancement is made harder by having this jump
here---the optimization the NEEDSWORK comment alludes to has no
reason to be incompatible with "--recurse-submodules".

If the above block is placed _after_ the "if the main fetch was
successful, and we are not told not to recurse into submodules, then
do this" block we see below, then

 (1) this patch still achieves its goal, as we have manually
     and unconditionally turned recursion off;

 (2) such a future enhancement will not be forbidden from working
     with recurse-submodules feature.

>  	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
>  		struct strvec options = STRVEC_INIT;
>  		int max_children = max_jobs;
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 8212ca56dc..732031085e 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -229,6 +229,18 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
>  	test_i18ngrep "push negotiation failed" err
>  '
>  
> +test_expect_success 'push with negotiation does not attempt to fetch submodules' '
> +	mk_empty submodule_upstream &&
> +	test_commit -C submodule_upstream submodule_commit &&
> +	git submodule add ./submodule_upstream submodule &&
> +	mk_empty testrepo &&
> +	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
> +	test_commit -C testrepo unrelated_commit &&
> +	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
> +	git -c submodule.recurse=true -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
> +	! grep "Fetching submodule" err
> +'
> +
>  test_expect_success 'push without wildcard' '
>  	mk_empty testrepo &&
