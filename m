Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF54DC433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860B322583
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgL1LtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:49:12 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:35742 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgL1LtM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:49:12 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4D4G5p33ZPz5tlB;
        Mon, 28 Dec 2020 12:48:30 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CB0C720EE;
        Mon, 28 Dec 2020 12:48:29 +0100 (CET)
Subject: Re: [PATCH v8 3/4] mergetool: Break setup_tool out into separate
 initialization function
To:     Seth House <seth@eseth.com>
References: <20201228004152.522421-1-seth@eseth.com>
 <20201228045427.1166911-1-seth@eseth.com>
 <20201228045427.1166911-4-seth@eseth.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <cc8c5d6e-eee3-afdb-55cc-633455a5dcfa@kdbg.org>
Date:   Mon, 28 Dec 2020 12:48:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201228045427.1166911-4-seth@eseth.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.20 um 05:54 schrieb Seth House:
> The tool-specific functions are sometimes needed in scope earlier than
> when run_merge_tool is called.

You should answer why this change is needed. "are sometimes needed in
scope earlier" cannot be true, else we would have a bug that is fixed by
this change. But this isn't a bug fix, is it?

It would be ok to say "We are going to add another thing that we will
need before run_merge_tool; this is a preparation" or something.

Which brings me to another point: I do not see that something is added
to initialize_merge_tool in a later patch. You are only replacing
setup_tool calls by initialize_merge_tool, which forwards to setup_tool.
Why do we need a new function?

> 
> Signed-off-by: Seth House <seth@eseth.com>
> ---
>  Documentation/git-mergetool--lib.txt | 4 ++++
>  git-difftool--helper.sh              | 2 ++
>  git-mergetool--lib.sh                | 7 ++++---
>  git-mergetool.sh                     | 2 ++
>  4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
> index 4da9d24096..3e8f59ac0e 100644
> --- a/Documentation/git-mergetool--lib.txt
> +++ b/Documentation/git-mergetool--lib.txt
> @@ -38,6 +38,10 @@ get_merge_tool_cmd::
>  get_merge_tool_path::
>  	returns the custom path for a merge tool.
>  
> +initialize_merge_tool::
> +	bring merge tool specific functions into scope so they can be used or
> +	overridden.
> +
>  run_merge_tool::
>  	launches a merge tool given the tool name and a true/false
>  	flag to indicate whether a merge base is present.

[ swapped hunks for better sentence structure ]

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 7225abd811..e059b3559e 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -248,6 +248,10 @@ trust_exit_code () {
>  	fi
>  }
>
> +initialize_merge_tool () {
> +	# Bring tool-specific functions into scope
> +	setup_tool "$1" || return 1
> +}
>
>  # Entry point for running tools
>  run_merge_tool () {
> @@ -259,9 +263,6 @@ run_merge_tool () {
>  	merge_tool_path=$(get_merge_tool_path "$1") || exit
>  	base_present="$2"
>
> -	# Bring tool-specific functions into scope
> -	setup_tool "$1" || return 1
> -

Before this change, run_merge_tool would exit here when there was an
error during setup_tool. But...

> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 46af3e60b7..c47a6d4253 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -61,6 +61,7 @@ launch_merge_tool () {
>  		export BASE
>  		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
>  	else
> +		initialize_merge_tool "$merge_tool"
>  		run_merge_tool "$merge_tool"
>  	fi

... after the change we do not exit anymore. Does it matter?

Perhaps

		initialize_merge_tool "$merge_tool" &&
  		run_merge_tool "$merge_tool"

>  }
> @@ -79,6 +80,7 @@ if test -n "$GIT_DIFFTOOL_DIRDIFF"
>  then
>  	LOCAL="$1"
>  	REMOTE="$2"
> +	initialize_merge_tool "$merge_tool"
>  	run_merge_tool "$merge_tool" false
>  else
>  	# Launch the merge tool on each path provided by 'git diff'


> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index e3c7d78d1d..929192d0f8 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -334,6 +334,8 @@ merge_file () {
>  	checkout_staged_file 2 "$MERGED" "$LOCAL"
>  	checkout_staged_file 3 "$MERGED" "$REMOTE"
>  
> +	initialize_merge_tool "$merge_tool"
> +
>  	if test "$(
>  		git config --get --bool "mergetool.$merge_tool.automerge" ||
>  		git config --get --bool "mergetool.automerge" ||
> 

