Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D3720D0A
	for <e@80x24.org>; Mon, 29 May 2017 21:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbdE2VCR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 17:02:17 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:61736 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbdE2VCR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 17:02:17 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wc8Lv3wv1z5tlB;
        Mon, 29 May 2017 23:02:15 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3065A303E;
        Mon, 29 May 2017 23:02:15 +0200 (CEST)
Subject: Re: [PATCH 1/2] mingw: verify that paths are not mistaken for remote
 nicknames
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
 <20170526033510.1793-14-gitster@pobox.com>
 <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
 <CACBZZX5BgVbUFEwQjHqJVfHFUitTJRaCx-Lg+j7q54uErEpqcg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <34029b29-9f65-78c0-c2ed-649b179a79ac@kdbg.org>
Date:   Mon, 29 May 2017 23:02:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX5BgVbUFEwQjHqJVfHFUitTJRaCx-Lg+j7q54uErEpqcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.05.2017 um 22:40 schrieb Ævar Arnfjörð Bjarmason:
> On Mon, May 29, 2017 at 10:25 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
>> index b195f71ea9..fd719a209e 100755
>> --- a/t/t5580-clone-push-unc.sh
>> +++ b/t/t5580-clone-push-unc.sh
>> @@ -1,13 +1,19 @@
>>   #!/bin/sh
>>
>> -test_description='various UNC path tests (Windows-only)'
>> +test_description='various Windows-only path tests'
>>   . ./test-lib.sh
>>
>>   if ! test_have_prereq MINGW; then
>> -       skip_all='skipping UNC path tests, requires Windows'
>> +       skip_all='skipping Windows-only path tests'
>>          test_done
>>   fi
>>
>> +test_expect_failure 'remote nick cannot contain backslashes' '
>> +       BACKSLASHED="$(pwd | tr / \\\\)" &&
>> +       git ls-remote "$BACKSLASHED" >out 2>err &&
>> +       ! grep "unable to access" err
>> +'
> 
> Doesn't this need test_i18ngrep?:

Good catch! It would be this one in warn_on_inaccessible:

>      wrapper.c:581:  warning_errno(_("unable to access '%s'"), path);

But actually, I'm more worried about the unholy mix of 
one-test-first-then-skip_all-later that occurs in this test script (I do 
not mean the skip_all that is visible in the context, there are others 
later). I think there was some buzz recently that prove only understands 
a summary line that reads "1..0", but here we would see "1..1". What to 
do? Reorganize the test script? Dscho, any ideas?

-- Hannes
