Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD91C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A3D61263
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFHBcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 21:32:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63364 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHBcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 21:32:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED529C34A4;
        Mon,  7 Jun 2021 21:30:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wGehlPAl3vgNq+R9yFrKLgaahJXnXiKMpAxN9b
        66nUQ=; b=r9miI+7VzDejMV/nv6T9ogCrj62diV5LCNoT5VF+NqFtj2ptwjY8Fo
        X0Xi/DJsgC5ooxpO9AABm0phBLH23d37XX9CioVRUMtJ8urkiQ+M4GvzvbTQ8v7p
        u8o0ORxGFb3OsnZc5jFRqtFJpfhMD1hMyl61hCGPFeJBcrUbM/zwQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5D46C34A2;
        Mon,  7 Jun 2021 21:30:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A82BC34A1;
        Mon,  7 Jun 2021 21:30:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Michael Schindler via GitGitGadget" <gitgitgadget@gmail.com>,
        David Aguilar <davvid@gmail.com>
Cc:     git@vger.kernel.org,
        Michael Schindler <michael@compressconsult.com>
Subject: Re: [PATCH] use get_merge_tool_path() also in is_available() to
 honor settings
References: <pull.1032.git.git.1623098845733.gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 10:30:17 +0900
In-Reply-To: <pull.1032.git.git.1623098845733.gitgitgadget@gmail.com> (Michael
        Schindler via GitGitGadget's message of "Mon, 07 Jun 2021 20:47:25
        +0000")
Message-ID: <xmqq7dj5rvme.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1562B9D4-C7F9-11EB-8862-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding David Aguilar as an area expert for help reviewing.

Thanks.

"Michael Schindler via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Michael Schindler <michael@compressconsult.com>
>
> fix the is_available test used in git mergetool --tool-help or
> git difftool --tool-help or to check the list of tools available when no
> tool is configured/given with --tool
>
> symtoms: the actual tool running run_merge_tool () considers the difftool.
> "$merge_tool".path and mergetool."$merge_tool".path and if configured
> honors these. See get_merge_tool_path () in git-mergetool--lib.sh
> If not set use fallback: translate_merge_tool_path "$merge_tool".
>
> The is_available () just uses translate_merge_tool_path "$merge_tool".
>
> repo 1: Configure an invalid path in mergetool."$merge_tool".path for a
> tool of your choice.
> You will be informed that the tool is available, but when trying to use
> it will not be found because the invalid configured path is used.
>
> repo2: Install a tool of your choice on a nonstandard place (e.g. rename
> the program) and configure mergetool."$merge_tool".path for this tool.
> You will be informed that the tool is not available (because not found on
> standard place), but when trying to run it will work.
>
> This fix will make the information consistent by using get_merge_tool_path()
> also in is_available()
>
> Signed-off-by: Michael Schindler <michael@compressconsult.com>
> ---
>     use get_merge_tool_path() also in is_available() to honor settings
>     
>     fix the is_available() used in git mergetool --tool-help or git difftool
>     --tool-help or used to check the list of tools available when no tool is
>     configured/given with --tool
>     
>     symtoms: the actual tool running run_merge_tool () considers the
>     difftool."$merge_tool".path and mergetool."$merge_tool".path and if
>     configured honors these. See get_merge_tool_path () in
>     git-mergetool--lib.sh If not defined use fallback:
>     translate_merge_tool_path "$merge_tool".
>     
>     The is_available () just uses translate_merge_tool_path "$merge_tool".
>     
>     repo 1: Configure an invalid path in mergetool."$merge_tool".path for a
>     tool of your choice. You will be informed that the tool is available,
>     but when trying to use it it will not be found because the invalid
>     configured path is used.
>     
>     repo2: Install a tool of your choice on a nonstandard place (e.g. rename
>     the program) and configure mergetool."$merge_tool".path for this tool.
>     You will be informed that the tool is not available (because not found
>     on standard place), but when trying to run it will work.
>     
>     This fix will make the information consistent by using
>     get_merge_tool_path() also in is_available()
>     
>     Signed-off-by: Michael Schindler michael@compressconsult.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1032%2Fmichaelcompressconsult%2Fmergetoollib_is_available-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1032/michaelcompressconsult/mergetoollib_is_available-v1
> Pull-Request: https://github.com/git/git/pull/1032
>
>  git-mergetool--lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 542a6a75eb3c..8b946e585d7f 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -18,7 +18,7 @@ mode_ok () {
>  }
>  
>  is_available () {
> -	merge_tool_path=$(translate_merge_tool_path "$1") &&
> +	merge_tool_path=$(get_merge_tool_path "$1") &&
>  	type "$merge_tool_path" >/dev/null 2>&1
>  }
>  
>
> base-commit: c09b6306c6ca275ed9d0348a8c8014b2ff723cfb
