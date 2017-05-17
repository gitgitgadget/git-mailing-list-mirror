Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393C1201A7
	for <e@80x24.org>; Wed, 17 May 2017 20:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbdEQUs7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 16:48:59 -0400
Received: from avasout07.plus.net ([84.93.230.235]:50462 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdEQUs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 16:48:58 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id MYov1v0051keHif01YoxGY; Wed, 17 May 2017 21:48:57 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=pJ1g7XDVtAwV4EuFfrUA:9 a=QEXdDO2ut3YA:10
 a=ezPG0ZpnnpEA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: t5545: reduced test coverage
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ca942ab1-db57-5794-4587-1a756686c833@ramsayjones.plus.com>
 <xmqqbmqsyzn7.fsf@gitster.mtv.corp.google.com>
 <xmqqmvacxhk0.fsf@gitster.mtv.corp.google.com>
 <xmqqinl0xga6.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <17124bdc-c6cb-5f1a-5021-7c92ad7e669c@ramsayjones.plus.com>
Date:   Wed, 17 May 2017 21:48:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqinl0xga6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/05/17 05:23, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> It appears to me that only a few tests in the entire script wants to
>>> work with HTTP server, so perhaps moving them to the end, together
>>> with the inclusion of lib-httpd and start_httpd that 438fc684 ("push
>>> options: pass push options to the transport helper", 2017-02-08)
>>> introduced, may be sufficient?
>>
>> Probably not, as lib-httpd, when it gives up, does the
>> "skip_all=message; test_done" thing, which makes test_done
>> to trigger this:
>>
>> 	# Maybe print SKIP message
>> 	if test -n "$skip_all" && test $test_count -gt 0
>> 	then
>> 		error "Can't use skip_all after running some tests"
>> 	fi
>>
>> So a bit more work is needed, than just moving things around, I am
>> afraid...
> 
> And now I am visiting bf4b7219 ("test-lib.sh: Add check for invalid
> use of 'skip_all' facility", 2012-09-01), which is yours ;-)

Indeed. :-D

> I am wondering what the fallouts would be if we did the following to
> test-lib.  We used to say "1..0 # SKIP <why>" when we skip
> everything, which is still kept, so that prove can notice why things
> are skipped.
> 
> When we abort early but after executing any test, we used to error
> out, but instead we pretend that the test finished right there, as
> it seems that we are not allowed to say "1..4 # SKIP <why>" after
> running 4 tests.

Yes, I had this exact 'Huh?' moment back in 2012. I remember spending
quite a long time searching 'TAP specification' documents, in order to
get an answer to this. It was so long ago (and I can't find the links
to those documents now), but I have a vague recollection that prove's
behaviour is correct in allowing '1..0 <skip message>', while throwing
a fit at '1..n <any message>' (for n > 0).

I would probably have simply split the test file into two, but ...

>  t/test-lib.sh | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 13b5696822..46f29cf112 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -745,20 +745,25 @@ test_done () {
>  	fi
>  	case "$test_failure" in
>  	0)
> -		# Maybe print SKIP message
> -		if test -n "$skip_all" && test $test_count -gt 0
> -		then
> -			error "Can't use skip_all after running some tests"
> -		fi
> -		test -z "$skip_all" || skip_all=" # SKIP $skip_all"
> -
>  		if test $test_external_has_tap -eq 0
>  		then
>  			if test $test_remaining -gt 0
>  			then
>  				say_color pass "# passed all $msg"
>  			fi
> -			say "1..$test_count$skip_all"
> +
> +			# Maybe print SKIP message
> +			test -z "$skip_all" || skip_all="# SKIP $skip_all"
> +			case "$test_count" in
> +			0)			    
> +				say "1..$test_count${skip_all:+ $skip_all}"
> +				;;
> +			*)
> +				test -z "$skip_all" ||
> +				say_color warn "$skip_all"
> +				say "1..$test_count"
> +				;;
> +			esac
>  		fi
>  
>  		test -d "$remove_trash" &&

... this looks good to me. (tested on Linux and cygwin).

Thanks!

ATB,
Ramsay Jones

