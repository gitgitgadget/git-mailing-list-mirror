Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B9C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 23:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353734AbhLAXIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 18:08:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53186 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbhLAXIP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 18:08:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95D75FAD4C;
        Wed,  1 Dec 2021 18:04:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o3FRiSPFkEJ6RofBIfnDGU8Kv/uBBG72fYavRc
        ppcAc=; b=N7KaO2hf40ZdKmKt7eEKq7ii5/WYDBC0GSpRo8BzCLSxccPt7arNf0
        PJjPDWqr4lc2gT97LT4Te+4l++pt7o9WIcShXMRA8FJ+3s9vm9GBsIA+xvSVXAi4
        fAAhIRJHIUwDuu3B34tp/jrwwh/l8x4uEV1zE2hTGBU7NqAhJLBYM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C85BFAD47;
        Wed,  1 Dec 2021 18:04:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00741FAD46;
        Wed,  1 Dec 2021 18:04:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "James Limbouris via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, James Limbouris <james@digitalmatter.com>
Subject: Re: [PATCH] subtree: fix argument handling in check_parents
References: <pull.1086.git.1638324413653.gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 15:04:51 -0800
In-Reply-To: <pull.1086.git.1638324413653.gitgitgadget@gmail.com> (James
        Limbouris via GitGitGadget's message of "Wed, 01 Dec 2021 02:06:53
        +0000")
Message-ID: <xmqq1r2wylik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17BD5058-52FB-11EC-96CB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"James Limbouris via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: James Limbouris <james@digitalmatter.com>
>
> check_parents was taking all of its arguments as a single string,
> and erroneously passing them to cache_miss as a single string.
> cache_miss would then fail, and the spurious cache misses it produced
> would hurt performance.
>
> For consistency, take multiple arguments in check_parents,
> and pass all of them to cache_miss separately.
>
> Signed-off-by: James Limbouris <james@digitalmatter.com>
> ---
>     subtree: fix argument handling in check_parents
>     
>     Hello git developers. Please consider this small patch that fixes a bug
>     introduced during a coding style cleanup of the subtree command. Changes
>     to the argument handling were causing check_parents to fail when more
>     than one parent was supplied, which led to a small loss of performance.

I do not do "git subtree", and this cannot really be a proper review
that is more than "Looks OK from a cursory look", but anyway...

It seems that 315a84f9 (subtree: use commits before rejoins for
splits, 2018-09-28) is what broke the logic, but it does not look
like a coding style clean-up to me.

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 7f767b5c38f..56f24000c2c 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -296,10 +296,9 @@ cache_miss () {
>  	done
>  }
>  
> -# Usage: check_parents PARENTS_EXPR
> +# Usage: check_parents [REVS...]
>  check_parents () {
> -	assert test $# = 1
> -	missed=$(cache_miss "$1") || exit $?
> +	missed=$(cache_miss $*) || exit $?

We know at this point each of $1, $2, etc. have exactly one
revision, and we want cache_miss function to take one revision per
its parameter, so writing "$@" is much more preferrable over $* even
though they do the same thing in practice in the context of this
code, I think.

>  	local indent=$(($indent + 1))
>  	for miss in $missed
>  	do
> @@ -753,7 +752,7 @@ process_split_commit () {
>  	fi
>  	createcount=$(($createcount + 1))
>  	debug "parents: $parents"
> -	check_parents "$parents"
> +	check_parents $parents
>  	newparents=$(cache_get $parents) || exit $?
>  	debug "newparents: $newparents"
>  
>
> base-commit: e9d7761bb94f20acc98824275e317fa82436c25d
