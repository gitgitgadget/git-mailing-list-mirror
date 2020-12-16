Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A7C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5CE223E8
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgLPTI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:08:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56271 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733261AbgLPTI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 14:08:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F40728CCDF;
        Wed, 16 Dec 2020 14:07:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ks0vtD9tzk6FaaOHhcHZpdMYbc0=; b=qLqa7q
        9yZvvkw3uW6zGzREZDtqGui1Efkgl519T8PbDccvA+sX1HN4amJDxlWuuBNvkbRi
        jceynPhiApG9Hhfw3xY0AazeCZxh941I72dXKVv/OpE1ST5eeRxW6yjAVLK8FMi7
        pFMMrKERG0KH9UFHKEdCK4mmvsEVeiLvLhcG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q9409Qo4Rlzn2I3j2qlkSmNr2rY9x4ec
        ABjad0pgm+YYGrpqhE77y/4KseUrnGQn/JDVEUNkBgQUlGwg+BMUBfku/tcMJqNq
        8SZlvq1TMg35O7zlsRXVewFe7oDqJ5HNTXa4ZY/i+jzNe0UaCJmueDOfCwpJDops
        a488tnh8/CE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB74D8CCDE;
        Wed, 16 Dec 2020 14:07:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73A008CCDD;
        Wed, 16 Dec 2020 14:07:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Sangeeta <sangunb09@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t/perf: fix test_export() failure with BSD `sed`
References: <20201216073907.62591-1-sunshine@sunshineco.com>
Date:   Wed, 16 Dec 2020 11:07:42 -0800
In-Reply-To: <20201216073907.62591-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Wed, 16 Dec 2020 02:39:07 -0500")
Message-ID: <xmqq5z514lj5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9B34C08-3FD1-11EB-BA14-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Fortunately, alternation is unnecessary in this case and can easily be
> avoided, so replace it with a series of simple expressions such as
> `s/^var1/.../p;s/^var2/.../p`.

Simple is good.

> While at it, tighten the expressions so they match the variable names
> exactly rather than matching prefixes (i.e. use `s/^var1=/.../p`).

Good eyes.  That is quite good.

> @@ -148,13 +148,18 @@ test_run_perf_ () {
>  . '"$TEST_DIRECTORY"/test-lib-functions.sh'
>  test_export () {
>  	[ $# != 0 ] || return 0
> -	test_export_="$test_export_\\|$1"
> +	test_export_="$test_export_ $1"
>  	shift
>  	test_export "$@"
>  }

This "recursion to consume $@ one by one, instead of looping" caught
my eyes a bit, but the bug being fixed is not caused by it, so it is
fine to let it pass.  Given that the arguments to test_export are
supposed to be all variable names (i.e. no funny characters anywhere
in it), I think it could just be

	test_export () {
		test_export_="$*"
	}

though.

Oh, does anybody need to clear test_export_ to an empty string (or
unset it), by the way?

>  '"$1"'
>  ret=$?
> -set | sed -n "s'"/'/'\\\\''/g"';s/^\\($test_export_\\)/export '"'&'"'/p" >test_vars
> +needles=
> +for v in $test_export_
> +do
> +	needles="$needles;s/^$v=/export $v=/p"
> +done
> +set | sed -n "s'"/'/'\\\\''/g"'$needles" >test_vars
>  exit $ret' >&3 2>&4
>  	eval_ret=$?

Other than these, none of which were "this is wrong and needs to be
fixed", I have no comments.  The patch is quite readably done.

Will queue.  Thanks.
