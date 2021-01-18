Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC16C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 07:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9996E224B8
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 07:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbhARH5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 02:57:09 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:55846 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733170AbhARH5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 02:57:07 -0500
Received: from [10.42.0.115] (cpe-173-88-170-197.neo.res.rr.com [173.88.170.197])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10I7uMGW005788
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 18 Jan 2021 02:56:23 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10I7uMGW005788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1610956584; bh=IZ9m+3T13TmKmA/sZpMzYI6YByGVC44Ire7WT14+WbM=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=SJOCNXK/W7ZruwD9di6MGpmdqRfqFjMfKk0oa9GGB5Rk6A3+PplfqR342dPB/aw42
         YXza+2kSoLRS97CTL+7Fe44ShcUwl7uPEBdHSCLFkaV1eamFQfDu4yYCHfIEo9cUSR
         bsSrQojdUQemGnJaGODcvzB4LYDf4pHnwqdCKO1Un4MbL1vn6z2wauiQ1b1vaHJJjy
         1puDNirs/csTM3+iJG1Mz/e5b75N9pYMqk1xv4zX9022mRGwm9Ldz07ZBCc3c31p9r
         k6XrkdqlmPhRvIkXPvvWgCPuCT6UXbv4fPGJplDAvOgShBhxmLYifaNhWx3XhhMnsV
         U47+baIarH/Bw==
From:   Kyle Marek <kmarek@pdinc.us>
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
 <20210117110337.429994-1-kmarek@pdinc.us>
 <20210117110337.429994-2-kmarek@pdinc.us>
 <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
Message-ID: <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>
Date:   Mon, 18 Jan 2021 02:56:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/21 4:10 PM, Junio C Hamano wrote:
> Kyle Marek<kmarek@pdinc.us>  writes:
>
>> This aids in identifying where an unrelated branch history starts when
>> using `git log --graph --oneline --all`
>>
>> Signed-off-by: Kyle Marek<kmarek@pdinc.us>
>> ---
>>   revision.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
> No tests?

I'm not very familiar with the code base. I now see the t/README file.

>> diff --git a/revision.c b/revision.c
>> index 9dff845bed..8556923de8 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -4191,9 +4191,11 @@ const char *get_revision_mark(const struct rev_info *revs, const struct commit *
>>   			return "<";
>>   		else
>>   			return ">";
>> -	} else if (revs->graph)
>> +	} else if (revs->graph) {
>> +		if (!commit->parents)
>> +			return "#";
>>   		return "*";
>> -	else if (revs->cherry_mark)
>> +	} else if (revs->cherry_mark)
>>   		return "+";
>>   	return "";
>>   }
> Here is what I tried to come up with, but somehow the "#" marker is
> not showing for me.
>
> The "counted plus --left-right" tests stress why a single "#" is not
> good enough.  I think the patch also needs to replace "<" and ">"
> for root commits that are left and right---in the tests, I used "L"
> to denote "root that is on the left side" (and "R" for the right
> side) instead of single "#", so that we do not to lose information.
>
> By the way, as I already said in the original thread, I do not think
> the '#' marking is a good idea; I'd rather see the root commit shown
> by shifting columns.

Sorry, I wasn't subscribed to the list until Jason CC'd me on his 
request. I also wasn't aware of --left-right.

I'll investigate the revision-mark shifting idea. I am concerned that it 
would get complicated if a graph edge extends around a revision that 
needs to be shifted, but I'm finding it difficult to produce this with 
--graph:

*   8d82d0a (HEAD -> master) Merge branch 'o1'
|\
| * 3479914 (o1) O1
| * a674e07 O1        <-- root commit
| * 2237b52 (t) T
| * f525fa5 T
|/
* f15f936 A
| * 9e289ed (u) U
|/
* ee911c8 initial     <-- root commit

vs:

*   8ee9b14 (HEAD -> master) Merge branch 'u'
|\
| * ed1990f (u) U
* |   277f31c Merge branch 'o1'
|\ \
| * | eaa71bb (o1) O1
| * | 9203a43 O1      <-- root commit
|  /
| | * bc2c4d9 (t) T
| | * 2d3c03b T
| |/
|/|
* | 6a26183 A
|/
* da85ccf initial     <-- root commit
  

Thoughts? Will git ever graph something like:

*
|\
| *
* |
|\ \
| * | <-- root commit
| * | <-- some head
|/ /
* /
|/
*     <-- root commit

-- 

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Kyle Marek                        PD Inc.http://www.pdinc.us  -
- Jr. Developer                     10 West 24th Street #100    -
- +1 (443) 269-1555 x361            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

