Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE5CC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 16:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhL1Qcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:32:43 -0500
Received: from siwi.pair.com ([209.68.5.199]:38228 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235914AbhL1Qci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 11:32:38 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8B2A43F410F;
        Tue, 28 Dec 2021 11:32:36 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 17A293F412F;
        Tue, 28 Dec 2021 11:32:36 -0500 (EST)
Subject: Re: [RFC PATCH 19/21] usage API: use C99 macros for
 {usage,usagef,die,error,warning,die}*()
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
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9952005b-9174-7578-7718-e9576b27b4ce@jeffhostetler.com>
Date:   Tue, 28 Dec 2021 11:32:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211228.861r1xk40d.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/27/21 6:01 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 27 2021, Jeff Hostetler wrote:
> 
>> On 11/15/21 5:18 PM, Ævar Arnfjörð Bjarmason wrote:
>> [...]
>>> It might be a good change to remove the "fmt" key from the "error"
>>> events as a follow-up change. As these few examples from running the
>>> test suite show it's sometimes redundant (same as the "msg"), rather
>>> useless (just a "%s"), or something we could now mostly aggregate by
>>> file/line instead of the normalized printf format:
>>>         1 file":"builtin/gc.c","line":1391,"msg":"'bogus' is not a
>>> valid task","fmt":"'%s' is not a valid task"}
>>>         1 file":"builtin/for-each-ref.c","line":89,"msg":"format: %(then) atom used more than once","fmt":"%s"}
>>>         1 file":"builtin/fast-import.c","line":411,"msg":"Garbage after mark: N :202 :302x","fmt":"Garbage after mark: %s"}
>>> "Mostly" here assumes that it would be OK if the aggregation changed
>>> between git versions, which may be what all users of trace2 want. The
>>> change that introduced the "fmt" code was ee4512ed481 (trace2: create
>>> new combined trace facility, 2019-02-22), and the documentation change
>>> was e544221d97a (trace2: Documentation/technical/api-trace2.txt,
>>> 2019-02-22).
>>> Both are rather vague on what problem "fmt" solved exactly, aside
>>> from
>>> the obvious one of it being impossible to do meaningful aggregations
>>> due to the "file" and "line" being the same everywhere, which isn't
>>> the case now.
>>> In any case, let's leave "fmt" be for now, the above summary was
>>> given
>>> in case it's interesting to remove it in the future, e.g. to save
>>> space in trace2 payloads.
>>
>> I added the "fmt" field so that we could do aggregations
>> of error messages across multiple users without regard
>> to what branch or filename or percentage or whatever was
>> formatted into the actual "msg" written to stderr.
>>
>> The actual file:line wasn't useful (primarily because it
>> was probably something in usage.c), but even if we fix that
>> it might not be useful if we have users running 10 different
>> versions of Git (because some people don't upgrade immediately).
>>
>> So I'd rather not kill it right now.
> 
> Thanks. I'm not trying to kill it, but just poking at what it was for
> exactly.
> 
> Depending on the answer to that perhaps we didn't need it anymore, but
> the explanation you provide (mostly) makes sense.
> 
> The "mostly" being because I'm assuming that you only need to deal with
> LC_ALL=C users?
> 
> I.e. the documented promise that you can group things by "fmt" doesn't
> hold if you're processing even streams from users who are using a
> translated git, because we'll get the translated format string, not the
> original.

I just did a query on the data we've collected over the last
few weeks and there are only English error messages in the
database, so yes LC_ALL=C seems to be the norm.

> 
> For that we'd need to change the API from/to to:
> 
>      - error(_("some format %s"), ...)
>      + error(N_("some format %s"), ...)

So no, I don't think it is worth the complexity to change
this.  Besides, wouldn't you need to more machinery under
the hood -- to emit the untranslated string to trace2 and
the translated string to stderr?  (As in, move the translation
down a layer??)

My "fmt" field is not worth that effort.

And besides, my goal was only to get the "top 10 or 20 errors"
across a large set of users.  I guess I'm thinking of it as a
sample rather than an exhaustive list, so it is OK if we don't
capture the translated strings.


Something else to consider is the GDPR.  The "fmt" string is
generic (e.g. "path '%s' exists on disk, but not in the index")
but doesn't leak an PII or otherwise sensitive data.  Whereas
the corresponding "msg" field does include the pathname in this
example.  So if someone is post-processing the data and aggregating,
they may want to relay only the "fmt" field and not the "msg" field
to their database.

(Granted, there are lots of PII and GDPR problematic fields in
the data stream that a post-processor would need to be aware of,
but all of that is outside of the scope of the Trace2 logging.
I only mention it here because the "fmt" field may be useful for
reasons not previously discussed.)

> 
> So being able to say "just group on file/line" would be simpler.
> 
> And also "mostly" because the "fmt" case also won't handle these and
> other duplicate formats (but maybe you haven't run into them in
> practice):
> 
>      $ git grep -E '\b(usage|die|error|warning)(_errno)?\("%s\"' -- '*.[ch]' | wc -l
>      90
> 
> So I was somewhat hoping for future work that you'd be OK with the new
> file/line grouping.
> 
> Because keeping "fmt" would eventually need some massive coccinelle
> search/replacement for "_(...)" -> "N_(...)" per the above, even then
> consumers of the stream would get duplicate grouping for the likes of
> "%s".
> 
> Do you think if as a follow-up we had "__func__"[1] along with
> "file/line" that the "file/__func__" combination would be good enough?
> The advantage of that would be that we could punt that "fmt"
> change/complexity and document:
> 
>      If you'd like to group errors the "file/line" pair will be unique
>      enough within a given git version to do so (sans a few codepaths that
>      relay errors from elsewhere).
> 
>      If you'd like a semi-stable grouping across similar git versions the
>      "file/func" pair should be Good Enough for most purposes. Some functions
>      might emit multiple errors, but you'd probably want to group them as
>      similar enough anyway.
> 
> But I realize that those things don't give you exactly the same things
> that "fmt" does, but maybe they're good enough (or even better?), or
> not.
> 
> 1. https://gcc.gnu.org/onlinedocs/gcc/Function-Names.html
> 

I'll have to think about this some and get back to you.
Jeff

