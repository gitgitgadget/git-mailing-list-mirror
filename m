Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4074FC433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 18:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbiCTSJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiCTSJD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 14:09:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B243CA56
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 11:07:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C120417998C;
        Sun, 20 Mar 2022 14:07:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=plVTtSvGRqietO6cN08IxkATztu9EdQsiJiMmW
        UzvYk=; b=oKyQXiJy46IEIvtv4E7QJ29LSxD9w6XW2uTmQUrb1cMOgNad2OgvTY
        LKYBVwwgSOuXH/NE8QsTlWbat+n/Oi3o6y+sGvE24dy7Udfa6IN4cBwlgwPVHYVt
        UN+3Ruyr3xDXORMEvYu10JjAK+pAIfFSsQuXqz4l/l9s+Rxbp93dw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8AF217998B;
        Sun, 20 Mar 2022 14:07:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DD69E179985;
        Sun, 20 Mar 2022 14:07:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/7] test-lib: add a "test_expect_todo", similar to
 "test_expect_failure"
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
        <patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com>
        <xmqqczij9jeg.fsf@gitster.g> <xmqq8rt77zp7.fsf@gitster.g>
        <220319.86v8waetae.gmgdl@evledraar.gmail.com>
        <xmqqilsa76ve.fsf@gitster.g>
        <220319.86ilsadw69.gmgdl@evledraar.gmail.com>
        <db558292-2783-3270-4824-43757822a389@gmail.com>
Date:   Sun, 20 Mar 2022 11:07:33 -0700
In-Reply-To: <db558292-2783-3270-4824-43757822a389@gmail.com> (Phillip Wood's
        message of "Sun, 20 Mar 2022 15:13:36 +0000")
Message-ID: <xmqqy2144hwa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E6EAA5C-A878-11EC-A061-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> .... I had a look
> at some of the conversions with your test_todo --want/--expect/--reset
> and found the result really hard to follow. Junio's suggestions chimed
> with some things I've been thinking about so I had a go at
> implementing it and doing some sample conversions (see below). Marking
> the individual commands that should fail is a big step forward and the
> failing commands are checked to make sure they don't segfault etc.

;-)

Another small detail in my suggestion that will make a huge
difference in the end is not to introduce test_expect_todo as a
separate top-level construct, and instead teach test_expect_success
to pay attention to the use of test_todo "unfortunately this does
not work yet" mark in it.  It allows us to use test_todo in a shared
test helper function and call them in test_expect_success, and when
the step the test helper has trouble with gets fixed, the "unmark"
step will be an isolated change.

Your sample change seems to already have it, which is good.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 0f439c99d6..deb74a22f3 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -739,6 +739,7 @@ test_expect_failure () {
>  }
>    test_expect_success () {
> +	test_todo_=
>  	test_start_
>  	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
>  	test "$#" = 2 ||
> @@ -750,7 +751,12 @@ test_expect_success () {
>  		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
>  		if test_run_ "$2"
>  		then
> -			test_ok_ "$1"
> +			if test -n "$test_todo_"
> +			then
> +				test_known_broken_failure_ "$1"
> +			else
> +				test_ok_ "$1"
> +			fi
>  		else
>  			test_failure_ "$@"
>  		fi
