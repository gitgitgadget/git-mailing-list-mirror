Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F88C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 03:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8115164DF5
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 03:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhBQDih (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:38:37 -0500
Received: from [93.83.142.38] ([93.83.142.38]:37138 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhBQDih (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 22:38:37 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 301C01CE68;
        Tue, 16 Feb 2021 22:45:30 +0100 (CET)
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-10-avarab@gmail.com>
 <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
 <xmqqsg5vrhha.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1b2cb670-b49b-b478-7f69-6d4c356c8118@kdbg.org>
Date:   Tue, 16 Feb 2021 22:45:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqsg5vrhha.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.02.21 um 19:32 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>>    t/t4018-diff-funcname.sh                      |  7 +++---
>>>    t/t4018/README                                | 22 +++++++++----------
>>>    t/t4018/README.ctx                            |  1 +
>>>    t/t4018/bash-arithmetic-function.ctx          |  1 +
>>>    t/t4018/bash-bashism-style-compact.ctx        |  1 +
>>>    [...and so on...]
>>
>> This is what I meant by "without burdening test writers with lots of
>> subtleties".
>>
>> I'm not a friend of this change :-(
>>
>> I think you are going overboard with required test precision. To have
>> useful tests for userdiff patterns that demonstrate its features,
>> authors should write *many* tests. The right balance should be on the
>> coverage of userdiff pattern features, not on the subtle details of
>> each and everyone of it. Requiring that many additional context files
>> makes it *really hard* to comply.
> 
> Yeah, the first time I saw the t4018 test framework appeared in my
> tree, I truly appreciated its simplicity, how the test input file is
> self-documenting and self-contained, with the clever use of "RIGHT",
> "broken" and "ChangeMe" magic tokens, admired the cleverness of the
> approach, and wished I was clever enough to invent that pattern to
> apply to other tests myself.
> 
> A little new for each and every test for the miniscule gain of
> checking which part of the function header line is extracted feels a
> bit too much noise and rubs my sense of aesthetics, spoiled by the
> existing t4018 tests, the wrong way.
> 
> This is a rough sketch of a different approach aiming for the same.
> I converted only a few files, but I hope that this is enough to
> illustrate the idea.
> 
>   t/t4018-diff-funcname.sh         | 17 ++++++++++++++---
>   t/t4018/README                   |  9 ++++++---
>   t/t4018/bash-arithmetic-function |  3 +++
>   3 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git c/t/t4018-diff-funcname.sh w/t/t4018-diff-funcname.sh
> index 9675bc17db..dd79c99fc5 100755
> --- c/t/t4018-diff-funcname.sh
> +++ w/t/t4018-diff-funcname.sh
> @@ -107,10 +107,21 @@ do
>   	else
>   		result=success
>   	fi
> -	test_expect_$result "hunk header: $i" "
> +
> +	test_expect_$result "hunk header: $i" '
> +		HEAD=$(sed -n \
> +			-e "s/^.*HEADER.*|\(.*\)right\(.*\)|.*/ \1RIGHT\2/p" "$i") &&
> +
>   		git diff -U1 $i >actual &&
> -		grep '@@ .* @@.*RIGHT' actual
> -	"
> +
> +		sed -ne "s/^@@[^@]*@@//p" actual |
> +		if test -n "$HEAD"
> +		then
> +			grep -F "$HEAD"
> +		else
> +			grep "^.*RIGHT"
> +		fi
> +	'
>   done
>   
>   test_done

> diff --git c/t/t4018/bash-arithmetic-function w/t/t4018/bash-arithmetic-function
> index c0b276cb50..935f18d96d 100644
> --- c/t/t4018/bash-arithmetic-function
> +++ w/t/t4018/bash-arithmetic-function
> @@ -2,3 +2,6 @@ RIGHT() ((
>   
>       ChangeMe = "$x" + "$y"
>   ))
> +
> +
> +# HEADER |right()|
> 

Clever! Opt-in for those who desire precise tests.

-- Hannes
