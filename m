Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCE7C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 07:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E4264EE2
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 07:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhBEHsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 02:48:39 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:56342 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhBEHsi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 02:48:38 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4DX6wB3Rw2z5tlC;
        Fri,  5 Feb 2021 08:47:54 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1D8824B8D;
        Fri,  5 Feb 2021 08:47:53 +0100 (CET)
Subject: Re: [PATCH v2 2/5] pager: test for exit code with and without SIGPIPE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
References: <20210201144921.8664-1-avarab@gmail.com>
 <20210202020001.31601-3-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9c686629-82d9-f441-a255-a288fe322881@kdbg.org>
Date:   Fri, 5 Feb 2021 08:47:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202020001.31601-3-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.21 um 02:59 schrieb Ævar Arnfjörð Bjarmason:
> Add tests for how git behaves when the pager itself exits with
> non-zero, as well as for us exiting with 141 when we're killed with
> SIGPIPE due to the pager not consuming its output.
> 
> There is some recent discussion[1] about these semantics, but aside
> from what we want to do in the future, we should have a test for the
> current behavior.
> 
> This test construct is stolen from 7559a1be8a0 (unblock and unignore
> SIGPIPE, 2014-09-18). The reason not to make the test itself depend on
> the MINGW prerequisite is to make a subsequent commit easier to read.

At least for my Windows build, the MINGW games do not make a difference:
The test is skipped anyway due to the unsatisfied TTY prerequisite.

> 
> 1. https://lore.kernel.org/git/87o8h4omqa.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t7006-pager.sh | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index fdb450e446a..0aa030962b1 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -656,4 +656,86 @@ test_expect_success TTY 'git tag with auto-columns ' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
> +	test_when_finished "rm pager-used" &&
> +	test_config core.pager ">pager-used; head -n 1; exit 0" &&
> +
> +	if test_have_prereq !MINGW
> +	then
> +		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
> +		test_match_signal 13 "$OUT"
> +	else
> +		test_terminal git log
> +	fi &&
> +	test_path_is_file pager-used
> +'
> +
> +test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
> +	test_when_finished "rm pager-used" &&
> +	test_config core.pager ">pager-used; head -n 1; exit 1" &&
> +
> +	if test_have_prereq !MINGW
> +	then
> +		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
> +		test_match_signal 13 "$OUT"
> +	else
> +		test_terminal git log
> +	fi &&
> +	test_path_is_file pager-used
> +'
> +
> +test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
> +	test_when_finished "rm pager-used" &&
> +	test_config core.pager "wc >pager-used; exit 1" &&
> +
> +	if test_have_prereq !MINGW
> +	then
> +		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
> +		test "$OUT" -eq 0
> +	else
> +		test_terminal git log
> +	fi &&
> +	test_path_is_file pager-used
> +'
> +
> +test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
> +	test_when_finished "rm pager-used" &&
> +	test_config core.pager "wc >pager-used; does-not-exist" &&
> +
> +	if test_have_prereq !MINGW
> +	then
> +		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
> +		test "$OUT" -eq 0
> +	else
> +		test_terminal git log
> +	fi &&
> +	test_path_is_file pager-used
> +'
> +
> +test_expect_success TTY 'git attempts to page to nonexisting pager command, gets SIGPIPE' '
> +	test_config core.pager "does-not-exist" &&
> +
> +	if test_have_prereq !MINGW
> +	then
> +		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
> +		test_match_signal 13 "$OUT"
> +	else
> +		test_terminal git log
> +	fi
> +'
> +
> +test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
> +	test_when_finished "rm pager-used" &&
> +	test_config core.pager ">pager-used; test-tool sigchain" &&
> +
> +	if test_have_prereq !MINGW
> +	then
> +		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
> +		test_match_signal 13 "$OUT"
> +	else
> +		test_terminal git log
> +	fi &&
> +	test_path_is_file pager-used
> +'
> +
>  test_done
> 

