Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1ECC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 23:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhKWX5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:57:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61928 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbhKWX5H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 18:57:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4D9815A01C;
        Tue, 23 Nov 2021 18:53:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2KOA5RtxZ1lQqKUavct3/CgF83ZSM/pWKTC8MA
        XZalM=; b=rxZCY+AvTRPMbxPtlHkTFlawlu30ZF6/BI8gFRs4dEMbnNKNMUcgFE
        Gvw0Ye8rqzVv6drI3/adjVaTF3twpSI/ScuIbilznkp27XMIymwLoPhcJKt/r40I
        tpsr41502Xw7BmDQ4HDaqZlYVOY/4icyQFulnCa5MwO91tj/v4JBw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CECC15A01B;
        Tue, 23 Nov 2021 18:53:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C73A415A01A;
        Tue, 23 Nov 2021 18:53:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v4 4/4] blame: enable and test the sparse index
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <7acf5118bf5602fbafca2d42c4f363b5adbcbd54.1637620958.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 15:53:54 -0800
In-Reply-To: <7acf5118bf5602fbafca2d42c4f363b5adbcbd54.1637620958.git.gitgitgadget@gmail.com>
        (Lessley Dennington via GitGitGadget's message of "Mon, 22 Nov 2021
        22:42:38 +0000")
Message-ID: <xmqqr1b65sz1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E7C9C78-4CB8-11EC-82BC-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 641523ff9af..247b9eaf88f 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -902,6 +902,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	long anchor;
>  	const int hexsz = the_hash_algo->hexsz;
>  
> +	if (startup_info->have_repository) {

The command is marked with RUN_SETUP bit in git.c::commands[] list,
so I would think we wouldn't even get called if we are not in a
repository here.

Under what condition can startup_info->have_repository be false at
this point in the control flow?  If there is such a case, it would
mean that startup_info->have_repository bit can be false even if we
are in a repository.  That sounds like a bug in some code (I do not
know where offhand) that is supposed to prepare the startup_info
before cmd_X() functions are called.

> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 5cf94627383..9ac76a049b8 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -114,6 +114,8 @@ test_perf_on_all git reset
>  test_perf_on_all git reset --hard
>  test_perf_on_all git reset -- does-not-exist
>  test_perf_on_all git diff
> -test_perf_on_all git diff --cached
> +test_perf_on_all git diff --staged

That's a funny revert of what the previous step did; I thought this
step was about "blame" and not "diff".

> +test_perf_on_all git blame $SPARSE_CONE/a
> +test_perf_on_all git blame $SPARSE_CONE/f3/a
>  
>  test_done
> -# TODO: blame currently does not support blaming files outside of the
> -# sparse definition. It complains that the file doesn't exist locally.
> -test_expect_failure 'blame with pathspec outside sparse definition' '
> +# NEEDSWORK: This test documents the current behavior, but this could
> +# change in the future if we decide to support blaming files outside
> +# the sparse definition.

OK.  From the description it is clear that we do not support it
right now, which is OK by me.
