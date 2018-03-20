Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42861F404
	for <e@80x24.org>; Tue, 20 Mar 2018 16:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCTQoY (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 12:44:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:20307 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbeCTQoV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 12:44:21 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8004B3F4013;
        Tue, 20 Mar 2018 12:44:20 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id ECC633F4004;
        Tue, 20 Mar 2018 12:44:19 -0400 (EDT)
Subject: Re: [PATCH 0/2] routines to generate JSON data
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180316194057.77513-1-git@jeffhostetler.com>
 <20180316211837.GB12333@sigill.intra.peff.net>
 <e2a9d2a9-f2e2-f285-52c3-be11668da543@jeffhostetler.com>
 <20180320054223.GC15813@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <09dca55b-6c8b-2793-901d-d9f2cf5dd873@jeffhostetler.com>
Date:   Tue, 20 Mar 2018 12:44:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320054223.GC15813@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/20/2018 1:42 AM, Jeff King wrote:
> On Mon, Mar 19, 2018 at 06:19:26AM -0400, Jeff Hostetler wrote:
> 
>>> To make the above work, I think you'd have to store a little more state.
>>> E.g., the "array_append" functions check "out->len" to see if they need
>>> to add a separating comma. That wouldn't work if we might be part of a
>>> nested array. So I think you'd need a context struct like:
>>>
>>>     struct json_writer {
>>>       int first_item;
>>>       struct strbuf out;
>>>     };
>>>     #define JSON_WRITER_INIT { 1, STRBUF_INIT }
>>>
>>> to store the state and the output. As a bonus, you could also use it to
>>> store some other sanity checks (e.g., keep a "depth" counter and BUG()
>>> when somebody tries to access the finished strbuf with a hanging-open
>>> object or array).
>>
>> Yeah, I thought about that, but I think it gets more complex than that.
>> I'd need a stack of "first_item" values.  Or maybe the _begin() needs to
>> increment a depth and set first_item and the _end() needs to always
>> unset first_item.  I'll look at this gain.
> 
> I think you may be able to get by with just unsetting first_item for any
> "end". Because as you "pop" to whatever data structure is holding
> whatever has ended, you know it's no longer the first item (whatever
> just ended was there before it).
> 
> I admit I haven't thought too hard on it, though, so maybe I'm missing
> something.

I'll take a look.  Thanks.

  
>> The thing I liked about the bottom-up construction is that it is easier
>> to collect multiple sets in parallel and combine them during the final
>> roll-up.  With the in-line nesting, you're tempted to try to construct
>> the resulting JSON in a single series and that may not fit what the code
>> is trying to do.  For example, if I wanted to collect an array of error
>> messages as they are generated and an array of argv arrays and any alias
>> expansions, then put together a final JSON string containing them and
>> the final exit code, I'd need to build it in parts.  I can build these
>> parts in pieces of JSON and combine them at the end -- or build up other
>> similar data structures (string arrays, lists, or whatever) and then
>> have a JSON conversion step.  But we can make it work both ways, I just
>> wanted to keep it simpler.
> 
> Yeah, I agree that kind of bottom-up construction would be nice for some
> cases. I'm mostly worried about inefficiency copying the strings over
> and over as we build up the final output.  Maybe that's premature
> worrying, though.
> 
> If the first_item thing isn't too painful, then it might be nice to have
> both approaches available.

True.

  
>>> In general I'd really prefer to keep the shell script as the driver for
>>> the tests, and have t/helper programs just be conduits. E.g., something
>>> like:
>>>
>>>     cat >expect <<-\EOF &&
>>>     {"key": "value", "foo": 42}
>>>     EOF
>>>     test-json-writer >actual \
>>>       object_begin \
>>>       object_append_string key value \
>>>       object_append_int foo 42 \
>>>       object_end &&
>>>     test_cmp expect actual
>>>
>>> It's a bit tedious (though fairly mechanical) to expose the API in this
>>> way, but it makes it much easier to debug, modify, or add tests later
>>> on (for example, I had to modify the C program to find out that my
>>> append example above wouldn't work).
>>
>> Yeah, I wasn't sure if such a simple api required exposing all that
>> machinery to the shell or not.  And the api is fairly self-contained
>> and not depending on a lot of disk/repo setup or anything, so my tests
>> would be essentially static WRT everything else.
>>
>> With my t0019 script you should have been able use -x -v to see what
>> was failing.
> 
> I was able to run the test-helper directly. The tricky thing is that I
> had to write new C code to test my theory about how the API worked.
> Admittedly that's not something most people would do regularly, but I
> often seem to end up doing that kind of probing and debugging. Many
> times I've found the more generic t/helper programs useful.
> 
> I also wonder if various parts of the system embrace JSON, if we'd want
> to have a tool for generating it as part of other tests (e.g., to create
> "expect" files).

Ok, let me see what I can come up with.

Thanks
Jeff

