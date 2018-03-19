Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41FA51F42D
	for <e@80x24.org>; Mon, 19 Mar 2018 10:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755330AbeCSKTa (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 06:19:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:41392 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752957AbeCSKT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 06:19:29 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C73053F4006;
        Mon, 19 Mar 2018 06:19:28 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9A3923F4003;
        Mon, 19 Mar 2018 06:19:28 -0400 (EDT)
Subject: Re: [PATCH 0/2] routines to generate JSON data
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180316194057.77513-1-git@jeffhostetler.com>
 <20180316211837.GB12333@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e2a9d2a9-f2e2-f285-52c3-be11668da543@jeffhostetler.com>
Date:   Mon, 19 Mar 2018 06:19:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180316211837.GB12333@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/16/2018 5:18 PM, Jeff King wrote:
> On Fri, Mar 16, 2018 at 07:40:55PM +0000, git@jeffhostetler.com wrote:
> 
[...]
> I really like the idea of being able to send our machine-readable output
> in some "standard" syntax for which people may already have parsers. But
> one big hangup with JSON is that it assumes all strings are UTF-8. That
> may be OK for telemetry data, but it would probably lead to problems for
> something like status porcelain, since Git's view of paths is just a
> string of bytes (not to mention possible uses elsewhere like author
> names, subject lines, etc).
[...]

I'll come back to the UTF-8/YAML questions in a separate response.


>> Documentation for the new API is given in json-writer.h at the bottom of
>> the first patch.
> 
> The API generally looks pleasant, but the nesting surprised me.  E.g.,
> I'd have expected:
> 
>    jw_array_begin(out);
>    jw_array_begin(out);
>    jw_array_append_int(out, 42);
>    jw_array_end(out);
>    jw_array_end(out);
> 
> to result in an array containing an array containing an integer. But
> array_begin() actually resets the strbuf, so you can't build up nested
> items like this internally. Ditto for objects within objects. You have
> to use two separate strbufs and copy the data an extra time.
> 
> To make the above work, I think you'd have to store a little more state.
> E.g., the "array_append" functions check "out->len" to see if they need
> to add a separating comma. That wouldn't work if we might be part of a
> nested array. So I think you'd need a context struct like:
> 
>    struct json_writer {
>      int first_item;
>      struct strbuf out;
>    };
>    #define JSON_WRITER_INIT { 1, STRBUF_INIT }
> 
> to store the state and the output. As a bonus, you could also use it to
> store some other sanity checks (e.g., keep a "depth" counter and BUG()
> when somebody tries to access the finished strbuf with a hanging-open
> object or array).

Yeah, I thought about that, but I think it gets more complex than that.
I'd need a stack of "first_item" values.  Or maybe the _begin() needs to
increment a depth and set first_item and the _end() needs to always
unset first_item.  I'll look at this gain.

The thing I liked about the bottom-up construction is that it is easier
to collect multiple sets in parallel and combine them during the final
roll-up.  With the in-line nesting, you're tempted to try to construct
the resulting JSON in a single series and that may not fit what the code
is trying to do.  For example, if I wanted to collect an array of error
messages as they are generated and an array of argv arrays and any alias
expansions, then put together a final JSON string containing them and
the final exit code, I'd need to build it in parts.  I can build these
parts in pieces of JSON and combine them at the end -- or build up other
similar data structures (string arrays, lists, or whatever) and then
have a JSON conversion step.  But we can make it work both ways, I just
wanted to keep it simpler.


>> I wasn't sure how to unit test the API from a shell script, so I added a
>> helper command that does most of the work in the second patch.
> 
> In general I'd really prefer to keep the shell script as the driver for
> the tests, and have t/helper programs just be conduits. E.g., something
> like:
> 
>    cat >expect <<-\EOF &&
>    {"key": "value", "foo": 42}
>    EOF
>    test-json-writer >actual \
>      object_begin \
>      object_append_string key value \
>      object_append_int foo 42 \
>      object_end &&
>    test_cmp expect actual
> 
> It's a bit tedious (though fairly mechanical) to expose the API in this
> way, but it makes it much easier to debug, modify, or add tests later
> on (for example, I had to modify the C program to find out that my
> append example above wouldn't work).

Yeah, I wasn't sure if such a simple api required exposing all that
machinery to the shell or not.  And the api is fairly self-contained
and not depending on a lot of disk/repo setup or anything, so my tests
would be essentially static WRT everything else.

With my t0019 script you should have been able use -x -v to see what
was failing.

> 
> -Peff
> 

thanks for the quick review
Jeff
