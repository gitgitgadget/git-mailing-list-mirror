Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B9420899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdHHTjR (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:39:17 -0400
Received: from avasout05.plus.net ([84.93.230.250]:37667 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbdHHTjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:39:16 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout05 with smtp
        id ujfE1v00118PUFB01jfFzm; Tue, 08 Aug 2017 20:39:15 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Iav3YSia c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=FEWp7enXAAAA:8 a=nbrm1AV8fFJFaNuTDr4A:9 a=QEXdDO2ut3YA:10
 a=IjYSrUNMXUflr7qE6tl5:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2] t3700: fix broken test under !POSIXPERM
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
References: <ed5c4105-a383-ef7c-c8de-75f22d41edbe@web.de>
 <7c104440-5903-472c-36c2-779cd0e81be5@web.de>
 <d6c6c246-ef15-64dd-208f-e8a4c240bd3d@ramsayjones.plus.com>
Message-ID: <5b918c3f-a518-3a7b-716e-a5dbe690cf0e@ramsayjones.plus.com>
Date:   Tue, 8 Aug 2017 20:39:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <d6c6c246-ef15-64dd-208f-e8a4c240bd3d@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/08/17 20:32, Ramsay Jones wrote:
> 
> 
> On 08/08/17 20:21, René Scharfe wrote:
>> 76e368c378 (t3700: fix broken test under !SANITY) explains that the test
>> 'git add --chmod=[+-]x changes index with already added file' can fail
>> if xfoo3 is still present as a symlink from a previous test and deletes
>> it with rm(1).  That still leaves it present in the index, which causes
>> the test to fail if POSIXPERM is not defined.  Get rid of it by calling
>> "git reset --hard" as well, as 76e368c378 already mentioned in passing.
> 
> Hmm, I don't think its POSIXPERM (which is defined on cygwin) but
> the lack of SANITY that is the problem. The test would fail on Linux
> as well, if it skipped the prior tests marked with SANITY (they get
> rid of the xfoo3->xfoo2 symlinks, among others).

Yep, I didn't read the commit message properly! ;-)

> 
> Ack, this fixes it for me.
> 
> ATB,
> Ramsay Jones
> 
>>
>> Helped-by: Adam Dinwoodie <adam@dinwoodie.org>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> Change since v1: Keep the rm(1) call to avoid a problem on Cygwin.
>>
>>  t/t3700-add.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
>> index f3a4b4a913..0aae21d698 100755
>> --- a/t/t3700-add.sh
>> +++ b/t/t3700-add.sh
>> @@ -356,6 +356,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
>>  
>>  test_expect_success 'git add --chmod=[+-]x changes index with already added file' '
>>  	rm -f foo3 xfoo3 &&
>> +	git reset --hard &&
>>  	echo foo >foo3 &&
>>  	git add foo3 &&
>>  	git add --chmod=+x foo3 &&
>>
> 
