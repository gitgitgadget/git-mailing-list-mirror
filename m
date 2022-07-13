Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943E0C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 19:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiGMTfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 15:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiGMTfq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 15:35:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5EC2B19F
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 12:35:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE4A81456AF;
        Wed, 13 Jul 2022 15:35:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0aVKet2GXbHhkSozyzqe+lgkBZsBUkbm3dNWkW
        X37Rs=; b=mT7QyfU+ZiuF6AmLzSzHfa+SLbphEC02Ec/oUT6yO8j4RuiNg+Rspy
        6cmxiBgxQkGBJ45LBZl9Pi6Y+IBXvjWB0aJf6G5VEUlqVG++8cCIwh96flrLZD9y
        L1H65iG9TL9s0+dLU1VmIfbR/VOHX1DAVNrrbUtU2Tp8lYKmOXfmk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B63251456AE;
        Wed, 13 Jul 2022 15:35:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2021B1456AD;
        Wed, 13 Jul 2022 15:35:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Allow debugging unsafe directories' ownership
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
        <3480381b8b99142bcc0213957a43d68a962c52d9.1657700238.git.gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 12:35:43 -0700
In-Reply-To: <3480381b8b99142bcc0213957a43d68a962c52d9.1657700238.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 13 Jul 2022
        08:17:15 +0000")
Message-ID: <xmqq5yk0dcvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC901FCA-02E2-11ED-B233-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When Git refuses to use an existing repository because it is owned by
> someone else than the current user, it can be a bit tricky on Windows to
> figure out what is going on.
>
> Let's help with that by offering some more information via the
> environment variable `GIT_TEST_DEBUG_UNSAFE_DIRECTORIES`.

I can see how the change to compat/ part is useful, but ...

> diff --git a/setup.c b/setup.c
> index 9dcecda65b0..3ba42ffcb27 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1353,13 +1353,23 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	case GIT_DIR_INVALID_OWNERSHIP:
>  		if (!nongit_ok) {
>  			struct strbuf quoted = STRBUF_INIT;
> +			struct strbuf hint = STRBUF_INIT;
> +
> +#ifdef __MINGW32__
> +			if (!git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0))
> +				strbuf_addstr(&hint,
> +					      _("\n\nSet the environment variable "
> +						"GIT_TEST_DEBUG_UNSAFE_DIRECTORIES=true "
> +						"and run\n"
> +						"again for more information."));
> +#endif

... I am not sure about this part.  Do we have any other codepath to
show "to debug, run the program with this" suggestion?  Adding it in
the documentation is probably good, but this is an extra message
that is much larger than the "owned by X but you are Y" message that
would be shown.  With or without the environment set, the output
will become noisier with this patch.  I wonder if we are better off
giving the information that is given in the warning (in compat/ part
of the patch) _unconditionally_ in the message, which would make it
less noisy overall.

Also what's our vision for non-Windows platform for "further
debugging aid" in this area?  Would we perhaps want a similar
"warning" that says "owned by X but you are Y"?

Thanks.
