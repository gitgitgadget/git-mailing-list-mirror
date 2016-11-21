Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F251FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 21:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754246AbcKUVE6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 16:04:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61119 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753671AbcKUVE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 16:04:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 926BA5079F;
        Mon, 21 Nov 2016 16:04:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eupJ3IpqX3zuf5AJ+VndMmkDeJA=; b=fw5mfN
        xbrgiYj/11NivxzgCr0DXiERdHOn3SovJ8ipNXfRt28RMh2ewx8D8bjO/J0WF0vs
        8LT/Xp4PhmLRbmZpHeEF5ihfTULv5FPmBIvW4QcDzlb8hwocs0iTX+T/kRBdELPz
        aBwnm8+iYRYrL0YUK61XjULEY6lBwquuBzzfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dz3bdJkxYIrI+5wzgnk4dXtQfcAtCcU6
        DgsjZp2/MEV+mxq6INiMbmNaJriAB1xqXKddtNpUZ5loCuoeUfxSJQ4Zx5ZQ/TLB
        XDK40V4khEnmST+xGFz2ahyaqO1piHfPPys5jl1BkrSCAXTzb9L//nStESO81MLq
        aJrHEpiYOxI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A4145079E;
        Mon, 21 Nov 2016 16:04:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A9855079D;
        Mon, 21 Nov 2016 16:04:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, jrnieder@gmail.com, git@vger.kernel.org,
        Jens.Lehmann@web.de, hvoigt@hvoigt.net
Subject: Re: [PATCH 2/3] test-lib-functions.sh: teach test_commit -C <dir>
References: <20161121204146.13665-1-sbeller@google.com>
        <20161121204146.13665-3-sbeller@google.com>
Date:   Mon, 21 Nov 2016 13:04:55 -0800
In-Reply-To: <20161121204146.13665-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 21 Nov 2016 12:41:45 -0800")
Message-ID: <xmqq37ikilxk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27A10520-B02E-11E6-9E57-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Specifically when setting up submodule tests, it comes in handy if
> we can create commits in repositories that are not at the root of
> the tested trash dir. Add "-C <dir>" similar to gits -C parameter
> that will perform the operation in the given directory.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Looks useful.

>  t/test-lib-functions.sh | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index fdaeb3a96b..579e812506 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -157,16 +157,21 @@ debug () {
>  	 GIT_TEST_GDB=1 "$@"
>  }
>  
> -# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
> +# Call test_commit with the arguments
> +# [-C <directory>] <message> [<file> [<contents> [<tag>]]]"
>  #
>  # This will commit a file with the given contents and the given commit
>  # message, and tag the resulting commit with the given tag name.
>  #
>  # <file>, <contents>, and <tag> all default to <message>.
> +#
> +# If the first argument is "-C", the second argument is used as a path for
> +# the git invocations.
>  
>  test_commit () {
>  	notick= &&
>  	signoff= &&
> +	indir= &&
>  	while test $# != 0
>  	do
>  		case "$1" in
> @@ -176,21 +181,26 @@ test_commit () {
>  		--signoff)
>  			signoff="$1"
>  			;;
> +		-C)
> +			indir="$2"
> +			shift
> +			;;
>  		*)
>  			break
>  			;;
>  		esac
>  		shift
>  	done &&
> +	indir=${indir:+"$indir"/} &&
>  	file=${2:-"$1.t"} &&
> -	echo "${3-$1}" > "$file" &&
> -	git add "$file" &&
> +	echo "${3-$1}" > "$indir$file" &&
> +	git ${indir:+ -C "$indir"} add "$file" &&
>  	if test -z "$notick"
>  	then
>  		test_tick
>  	fi &&
> -	git commit $signoff -m "$1" &&
> -	git tag "${4:-$1}"
> +	git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
> +	git ${indir:+ -C "$indir"} tag "${4:-$1}"
>  }
>  
>  # Call test_merge with the arguments "<message> <commit>", where <commit>
