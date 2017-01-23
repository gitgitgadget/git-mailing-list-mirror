Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427BB20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdAWSur (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:50:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60794 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750705AbdAWSuq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:50:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B51AB61A7F;
        Mon, 23 Jan 2017 13:50:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oRfC1eyGGwqdpAXf+uOoUVJLYCg=; b=itM1ui
        1MkNeIRUestAZ6HfgaZGkLLWOJWiBLgVykKDoXfPnkGm/COK7XYG7/xUztb4CmmT
        DoWNrgNz8+4I6u2/HuOe4+6tSsq+nA0E0T6f+ABPavMw28J68lNlTwqKOo0vsEZJ
        5BcgFZW+OtpnXttoRFqkGOVvhrbXCmXwwAqE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OfJbrM2GPA5jRsgK80XXnI+ifJ7rwwCK
        euLos3EwyxZKRralzD/vlp+VzGkIzGG3v3Jr0ReTSISJhnshq28debpkSkv1suKx
        IsaQksWmmaiL2Bq4pdpNNpuieVXp+gBXBEZk7ns7O385a/jM7GxRnbO6HFdVz7Mb
        2d+HpdA39uE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BE0961A7E;
        Mon, 23 Jan 2017 13:50:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1FBD61A7D;
        Mon, 23 Jan 2017 13:50:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] stash: support filename argument
References: <20170121200804.19009-1-t.gummerer@gmail.com>
        <20170121200804.19009-4-t.gummerer@gmail.com>
Date:   Mon, 23 Jan 2017 10:50:43 -0800
In-Reply-To: <20170121200804.19009-4-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sat, 21 Jan 2017 20:08:04 +0000")
Message-ID: <xmqqinp5sj98.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8B24D2A-E19C-11E6-8A57-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> diff --git a/git-stash.sh b/git-stash.sh
> index d6b4ae3290..7dcce629bd 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -41,7 +41,7 @@ no_changes () {
>  untracked_files () {
>  	excl_opt=--exclude-standard
>  	test "$untracked" = "all" && excl_opt=
> -	git ls-files -o -z $excl_opt
> +	git ls-files -o -z $excl_opt -- $1

Does $1 need to be quoted to prevent it from split at $IFS?

> @@ -56,6 +56,23 @@ clear_stash () {
>  }
>  
>  create_stash () {
> +	files=
> +	while test $# != 0
> +	do
> +		case "$1" in
> +		--)
> +			shift
> +			break
> +			;;
> +		--files)
> +			;;
> +		*)
> +			files="$1 $files"
> +			;;

Hmph.  What is this "no-op" option about?  Did you mean to say
something like this instead?

	case "$1" in
	...
	--file)
		case $# in
		1)
			die "--file needs a pathspec" ;;
		*)
			shift
			files="$files$1 " ;;
		esac
		;;


Another thing I noticed.  We won't support filenames with embedded
$IFS characters at all?

I somehow had an impression that the script was carefully done
(e.g. by using -z option where appropriate) to add such a
limitation.

Perhaps we have broken it over time and it no longer matters
(i.e. there already may be existing breakages), but this troubles
me somehow.

By the way, in addition to "push" thing that corrects the argument
convention by requiring "-m" before the message, we need to correct
create_stash that is used internally from "stash push" somehow?
