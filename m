Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAF6C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 17:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDDC61205
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 17:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhKJROm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 12:14:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61699 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhKJROj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 12:14:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1970DFF48D;
        Wed, 10 Nov 2021 12:11:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TlkMejvzPaB9BtX86zvsH90w111PfxWCIOHpqP
        agBSU=; b=F2OjoZmUEB8MzTp7KO2Y2Qbg0Cd/+U+i/OuiRXphr7ViSXm/lOkySG
        qcp8vizlO9gU/JHFfzic/ktp40Q2/htDWua2/TfAra/QlGlobpEQUEaOJ60CYf64
        785EbBleltbfidcxBj9RtaNZA/LnqvIyLqIe+Iuw4db1ad+zzDbZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 110F8FF48C;
        Wed, 10 Nov 2021 12:11:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70505FF48B;
        Wed, 10 Nov 2021 12:11:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] simple-ipc: work around issues with Cygwin's Unix
 socket emulation
References: <pull.1074.git.1636542550889.gitgitgadget@gmail.com>
Date:   Wed, 10 Nov 2021 09:11:49 -0800
In-Reply-To: <pull.1074.git.1636542550889.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 10 Nov 2021 11:09:10
        +0000")
Message-ID: <xmqqtugkx7e2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B4949D0-4249-11EC-A7D0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Cygwin emulates Unix sockets by writing files with custom contents and
> then marking them as system files.
>
> The tricky problem is that while the file is written and its `system`
> bit is set, it is still identified as a file. This caused test failures
> when Git is too fast looking for the Unix sockets and then complains
> that there is a plain file in the way.
>
> Let's work around this by adding a delayed retry loop, specifically for
> Cygwin.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

OK, I was about to ask for an Ack from Cygwin folks but I see the
original that got Ack is more-or-less the same except for placement
of the comments (and this version of course is more polished than
the "this should work---please try it" version), so let me pretend
that this got tested-by from those who were happy with the original
in the old thread.

Thanks.


>     simple-ipc: work around issues with Cygwin's Unix socket emulation
>     
>     Adam Dinwoodie reported problems running the simple-ipc tests on Cygwin
>     [https://lore.kernel.org/git/20211104194619.GA12886@dinwoodie.org]. This
>     patch works around the underlying problem, which is rooted in Cygwin's
>     implementation details.
>     
>     With this patch, I could not reproduce the problem, even with sh
>     t0052-simple-ipc.sh --stress-limit=30.
>     
>     As per Junio's encouragement
>     [https://lore.kernel.org/git/xmqqee7ozyx4.fsf@gitster.g], I am
>     submitting this still in the -rc phase, hoping that it will make it into
>     v2.34.0 final.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1074%2Fdscho%2Fcygwin-vs-simple-ipc-workaround-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1074/dscho/cygwin-vs-simple-ipc-workaround-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1074
>
>  compat/simple-ipc/ipc-unix-socket.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
> index 4e28857a0a1..28a79289d4f 100644
> --- a/compat/simple-ipc/ipc-unix-socket.c
> +++ b/compat/simple-ipc/ipc-unix-socket.c
> @@ -35,6 +35,28 @@ enum ipc_active_state ipc_get_active_state(const char *path)
>  		}
>  	}
>  
> +#ifdef __CYGWIN__
> +	/*
> +	 * Cygwin emulates Unix sockets by writing special-crafted files whose
> +	 * `system` bit is set.
> +	 *
> +	 * If we are too fast, Cygwin might still be in the process of marking
> +	 * the underlying file as a system file. Until then, we will not see a
> +	 * Unix socket here, but a plain file instead. Just in case that this
> +	 * is happening, wait a little and try again.
> +	 */
> +	{
> +		static const int delay[] = { 1, 10, 20, 40, -1 };
> +		int i;
> +
> +		for (i = 0; S_ISREG(st.st_mode) && delay[i] > 0; i++) {
> +			sleep_millisec(delay[i]);
> +			if (lstat(path, &st) == -1)
> +				return IPC_STATE__INVALID_PATH;
> +		}
> +	}
> +#endif
> +
>  	/* also complain if a plain file is in the way */
>  	if ((st.st_mode & S_IFMT) != S_IFSOCK)
>  		return IPC_STATE__INVALID_PATH;
>
> base-commit: 6c220937e2b26d85920bf2d38ff2464a0d57fd6b
