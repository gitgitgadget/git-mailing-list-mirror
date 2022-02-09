Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C712C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 18:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiBISEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiBISEq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 13:04:46 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91391C05CB8C
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 10:04:47 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DF05FC9AC;
        Wed,  9 Feb 2022 13:04:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I4h+3M6FJAoKLwfxZZyyBzA9SyCTctqDczM8l2
        Aqw+U=; b=qgzqTzjPOI42bBl+qkBOUuoDq6TFfIYgGuY9GjxG/OK7U7TZI8Lpvm
        M0ymXp7D+TXNqz3cLP9eEOTHzjvuXf0cqJOjIn3ChCi0x+dCpIl2sxaf51b7VNsv
        Y4ELUDR2SsaDefaNh3GmHXaVxC3WZm1GgPCxwgpHwKR+qys6253LU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2325DFC9AB;
        Wed,  9 Feb 2022 13:04:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74798FC9AA;
        Wed,  9 Feb 2022 13:04:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] xdiff: refactor a function
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
        <8655bb0348d7344ae85c8d521fb1ec7a5f4188d2.1644404356.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 10:04:43 -0800
In-Reply-To: <8655bb0348d7344ae85c8d521fb1ec7a5f4188d2.1644404356.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 09 Feb 2022 10:59:14
        +0000")
Message-ID: <xmqqmtiz9aro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2BD43F6-89D2-11EC-93F7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Rather than having to remember exactly what to free after an
> allocation failure use the standard "goto out" pattern. This will
> simplify the next commit that starts handling currently unhandled
> failures.

It sound like this is meant to be a no-op clean-up; let's see.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  xdiff/xmerge.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index fff0b594f9a..48c5e9e3f35 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -684,35 +684,30 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
>  int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
>  		xmparam_t const *xmp, mmbuffer_t *result)
>  {
> -	xdchange_t *xscr1, *xscr2;
> -	xdfenv_t xe1, xe2;
> -	int status;
> +	xdchange_t *xscr1 = NULL, *xscr2 = NULL;
> +	xdfenv_t xe1 = { 0 }, xe2 = { 0 };
> +	int status = -1;
>  	xpparam_t const *xpp = &xmp->xpp;
>  
>  	result->ptr = NULL;
>  	result->size = 0;
>  
> -	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
> -		return -1;
> -	}
> -	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
> -		xdl_free_env(&xe1);
> -		return -1;
> -	}

OK, xdl_do_diff() calls xdl_free_env(xe) before an error return (I
didn't check if patience and histogram also do so correctly), so the
original was not leaking xe1 or xe2.

> +	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0)
> +		goto out;
> +
> +	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0)
> +		goto out;
> +

And this does not change that.

>  	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
>  	    xdl_change_compact(&xe1.xdf2, &xe1.xdf1, xpp->flags) < 0 ||
> -	    xdl_build_script(&xe1, &xscr1) < 0) {
> -		xdl_free_env(&xe1);
> -		return -1;
> -	}
> +	    xdl_build_script(&xe1, &xscr1) < 0)
> +		goto out;
> +

Here, as xdl_build_script() does free the script it failed to build,
but not the xe it was given, the original is correct to free xe1.

We jump from here to leave the freeing of xe1 to the clean-up part.

>  	if (xdl_change_compact(&xe2.xdf1, &xe2.xdf2, xpp->flags) < 0 ||
>  	    xdl_change_compact(&xe2.xdf2, &xe2.xdf1, xpp->flags) < 0 ||
> -	    xdl_build_script(&xe2, &xscr2) < 0) {
> -		xdl_free_script(xscr1);
> -		xdl_free_env(&xe1);
> -		xdl_free_env(&xe2);
> -		return -1;
> -	}
> +	    xdl_build_script(&xe2, &xscr2) < 0)
> +		goto out;

Ditto for xe2 here.

>  	status = 0;
>  	if (!xscr1) {
>  		result->ptr = xdl_malloc(mf2->size);
> @@ -727,6 +722,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
>  				      &xe2, xscr2,
>  				      xmp, result);
>  	}
> + out:
>  	xdl_free_script(xscr1);
>  	xdl_free_script(xscr2);

And after the post-context of this hunk, we do free_env() both xe1
and xe2, so we should be doing the same thing as before.

Looking good.

