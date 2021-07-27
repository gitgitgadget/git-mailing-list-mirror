Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A3DC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 18:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D69060F93
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhG0S3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 14:29:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65392 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhG0S3I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 14:29:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0545BCF61F;
        Tue, 27 Jul 2021 14:29:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sxezwkp8pOwGCZtGMl6i2Xbu4xelL06qJ/ofSc
        H/Opc=; b=rQKX+XiRgyXR0jEcWUDL4CUhwHmUej+3Qa3zakm+vVRd1O6fgAtJnS
        Z2POA33FHYylw5HAWojco6lqO5PCiJQDUvfdojNoj+Hk9xdamM0H6o483fxjtCyC
        XGBsWuUwEP8dRyYTI4Mq4vv6fquWOf5Ht30fo+ORNAD9YJoKgUAiw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B58ADCF61D;
        Tue, 27 Jul 2021 14:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B827DCF61A;
        Tue, 27 Jul 2021 14:29:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Oded S via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Oded S <oded@istraresearch.com>
Subject: Re: [PATCH v2] bisect: disable pager while invoking show-branch
References: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
        <pull.1003.v2.git.1627373560881.gitgitgadget@gmail.com>
Date:   Tue, 27 Jul 2021 11:29:05 -0700
In-Reply-To: <pull.1003.v2.git.1627373560881.gitgitgadget@gmail.com> (Oded
        S. via GitGitGadget's message of "Tue, 27 Jul 2021 08:12:40 +0000")
Message-ID: <xmqq5ywvehla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 865987A4-EF08-11EB-95DE-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Oded S via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Oded Shimon <oded@istraresearch.com>
>
> git-bisect uses show-branch for logging during the bisect process. If the user
> sets an interactive pager for show-branch, this makes bisect hang (wait for
> user input) unexpectedly - so we disable pager with -P.
>
> It's possible that the user would set a pager for git-checkout as well, but an
> interactive pager there would break many more scripts.
>
> Signed-off-by: Oded Shimon <oded@istraresearch.com>
> ---

Nicely described.  Now we can discuss if the thought process behind
this change makes sense or not with such a clear description.

I do not know if "unexpectedly" is truly unexpected for those who
configure show-branch to page, though.  After all they wanted their
pager to kick in.

In any case, such users are probably better off configuring their
pager not to prompt and wait when the output is less than pageful
(e.g. "less" has "--quit-if-one-screen" option and 'F' in $LESS
environemnt variable triggers this behaviour).

The patch looks good to me.

Thanks.



> diff --git a/bisect.c b/bisect.c
> index af2863d044b..c02bcc3359f 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -23,7 +23,7 @@ static struct oid_array skipped_revs;
>  static struct object_id *current_bad_oid;
>  
>  static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
> -static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
> +static const char *argv_show_branch[] = {"-P", "show-branch", NULL, NULL};
>  
>  static const char *term_bad;
>  static const char *term_good;
> @@ -748,7 +748,7 @@ static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int
>  			return -abs(res);
>  	}
>  
> -	argv_show_branch[1] = bisect_rev_hex;
> +	argv_show_branch[2] = bisect_rev_hex;
>  	res = run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
>  	/*
>  	 * Errors in `run_command()` itself, signaled by res < 0,
>
> base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
