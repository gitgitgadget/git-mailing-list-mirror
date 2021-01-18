Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C27C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 07:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85BC22525
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 07:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbhARH5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 02:57:18 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:55854 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbhARH5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 02:57:17 -0500
Received: from [10.42.0.115] (cpe-173-88-170-197.neo.res.rr.com [173.88.170.197])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10I7uO2c005792
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 18 Jan 2021 02:56:25 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10I7uO2c005792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1610956586; bh=NUbn1VyL73+dnYYp95rZFEsToPJKPBMLZ39kcIfhejM=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=FMLta83Opk7bG131wEGfHuwAuh1JP6mp5Mg8y3MupyDB0PxMQmo60DKLJGLgYakly
         rSE6tf8QzpG1xnsKVHGgzk44zzhUJ+2Q/vLwF3vLC7aeVAt/teweASxnHDn5u7xVIF
         PAlb0AmdMpDvdXANrDwXZFaocnbP/SB6FlbraNnU/FyRMy9j21cYA00X7Xm0aDoBUD
         58y9iSbKlj2VQRxqRP9MrSFqBl4R+5JYyg5t6TTYKMstfSaT5Wvb1v1f2fBMWwcp70
         mr4X2+HcvPstGmURftzttThy+JFzxrrEzLNwqn6mHrddu1BzqHWNpxuw/J30xKC9HA
         hQ3J8uFf3jd9A==
From:   Kyle Marek <kmarek@pdinc.us>
Subject: Re: [PATCH 2/2] revision: implement --show-linear-break for --graph
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
 <20210117110337.429994-1-kmarek@pdinc.us>
 <20210117110337.429994-3-kmarek@pdinc.us>
 <xmqqsg6zkwa8.fsf@gitster.c.googlers.com>
 <xmqq35yzknbr.fsf@gitster.c.googlers.com>
Message-ID: <04c81462-3181-37d7-0109-4292040b84e9@pdinc.us>
Date:   Mon, 18 Jan 2021 02:56:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq35yzknbr.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/21 9:09 PM, Junio C Hamano wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> In other words, revs->break_revision_mark is left NULL unless
>> --show-linear-break is given.
>>
>>> @@ -4192,8 +4192,8 @@ const char *get_revision_mark(const struct rev_info *revs, const struct commit *
>>>   		else
>>>   			return ">";
>>>   	} else if (revs->graph) {
>>> -		if (!commit->parents)
>>> -			return "#";
>>> +		if (revs->break_revision_mark && !commit->parents)
>>> +			return revs->break_revision_mark;
>> And that causes this to break.  Now "--graph" alone won't show '#'
>> for the root commits, despite that is what [1/2] wanted to do.
>>
>> Here is a fix-up, plus some minimum tests.
> Having said all that, I do not mind if the new markings were
> activated only when --show-linear-break option (or a separate new
> option) is given.  But if that is where we want to go, your [1/2]
> that uses the new markings unconditionally is a regression.
>
> A better organization, if we wanted to have multiple and smaller
> steps than a single whole thing, would be:
>
>   [1/2] Introduce a new "--mark-root-commits" option, or abuse the
>         existing "--show-linear-break" option, and change "*<>"
>         marking used for commits to "#LR" (or whatever appropriate)
>         when the option is in effect.  Document the behaviour and add
>         tests.
>
>   [2/2] Introduce "--show-linear-break=<custom-value>" option.
>         Document the behaviour and add tests.
>
> If you apply [1/2] and [2/2] with the earlier fixes I sent, you'll
> see many fallouts from existing tests, as the representation of the
> root commit is changed unconditionally.  We view breakages of tests
> as a rough estimate of how badly end-user scripts could break, and
> the picture was not very pretty.  And that is why I am suggesting
> the above "only do the new markings when asked, not unconditionally"
> approach.

Sorry. I didn't make this clear. It is not an accident that patch 1 
denotes root commits unconditionally and patch 2 makes it optional. I 
present two choices. If we prefer to unconditionally denote root 
commits, patch 2 may be left out, otherwise, patch 1 should be squashed 
away.

I didn't have an opinion towards either option, but you make a good 
point about end-user scripts.

> I still am skeptical that spending 3 more letters to denote roots is
> worth it, though.

Me too, but I think a user-defined mark needs to be a string to support 
Unicode characters.

-- 

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Kyle Marek                        PD Inc.http://www.pdinc.us  -
- Jr. Developer                     10 West 24th Street #100    -
- +1 (443) 269-1555 x361            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

