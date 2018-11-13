Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2691F1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 02:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeKMMsV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 07:48:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64956 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeKMMsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 07:48:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD926112D2D;
        Mon, 12 Nov 2018 21:52:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=41O4e/bKVm6Bv52nScYLQnIO/Zg=; b=lgvHM1
        0dCoBfQ7c1vwiHvY5hqVwywIXe1RViFwJHsGj7u/zbqCS5tzqjo3jz0lKiEuI+6p
        65Xy/fpkedlEBwXH3rSlXeaLbSR2IukwVEYW65PU62RTbbo3vqy7cLbUXUS7w7T0
        mxMWNwmZzr1pL+J6Mt5BpEZ18D1OGLnpugVjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TSr2WWL/a2gYt5R/gcXl9AHjd5+o18Ol
        SFMKx4zJbAcK2hzbEdzGqHn7WvbvoJ1jvpNZsMqAcOB2TCqIsXIu8qDYtBbg5OKq
        6CJCl4eXh7h3DZsS+6k7EXdmqgoGBItUzVzb1UcWepkE2K3VoqKlZQY0Ypmeve+s
        qF/ZVfsi/6U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B60FA112D2C;
        Mon, 12 Nov 2018 21:52:13 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DF73112D2B;
        Mon, 12 Nov 2018 21:52:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: die on server-side errors
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
Date:   Tue, 13 Nov 2018 11:52:12 +0900
In-Reply-To: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
        (steadmon's message of "Mon, 12 Nov 2018 14:44:56 -0800")
Message-ID: <xmqqbm6ty9ib.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F54A346-E6EF-11E8-8382-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

steadmon@google.com writes:

> When a smart HTTP server sends an error message via pkt-line,
> remote-curl will fail to detect the error (which usually results in
> incorrectly falling back to dumb-HTTP mode).
>
> This patch adds a check in discover_refs() for server-side error
> messages, as well as a test case for this issue.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  remote-curl.c                   | 4 +++-
>  t/lib-httpd.sh                  | 1 +
>  t/lib-httpd/apache.conf         | 4 ++++
>  t/lib-httpd/error-smart-http.sh | 3 +++
>  t/t5551-http-fetch-smart.sh     | 5 +++++
>  5 files changed, 16 insertions(+), 1 deletion(-)
>  create mode 100644 t/lib-httpd/error-smart-http.sh
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 762a55a75f..bb3a86505e 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -436,7 +436,9 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  	} else if (maybe_smart &&
>  		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
>  		last->proto_git = 1;
> -	}
> +	} else if (maybe_smart && last->len > 5 &&
> +		   starts_with(last->buf + 4, "ERR "))
> +		die(_("remote error: %s"), last->buf + 8);

Two observations and a half.

 - All of these if/else if/ blocks (currently 2, now you added the
   third one) are to special case the "maybe_smart" case.  Perhaps
   the whole thing should be restrucutred to

	if (maybe_smart) {
		if ...
		else if ...
		else if ...
	}

 - All conditions skip the first four bytes in last->buf and does
   starts_with (the first branch is "starts_with("#") in disguise).
   Can we do something to the hardcoded magic number 4, which looks
   somewhat irritating?

 - This is less of the problem with the suggested change in the
   first bullet item above, but the current code structure makes
   readers wonder if maybe_start that starts as 1 is turned off
   somewhere in the if/else if/ cascade when we find out that we are
   not dealing with smart HTTP after all.  That however is not what
   is happening.  The "maybe" variable is primarily there to avoid
   repeating the logic that determined its initial value in the
   early part of the function.  The last->proto_git field is used to
   record if we are using smart HTTP or not.

Otherwise the change looks sensible.


> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index a8729f8232..4e946623bb 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -131,6 +131,7 @@ prepare_httpd() {
>  	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
>  	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
>  	install_script broken-smart-http.sh
> +	install_script error-smart-http.sh
>  	install_script error.sh
>  	install_script apply-one-time-sed.sh
>  
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 581c010d8f..6de2bc775c 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -117,6 +117,7 @@ Alias /auth/dumb/ www/auth/dumb/
>  </LocationMatch>
>  ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
>  ScriptAlias /broken_smart/ broken-smart-http.sh/
> +ScriptAlias /error_smart/ error-smart-http.sh/
>  ScriptAlias /error/ error.sh/
>  ScriptAliasMatch /one_time_sed/(.*) apply-one-time-sed.sh/$1
>  <Directory ${GIT_EXEC_PATH}>
> @@ -125,6 +126,9 @@ ScriptAliasMatch /one_time_sed/(.*) apply-one-time-sed.sh/$1
>  <Files broken-smart-http.sh>
>  	Options ExecCGI
>  </Files>
> +<Files error-smart-http.sh>
> +	Options ExecCGI
> +</Files>
>  <Files error.sh>
>    Options ExecCGI
>  </Files>
> diff --git a/t/lib-httpd/error-smart-http.sh b/t/lib-httpd/error-smart-http.sh
> new file mode 100644
> index 0000000000..0a1af318f7
> --- /dev/null
> +++ b/t/lib-httpd/error-smart-http.sh
> @@ -0,0 +1,3 @@
> +printf "Content-Type: text/%s\n" "html"
> +echo
> +printf "%s" "0019ERR server-side error"
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 8630b0cc39..ba83e567e5 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -429,5 +429,10 @@ test_expect_success 'GIT_TRACE_CURL_NO_DATA prevents data from being traced' '
>  	! grep "=> Send data" err
>  '
>  
> +test_expect_success 'server-side error detected' '
> +	test_must_fail git clone $HTTPD_URL/error_smart/repo.git 2>actual &&
> +	grep "server-side error" actual
> +'
> +
>  stop_httpd
>  test_done
