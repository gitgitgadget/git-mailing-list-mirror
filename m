Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F5920D0A
	for <e@80x24.org>; Mon, 29 May 2017 21:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbdE2V7y (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 17:59:54 -0400
Received: from avasout08.plus.net ([212.159.14.20]:47018 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdE2V7y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 17:59:54 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id SMzr1v0011keHif01Mzs1n; Mon, 29 May 2017 22:59:52 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=A9qS8gIqAAAA:8 a=LoG4C5gyAAAA:8 a=-mlu9VBoxAkBj5evuzAA:9
 a=QEXdDO2ut3YA:10 a=Vr7qJMbYMNsA:10 a=H28RkzuXznr5akrmL4QT:22
 a=szc4L7tIoTp4SOWyBAQL:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] mingw: verify that paths are not mistaken for remote
 nicknames
To:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
 <20170526033510.1793-14-gitster@pobox.com>
 <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
 <CACBZZX5BgVbUFEwQjHqJVfHFUitTJRaCx-Lg+j7q54uErEpqcg@mail.gmail.com>
 <34029b29-9f65-78c0-c2ed-649b179a79ac@kdbg.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <bc145b9d-96cc-325a-8df3-af87d23c8727@ramsayjones.plus.com>
Date:   Mon, 29 May 2017 22:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <34029b29-9f65-78c0-c2ed-649b179a79ac@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/05/17 22:02, Johannes Sixt wrote:
> Am 29.05.2017 um 22:40 schrieb Ævar Arnfjörð Bjarmason:
>> On Mon, May 29, 2017 at 10:25 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>> diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
>>> index b195f71ea9..fd719a209e 100755
>>> --- a/t/t5580-clone-push-unc.sh
>>> +++ b/t/t5580-clone-push-unc.sh
>>> @@ -1,13 +1,19 @@
>>>   #!/bin/sh
>>>
>>> -test_description='various UNC path tests (Windows-only)'
>>> +test_description='various Windows-only path tests'
>>>   . ./test-lib.sh
>>>
>>>   if ! test_have_prereq MINGW; then
>>> -       skip_all='skipping UNC path tests, requires Windows'
>>> +       skip_all='skipping Windows-only path tests'
>>>          test_done
>>>   fi
>>>
>>> +test_expect_failure 'remote nick cannot contain backslashes' '
>>> +       BACKSLASHED="$(pwd | tr / \\\\)" &&
>>> +       git ls-remote "$BACKSLASHED" >out 2>err &&
>>> +       ! grep "unable to access" err
>>> +'
>>
>> Doesn't this need test_i18ngrep?:
> 
> Good catch! It would be this one in warn_on_inaccessible:
> 
>>      wrapper.c:581:  warning_errno(_("unable to access '%s'"), path);
> 
> But actually, I'm more worried about the unholy mix of one-test-first-then-skip_all-later that occurs in this test script (I do not mean the skip_all that is visible in the context, there are others later). I think there was some buzz recently that prove only understands a summary line that reads "1..0", but here we would see "1..1". What to do? Reorganize the test script? Dscho, any ideas?

See commit c7018be509 ("test: allow skipping the remainder", 18-05-2017)
which is currently merged to the 'next' branch (merge 03b8a61e47 of the
'jc/skip-test-in-the-middle' branch).

(see also http://testanything.org)

If you look at http://testanything.org//tap-specification.html, it shows
that you are allowed to annotate a plan of '1..0' with a SKIP directive
to explain why no tests in a file were run. However, a plan with '1..n'
(for any n > 0) must not have any annotation. (Back in 2012, when I wrote
commit bf4b721932, I found much better documentation than the above!)

So, after commit c7018be509, you can now use the 'skip_all' facility
after having run some tests; it now converts that into an 'SKIP comment'
just before the test plan, effectively skipping the remainder of the
tests in the file. (since we are using a 'trailing plan', and have thus
not declared how many tests we had intended to run, we can output an
accurate plan).

ATB,
Ramsay Jones


