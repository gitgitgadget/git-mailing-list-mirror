Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371821F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933102AbeBMB6X (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:58:23 -0500
Received: from avasout01.plus.net ([84.93.230.227]:35296 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeBMB6W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:58:22 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id lPrPeat5Eea87lPrQexUob; Tue, 13 Feb 2018 01:58:20 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=FbMZOq26 c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=YZWFN3Hl_Pw1dG2CYhcA:9
 a=a2Z2vUmHC0WjXQPD:21 a=0xT0_1GqruS_DRYu:21 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
 <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
Date:   Tue, 13 Feb 2018 01:58:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA6pfpzYLOzZIPcuGgm10u++UD73LK7b8swQxg+FTPWUV1Y8+yXpNk2shJKAclQ9RvCAq71fCBOmSYXiRChQC8QO9OlP8lSi0ri8UU5N+66HSRJVbSFT
 wFBaW6ASxVQdcjoxWTJ+SgVYhGt3ZDUM1pIsg8ygzkO8o1+fU3fl397CGf1L+gYI0EQw8IMciIaBQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/02/18 20:18, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Attempting to grep the output of test_i18ngrep will not work under a
>> poison build, since the output is (almost) guaranteed not to have the
>> string you are looking for. In this case, the output of test_i18ngrep
>> is further filtered by a simple piplined grep to exclude an '... remote
>> end hung up unexpectedly' warning message. Use a regular 'grep -E' to
>> replace the call to test_i18ngrep in the filter pipeline.
>> Also, remove a useless invocation of 'sort' as the final element of the
>> pipeline.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>  t/t5536-fetch-conflicts.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
>> index 2e42cf331..38381df5e 100755
>> --- a/t/t5536-fetch-conflicts.sh
>> +++ b/t/t5536-fetch-conflicts.sh
>> @@ -22,7 +22,7 @@ verify_stderr () {
>>  	cat >expected &&
>>  	# We're not interested in the error
>>  	# "fatal: The remote end hung up unexpectedly":
>> -	test_i18ngrep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
>> +	grep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual &&
>>  	test_i18ncmp expected actual
> 
> OK, but not quite OK.

:-D

> Two grep invocations will not leave anything useful in 'actual'
> under poison build, and is almost guaranteed that 'expected' would
> not match, but that is perfectly OK because the final comparison is
> done.

"...is done with i18ncmp.", indeed.

The contents of 'actual' would look like:

  warning: # GETTEXT POISON #
  warning: # GETTEXT POISON #

or

  fatal: # GETTEXT POISON #

... depending on which test we are looking at.

> However, it is brittle to rely on the latter "grep -v" to exit with
> status 0 for the &&-chain to work.  The original was most likely
> masked by the "| sort" exiting with 0 status all the time ;-)

I must admit that I didn't think about the effect of the useless
"| sort" on the exit status!  What I saw was: a process that
received no input, sorted nothing and produced no output - pretty
much the definition of useless! ;-)

Also, the "| grep -v" part does remove the "... hung up ..."
message (when present in the input), since that message has not
been i18n-ed. I thought this was deliberate - but maybe not.
(also, so long a _some_ output gets passed on by that grep, the
exit status will be 0).

> There needs an explanation why this commit thinks the invocation of
> "sort" useless.

You mean, other than the fact that it is? ;-)

>                   I do not particularly think "suppressing a
> not-found non-zero exit from 'grep'" is a useful thing, but are we
> committed to show the two warnings seen in the last test in this
> file to always in the shown order (i.e. the same order as the
> refspecs are given to us)?  If not, then "sort" does serve a
> purpose.  Note that I do not think we want to be able to reorder the
> warning messages in future versions of Git for that last case, so
> making that explicit may be a good justification.

I did not look back at the history of this test, so I can't say
if that was the original _intent_ of the "| sort" part of the
pipeline. However, it is not serving any purpose now.

>     The "sort" as the last step in the pipeline makes sure that we
>     do not have to guarantee the order in which we give the two
>     warning messages from the last test in this script, but
>     processing the refspecs in the same order as they are given on
>     the command line and warning against them as we discover
>     problems is a property we would rather want to keep, so drop it
>     to make sure that we would catch regression when we accidentally
>     change the order in which these messages are given.
> 
> or something like that, perhaps.

Hmm, so do you want anything other than a commit message update?

ATB,
Ramsay Jones


