Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F0D1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969897AbdAITxU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:53:20 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:30951 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965412AbdAITxT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:53:19 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3ty5Rw5cxTz5tlL;
        Mon,  9 Jan 2017 20:53:16 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C6C413AB;
        Mon,  9 Jan 2017 20:53:15 +0100 (CET)
Subject: Re: [PATCH v3 13/13] mergetool: fix running in subdir when rerere
 enabled
To:     Junio C Hamano <gitster@pobox.com>,
        Richard Hansen <hansenr@google.com>
References: <20170106010945.79382-1-hansenr@google.com>
 <20170109054238.42599-1-hansenr@google.com>
 <20170109054238.42599-14-hansenr@google.com>
 <xmqq4m18ump1.fsf@gitster.mtv.corp.google.com>
 <xmqqvatot5ob.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, sbeller@google.com,
        simon@ruderich.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <babb5073-97d1-3d03-02a5-9c690e86b8a0@kdbg.org>
Date:   Mon, 9 Jan 2017 20:53:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqvatot5ob.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.01.2017 um 20:05 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I wonder if it makes more sense to always move to toplevel upfront
>> and consistently use path from the toplevel, perhaps like the patch
>
> s/the patch/the attached patch/ I meant.
>
>> does.  The first hunk is what you wrote but only inside MERGE_RR
>> block, and the second hunk deals with converting end-user supplied
>> paths that are relative to the original relative to the top-level.
>>
>> The tweaking of $orderfile you have in the first hunk may have to be
>> tightened mimicking the way how "eval ... --sq ... ; shift" is used
>> in the second hunk to avoid confusion in case orderfile specified by
>> the end user happens to be the same as a valid revname
>> (e.g. "master").
>
> And here is a squash-able patch to illustrate what I mean.
>
> I removed both of the comment blocks as the code always works with
> the worktree-relative pathname after this patch while adjusting
> end-user supplied paths from relative to original cwd.  As that is
> how the core parts of the system (including the parts written in C)
> work, even though an explanation you did in the log message is
> needed to explain why the change was needed and what the change
> intended to do to readers of "git log", it is not necessary to
> explain it to the readers of the latest code, which is what the
> in-code comment is about.
>
> The single-liner addition to the test creates a branch whose name is
> the same as the specified orderfile to deliberately create a
> confusing situation.  I haven't tried, but I am fairly sure that the
> test will demonstrate how broken the orderfile=$(...) in the
> original is, if you apply the test part of the attached patch,
> without the changes to git-mergetool.sh, to your version.
>
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 22f56c25a2..21f82d5b58 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -454,53 +454,34 @@ main () {
>  	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
>  	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
>
> -	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
> +	prefix=$(git rev-parse --show-prefix) || exit 1
> +	cd_to_toplevel
> +
> +	if test -n "$orderfile"
>  	then
> -		# The pathnames output by the 'git rerere remaining'
> -		# command below are relative to the top-level
> -		# directory but the 'git diff --name-only' command
> -		# further below expects the pathnames to be relative
> -		# to the current working directory.  Thus, we cd to
> -		# the top-level directory before running 'git diff
> -		# --name-only'.  We change directories even earlier
> -		# (before running 'git rerere remaining') in case 'git
> -		# rerere remaining' is ever changed to output
> -		# pathnames relative to the current working directory.
> -		#
> -		# Changing directories breaks a relative $orderfile
> -		# pathname argument, so fix it up to be relative to
> -		# the top-level directory.
> -
> -		prefix=$(git rev-parse --show-prefix) || exit 1
> -		cd_to_toplevel
> -		if test -n "$orderfile"
> -		then
> -			orderfile=$(git rev-parse --prefix "$prefix" "$orderfile") || exit 1
> -		fi
> +		orderfile=$(
> +			git rev-parse --prefix "$prefix" -- "$orderfile" |
> +			sed -e 1d
> +		)
> +	fi
>
> +	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
> +	then
>  		set -- $(git rerere remaining)
>  		if test $# -eq 0
>  		then
>  			print_noop_and_exit
>  		fi
> +	elif test $# -ge 0
> +	then
> +		eval "set -- $(git rev-parse --sq --prefix "$prefix" -- "$@")"
> +		shift
>  	fi
>
> -	# Note:  The pathnames output by 'git diff --name-only' are
> -	# relative to the top-level directory, but it expects input
> -	# pathnames to be relative to the current working directory.
> -	# Thus:
> -	#   * Either cd_to_toplevel must not be run before this or all
> -	#     relative input pathnames must be converted to be
> -	#     relative to the top-level directory (or absolute).
> -	#   * Either cd_to_toplevel must be run after this or all
> -	#     relative output pathnames must be converted to be
> -	#     relative to the current working directory (or absolute).
>  	files=$(git -c core.quotePath=false \
>  		diff --name-only --diff-filter=U \
>  		${orderfile:+"-O$orderfile"} -- "$@")
>
> -	cd_to_toplevel
> -
>  	if test -z "$files"
>  	then
>  		print_noop_and_exit

The control flow after this patch looks much more like what I had in 
mind. Thanks.

-- Hannes

