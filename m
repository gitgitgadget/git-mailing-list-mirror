Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0341B1FEB3
	for <e@80x24.org>; Tue, 10 Jan 2017 06:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764945AbdAJGSH (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 01:18:07 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:62505 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756895AbdAJGSF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 01:18:05 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3tyMJq50Fyz5tlW;
        Tue, 10 Jan 2017 07:17:52 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 165973AE;
        Tue, 10 Jan 2017 07:17:52 +0100 (CET)
Subject: Re: [PATCH v4 14/14] mergetool: fix running in subdir when rerere
 enabled
To:     Richard Hansen <hansenr@google.com>
References: <20170109054238.42599-1-hansenr@google.com>
 <20170109232941.43637-1-hansenr@google.com>
 <20170109232941.43637-15-hansenr@google.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, sbeller@google.com,
        simon@ruderich.org, gitster@pobox.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3a09e318-f14b-5f14-a992-3bd045f0a4c6@kdbg.org>
Date:   Tue, 10 Jan 2017 07:17:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170109232941.43637-15-hansenr@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.2017 um 00:29 schrieb Richard Hansen:
> The pathnames output by the 'git rerere remaining' command are
> relative to the top-level directory but the 'git diff --name-only'
> command expects its pathname arguments to be relative to the current
> working directory.  Run cd_to_toplevel before running 'git diff
> --name-only' and adjust any relative pathnames so that 'git mergetool'
> does not fail when run from a subdirectory with rerere enabled.
>
> This fixes a regression introduced in
> 57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).
>
> Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Richard Hansen <hansenr@google.com>
> ---
>  git-mergetool.sh     | 16 ++++++++++++++--
>  t/t7610-mergetool.sh |  7 ++++++-
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index b506896dc..cba6bbd05 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -454,6 +454,15 @@ main () {
>  	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
>  	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
>
> +	prefix=$(git rev-parse --show-prefix) || exit 1
> +	cd_to_toplevel
> +
> +	if test -n "$orderfile"
> +	then
> +		orderfile=$(git rev-parse --prefix "$prefix" -- "$orderfile") || exit 1
> +		orderfile=$(printf %s\\n "$orderfile" | sed -e 1d)

Is the purpose of this complication only to detect errors of the git 
invocation? IMHO, we could dispense with that, but others might 
disagree. I am arguing because this adds yet another process; but it is 
only paid when -O is used, so...

> +	fi
> +
>  	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
>  	then
>  		set -- $(git rerere remaining)
> @@ -461,14 +470,17 @@ main () {
>  		then
>  			print_noop_and_exit
>  		fi
> +	elif test $# -ge 0
> +	then
> +		files_quoted=$(git rev-parse --sq --prefix "$prefix" -- "$@") || exit 1
> +		eval "set -- $files_quoted"

BTW, the --sq and eval business is not required here. At this point, 
$IFS = $'\n', so

		set -- $(git rev-parse --sq --prefix "$prefix" -- "$@")

will do. (Except that it would not detect errors.)

> +		shift
>  	fi

As I don't see anything wrong with what you have written, these comments 
alone do not warrant another re-roll.

-- Hannes

