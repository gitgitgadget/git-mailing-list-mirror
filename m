Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73F51F404
	for <e@80x24.org>; Thu, 30 Aug 2018 13:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeH3RtV (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 13:49:21 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:5930 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeH3RtV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 13:49:21 -0400
Received: from [192.168.1.11] ([92.2.147.78])
        by smtp.talktalk.net with SMTP
        id vNHsffcAsbZX5vNHsfD4vR; Thu, 30 Aug 2018 14:47:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1535636825;
        bh=W6yjKzOnWWAdkegwZjMetBiqFcY4ADSo6lC0Y6hVuuI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QP0/yeGq9SZMPA6R1QpsG8VeoTb2YcVwXCy7/I7sBW+YMQvERuDRU9c3YY0B7SJW0
         8CFWblTdf8KV0/dtCWk4yp2bxTpO8Udf2mgnmgZPDzGSh2UmxWqUClSdkywdhka5EE
         TmPmx2Et7C0qSVNl+LMDvQAcrdkdn3jFQ9zsS48I=
X-Originating-IP: [92.2.147.78]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=pQayyGo/WMwZmys47m2ZwQ==:117
 a=pQayyGo/WMwZmys47m2ZwQ==:17 a=IkcTkHD0fZMA:10 a=rS_2w5xYUxJKLV8wfe0A:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
To:     Junio C Hamano <gitster@pobox.com>,
        Jochen Sprickerhof <git@jochen.sprickerhof.de>
Cc:     git@vger.kernel.org
References: <20180828085858.3933-1-git@jochen.sprickerhof.de>
 <xmqq36uygyau.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>
Date:   Thu, 30 Aug 2018 14:47:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq36uygyau.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPXW6E19gMgGlq1EBB7ThaLdYbv/xSjXINtII9KmFNi2kk9VJgvF3OeIRXD6ahfnjJh6C8yJe1NrK+TfHCjzjWGuweJIPNrHMfoUHp2W0kik3l5riE5d
 uQNK9c7IX7eUJj2zgFoLwOVCa7Doqy2FtJU+CDqkPt26xzmMowl1I9yfrgr12/qb9+SqWfcGnOdUZFLNDA0sbU8rm5lPHVsaPs2fC7aAKfxtUdHjmwn9yFxD
 mBJgwifdpIQPRNm592Pg8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Jochen/Junio

On 28/08/18 19:07, Junio C Hamano wrote:
> Jochen Sprickerhof <git@jochen.sprickerhof.de> writes:
> 
>> When a hunk was split before being edited manually, it does not apply
>> anymore cleanly. Apply coalesce_overlapping_hunks() first to make it
>> work. Enable test for it as well.
>>
>> Signed-off-by: Jochen Sprickerhof <git@jochen.sprickerhof.de>
>> ---
>>   git-add--interactive.perl  | 8 ++++----
>>   t/t3701-add-interactive.sh | 2 +-
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
>> index 36f38ced9..c9f434e4a 100755
>> --- a/git-add--interactive.perl
>> +++ b/git-add--interactive.perl
>> @@ -1195,10 +1195,10 @@ sub edit_hunk_loop {
>>   		# delta from the original unedited hunk.
>>   		$hunk->{OFS_DELTA} and
>>   				$newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
>> -		if (diff_applies($head,
>> -				 @{$hunks}[0..$ix-1],
>> -				 $newhunk,
>> -				 @{$hunks}[$ix+1..$#{$hunks}])) {
>> +		my @hunk = @{$hunks};
>> +		splice (@hunk, $ix, 1, $newhunk);
>> +		@hunk = coalesce_overlapping_hunks(@hunk);
>> +		if (diff_applies($head, @hunk)) {
>>   			$newhunk->{DISPLAY} = [color_diff(@{$newtext})];
>>   			return $newhunk;
>>   		}
> 
> OK.  I think I understand how this may be needed in certain forms of
> edit. 

When $newhunk is created it is marked as dirty to prevent 
coalesce_overlapping_hunks() from coalescing it. This patch does not 
change that. What is happening is that by calling 
coalesce_overlapping_hunks() the hunks that are not currently selected 
are filtered out and any hunks that can be coalesced are (I think that 
in the test that starts passing with this patch the only change is the 
filtering as there's only a single hunk selected).

This is a subtle change to the test for the applicability of an edited 
hunk. Previously when all the hunks were used to create the test patch 
we could be certain that if the test patch applied then if the user 
later selected any unselected hunk or deselected any selected hunk then 
that operation would succeed. I'm not sure that is true now (but I 
haven't thought about it for very long). We could restore the old test 
condition and coalesce the hunks by copying all the hunks and setting 
$hunk->{USE}=1 when creating the test patch if that turns out to be 
useful (it would be interesting to see if the test still passes with 
that change).

Best Wishes

Phillip

  I do not think coalesce would reliably work against arbitrary
> kind of edit, but the function is called at the end of the loop of
> the caller of this function anyway, so it is not like this is making
> anything worse at all.  Let's queue it and try it out.
> 
> Thanks.
> 
> All of the following is a tangent for future/further work, and
> should not be done as part of your patch.  While this change may
> work around the immediate issue of diff_applies() returning "no", it
> makes it feel a bit iffy to keep the interface to return $newhunk.
> 
> With the current interface, the function is saying the caller "here
> is a text that shows a new hunk, when spliced back into the @hunk
> array and coalesced together with others, would apply cleanly to the
> current index".  But the corrected code is already doing a trial
> splice with trial coalescing anyway, so perhaps it may make more
> sense to update the interface into this function for the caller to
> say "the user asks to edit $ix'th hunk in @$hunks" and the function
> to answer "Here is the edited result in @$hunks; I've made sure it
> would cleanly apply".
> 
> Incidentally, that would make it possible in the future to allow
> edit_hunk_loop to be told "the user wants to edit this $ix'th hunk",
> allow the editor to split that hunk into multiple hunks, and return
> the result by stuffing them (not just a single $newhunk) into the
> @hunk array.  The caller's loop could then further select or join
> these hunks---such an interaction is impossible with the current
> interface that allows edit_hunk_loop to take a single hunk and
> return a single newhunk.
> 
> But again, all of the above is a tangent for future/further work,
> and should not be done as part of your patch.
> 
