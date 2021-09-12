Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38D6C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 16:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3C6610CE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 16:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhILQRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 12:17:22 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:39794 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhILQRV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 12:17:21 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mPS9D-0007yr-Be; Sun, 12 Sep 2021 17:16:06 +0100
Subject: Re: Question about timezones in commit & tag dates
To:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <b39aab0a-bf53-9e33-59a7-d4f1a06e72a7@gigacodes.de>
 <87fsu997wn.fsf@evledraar.gmail.com>
 <b121acdf-354f-c896-d2f6-b221ea2443c1@gigacodes.de>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1002242a-a353-a904-5c1a-f23b0c5ed1a3@iee.email>
Date:   Sun, 12 Sep 2021 17:16:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b121acdf-354f-c896-d2f6-b221ea2443c1@gigacodes.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/2021 16:07, Fabian Stelzer wrote:
> On 12.09.21 16:21, Ævar Arnfjörð Bjarmason wrote:
>> On Sun, Sep 12 2021, Fabian Stelzer wrote:
>>
>>> Hi,
>>> while working on correct key rollover and verifying signatures for past
>>> commits for the ssh signing topic i am trying to understand how Git
>>> deals with timestamps for commits & tags.
>>> For ssh signing the user will manage expiration times within their
>>> allowedSigners file. Those timestamps do not carry a timezone and i
>>> would assume a user (or automatic generation of this file) will assume
>>> the systems timezone for them.
>>> Therefore i wanted to pass the commit & tags timestamps adjusted to the
>>> system timezone to make sure key rollover will have no gaps or failed
>>> verification's especially when commit and system timezone differ greatly
>>> and might roll over to another day.
>>>
>>> However the commit & tags structs only seem to carry the objects
>>> timestamp as is, simply ignoring any timezone information. For the ssh
>>> feature i can easily enough parse the ident line again from the object
>>> header. But while looking at the usage of the existing date fields i can
>>> see that objects are sometimes sorted on and compared by these dates.
>>> When commands provide cut off times (--since) i think they might include
>>> or exclude commits erroneously when they were made in a different
>>> timezone around the cutoff date. ("log --since" indeed gives me some
>>> unexpected results when mixing multiple timezones. Based on some simple
>>> testing i think it just stops output when a commit falls outside of this
>>> window, even though there might be one before it wich is within)
>>>
>>> Is my understanding of this correct and this the expected behaviour?
>>> I think generally for git this does not matter much. But in certain
>>> situations this is problematic.
>>>
>>> I would have assumed that git would either add the timezone as well or
>>> adjust the commit timestamp upon populating the date field in the commit
>>> struct to UTC but i could not find anything like it.
>> Timezones are ultimately display information that's confusing to humans,
>> but not machines. Machines just need to deal with epochs, or when a
>> human supplies them a date convert a formatted date + timezone pair to
>> an epoch.
>>
>> So in the key expiry case, I'd expect that any such system would say
>> issue keys right now, now as in time(NULL), and we'd set those keys to
>> expire after some time, say 1 day, so time(NULL) + 60 * 60 * 24;
>>
>> If you're in UTC that might yield a very satisfying (to humans, a
>> machine won't care) expiry time. I.e. you'll get keys issued say at
>> midnight, and expiring midnight the following day.
>>
>> What you're saying sounds to me like you're conflating the two
>> things.
> You are correct. I somehow thought the stored timestamp would be in the
> specified timezone when it is not. The timezone is only used as
> reference for display.
>
>> Anyway, maybe I've misunderstood you. I just don't see how something
>> like key expiry would need to concern itself with anything but
>> epochs. If you conflate timezones with that and say "here's a key, it
>> expires at mindight" surely you'll have some keys last mere seconds,
>> others 10 hours etc.
>>
> The ssh allowedSigners file specifies key expiry in a "%Y%m%d%H%M%S"
> format without any timezone information. So i have to assume the systems
> timezone is used.
> But correcting my misconception of the stored commit timestamp i can
> simply present it in the systems timezone for ssh to compare it with the
> specified expiry date.
>
> Thanks for your help!
It is possible to have, near the international date line, places that
are more than 24 hours apart (local/calendar time), E.g compare Pago
Pago (-11) and Apia (+13).
In the wrong conditions, a 24hr expiry, using local/calendar time, could
have already expired at a near neighbour, because of the shift in their
local times. It ('date/time') is tricky confusing stuff without careful
consideration of the standards and terminology [1,2]. Regular folks can
easily be confused ;-) Sometimes things need spelling out rather more
than one may have expected/hoped.

[1] https://en.wikipedia.org/wiki/System_time and
[2] https://en.wikipedia.org/wiki/Unix_time
--
Philip
