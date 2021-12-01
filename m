Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B56C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 23:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245603AbhLAXRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 18:17:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57064 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245055AbhLAXRE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 18:17:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD947173BD6;
        Wed,  1 Dec 2021 18:13:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mhtTpmfv3Agcifa1QdtlVxpPtqkvSnf84GeLI4
        GtkeE=; b=IfAFGKAjL+q7rrkV4zNtVy0aBjwrTsPq4ixxxlF4ELZ/On3AdKxs8z
        ynuvUXWaOILdvU85jZ6Frw6KfUrm5Og2OaY2qgAZkz1LKAK4KbN0xcbdVGMV8Y+n
        //FDQm8c7SY7EGjZ61RkM9E24t0TNlzSxDTvfYp1kqXj6T4alq8mA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5D33173BD5;
        Wed,  1 Dec 2021 18:13:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6E694173BD4;
        Wed,  1 Dec 2021 18:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] test-lib: make BAIL_OUT() work in tests and prereq
References: <20211120150401.254408-1-fs@gigacodes.de>
        <20211201085315.576865-1-fs@gigacodes.de>
        <20211201085315.576865-4-fs@gigacodes.de>
Date:   Wed, 01 Dec 2021 15:13:35 -0800
In-Reply-To: <20211201085315.576865-4-fs@gigacodes.de> (Fabian Stelzer's
        message of "Wed, 1 Dec 2021 09:53:15 +0100")
Message-ID: <xmqqv907yl40.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5055C99E-52FC-11EC-9E3A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> BAIL_OUT() is meant to abort the whole test run and print a message with
> a standard prefix that can be parsed to stdout. Since for every test the
> normal fd`s are redirected in test_eval_ this output would not be seen
> when used within the context of a test or prereq like we do in
> test_have_prereq(). To make this function work in these contexts we move
> the setup of the fd aliases a few lines up before the first use of
> BAIL_OUT() and then have this function always print to the alias.
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  t/test-lib.sh | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9090ce1225..14a7aeae0f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -589,6 +589,15 @@ USER_TERM="$TERM"
>  TERM=dumb
>  export TERM USER_TERM
>  
> +# What is written by tests to stdout and stderr is sent so different places

"sent so" -> "sent to".  I'll tweak locally, so no need to resend.

> +# depending on the test mode (e.g. /dev/null in non-verbose mode, piped to tee
> +# with --tee option, etc.). We save the original stdin to FD #6 and stdout and
> +# stderr to #5 and #7, so that the test framework can use them (e.g. for
> +# printing errors within the test framework) independently of the test mode.
> +exec 5>&1
> +exec 6<&0
> +exec 7>&2
> +
>  _error_exit () {
>  	finalize_junit_xml
>  	GIT_EXIT_OK=t
> @@ -612,7 +621,7 @@ BAIL_OUT () {
>  	local bail_out="Bail out! "
>  	local message="$1"
>  
> -	say_color error $bail_out "$message"
> +	say_color error $bail_out "$message" >&5

This is merely a style thing, but as commands get longer, it becomes
easier to spot redirection if it is written immediately after the
verb, i.e.

	say_color >&5 error $bail_out "$message"

>  	_error_exit
>  }
>  
> @@ -637,9 +646,6 @@ then
>  	exit 0
>  fi
>  
> -exec 5>&1
> -exec 6<&0
> -exec 7>&2
>  if test "$verbose_log" = "t"
>  then
>  	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3

Looks good.  Thanks.
