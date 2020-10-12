Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54444C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033D520BED
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eyCtj1Hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgJLUvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:51:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52466 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJLUvu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:51:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4CE469254;
        Mon, 12 Oct 2020 16:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zwaeU31NzImo3PYrWaPw9qOhcJY=; b=eyCtj1
        HuFnl2BGYMvl3lIPsHnLfklk0aLbdstDroAkriQm3ccX1JR94ltytfhYngVqG1sN
        smLPISR2vYDfDSdkWgKeFjQ3UAzYLRM0WJrrBAfJwkrgZ73iAb3qPBkFL4ODg7OU
        9sGB/kSphbMooT73/9G5CXrzhhZX2521jj6wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w593ZU5tyPeVnE4FnTxVrU2ezGFFFDfN
        iUbPZImKMG4zMtYXwSNxGjiOqYOkGf/sOU+GjpHLCiKwdUtCKRKnpl8GvF4V0FMb
        kUdOtp4fcjQQstvDA54GprnRfeQGglALoT6ot3I9dCfe+BzW7Dd279hzD+uXefc6
        Qi413zyfu0Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA46869252;
        Mon, 12 Oct 2020 16:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4862469251;
        Mon, 12 Oct 2020 16:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean McAllister <smcallis@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, masayasuzuki@google.com
Subject: Re: [PATCH] remote-curl: add testing for intelligent retry for HTTP
References: <20201012184806.166251-1-smcallis@google.com>
        <20201012201940.229694-1-smcallis@google.com>
Date:   Mon, 12 Oct 2020 13:51:44 -0700
In-Reply-To: <20201012201940.229694-1-smcallis@google.com> (Sean McAllister's
        message of "Mon, 12 Oct 2020 14:19:40 -0600")
Message-ID: <xmqqy2kbmalb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD43D022-0CCC-11EB-877B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean McAllister <smcallis@google.com> writes:

> +# generate a random 12 digit string
> +gen_nonce() {
> +    test_copy_bytes 12 < /dev/urandom | tr -dc A-Za-z0-9
> +}

What is the randomness requirement of this application?  IOW, what
breaks if we just change this to "echo 0123456789ab"?

Or "date | git hash-object --stdin" for that matter?

We'd want to make our tests more predictiable, not less.

> diff --git a/t/lib-httpd/error-ntime.sh b/t/lib-httpd/error-ntime.sh
> new file mode 100755
> index 0000000000..e4f91ab816
> --- /dev/null
> +++ b/t/lib-httpd/error-ntime.sh
> @@ -0,0 +1,79 @@
> +#!/bin/sh
> +
> +# Script to simulate a transient error code with Retry-After header set.
> +#
> +# PATH_INFO must be of the form /<nonce>/<times>/<retcode>/<retry-after>/<path>
> +#   (eg: /dc724af1/3/429/10/some/url)
> +#
> +# The <nonce> value uniquely identifies the URL, since we're simulating
> +# a stateful operation using a stateless protocol, we need a way to "namespace"
> +# URLs so that they don't step on each other.
> +#
> +# The first <times> times this endpoint is called, it will return the given
> +# <retcode>, and if the <retry-after> is non-negative, it will set the
> +# Retry-After head to that value.
> +#
> +# Subsequent calls will return a 302 redirect to <path>.
> +#
> +# Supported error codes are 429,502,503, and 504
> +
> +print_status() {
> +      if [ "$1" -eq "302" ]; then printf "Status: 302 Found\n"
> +    elif [ "$1" -eq "429" ]; then printf "Status: 429 Too Many Requests\n"
> +    elif [ "$1" -eq "502" ]; then printf "Status: 502 Bad Gateway\n"
> +    elif [ "$1" -eq "503" ]; then printf "Status: 503 Service Unavailable\n"
> +    elif [ "$1" -eq "504" ]; then printf "Status: 504 Gateway Timeout\n"
> +    else
> +        printf "Status: 500 Internal Server Error\n"
> +    fi
> +    printf "Content-Type: text/plain\n"

Style????? (I won't repeat this comment for the rest of this script)

I briefly wondered "oh, are t/lib-httpd/* scripts excempt from the
coding guidelines?" but a quick look at them tells me that that is
not the case.

> +}
> +
> +# read in path split into cmoponents
> +IFS='/'
> +tokens=($PATH_INFO)
> +
> +# break out code/retry parts of path
> +nonce=${tokens[1]}
> +times=${tokens[2]}
> +code=${tokens[3]}
> +retry=${tokens[4]}

You said /bin/sh upfront.  Don't use non-POSIX shell arrays.

> +
> +# get redirect path
> +cnt=0
> +path=""
> +for ((ii=0; ii < ${#PATH_INFO}; ii++)); do
> +    if [ "${PATH_INFO:${ii}:1}" == "/" ]; then
> +        let cnt=${cnt}+1
> +    fi
> +    if [ "${cnt}" -eq 5 ]; then
> +        path="${PATH_INFO:${ii}}"
> +        break
> +    fi
> +done
> +
> +# leave a cookie for this request/retry count
> +state_file="request_${REMOTE_ADDR}_${nonce}_${times}_${code}_${retry}"
> +
> +if [ ! -f "$state_file" ]; then
> +    echo 0 > "$state_file"
> +fi
> +
> +
> +read cnt < "$state_file"
> +if [ "$cnt" -lt "$times" ]; then
> +    let cnt=cnt+1
> +    echo "$cnt" > "$state_file"
> +
> +    # return error
> +    print_status "$code"
> +    if [ "$retry" -ge "0" ]; then
> +        printf "Retry-After: %s\n" "$retry"
> +    fi
> +else
> +    # redirect
> +    print_status 302
> +    printf "Location: %s?%s\n" "$path" "${QUERY_STRING}"
> +fi
> +
> +echo
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 7df3c5373a..71d4307001 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -756,6 +756,15 @@ test_expect_success 'partial clone using HTTP' '
>  	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
>  '
>  
> +test_expect_success 'partial clone using HTTP with redirect' '
> +    _NONCE=`gen_nonce` && export _NONCE &&
> +    curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
> +    curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
> +    curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&

These lines are not indented with HT?

Don't redirect test output to /dev/null, which is done by test_expect_success
for us.  >/dev/null makes it less useful to run the test under "-v" option.

> +	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server"
> +'
> +
> +
>  # DO NOT add non-httpd-specific tests here, because the last part of this
>  # test script is only executed when httpd is available and enabled.
