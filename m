Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59ECC433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07EF64E13
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhBOSaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:30:07 -0500
Received: from [93.83.142.38] ([93.83.142.38]:47432 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229908AbhBOSaG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:30:06 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 84B7A1B280;
        Mon, 15 Feb 2021 19:29:44 +0100 (CET)
Subject: Re: [PATCH v2 22/27] userdiff tests: test hunk headers on accumulated
 files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-23-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <eebdd570-ba21-037c-c608-ec0989956bfa@kdbg.org>
Date:   Mon, 15 Feb 2021 19:29:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215154427.32693-23-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 16:44 schrieb Ævar Arnfjörð Bjarmason:
> The existing tests in "t/t4018/" are unrealistic in that they're all
> setting up small few-line isolated test cases with one thing we could
> match as a hunk header, right above the one change in the file.
> 
> Expand those tests by accumulating changes within the same file type
> in the "test_diff_funcname" function. So e.g. for "bash" we'll end up
> a "bash.acc" file with 15 s/ChangeMe/IWasChanged/ changes.
> 
> This stress tests whether the hunk header selection will "jump across"
> to an earlier change because the match for that is greedier.
> 
> As it turns out we had one false positive in "t/t4018/cpp.sh" and
> "t4018/matlab.sh" because of how the tests were structured, we must
> always give the "ChangeMe" line at least one line of separation from
> the header, since it was at the end of those tests we'd select the
> "wrong" header. Let's adjust the spacing to compensate.

I can't wrap my head around this. The ChangeMe lines are one line away 
from the RIGHT lines. Why would we need a line below ChangeMe?

Or is this just a fall-out from this change itself? Then I'd appreciate 
to describe it as "This change now triggers false positives in... 
because... Let's adjust the spacing compensate.".

> 
> So in the end we found nothing of interest here, regardless, I think
> it is useful to continue to test in this mode. It's likely to aid in
> finding bugs in combinations of our positive and negative matching as
> we add more built-in patterns.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/t4018-diff-funcname.sh | 19 +++++++++++++++++++
>   t/t4018/cpp.sh           |  1 +
>   t/t4018/matlab.sh        |  3 +++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 2efe4e5bdd..8b4500037f 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -65,12 +65,26 @@ test_diff_funcname () {
>   		do_change_me "$what"
>   	' &&
>   
> +	test_expect_success "setup: $desc (accumulated)" '
> +		cat arg.test >>arg.tests &&
> +		cp arg.tests "$what".acc &&
> +		git add "$what".acc &&
> +		do_change_me "$what".acc
> +	' &&
> +
>   	test_expect_success "$desc" '
>   		git diff -U1 "$what" >diff &&
>   		last_diff_context_line diff >actual &&
>   		test_cmp expected actual
>   	' &&
>   
> +	test_expect_success "$desc (accumulated)" '
> +		git diff -U1 "$what".acc >diff &&
> +		last_diff_context_line diff >actual.lines &&
> +		tail -n 1 actual.lines >actual &&
> +		test_cmp expected actual
> +	' &&
> +
>   	test_expect_success "teardown: $desc" '
>   		# In case any custom config was set immediately before
>   		# the test itself in the test file
> @@ -93,6 +107,11 @@ do
>   		echo "$what" >arg.what
>   	' &&
>   
> +	test_expect_success "setup: hunk header for $what (accumulated)" '
> +		>arg.tests &&
> +		echo "$what.acc diff=$what" >>.gitattributes
> +	' &&
> +
>   	. "$test"
>   done
>   
> diff --git a/t/t4018/cpp.sh b/t/t4018/cpp.sh
> index 185d40d5ef..e0ab749316 100755
> --- a/t/t4018/cpp.sh
> +++ b/t/t4018/cpp.sh
> @@ -206,6 +206,7 @@ void wrong()
>   struct RIGHT_iterator_tag {};
>   
>   int ChangeMe;
> +
>   EOF_TEST
>   
>   test_diff_funcname 'cpp: template function definition' \
> diff --git a/t/t4018/matlab.sh b/t/t4018/matlab.sh
> index f62289148e..fba410e6f5 100755
> --- a/t/t4018/matlab.sh
> +++ b/t/t4018/matlab.sh
> @@ -31,6 +31,7 @@ EOF_HUNK
>   %%% RIGHT section
>   # this is octave script
>   ChangeMe = 1;
> +
>   EOF_TEST
>   
>   test_diff_funcname 'matlab: octave section 2' \
> @@ -40,6 +41,7 @@ EOF_HUNK
>   ## RIGHT section
>   # this is octave script
>   ChangeMe = 1;
> +
>   EOF_TEST
>   
>   test_diff_funcname 'matlab: section' \
> @@ -49,4 +51,5 @@ EOF_HUNK
>   %% RIGHT section
>   % this is understood by both matlab and octave
>   ChangeMe = 1;
> +
>   EOF_TEST
> 

-- Hannes
