Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC00DC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A86610EA
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhKCRHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:07:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63265 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhKCRHx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 13:07:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55F1C171034;
        Wed,  3 Nov 2021 13:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H4OX2zMphxK0YE9a4s3HKs3ZaLhbXuGVNBVokI
        pQMB4=; b=fe1dZCkvhs5frZv0R2nJmnRQssranb+mg+ddG0wG90Zd548Ig4vZRh
        RUh1BLOs25xOd+Ffs32CSTMgObdV1s5/+27uRPgwaBU0LIzBfJtueJDSxpI2L9an
        8A5onGna++pguu+fweRaDehvly3XakcuNmy1VwzLRr7jrHRK6AkoQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E5A9171033;
        Wed,  3 Nov 2021 13:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 002D9171032;
        Wed,  3 Nov 2021 13:05:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v3 1/2] diff: enable and test the sparse index
References: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
        <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <991aaad37b41f71faa19fdef4373ccc115edcc40.1635802069.git.gitgitgadget@gmail.com>
Date:   Wed, 03 Nov 2021 10:05:12 -0700
In-Reply-To: <991aaad37b41f71faa19fdef4373ccc115edcc40.1635802069.git.gitgitgadget@gmail.com>
        (Lessley Dennington via GitGitGadget's message of "Mon, 01 Nov 2021
        21:27:48 +0000")
Message-ID: <xmqqcznh8913.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36164486-3CC8-11EC-9FBD-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> 2000.34: git diff --staged (full-v3)      0.08    0.08 +0.0%
> 2000.35: git diff --staged (full-v4)      0.08    0.08 +0.0%
> 2000.36: git diff --staged (sparse-v3)    0.17    0.04 -76.5%
> 2000.37: git diff --staged (sparse-v4)    0.16    0.04 -75.0%

Please do not add more use of the synonym to the test suite, other
than the one that makes sure the synonym works the same way as the
real option, which is "--cached".

> diff --git a/builtin/diff.c b/builtin/diff.c
> index dd8ce688ba7..cbf7b51c7c0 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -437,6 +437,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  
>  	prefix = setup_git_directory_gently(&nongit);
>  
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;
> +

Doesn't the code need to be protected with

	if (!nongit) {
		prepare_repo_settings(the_repository);
		the_repository->settings.command_requires_full_index = 0;
	}

at the very least?  It may be that the code is getting lucky because
the_repository may be initialized with a random value (after all,
when we are not in a repository, there is nowhere to read the
on-disk settings from) and we may even be able to set a bit in the
settings structure without crashing, but conceptually, doing the
above when we _know_ we are not in any repository is simply wrong.

I wonder if prepare_repo_settings() needs be more strict.  For
example, shouldn't it check if we have a repository to begin with
and BUG() if it was called when there is not a repository?  After
all, it tries to read from the repository configuration file, so any
necessary set-up to discover where the gitdir is must have been done
already before it can be called.

With such a safety feature to catch a programmer errors, perhaps the
above could have been caught before the patch hit the list.

Thoughts?  Am I missing some chicken-and-egg situation where
prepare_repo_settings() must be callable before we know where the
repository is, or something, which justifies why the function is so
loose in its sanity checks in the current form?


