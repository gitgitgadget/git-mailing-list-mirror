Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAB9C433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhL2QNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 11:13:08 -0500
Received: from siwi.pair.com ([209.68.5.199]:28266 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232040AbhL2QNH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 11:13:07 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 77EDC3F47EE;
        Wed, 29 Dec 2021 11:13:06 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 153ED3F4047;
        Wed, 29 Dec 2021 11:13:06 -0500 (EST)
Subject: Re: [RFC PATCH 19/21] usage API: use C99 macros for
 {usage,usagef,die,error,warning,die}*()
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
 <RFC-patch-19.21-0bbca8cca8e-20211115T220831Z-avarab@gmail.com>
 <66b25f23-7349-1540-76b8-c9f0a64660ac@jeffhostetler.com>
 <211228.861r1xk40d.gmgdl@evledraar.gmail.com>
 <9952005b-9174-7578-7718-e9576b27b4ce@jeffhostetler.com>
Message-ID: <06033cd6-8766-0e9e-9952-b03658dd2e31@jeffhostetler.com>
Date:   Wed, 29 Dec 2021 11:13:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9952005b-9174-7578-7718-e9576b27b4ce@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/28/21 11:32 AM, Jeff Hostetler wrote:
> 
> 
> On 12/27/21 6:01 PM, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Mon, Dec 27 2021, Jeff Hostetler wrote:
>>
>>> On 11/15/21 5:18 PM, Ævar Arnfjörð Bjarmason wrote:
>>> [...]
>>
>> So being able to say "just group on file/line" would be simpler.
>>
>> And also "mostly" because the "fmt" case also won't handle these and
>> other duplicate formats (but maybe you haven't run into them in
>> practice):
>>
>>      $ git grep -E '\b(usage|die|error|warning)(_errno)?\("%s\"' -- 
>> '*.[ch]' | wc -l
>>      90
>>
>> So I was somewhat hoping for future work that you'd be OK with the new
>> file/line grouping.
>>
>> Because keeping "fmt" would eventually need some massive coccinelle
>> search/replacement for "_(...)" -> "N_(...)" per the above, even then
>> consumers of the stream would get duplicate grouping for the likes of
>> "%s".
>>
>> Do you think if as a follow-up we had "__func__"[1] along with
>> "file/line" that the "file/__func__" combination would be good enough?
>> The advantage of that would be that we could punt that "fmt"
>> change/complexity and document:
>>
>>      If you'd like to group errors the "file/line" pair will be unique
>>      enough within a given git version to do so (sans a few codepaths 
>> that
>>      relay errors from elsewhere).
>>
>>      If you'd like a semi-stable grouping across similar git versions the
>>      "file/func" pair should be Good Enough for most purposes. Some 
>> functions
>>      might emit multiple errors, but you'd probably want to group them as
>>      similar enough anyway.
>>
>> But I realize that those things don't give you exactly the same things
>> that "fmt" does, but maybe they're good enough (or even better?), or
>> not.
>>
>> 1. https://gcc.gnu.org/onlinedocs/gcc/Function-Names.html
>>
> 
> I'll have to think about this some and get back to you.

I think I'd rather just have the "fmt" string in the log.

I don't think the file:line or func:line helps here.  Elsewhere
in this thread we've talked about having to support a user base
running various versions of Git (and don't forget to mix in GFW
and the GVFS-enabled version of Git).

Keep in mind that some users enable (or their EngSys/IT team
enables for them) brief mode (GIT_TRACE2_EVENT_BRIEF)
which omits the file:line data from the log.  This reduces the
size of the data stream on all events, so we don't have that
data for some users -- and forcing it on would send a lot more
data and cost a lot more than any savings from omitting the
somewhat redundant "fmt" field.

Just having the format string usually lets us track down the
error/die call in the code using just grep (unless it is one of
those `die("%s",...)` cases (which should be fixed independent
of this discussion)).  As Elijah mentioned elsewhere in this
thread, just having the format string doesn't mean we know exactly
which path/branch in the code lead us to that error, so local
analysis is still required if we want to kill a "top 10" item.
Having file:line doesn't help with that local effort.

As for handling translations, I'm not really worried about it.
If a post-processor really wants to get complete aggregations
independent of the users locale they could maybe build a tool
to load up the .po files, build a reverse index, and add a table
to their database that they could join with.  I'm speculating
here that anyone would want to go to that trouble, but it is
possible.  And it would keep all of this churn out of Git code.

Coalescing the format strings is the simplest by far.  So I'd
really like to leave things the way they are.

Jeff

