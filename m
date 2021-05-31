Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD270C47093
	for <git@archiver.kernel.org>; Mon, 31 May 2021 01:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA3F60FDA
	for <git@archiver.kernel.org>; Mon, 31 May 2021 01:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEaB4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 21:56:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58974 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhEaB4f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 21:56:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CB1212A829;
        Sun, 30 May 2021 21:54:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=OI6mWDtvStHo3/HsTbVQpsK5AqebnQsUAUweVZ2Q36g=; b=X6uq
        EYxGsG4qpMAo5NKibYOMC1AuuLFCIZQWk3yAdzEKoXMxPbmw59Qa7Lg9380XoL94
        w303iUeaFxDSGXBeeqzza8PU6q6rzB/pwKk/i4JyhH3ZhwiG4nMtqMomfV3TkQQk
        C/rST7rZ8TtCYNQMXSb14jRSj7ODqW8zzbJsEOc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 359DD12A828;
        Sun, 30 May 2021 21:54:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8123812A821;
        Sun, 30 May 2021 21:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dima Kov via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Dima Kov <dima.kovol@gmail.com>
Subject: Re: [PATCH] refactor of git_setup_gettext method
References: <pull.964.git.1622410962551.gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 10:54:51 +0900
Message-ID: <xmqqbl8r1xck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 314E1784-C1B3-11EB-8D0D-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dima Kov via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Dima Kov <dima.kovol@gmail.com>
> Subject: Re: [PATCH] refactor of git_setup_gettext method

We do not write in C++, so "method" -> "function".

> Use one "free" call at the end of the function,
> instead of being dependent on the execution flow.
>
> Signed-off-by: Dima Kov <dima.kovol@gmail.com>
> ---

I think an early return is more readable, but if this were a new
code and used the style used in this patch, it would also have been
acceptable.  IOW, this is probably a borderline "Meh" change,
belonging to "what's already commited is good enough and it is not
worth the brain cycles to swap it around" category.


>  gettext.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/gettext.c b/gettext.c
> index af2413b47e85..e75c7bfdb1a8 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -109,17 +109,14 @@ void git_setup_gettext(void)
>  	if (!podir)
>  		podir = p = system_path(GIT_LOCALE_PATH);
>  
> -	if (!is_directory(podir)) {
> -		free(p);
> -		return;
> +	if (is_directory(podir)) {
> +		bindtextdomain("git", podir);
> +		setlocale(LC_MESSAGES, "");
> +		setlocale(LC_TIME, "");
> +		init_gettext_charset("git");
> +		textdomain("git");
>  	}
>  
> -	bindtextdomain("git", podir);
> -	setlocale(LC_MESSAGES, "");
> -	setlocale(LC_TIME, "");
> -	init_gettext_charset("git");
> -	textdomain("git");
> -
>  	free(p);
>  }
>  
>
> base-commit: de88ac70f3a801262eb3aa087e5d9a712be0a54a
