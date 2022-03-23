Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE39EC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 16:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbiCWQpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiCWQpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 12:45:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF4DB868
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:43:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3292E1286C1;
        Wed, 23 Mar 2022 12:43:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w8LiL0OJhLiQHLDMci5QrZgv9c8JEt8+Gy+osf
        3nWAY=; b=HXRhJZHfRx2UaGaRxY+cim1cYpug1jAhohuyFSHdw298PoPvPzEMZ6
        H9pi43UF4fl2XH0RPZ3meaQUhZuT9SVBYjNRn/QvBnsLmkFZGL/wq7GIbAXXTLN8
        pMsUwfnJtrGLOauJGHaKtCwpJSrfKn+wV8my31KQdK53/c0MwuBXo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29ED01286C0;
        Wed, 23 Mar 2022 12:43:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 876541286BF;
        Wed, 23 Mar 2022 12:43:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH v5 1/3] vimdiff: new implementation with layout support
References: <20220319091141.4911-1-greenfoo@u92.eu>
        <20220319091141.4911-2-greenfoo@u92.eu>
Date:   Wed, 23 Mar 2022 09:43:34 -0700
In-Reply-To: <20220319091141.4911-2-greenfoo@u92.eu> (Fernando Ramos's message
        of "Sat, 19 Mar 2022 10:11:39 +0100")
Message-ID: <xmqqsfr8sjpl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61FC3FBA-AAC8-11EC-A45F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> When running 'git mergetool -t vimdiff', a new configuration option
> ('mergetool.vimdiff.layout') can now be used to select how the user
> wants the different windows, tabs and buffers to be displayed.
>
> If the option is not provided, the layout will be the same one that was
> being used before this commit (ie. two rows with LOCAL, BASE and COMMIT
> in the top one and MERGED in the bottom one).
>
> The 'vimdiff' variants ('vimdiff{1,2,3}') still work but, because they
> represented nothing else than different layouts, are now internally
> implemented as a subcase of 'vimdiff' with the corresponding
> pre-configured 'layout'.
>
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  mergetools/vimdiff | 548 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 521 insertions(+), 27 deletions(-)
>
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 96f6209a04..5bf77a5388 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -1,48 +1,440 @@
> +# This script can be run in two different contexts:
> +#
> +#   - From git, when the user invokes the "vimdiff" merge tool. In this context
> +#     this script expects the following environment variables (among others) to
> +#     be defined (which is something "git" takes care of):
> +#
> +#       - $BASE
> +#       - $LOCAL
> +#       - $REMOTE
> +#       - $MERGED
> +#
> +#     In this mode, all this script does is to run the next command:
> +#
> +#         vim -f -c ... $LOCAL $BASE $REMOTE $MERGED
> +#
> +#     ...where the "..." string depends on the value of the
> +#     "mergetool.vimdiff.layout" configuration variable and is used to open vim
> +#     with a certain layout of buffers, windows and tabs.
> +#
> +#   - From the unit tests framework ("t" folder) by sourcing this script and
> +#     then manually calling "run_unit_tests", which will run a battery of unit
> +#     tests to make sure nothing breaks.
> +#     In this context this script does not expect any particular environment
> +#     variable to be set.
> +
> +
> +################################################################################
> +## Internal functions (not meant to be used outside this script)
> +################################################################################
> +
> +debug_print() { 
> +	# Send message to stderr if global variable DEBUG is set to "true"
> +
> +	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
> +	then
> +		>&2 echo "$@"
> +	fi
> +}

Do we want to keep this helper, and many calls to it sprinkled in
this file, or are they leftover cruft?

Style.  "debug_print () {", i.e. SPACE on both sides of "()".

> +substring() {
> +	# Return a substring of $1 containing $3 characters starting at
> +	# zero-based offset $2.
> +	# 
> +	# Examples:
> +	#
> +	#   substring "Hello world" 0 4  --> "Hell"
> +	#   substring "Hello world" 3 4  --> "lo w"
> +	#   substring "Hello world" 3 10 --> "lo world"
> +
> +	STRING=$1
> +	START=$2
> +	LEN=$3
> +
> +	echo "$STRING" | cut -c$(( START + 1 ))-$(( START + $LEN))
> +}

The lack of space before the second closing "))" makes it look
inconsistent.  We should be able to do this no external commands
and just two variable substitutions and without relying on
bash-isms, but the above should do.

>  merge_cmd () {
> +	layout=$(git config mergetool.$merge_tool.layout)
> +
>  	case "$1" in
>  	*vimdiff)
> -		if $base_present
> +		if test -z "$layout"
>  		then
> -			"$merge_tool_path" -f -d -c '4wincmd w | wincmd J' \
> -				"$LOCAL" "$BASE" "$REMOTE" "$MERGED"
> -		else
> -			"$merge_tool_path" -f -d -c 'wincmd l' \
> -				"$LOCAL" "$MERGED" "$REMOTE"
> +			# Default layout when none is specified
> +			layout="(LOCAL,BASE,REMOTE)/MERGED"
>  		fi
>  		;;
> ...
> +	if $base_present
> +	then
> +		eval "$merge_tool_path" \
> +			-f "$FINAL_CMD" "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
> +	else
> +		# If there is no BASE (example: a merge conflict in a new file
> +		# with the same name created in both braches which didn't exist
> +		# before), close all BASE windows using vim's "quit" command
> +
> +		FINAL_CMD=$(echo "$FINAL_CMD" | \
> +			sed -e 's:2b:quit:g' -e 's:3b:2b:g' -e 's:4b:3b:g')
> +
> +		eval "$merge_tool_path" \
> +			-f "$FINAL_CMD" "$LOCAL" "$REMOTE" "$MERGED"
> +	fi


I wonder if there were an easy way to "compare" the $FINAL_CMD this
new code feeds to $merge_tool_path and what was fed to it by the
original code to show that we are not regressing what the end user
sees.

The "run_unit_tests()" only compares the cmd generated for each
given layout, but the original vimdiff$N didn't express them in
terms of $layout this patch introduces, so unfortunately that is not
it.

Ideas?
