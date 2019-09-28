Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7051F463
	for <e@80x24.org>; Sat, 28 Sep 2019 22:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfI1WXF (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 18:23:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59090 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfI1WXF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 18:23:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A1313DE2C;
        Sat, 28 Sep 2019 18:23:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+WoXlztHGQgsTmyvO14+4jdCfsE=; b=Hk7jt+
        yCX2GFhqSV9CSxWncuwfXBWCMuJBWllLtQ8o822vEGoIcHR0nBvLwqx7eqlJ4FaT
        V7dvnh+0BuT9oO1oZcZ/GwzgVqnvfX2/gVowhiU22X1L4OrAaGMoVrSev/JwQ9Eu
        n3kUOulhhz38VfAPOo9umSqFKklyRr0k0nDvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yZq5/IEg4mVcxVNmRR3PSqSN6JxjgLih
        pSnagX1ZQyT37Aq2MOPyoTMs0iJYT/HVut6iBUIdPyPFz5NjWCufa9IVxrogsV3Y
        772Hkyl+shHM9j5EY6tSbUTrv0JcuB59DcCtGZxlz71mn0THKzQ7y3NAduGH4B6k
        l0TAB4wk+gI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F36663DE2B;
        Sat, 28 Sep 2019 18:22:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4409F3DE2A;
        Sat, 28 Sep 2019 18:22:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/13] tests: let --immediate and --write-junit-xml play well together
References: <pull.288.git.gitgitgadget@gmail.com>
        <99724f6a1e45b497e15037bbac1cb5f70a3bb236.1569486607.git.gitgitgadget@gmail.com>
Date:   Sun, 29 Sep 2019 07:22:58 +0900
In-Reply-To: <99724f6a1e45b497e15037bbac1cb5f70a3bb236.1569486607.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 26 Sep 2019
        01:30:22 -0700 (PDT)")
Message-ID: <xmqq7e5sjc1p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 870A1DB8-E23E-11E9-8273-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index d1ba33745a..f21c781e68 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -695,7 +695,7 @@ test_failure_ () {
>  	say_color error "not ok $test_count - $1"
>  	shift
>  	printf '%s\n' "$*" | sed -e 's/^/#	/'
> -	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
> +	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
>  }

There are three places that do GIT_EXIT_OK=t in the test framework,
and the above covers one of them.  The original in test_done is
another, and that place is made to call the "finalize" thing (it
used to have the same finalization code inlined).

The remaining one appears in

        error () {
                say_color error "error: $*"
                GIT_EXIT_OK=t
                exit 1
        }

I wonder if we should cover this case, too.  One caller of "error" I
know is BUG that says "bug in the test script", which means that
after successfully passing 30 tests, when the 31st test has 5 params
to test_expect_success by mistake, without finailzation we will lose
the result for the first 30.

And if we call "finalize" from the "error" helper, perhaps it makes
even more sense to update the above manual exit in test_failure_ to
do something like

	if test -n "$immediate"
	then
		error "immediate exit after the first error"
	fi

to delegate the finalization.

> @@ -1085,21 +1104,7 @@ test_done () {
>  	# removed, so the commands can access pidfiles and socket files.
>  	test_atexit_handler
>  
> -	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
> -	then
> -		test -n "$junit_have_testcase" || {
> -			junit_start=$(test-tool date getnanos)
> -			write_junit_xml_testcase "all tests skipped"
> -		}
> -
> -		# adjust the overall time
> -		junit_time=$(test-tool date getnanos $junit_suite_start)
> -		sed "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
> -			<"$junit_xml_path" >"$junit_xml_path.new"
> -		mv "$junit_xml_path.new" "$junit_xml_path"
> -
> -		write_junit_xml "  </testsuite>" "</testsuites>"
> -	fi
> +	finalize_junit_xml
>  
>  	if test -z "$HARNESS_ACTIVE"
>  	then
