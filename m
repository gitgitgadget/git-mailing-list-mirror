Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4425C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833D720784
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDWUl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:41:56 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:46081 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgDWUl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 16:41:56 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jRifP-000BFe-4z; Thu, 23 Apr 2020 21:41:52 +0100
Subject: Re: [PATCH v3 1/2] date.c: skip fractional second part of ISO-8601
To:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
References: <cover.1586856398.git.congdanhqx@gmail.com>
 <cover.1587559135.git.congdanhqx@gmail.com>
 <c6d42785bb762f691b00c48b57c73a1933fadbc3.1587559135.git.congdanhqx@gmail.com>
 <xmqqk127jvrh.fsf@gitster.c.googlers.com> <20200423011812.GA1930@danh.dev>
 <xmqqmu72gfxu.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1861c472-7756-d433-9185-d83c03d72b9b@iee.email>
Date:   Thu, 23 Apr 2020 21:41:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqmu72gfxu.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/2020 20:28, Junio C Hamano wrote:
> Danh Doan <congdanhqx@gmail.com> writes:
>
>>>>  		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
>>>>  			tm->tm_hour = num;
>>>>  			tm->tm_min = num2;
>>> And after all that is done, if <num2> (and others) are within a
>>> reasonable range, we use that as HH:MM:SS.  
>>>
>>> OK.  If <num2> (or <num3>, or even <num> for that matter) weren't
>>> reasonable, is it still sensible to discard the fractional part?
>>> The answer is not immediately obvious to me.
>>>
>>> To be safe, it might make sense to extract a helper function from
>>> the next conditional, i.e.
>>>
>>> static int is_hms(long num1, long num2, long num3)
>> I'll make it `is_time` on par with is_date check.
> That is probably a lot more readable name than is_hms().  

I didn't immediately recognise hms and ymd (below) as abbreviations.
>
> I do not worry too much if the name is not "on par with" it, though,
> because is_date() does more than just "check", as you noticed below,
> unlike the "is hour-minute-seconds are within reasonable range?"
> check.
>
>> I'll look into it and check if int or long is suitable for parameter's
>> type.
>>
>>> {
>>> 	return (0 <= num1 && num1 < 25 &&
>>> 		0 <= num2 && num2 < 60 &&
>>> 		0 <= num3 && num3 <= 60);
>> Does it worth to add an explicit comment that we intentionally ignore
>> the old-and-defective 2nd leap seconds (i.e. second with value 61)?
>>
>> I saw in one of your previous email doubting if we should check for
>> `num3 <= 61` or not.
> I wrote that without checking anything, even what our own code does.
> As the existing code seems to want to work only with a second part
> that is 60 or less, not allowing a minute with 62 seconds, I think
> sticking to that and saying "0 <= num3 && num3 <= 60" is good.
>
>>> }
>>>
>>> and use it in the new "else if" block like so?
>>>
>>>
>>> 	} else if (*end == '.' && isdigit(end[1]) &&
>>> 		   is_date(tm->tm_year, tm->tm_mon, tm->tm_mday, NULL, now, tm) &&
>> When running into this, the code patch for non-approxidate hasn't
>> initialised value for now, yet.
> We may want to separate the logic that relies on the value of 'now'
> and 'now_tm->tm_year' out of is_date() to make it more easily
> reusable.  In this generic codepath, for example, we do not
> necessarily want to say "we refuse to parse timestamp that is 10
> days or more into the future".
>
> The longer I stare at is_date(), the more I am inclined to say it is
> a bit of impedance mismatch, and we instead should have the is_hms()
> helper as I suggested in the message you are responding to, plus
> something like:

Would is_hhmmss() and is_yyyymmdd() be more obvious abbreviations for
most readers?

Now that I type them, they do feel that bit too long... , as naming is
hard, maybe stick with the yms and hms, though I do keep wanting to type
ytd for the former..
>
> static int is_ymd(int year, int month, int day)
> {
>         /* like tm_to_time_t(), we only work between 1970-2099 */
> 	static const int days_in_month[] = {
> 		31, 28, 31, 30, ..., 31
> 	};
>
> 	return !(year < 1970 || 2100 <= year ||
> 		month <= 0 || 13 <= month ||
> 		day <= 0 || year / 4 + days_in_month[month-1] <= day);
> }
>
> and use it here.  I am not sure if we can reuse this inside
> is_date(), but if we can do so that would be good (and if we cannot,
> that is fine, too).
>
> Thanks.
--
Philip
