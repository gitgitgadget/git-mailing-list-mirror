Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282E4C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 16:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbiGNQOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiGNQOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 12:14:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2397361D5A
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 09:14:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D16E142F5F;
        Thu, 14 Jul 2022 12:14:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NfUXLbzdIWWwQdzqgrS/uZJrwocTqDa0EACi6I
        TlSaU=; b=qOCS8JX82Nls0nWKyIGWJadPuJmqAlRMuFvCTQYom3k9RcOOc2Udsd
        /Oaz6ntpNdXOrQlcWZ7UG9Su48DFoVaHOSJWOInb9DrdxW+iXTWButSFdUgaBfVU
        3htM63/7NVS4vgMp5aPls9VFhfysi/M0OOC1zQ8I+OB1xn7M6Qxmk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4606F142F5E;
        Thu, 14 Jul 2022 12:14:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7F51142F5D;
        Thu, 14 Jul 2022 12:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] tests: fix incorrect --write-junit-xml code
References: <pull.1288.git.1657789234416.gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 09:14:20 -0700
In-Reply-To: <pull.1288.git.1657789234416.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 14 Jul 2022 09:00:34
        +0000")
Message-ID: <xmqq35f38yeb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05504B96-0390-11ED-9C58-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     Unfortunately, I noticed this regression no earlier than when I needed
>     to validate Git for Windows v2.37.1. Since v2.37.1 was an embargoed
>     release, I could not use GitHub Actions for the CI testing, so I had to
>     reinstate Git's Azure Pipeline.

I wonder if it would make your life easier if the same GitHub
Actions CI stuff were available for the Cabal repository we use for
embargoed work, by allowing you to use the same validation for usual
releases and the enbargoed ones?

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  t/test-lib-junit.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
> index c959183c7e2..79c31c788b9 100644
> --- a/t/test-lib-junit.sh
> +++ b/t/test-lib-junit.sh
> @@ -46,7 +46,7 @@ finalize_test_case_output () {
>  	shift
>  	case "$test_case_result" in
>  	ok)
> -		set "$*"
> +		set -- "$*"
>  		;;
>  	failure)
>  		junit_insert="<failure message=\"not ok $test_count -"
> @@ -65,17 +65,17 @@ finalize_test_case_output () {
>  			junit_insert="$junit_insert<system-err>$(xml_attr_encode \
>  				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
>  		fi
> -		set "$1" "      $junit_insert"
> +		set -- "$1" "      $junit_insert"
>  		;;
>  	fixed)
> -		set "$* (breakage fixed)"
> +		set -- "$* (breakage fixed)"
>  		;;
>  	broken)
> -		set "$* (known breakage)"
> +		set -- "$* (known breakage)"
>  		;;
>  	skip)
>  		message="$(xml_attr_encode --no-lf "$skipped_reason")"
> -		set "$1" "      <skipped message=\"$message\" />"
> +		set -- "$1" "      <skipped message=\"$message\" />"
>  		;;
>  	esac

OK.  Ancient shells did not understand "--" and it was idiomatic to
say "set x ...; shift", but we already do assume "set --" is usable
everywhere we care about in many of our scripts and tests.

Looks good to me.

Thanks.  Will queue.
