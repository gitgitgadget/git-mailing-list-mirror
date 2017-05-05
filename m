Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5D8207B3
	for <e@80x24.org>; Fri,  5 May 2017 22:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbdEEWne (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 18:43:34 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:58880 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbdEEWnd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 18:43:33 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wKRkq6KkKz5tlB;
        Sat,  6 May 2017 00:43:31 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4FC0D2F7C;
        Sat,  6 May 2017 00:43:31 +0200 (CEST)
Subject: Re: [PATCH] t7406: fix i18n expectation of error message
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <20170505154053.58128-1-larsxschneider@gmail.com>
 <20170505173841.20555-1-sbeller@google.com>
 <CACBZZX6ZzrJk77ReJ592rJrNR1xhVCQid6_5KTonwTot5eq-hQ@mail.gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4a2318e6-b0c5-5061-15e4-af11b576c079@kdbg.org>
Date:   Sat, 6 May 2017 00:43:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX6ZzrJk77ReJ592rJrNR1xhVCQid6_5KTonwTot5eq-hQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.05.2017 um 19:50 schrieb Ævar Arnfjörð Bjarmason:
> On Fri, May 5, 2017 at 7:38 PM, Stefan Beller <sbeller@google.com> wrote:
>> The error message from "submodule update" is internationalized, which
>> makes sense. The test however did not check for the translated version,
>> but used a hardcoded string, which breaks the test when run with
>> GETTEXT_POISON.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  t/t7406-submodule-update.sh | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index 4ac386d98b..12f6435ab0 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -441,13 +441,11 @@ test_expect_success 'submodule update - command in .git/config catches failure -
>>         test_i18ncmp actual expect
>>  '
>>
>> +sq="'"
>>  test_expect_success 'submodule update - command run for initial population of submodule' '
>> -       cat >expect <<-EOF &&
>> -       Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
>> -       EOF
>>         rm -rf super/submodule &&
>>         test_must_fail git -C super submodule update 2>actual &&
>> -       test_cmp expect actual &&
>> +       test_i18ngrep "Execution of ${sq}false $submodulesha1${sq} failed in submodule path ${sq}submodule${sq}" actual &&
>>         git -C super submodule update --checkout
>>  '
>
> I have a fix for this in my gettext fixup series (so far lingering on
> the list, not in pu):
> https://public-inbox.org/git/20170421185757.28978-1-avarab@gmail.com/
>
> The diff is quite a bit smaller than yours:
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 4ac386d98b..034914a14f 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -447,7 +447,7 @@ test_expect_success 'submodule update - command
> run for initial population of su
>         EOF
>         rm -rf super/submodule &&
>         test_must_fail git -C super submodule update 2>actual &&
> -       test_cmp expect actual &&
> +       test_i18ncmp expect actual &&
>         git -C super submodule update --checkout
>  '
>
> Do you prefer to use i18ngrep for whatever reason? Seems better to use
> i18ncmp there.

With grep, you can focus on the important parts. Programs on different 
platforms or in different environments sometimes poison stderr with 
unexpected stuff (we've observed this recently with the nd/fopen-errors 
series, also sh -x output can end up in the >2 destination).

Also, grep allows to write

test_i18ngrep "Execution of .false.* failed in submodule path 
.submodule." actual

Note the lack of ugly single-quote hacks and volatile object names.

-- Hannes

