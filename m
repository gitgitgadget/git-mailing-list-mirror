Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFBF0208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbdHOUqZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 16:46:25 -0400
Received: from siwi.pair.com ([209.68.5.199]:55805 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752661AbdHOUqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 16:46:24 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8C3A6844ED;
        Tue, 15 Aug 2017 16:46:22 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8CB67844EC;
        Tue, 15 Aug 2017 16:46:22 -0400 (EDT)
Subject: Re: tsan: t3008: hashmap_add touches size from multiple threads
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
 <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <cff383c2-ca57-caba-5a46-7dec4abc25a4@jeffhostetler.com>
 <CAGZ79kbf52Uu-Th9W20QZV204A81kOAPTj2x6JkEP1rN=GTYtw@mail.gmail.com>
 <CAN0heSoXysu=6E_ScfWQVLOk805V=j7AYJi=z62SmNkP5U=A9Q@mail.gmail.com>
 <CAGZ79kb-1S9F4Pp0dzkDX488uiZ8Zu_1m2U=hQ1CcsgSu314rQ@mail.gmail.com>
 <CAN0heSr-OcLJU54acTdXWx8NAo=nPD=9+DfexWZ0F7NRgRB9Dg@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <217f3160-f4cb-581a-b7f3-8b654c74d080@jeffhostetler.com>
Date:   Tue, 15 Aug 2017 16:46:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSr-OcLJU54acTdXWx8NAo=nPD=9+DfexWZ0F7NRgRB9Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/15/2017 3:21 PM, Martin Ågren wrote:
> On 15 August 2017 at 20:48, Stefan Beller <sbeller@google.com> wrote:
>>>>>          /* total number of entries (0 means the hashmap is empty) */
>>>>> -       unsigned int size;
>>>>> +       /* -1 means size is unknown for threading reasons */
>>>>> +       int size;
>>>>
>>>> This double-encodes the state of disallow_rehash (i.e. if we had
>>>> signed size, then the invariant disallow_rehash === (size < 0)
>>>> is true, such that we could omit either the flag and just check for
>>>> size < 0 or we do not need the negative size as any user would
>>>> need to check disallow_rehash first. Not sure which API is harder
>>>> to misuse. I'd think just having the size and getting rid of
>>>> disallow_rehash might be hard to to reused.
>>>
>>> (Do you mean "might be hard to be misused"?)
>>
>> yes, I do.
>>
>>> One good thing about turning off the size-tracking with threading is
>>> that someone who later wants to know the size in a threaded application
>>> will not introduce any subtle bugs by misusing size, but will be forced
>>> to provide and use some sort of InterlockedIncrement().
>>
>> agreed.
>>
>>> When/if that
>>> change happens, it would be nice if no-one relied on the value of size
>>> to say anything about threading. So it might make sense to have an
>>> implementation-independent way of accessing disallow_rehash a.k.a.
>>> (size < 0).
>>
>> Yes, and my point was whether we want to keep disallow_rehash around,
>> as when a patch as this is applied, we'd have it encoded twice,
>> both size < 0 as well as disallow_rehash set indicate the rehashing
>> disabled.
>>
>> If we were to reduce it to one, we would not have "invalid" state possible
>> such as size < 0 and disallow_rehash = 0.
> 
> Agreed.
> 
>> In the future we may have more options that make size impossible to
>> compute efficiently, such that in that case we'd want to know which
>> condition lead to it. In that case we'd want to have the flags around.
> 
> Good point.

I feel like we're trying to push hashmaps a little beyond
their capability.  I mean the core hashmap code is NOT thread
safe.  The caller is responsible for carefully controlling how
the hashmap is used and whatever locking strategy it wants --
whether it is a single lock on the entire hashmap -- or a set
of partition-specific locks like I created here.  Whatever the
strategy, it is outside of hashmap.[ch].

Perhaps it would be best to just define things as:
* let (size < 0) mean we choose not to compute/track it (without
   saying why).
* keep "disallow_rehash = 1" to mean we do not want automatic
   resizing (without saying why).

Thread-aware callers will set both.

Thread-aware callers (when finished with threaded operations)
can themselves choose whether to compute the correct size and
re-allow rehashing.  And we can add a method to hashmap.c to
re-calculate the size if we want.


In my lazy_init_name_hash() I set "disallow", do the threaded
code, and then unset "disallow" -- mainly to keep the usage
consistent with the non-threaded case.  I could just as easily
set "disallow" and leave it that way -- the question is whether
we care if the hashmap automatically resizes later.  (I don't.)


>>> For example a function hashmap_disallow_rehash(), except that's
>>> obviously taken. :-) Maybe the existing function would then be
>>> hashmap_set_disallow_rehash(). Oh well..
>>
>> Not sure I understand this one.
> 
> Sorry. What I meant was, if we drop the disallow_rehash-field, someone
> might be tempted to use size < 0 (or size == -1) to answer the question
> "is rehashing disallowed?". (Or "am I threaded?" which already is a
> question which the hashmap as it is today doesn't know about.)
> 
> So instead of looking at "disallow_rehash" one should perhaps be calling
> "hashmap_is_disallow_rehash()" or "hashmap_get_disallow_rehash()", which
> would be implemented as "return disallow_rehash", or possibly "return
> size == -1".
> 
> Except such names are, to the best of my understanding, not the Git-way,
> so it should be, e.g., "hashmap_disallow_rehash()".
> 
> Except ... that name is taken.... So to free that name up, the existing
> function should perhaps be renamed "hashmap_set_disallow_rehash()",
> again assuming I've picked up the right conventions in my recent
> browsing of the Git-code.
> 
> The final "Oh well" was a short form of "it began with an observation
> which currently has no practical effect, and is slowly turning into a
> chain of ideas on how to rebuild the interface".
> 
