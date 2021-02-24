Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F09C433E9
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F57964F2C
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhBXUKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:10:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63296 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhBXUJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 15:09:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7DF6A7AFC;
        Wed, 24 Feb 2021 15:08:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EFFXKNaOjZREXI1cRdzgkVkG834=; b=g4l8Ny
        Yiobm/HIA3coN6AiWwdeeJLDXx2OyIuCQZY2UVH8+ZyAlxFStD5JBpK/YZdHEE7H
        2nrlopnw05AeKIGdAUrwSqR3sp9qJTrn4mFlQckhwG7+qWl7WlQ8JN2KWfpllXGW
        MM/j5bEXS+6LGP1N7VS3MPvT045jj/kDPJeNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ek2+GPfyACN4V/Oa8pJfJqPIfcvO2rmd
        Tr3rebxe9xdFqoWtthZ95fSAO92Uc3QyKZJkaqtfxTVOX/yMcJPLyTq5hjenFUSn
        EJ/aRYOciFjzk3XPFnSLVPYb2qC8YvYRVsxktIQsPzPoamz5i+AdswY5qyp9VYVv
        i7acruDrg/I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0D16A7AFA;
        Wed, 24 Feb 2021 15:08:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 732A3A7AF9;
        Wed, 24 Feb 2021 15:08:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] dir: fix malloc of root untracked_cache_dir
References: <pull.884.git.1614177117508.gitgitgadget@gmail.com>
Date:   Wed, 24 Feb 2021 12:08:42 -0800
In-Reply-To: <pull.884.git.1614177117508.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Wed, 24 Feb 2021 14:31:57
        +0000")
Message-ID: <xmqqk0qxz0s5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1824EBD8-76DC-11EB-AEF3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Use FLEX_ALLOC_STR() to allocate the `struct untracked_cache_dir`
> for the root directory.  Get rid of unsafe code that might fail to
> initialize the `name` field (if FLEX_ARRAY is not 1).  This will
> make it clear that we intend to have a structure with an empty
> string following it.
>
> A problem was observed on Windows where the length of the memset() was
> too short, so the first byte of the name field was not zeroed.  This
> resulted in the name field having garbage from a previous use of that
> area of memory.
>
> The record for the root directory was then written to the untracked-cache
> extension in the index.  This garbage would then be visible to future
> commands when they reloaded the untracked-cache extension.
>
> Since the directory record for the root directory had garbage in the
> `name` field, the `t/helper/test-tool dump-untracked-cache` tool
> printed this garbage as the path prefix (rather than '/') for each
> directory in the untracked cache as it recursed.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>     dir: fix malloc of root untracked_cache_dir

Nicely spotted.

The problematic code was introduced in 2015, a year before these
FLEX_ALLOC_*() helpers were introduced.  The result is of course
correct and much easier to read, as the necessary "ask for a region
of calloc'ed memory with an additional byte for terminating NUL
beyond strlen()" is hidden in the helper.

Will queue; thanks.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-884%2Fjeffhostetler%2Funtracked-cache-corruption-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-884/jeffhostetler/untracked-cache-corruption-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/884
>
>  dir.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index d153a63bbd14..fd8aa7c40faa 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2730,11 +2730,8 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>  		return NULL;
>  	}
>  
> -	if (!dir->untracked->root) {
> -		const int len = sizeof(*dir->untracked->root);
> -		dir->untracked->root = xmalloc(len);
> -		memset(dir->untracked->root, 0, len);
> -	}
> +	if (!dir->untracked->root)
> +		FLEX_ALLOC_STR(dir->untracked->root, name, "");
>  
>  	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
>  	root = dir->untracked->root;
>
> base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
