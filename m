Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6971FE90
	for <e@80x24.org>; Thu, 20 Apr 2017 03:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937996AbdDTDbD (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 23:31:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56393 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S937253AbdDTDbB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 23:31:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B3376DF17;
        Wed, 19 Apr 2017 23:31:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vVEXvVwaXs/3Glh8BaaLX7XfHHQ=; b=ZTkfID
        E5dVQD+avi8A23KirxKhN4JATfJhzgoWBq2wwHm9OWF4Fspwl3vdsxmu6GBna/Ln
        WtLu4buo3bwGm9n3jblQTgo16+z5DSECktORGlENMFQFl7nkF3kugjM8Mc6xt/a1
        B4iG3hvTrYJj5O9PmH/lrlrygw3C7S/O23+sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eX2l7k64ArjK/oTqTa6jebP5z55HnXxy
        2dmv5dEzsrxNPPmGxljv2bA2UfQn+/yJbESwxcSuPP0KnLWUcSO6IVmkBRWWZY0N
        amzR74jOwlQerIXbpwwTS/rPwYLsLynQzUpFxuEsYU56VwQVbqLDerWPq8eCZoXN
        CHJLIqffC+U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 127F46DF16;
        Wed, 19 Apr 2017 23:31:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62DB86DF15;
        Wed, 19 Apr 2017 23:30:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v10 4/5] dir_iterator: rewrite state machine model
References: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
        <1492607652-36341-5-git-send-email-bnmvco@gmail.com>
Date:   Wed, 19 Apr 2017 20:30:58 -0700
In-Reply-To: <1492607652-36341-5-git-send-email-bnmvco@gmail.com> (Daniel
        Ferreira's message of "Wed, 19 Apr 2017 10:14:11 -0300")
Message-ID: <xmqqfuh3ah71.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C594837C-2579-11E7-B22E-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Ferreira <bnmvco@gmail.com> writes:

> diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
> index 46e5ce5..4c6632f 100755
> --- a/t/t0065-dir-iterator.sh
> +++ b/t/t0065-dir-iterator.sh
> @@ -15,31 +15,41 @@ test_expect_success 'setup' '
>  	>dir/d/e/d/a &&
>  
>  	mkdir -p dir2/a/b/c/ &&
> -	>dir2/a/b/c/d
> +	>dir2/a/b/c/d &&
> +
> +	>file
>  '
>  
> -test_expect_success 'dir-iterator should iterate through all files' '
> -	cat >expect-sorted-output <<-\EOF &&
> -	[d] (a) [a] ./dir/a
> -	[d] (a/b) [b] ./dir/a/b
> -	[d] (a/b/c) [c] ./dir/a/b/c
> -	[d] (d) [d] ./dir/d
> -	[d] (d/e) [e] ./dir/d/e
> -	[d] (d/e/d) [d] ./dir/d/e/d
> -	[f] (a/b/c/d) [d] ./dir/a/b/c/d
> -	[f] (a/e) [e] ./dir/a/e
> -	[f] (b) [b] ./dir/b
> -	[f] (c) [c] ./dir/c
> -	[f] (d/e/d/a) [a] ./dir/d/e/d/a
> -	EOF
> +cat >expect-sorted-output <<-\EOF &&
> +[d] (a) [a] ./dir/a
> +[d] (a/b) [b] ./dir/a/b
> +[d] (a/b/c) [c] ./dir/a/b/c
> +[d] (d) [d] ./dir/d
> +[d] (d/e) [e] ./dir/d/e
> +[d] (d/e/d) [d] ./dir/d/e/d
> +[f] (a/b/c/d) [d] ./dir/a/b/c/d
> +[f] (a/e) [e] ./dir/a/e
> +[f] (b) [b] ./dir/b
> +[f] (c) [c] ./dir/c
> +[f] (d/e/d/a) [a] ./dir/d/e/d/a
> +EOF
>  
> -	test-dir-iterator ./dir >out &&

There is something fishy going on around here in this patch, pushing
the code to prepare test vector out of test_expect_success block.  A
mistake in rebasing or something?

If you need to reroll the series to update this part, please rename
the test to t0066 and do remember to update the logmessage of a few
commits that refer to t0065.

Thanks.
