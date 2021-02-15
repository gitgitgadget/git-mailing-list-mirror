Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB05C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5643664DFF
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhBOSUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:20:01 -0500
Received: from [93.83.142.38] ([93.83.142.38]:47412 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230388AbhBOSTS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:19:18 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id E56A41B27F;
        Mon, 15 Feb 2021 19:18:54 +0100 (CET)
Subject: Re: [PATCH v2 19/27] gitattributes doc: document multi-line userdiff
 patterns
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-20-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7984b3d6-7c01-565e-f5fd-3104af4b3ce6@kdbg.org>
Date:   Mon, 15 Feb 2021 19:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215154427.32693-20-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 16:44 schrieb Ævar Arnfjörð Bjarmason:
> diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
> index 72d38dad68..30df13d8b2 100755
> --- a/t/t4018/custom.sh
> +++ b/t/t4018/custom.sh
> @@ -111,3 +111,53 @@ ChangeMe
>   
>   baz
>   EOF_TEST
> +
> +test_expect_success 'custom: setup negation syntax, ! is magic' '
> +	git config diff.custom.xfuncname "!negation
> +line"
> +'
> +
> +test_diff_funcname 'custom: negation syntax, ! is magic' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +line
> +EOF_HUNK
> +line
> +!negation
> +
> +ChangeMe
> +
> +baz
> +EOF_TEST
> +
> +test_expect_success 'custom: setup negation syntax, use [!] to override ! magic' '
> +	git config diff.custom.xfuncname "[!]negation
> +line"
> +'
> +
> +test_diff_funcname 'custom: negation syntax, use [!] to override ! magic' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +!negation
> +EOF_HUNK
> +line
> +!negation
> +
> +ChangeMe
> +
> +baz
> +EOF_TEST
> +
> +test_expect_success 'custom: setup captures in multiple patterns' '
> +	git config diff.custom.xfuncname "!^=head
> +^format ([^ ]+)
> +^sub ([^;]+)"
> +'
> +
> +test_diff_funcname 'custom: captures in multiple patterns' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +foo
> +EOF_HUNK
> +sub foo;
> +=head1
> +ChangeMe
> +
> +EOF_TEST

This test would not catch a regression. You must leave a line between 
the candidate-that-must-not-be, =head1, and ChangeMe, otherwise, =head1 
is never tested against the negation pattern.

Or did you change the diff invocation in an earlier patch such that it 
does not emit context lines?

> diff --git a/t/t4018/perl.sh b/t/t4018/perl.sh
> index ac8fff7417..2952483a2c 100755
> --- a/t/t4018/perl.sh
> +++ b/t/t4018/perl.sh
> @@ -76,3 +76,19 @@ sub RIGHT
>   	print "ChangeMe\n";
>   }
>   EOF_TEST
> +
> +
> +test_expect_success 'custom: setup config overrides built-in patterns' '
> +	git config diff.perl.xfuncname "!^=head
> +^[^ ]+.*"
> +'
> +
> +test_diff_funcname 'custom: config overrides built-in patterns' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +sub foo;
> +EOF_HUNK
> +sub foo;
> +=head1
> +ChangeMe
> +
> +EOF_TEST

Same here.

-- Hannes
