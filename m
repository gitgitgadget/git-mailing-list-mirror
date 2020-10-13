Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB084C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4321820878
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 20:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VzhhZFuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgJMUk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 16:40:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52984 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgJMUk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 16:40:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2884F101AA0;
        Tue, 13 Oct 2020 16:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=faTVvb2066n3j+m+Z6lQj+1czZA=; b=VzhhZF
        uRZMCtCGa8JxPhOyTPsruycdRtuEkirb0d5tHy8okKB/ZKoiB7MzFhqWsj09Y7M8
        WxHAOtM7gRlwIfNLoT8yTtgshB4wvRDoTnGTtDlYeDHiyy6TNiS3NQsHWb8IwlTB
        RHmWz2V8q42jiBSPZRxmf3ye7SDfdoilvQpxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SDKo+022WcJKVvjtsimH5IPp578nMV/p
        zQb3iJkSzEDJVijRnpa5Q7YjHrE6ziSlRBbGhPi6NwY93veffM9VDDDSQu7BVCPI
        dCL0cqqtVxcmAVLek/GMGDiRNJhgOtmzIRlMUPBbcBWTaau9sil74mjTUPQJSWQI
        3lEzDz1kBJw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21355101A9F;
        Tue, 13 Oct 2020 16:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C8BC101A9E;
        Tue, 13 Oct 2020 16:40:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean McAllister <smcallis@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, masayasuzuki@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 1/3] remote-curl: add testing for intelligent retry
 for HTTP
References: <20201013191729.2524700-1-smcallis@google.com>
Date:   Tue, 13 Oct 2020 13:40:18 -0700
In-Reply-To: <20201013191729.2524700-1-smcallis@google.com> (Sean McAllister's
        message of "Tue, 13 Oct 2020 13:17:27 -0600")
Message-ID: <xmqqblh5kggd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5007E048-0D94-11EB-91E6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean McAllister <smcallis@google.com> writes:

> +# generate a process unique one-up value
> +global_counter_for_nonce=0
> +gen_nonce () {
> +	global_counter_for_nonce=$((global_counter_for_nonce + 1)) &&
> +	echo "$global_counter_for_nonce"
> +}

This must not be called in a subprocess if the caller truly wants
uniqueness.  May want to be described in a comment.

> diff --git a/t/lib-httpd/error-ntime.sh b/t/lib-httpd/error-ntime.sh
> new file mode 100755
> index 0000000000..64dc878746
> --- /dev/null
> +++ b/t/lib-httpd/error-ntime.sh
> @@ -0,0 +1,80 @@
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

I thought "error codes" were rephrased after the first round's
review to some other term (which I do not recall--was it status?)?

> +print_status() {
> +	if [ "$1" -eq "302" ]; then
> +		printf "Status: 302 Found\n"
> +	elif [ "$1" -eq "429" ]; then
> +		printf "Status: 429 Too Many Requests\n"
> +	elif [ "$1" -eq "502" ]; then
> +		printf "Status: 502 Bad Gateway\n"
> +	elif [ "$1" -eq "503" ]; then
> +		printf "Status: 503 Service Unavailable\n"
> +	elif [ "$1" -eq "504" ]; then
> +		printf "Status: 504 Gateway Timeout\n"
> +	else
> +		printf "Status: 500 Internal Server Error\n"
> +	fi
> +	printf "Content-Type: text/plain\n"
> +}

Style (Documentation/CodingGuidelines).

	print_status () {
		if test "$1" = "302"
		then
			printf "...";
		...
	}

but in this particular case, I do not see why we want if/else
cascade.  Perhaps

	print_status () {
		case "$1" in
		302)	printf "Status: 302 Found\n" ;;
		429)	... ;;
		...
		*)	printf "Status: 500 Internal Server Error\n" ;;
		esac
		printf "Content-Type: text/plain\n";
	}

would be more standard?

Also I am not sure why we want "printf ...\n" not "echo" here.  If
we want to talk HTTP ourselves strictly, I would understand avoiding
"echo" and doing "printf ...\r\n", though.  If we fear DOS line
endings coming out of localized "echo", and ensure we use LF line
ending even on Windows and Cygwin, it is sort of understandable but
if that is what is going on, that does not explain a lone "echo"
at the end of the caller.

Puzzled.

  +oIFS="$IFS"
> +IFS='/'
> +set -f
> +set -- $PATH_INFO
> +set +f
  +IFS="$oIFS"
> +
> +# pull out first four path components
> +shift
> +nonce=$1
> +times=$2
> +code=$3
> +retry=$4
> +shift 4
> +
> +# glue the rest back together as redirect path
> +path=""
> +while [ "$#" -gt "0" ]; do
> +	path="${path}/$1"
> +	shift
> +done

Hmph.  Would this work better, I wonder?

	path=${PATH_INFO#*/}	;# discard leading '/'
	nonce=${path%%/*}	path=${path#*/}
	times=${path%%/*}	path=${path#*/}
	code=${path%%/*}	path=${path#*/}
	retry=${path%%/*}	path=${path#*/}

At least it is shorter and easier to read.

> +# leave a cookie for this request/retry count
> +state_file="request_${REMOTE_ADDR}_${nonce}_${times}_${code}_${retry}"
> +
> +if [ ! -f "$state_file" ]; then
> +	echo 0 > "$state_file"
> +fi

Style (Documentation/CodingGuidelines, look for "For shell scripts
specifically").

 - use "test" not "[]";

 - don't write ";then" on the same line (rule of thumb. you should
   be able to write your shell scripts without semicolon except for
   double-semicolons in case/esac statements)

 - don't leave SP between redirection operator '>' and its target
   file, i.e. write 'echo 0 >"$state_file"'.

> +read -r cnt < "$state_file"
> +if [ "$cnt" -lt "$times" ]; then
> +	echo $((cnt+1)) > "$state_file"
> +
> +	# return error
> +	print_status "$code"
> +	if [ "$retry" -ge "0" ]; then
> +		printf "Retry-After: %s\n" "$retry"
> +	fi
> +else
> +	# redirect
> +	print_status 302
> +	printf "Location: %s?%s\n" "$path" "${QUERY_STRING}"
> +fi
> +
> +echo

This "echo" to the client also puzzles me further, after seeing
puzzling use of "printf ...\n" earlier.

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 7df3c5373a..72aaed5a93 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -756,6 +756,15 @@ test_expect_success 'partial clone using HTTP' '
>  	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
>  '
>  
> +test_expect_success 'partial clone using HTTP with redirect' '
> +	_NONCE=`gen_nonce` && export _NONCE &&
> +	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
> +	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
> +	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&

Why do we need to test "curl" here?  Is this remnant of debugging of
the server side?

> +	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server"
> +'
> +
> +
>  # DO NOT add non-httpd-specific tests here, because the last part of this
>  # test script is only executed when httpd is available and enabled.
