Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5125D1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 17:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfFJRRs (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:17:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58660 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfFJRRs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:17:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1AAE26993E;
        Mon, 10 Jun 2019 13:17:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=160f+YzBlkO4PB3WfvILwOIScIY=; b=a7XxAK
        A5qQOnBmiMj7mFI/VuSlTj6cZ095/ijPxuBuxTKgViiJFfa+KjZMClm87CbU4KGA
        H8zo+BFPbQWeQzbef+wADjytnlwloM+tG96velz3EpzARet2a+bGBcgMvAA41IWx
        u5sOF/r6uvHLZbLjhzHpUrJs6GXwpFWsCFOhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OY02ZZz/pGvKkHt5N+8vsAtxzrslYdFU
        UQRxac78AxOI44riTHpqqqE9xDOHhiUVNmSryHCShgT1lA0wN84xbaGqsPgpI95/
        1HN5xMg/J4Kgd8VxIGqKabDTIZFY6SUhs+fvveNUIRsa6Exx7ycf6VzWFVg50TOp
        jrbS92zZjqQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 135E16993D;
        Mon, 10 Jun 2019 13:17:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 390006993C;
        Mon, 10 Jun 2019 13:17:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] mergetool: dissect strings with shell variable magic instead of `expr`
References: <cover.1560152205.git.j6t@kdbg.org>
        <2a33ca20af41d68a5bb4e2cf1e5ae32fddf2796c.1560152205.git.j6t@kdbg.org>
Date:   Mon, 10 Jun 2019 10:17:41 -0700
In-Reply-To: <2a33ca20af41d68a5bb4e2cf1e5ae32fddf2796c.1560152205.git.j6t@kdbg.org>
        (Johannes Sixt's message of "Mon, 10 Jun 2019 10:58:59 +0200")
Message-ID: <xmqqblz5nyve.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A862D5B4-8BA3-11E9-9F33-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> git-mergetool spawns an enormous amount of processes. For this reason,
> the test script, t7610, is exceptionally slow, in particular, on
> Windows. Most of the processes are invocations of git, but there are
> also some that can be replaced with shell builtins. Do so with `expr`.

I see these as improvements independent of whatever test may or may
not be slow ;-)  s/^.*/but there are/There are/.  Thanks for working
on it.

>  checkout_staged_file () {
> -	tmpfile=$(expr \
> -		"$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" \
> -		: '\([^	]*\)	')

So this wants to grab leading non-HT substring that comes before an
HT; we are trying to grab the name of the temorary picked by the
checkout-index command, the output is ".merge_file_XXXXXX" followed
by HT followed by the original filename "$2".

> +	tmpfile="$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" &&
> +	tmpfile=${tmpfile%%'	'*}

And this obviously is an equivalent, at least in the successful
case.  The ".merge_file_XXXXXX" temporary filename never has HT in
it, and we are stripping everything after the first HT.

And this rewrite makes the error behaviour much better.  In the
original, the exit code checked in the next "if test $? -eq 0" is
that of "expr" (i.e. does the pattern match?); with this version, we
are looking at the exit status of the checkout-index command.

Good.

> @@ -255,13 +254,16 @@ merge_file () {
>  		return 1
>  	fi
>  
> -	if BASE=$(expr "$MERGED" : '\(.*\)\.[^/]*$')
> -	then
> -		ext=$(expr "$MERGED" : '.*\(\.[^/]*\)$')
> -	else
> +	# extract file extension from the last path component
> +	case "${MERGED##*/}" in
> +	*.*)
> +		ext=.${MERGED##*.}
> +		BASE=${MERGED%"$ext"}

This rewrite can potentially change the behaviour, when $ext has
glob metacharacters.  Wouldn't BASE=${MERGED%.*} be more faithful
conversion?

> +		;;
> +	*)
>  		BASE=$MERGED
>  		ext=
> -	fi
> +	esac
> @@ -406,7 +408,7 @@ main () {
>  		-t|--tool*)
>  			case "$#,$1" in
>  			*,*=*)
> -				merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
> +				merge_tool=${1#*=}

OK, we strip leading substring before the first '=' out of "$1" and
the case/esac ensures that there is such an equal '=' sign in "$1",
so the rewrite is correct.

Looks good.  Thanks.


