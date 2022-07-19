Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F2C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiGSUNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGSUNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:13:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6BC52E62
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:13:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AA0C1987C5;
        Tue, 19 Jul 2022 16:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6a2zpKQe6TwBIGWS131V1A0Iyy2D0dW7Uc6P+m
        6vLyM=; b=f0pnS7coU9os2tMQhedJUD3hAKQ6DFbAnG+xs/ehVY3CLNp4Eeb/Vh
        0iQt8EqVZMQmCC8w56jwoA2sQ6o3IyOvZ166ZY2rw1nvkUlrMoXY4ZGmuUW7m/8S
        M2SsydRBQ/YSCsiGwk/n1C4PmfeNoT5uY47pYfyTqUgbSMrt2+mIQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 338F11987C3;
        Tue, 19 Jul 2022 16:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9AD31987C2;
        Tue, 19 Jul 2022 16:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] compat/win32: correct for incorrect compiler warning
References: <pull.1294.git.1658256354725.gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 13:13:35 -0700
In-Reply-To: <pull.1294.git.1658256354725.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 19 Jul 2022 18:45:54
        +0000")
Message-ID: <xmqqk088amj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 459716AE-079F-11ED-896E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> index 1f8d8934cc9..0af18d88825 100644
> --- a/compat/win32/syslog.c
> +++ b/compat/win32/syslog.c
> @@ -44,6 +44,7 @@ void syslog(int priority, const char *fmt, ...)
>  
>  	while ((pos = strstr(str, "%1")) != NULL) {
>  		size_t offset = pos - str;
> +		char *new_pos;
>  		char *oldstr = str;
>  		str = realloc(str, st_add(++str_len, 1));
>  		if (!str) {
> @@ -51,9 +52,9 @@ void syslog(int priority, const char *fmt, ...)
>  			warning_errno("realloc failed");
>  			return;
>  		}
> -		pos = str + offset;
> -		memmove(pos + 2, pos + 1, strlen(pos));
> -		pos[1] = ' ';
> +		new_pos = str + offset;
> +		memmove(new_pos + 2, new_pos + 1, strlen(new_pos));
> +		new_pos[1] = ' ';
>  	}

Heh, after this sequence

	pos = strstr(str, ...);
	str = realloc(str, ...);
	pos = str + something;

the compiler warns about use of pos[] as if resetting of pos based
on the new value of str[] did not even exist?

Discovering a working work-around must have been a pain.

If I were writing this, I'd probably

 * avoid re-scanning "str" from the beginning in every iteration;

 * possibly avoid reallocating for %1 by first scanning and counting
   the problematic "%1";

 * also possibly give a deeper thought to see if "%1" -> "% 1" is
   necessary.  We are munging the original string anyway---in the
   output that has "% 1", you cannot tell if the original was "%1"
   that was munged by this code, or it was "% 1" from the beginning.
   In other words, we are already willing to lose information.
   Perhaps we can find a different replacement sequence that is
   still 2-byte-wide and that is unlikely to appear in the original,
   eliminating the need for reallocation altogether?

But none of that is a problem with this patch.

Will queue.  Thanks.


