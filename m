Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA66C433E9
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 08:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41BA207B8
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 08:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgL2Iv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:51:27 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:58255 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgL2Iv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 03:51:27 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4D4p6F67SJz5tlC;
        Tue, 29 Dec 2020 09:50:45 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DEBD549E4;
        Tue, 29 Dec 2020 09:50:44 +0100 (CET)
Subject: Re: [PATCH v9 4/5] mergetool: break setup_tool out into separate
 initialization function
To:     Seth House <seth@eseth.com>
References: <20201228045427.1166911-1-seth@eseth.com>
 <20201228192919.1195211-1-seth@eseth.com>
 <20201228192919.1195211-5-seth@eseth.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3eb8c8d9-5b56-82ff-21d8-725a6c269f66@kdbg.org>
Date:   Tue, 29 Dec 2020 09:50:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201228192919.1195211-5-seth@eseth.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.20 um 20:29 schrieb Seth House:
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index e3c7d78d1d..929192d0f8 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -334,6 +334,8 @@ merge_file () {
>  	checkout_staged_file 2 "$MERGED" "$LOCAL"
>  	checkout_staged_file 3 "$MERGED" "$REMOTE"
>  
> +	initialize_merge_tool "$merge_tool"

In my earlier review, I was not explicit about the lack of error
handling of this invocation, because I hoped that you would notice it
yourself. `initialize_merge_tool` does have a few failure modes via
`setup_tool` that are not really unlikely; ignoring errors would be
wrong, I think.

Before this change, the errors would be handled as part of the failing
`run_merge_tool` call at the end of function `merge_file`. But now
errors are ignored. Just appending `|| return` would not be appropriate
at this point because a lot has already happened before the call that
has to be rewound. Would it be possible to move the call above the
`mergetool_tmpdir_init` call, so that nothing has to be rewound?

> +
>  	if test "$(
>  		git config --get --bool "mergetool.$merge_tool.automerge" ||
>  		git config --get --bool "mergetool.automerge" ||
> 

-- Hannes
