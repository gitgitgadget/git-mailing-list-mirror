Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5104C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 21:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiHVVlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbiHVVlV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 17:41:21 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D7F53001
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 14:41:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD8181BD5DC;
        Mon, 22 Aug 2022 17:41:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q9ekgDutOdXw8rJxJsFLP90Ptmq/4O8dZ0+qTQ
        q24SI=; b=rM2Nenxst1P8lcWXiUC/BUYCH1peMvZe4WwK5CGzXTpiL4J2dGm12Y
        0w8Xj6iD94NeXXGnpFwk3Sv6P1+/uTh66QJXv4pOI1J38TX6vKebIn5Scqf3xyTg
        1ST92HVCHHD+u+K+b21tFF9H2RuMOKROdqTQRdBH4fgDCYEAYJFyM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2FFC1BD5DB;
        Mon, 22 Aug 2022 17:41:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B01361BD5DA;
        Mon, 22 Aug 2022 17:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Delannoy <anthony.2lannoy@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] pathspec: fix memleak
References: <20220822211507.8693-1-anthony.2lannoy@gmail.com>
        <20220822211507.8693-2-anthony.2lannoy@gmail.com>
Date:   Mon, 22 Aug 2022 14:41:11 -0700
In-Reply-To: <20220822211507.8693-2-anthony.2lannoy@gmail.com> (Anthony
        Delannoy's message of "Mon, 22 Aug 2022 23:15:07 +0200")
Message-ID: <xmqq4jy4ard4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2478D410-2263-11ED-A65A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Delannoy <anthony.2lannoy@gmail.com> writes:

> Fix a memory leak occuring in case of pathspec copy in preload_index.
>
> Direct leak of 8 byte(s) in 8 object(s) allocated from:
>     #0 0x7f0a353ead47 in __interceptor_malloc (/usr/lib/gcc/x86_64-pc-linux-gnu/11.3.0/libasan.so.6+0xb5d47)
>     #1 0x55750995e840 in do_xmalloc /home/anthony/src/c/git/wrapper.c:51
>     #2 0x55750995e840 in xmalloc /home/anthony/src/c/git/wrapper.c:72
>     #3 0x55750970f824 in copy_pathspec /home/anthony/src/c/git/pathspec.c:684
>     #4 0x557509717278 in preload_index /home/anthony/src/c/git/preload-index.c:135
>     #5 0x55750975f21e in refresh_index /home/anthony/src/c/git/read-cache.c:1633
>     #6 0x55750915b926 in cmd_status builtin/commit.c:1547
>     #7 0x5575090e1680 in run_builtin /home/anthony/src/c/git/git.c:466
>     #8 0x5575090e1680 in handle_builtin /home/anthony/src/c/git/git.c:720
>     #9 0x5575090e284a in run_argv /home/anthony/src/c/git/git.c:787
>     #10 0x5575090e284a in cmd_main /home/anthony/src/c/git/git.c:920
>     #11 0x5575090dbf82 in main /home/anthony/src/c/git/common-main.c:56
>     #12 0x7f0a348230ab  (/lib64/libc.so.6+0x290ab)
>
> Signed-off-by: Anthony Delannoy <anthony.2lannoy@gmail.com>
> ---
>  preload-index.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/preload-index.c b/preload-index.c
> index e5529a5863..100f7a374d 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -151,6 +151,12 @@ void preload_index(struct index_state *index,
>  	}
>  	stop_progress(&pd.progress);
>  
> +	if (pathspec) {
> +		/* earlier we made deep copies for each thread to work with */
> +		for (i = 0; i < threads; i++)
> +			clear_pathspec(&data[i].pathspec);
> +	}
> +

This round looks good to me.

Thanks, will queue.

>  	trace_performance_leave("preload index");
>  
>  	trace2_data_intmax("index", NULL, "preload/sum_lstat", t2_sum_lstat);
