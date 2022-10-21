Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC0AFA373D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJURir (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJURip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:38:45 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E742670FA
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:38:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3566A1B207B;
        Fri, 21 Oct 2022 13:38:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E+DFm+xCnDgGSFea4u2E2M+eol513F6ygwVyG8
        GCBTQ=; b=YDh01O5BGD9lTblSLvNimR2kK1/kD9rN2nGT0pmQ03UJ+AzBa7TiaX
        281GkmeTe3bz0KeU3GJ84OKzZ6cyS33us7yIgG7TDz+F/W/gAdW1FSm2iAVZIg3f
        ISdm6OfJKUuf6LqAkTnNq42BhRE9V5tAd0Sa6zRpyaEA2wMglF3D0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E6511B207A;
        Fri, 21 Oct 2022 13:38:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E83A31B2077;
        Fri, 21 Oct 2022 13:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 5/8] rebase --apply: respect GIT_REFLOG_ACTION
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
        <0c71c73290441b67e2d70809cfaf605a1f3f70ca.1666344108.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 10:38:36 -0700
In-Reply-To: <0c71c73290441b67e2d70809cfaf605a1f3f70ca.1666344108.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Oct 2022 09:21:45
        +0000")
Message-ID: <xmqqfsfhm603.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31F0FA22-5167-11ED-8C1D-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The reflog messages when finishing a rebase hard code "rebase" rather
> than using GIT_REFLOG_ACTION.

Makes sense.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c          | 7 ++++---
>  t/t3406-rebase-message.sh | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index c1e68173b5f..ea246c6bb3a 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -582,10 +582,11 @@ static int move_to_original_branch(struct rebase_options *opts)
>  	if (!opts->onto)
>  		BUG("move_to_original_branch without onto");
>  
> -	strbuf_addf(&branch_reflog, "rebase finished: %s onto %s",
> +	strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
> +		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>  		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
> -	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
> -		    opts->head_name);
> +	strbuf_addf(&head_reflog, "%s finished: returning to %s",
> +		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
>  	ropts.branch = opts->head_name;
>  	ropts.flags = RESET_HEAD_REFS_ONLY;
>  	ropts.branch_msg = branch_reflog.buf;
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 8aa6a79acc1..bb2a4949abc 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -88,7 +88,7 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
>  write_reflog_expect () {
>  	if test $mode = --apply
>  	then
> -		sed 's/.*(finish)/rebase finished/; s/ ([^)]*)//'
> +		sed 's/(finish)/finished/; s/ ([^)]*)//'
>  	else
>  		cat
>  	fi >expect
