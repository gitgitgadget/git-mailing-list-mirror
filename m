Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121652047F
	for <e@80x24.org>; Wed, 26 Jul 2017 18:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbdGZSFd (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 14:05:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59693 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750907AbdGZSFc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 14:05:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDB469319C;
        Wed, 26 Jul 2017 14:05:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1SpTYWg/wDmgOqh2jkUqfKmOyC0=; b=FB2/MR
        Jy0tm7JFN5a+/Noc8cHdJuli2arvhNClQPJZNNi46OeAZ6nS1c1e2U0c/XSMm8D/
        +X7u/Gs0/3Zy+T6mO76JgPaA+af937cSBDHJVeHZArZQ7JbAoAfQVFOR9LgARXbh
        EJgiJ4cr223EltGaWU1yU55DWcLK9HR8IihXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BVjQk8vDoyfmZkSVt01dm0iQ+pX1kniQ
        9r4dlNl35Ci5dvBTCBTKZ6u4d5BrT+RKBKJmSFCrpzX/oaNyV0NMFwUzON026UFQ
        ydDoBL7oEr0abHMCPiCrZWt00B9CASKtQ+KDXiQGEGfqybKv+01DkWvCw3I48g2Y
        4+IdyXCORbU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4F339319B;
        Wed, 26 Jul 2017 14:05:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AAEB93199;
        Wed, 26 Jul 2017 14:05:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Raman Gupta <rocketraman@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] contrib/rerere-train: optionally overwrite existing resolutions
References: <1caa9bb1-9184-7335-a041-6abd2c8f616c@gmail.com>
        <xmqqwp6wtdu0.fsf@gitster.mtv.corp.google.com>
        <ae4d9b77-c47e-199b-d40f-ad5b49c5dd60@gmail.com>
Date:   Wed, 26 Jul 2017 11:05:30 -0700
In-Reply-To: <ae4d9b77-c47e-199b-d40f-ad5b49c5dd60@gmail.com> (Raman Gupta's
        message of "Tue, 25 Jul 2017 18:48:12 -0400")
Message-ID: <xmqqmv7rrs45.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0360DEE4-722D-11E7-A29C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raman Gupta <rocketraman@gmail.com> writes:

> Provide the user an option to overwrite existing resolutions using an
> `--overwrite` flag. This might be used, for example, if the user knows
> that they already have an entry in their rerere cache for a conflict,
> but wish to drop it and retrain based on the merge commit(s) passed to
> the rerere-train script.
>
> Signed-off-by: Raman Gupta <rocketraman@gmail.com>
> ---
>  contrib/rerere-train.sh | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
> index 52ad9e4..e25bf8a 100755
> --- a/contrib/rerere-train.sh
> +++ b/contrib/rerere-train.sh
> @@ -3,10 +3,38 @@
>  # Prime rerere database from existing merge commits
>  
>  me=rerere-train
> -USAGE="$me rev-list-args"
>  
>  SUBDIRECTORY_OK=Yes
> -OPTIONS_SPEC=
> +OPTS_SPEC="\
> +$me [--overwrite] <rev-list-args>
> +--
> +h,help        show the help
> +o,overwrite   overwrite any existing rerere cache
> +"
> +eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
> +
> +overwrite=0

It is very good that you initialize overwrite explicitly here, to
prevent it from seeping through from the caller's environment.

> +while test $# -gt 0
> +do
> +	opt="$1"
> +	case "$opt" in
> +	-o)
> +		overwrite=1
> +		shift
> +		shift
> +		;;
> +	--)
> +		shift
> +		break
> +		;;
> +	*)
> +		break
> +		exit 1
> +		;;
> +	esac
> +done

I haven't tried this patch, but would this work well with options
meant for the 'git rev-list --parents "$@"' that grabs the list of
merge commits to learn from?  e.g.

	$ contrib/rerere-train.sh -n 4 --merges master
	$ contrib/rerere-train.sh --overwrite -n 4 --merges master
	$ contrib/rerere-train.sh -n 4 --overwrite --merges master

I do not think it is necessary to make the last one work; as long as
the first two work as expected, we are good even if the last one
dies with a sensible message e.g. "options X, Y and Z must be given
before other options" (currently "X, Y and Z" consists only of
"--overwrite", but I think you get what I mean).

>  . "$(git --exec-path)/git-sh-setup"
>  require_work_tree
>  cd_to_toplevel
> @@ -34,6 +62,10 @@ do
>  		# Cleanly merges
>  		continue
>  	fi
> +	if [ $overwrite == 1 ]

	if test "$overwrite" = 1

cf. Documentation/CodingGuidelines.

> +	then
> +		git rerere forget .
> +	fi
>  	if test -s "$GIT_DIR/MERGE_RR"
>  	then
>  		git show -s --pretty=format:"Learning from %h %s" "$commit"
