Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38F6A1F462
	for <e@80x24.org>; Mon, 20 May 2019 18:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfETSW2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 14:22:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:40450 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfETSW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 14:22:28 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 13CAB3F4088;
        Mon, 20 May 2019 14:22:27 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:995c:4aa3:4774:bbd8] (unknown [IPv6:2001:4898:a800:1012:4a90:4aa3:4774:bbd8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9ACB93F4019;
        Mon, 20 May 2019 14:22:26 -0400 (EDT)
Subject: Re: I made a flame graph renderer for git's trace2 output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <87zhnuwdkp.fsf@evledraar.gmail.com>
 <20190510210324.GA30947@sigill.intra.peff.net>
 <87y33evuop.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d1f9a2f4-500d-d5f6-af3d-75d3fdb1323b@jeffhostetler.com>
Date:   Mon, 20 May 2019 14:22:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87y33evuop.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/10/2019 5:57 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, May 10 2019, Jeff King wrote:
> 
>> On Fri, May 10, 2019 at 05:09:58PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>>> As noted in TODOs in the script there's various stuff I'd like to do
>>> better, and this also shows how we need a lot more trace regions to get
>>> granular data.
>>
>> Hmm. My gut reaction was: doesn't "perf record -g make test" already
>> give us that granular data? I know "perf" isn't available everywhere,
>> but the idea of the FlameGraph repo is that it takes input from a lot of
>> sources (though I don't know if it supports any Windows-specific formats
>> yet, which is presumably a point of interesting to trace-2 authors).
>>
>> But having generated such a flamegraph, it's not all that helpful. It
>> mainly tells us that we spend a lot of time on fork/exec. Which is no
>> surprise, since the test suite is geared not towards heavy workloads,
>> but lots of tiny functionality tests.
>>
>> TBH, I'm not sure that flame-graphing the test suite is going to be all
>> that useful in the long run. It's going to be heavily weighted by the
>> types of things the test suite does. Flamegraphs are good for
>> understanding where your time is going for a particular workload, but
>> the workload of the test suite is not that interesting.
>>
>> And once you do have a particular workload of interest that you can
>> replay, then I think the granular "perf" results really can be helpful.
>>
>> I think the trace2 flamegraph would be most useful if you were
>> collecting across a broad spectrum of workloads done by a user. You
>> _can_ do that with perf or similar tools, but it can be a bit awkward.
>> I do wonder how painful it would be to alias "git" to "perf record git"
>> for a day or something.
> 
> Yeah I should have mentioned that I'm mainly linking to the test suite
> rendering as a demo.
> 
> My actual use-case for this is to see what production nodes are spending
> their time on, similar to what Microsoft is doing with their use of this
> facility.
> 
> The test suite serves as a really good test-case for the output, and to
> stress-test my aggregation script, since we're pretty much guaranteed to
> run all our commands, and cover a lot of unusual cases.
> 
> It also shows that we've got a long way to go in improving the trace2
> facility, i.e. adding region enter/leave for some of the things we spend
> the most time on.
> 

Very nice!

Yes, there is more work to do to add more regions to get more
granular data for interesting/problematic things.  My primary
goal in this phase has been to get the basic machinery in place
and be vetted with some universally interesting regions, such as
reading/writing the index and the phases of status.

Going forward, we can trivially (permanently) add new regions as we
want.  I tend to use temporary "experimental" regions during my perf
investigations so that I don't clutter up the mainline source with
uninteresting noise.

WRT the TODO's in your script:

[] I don't think data events will be useful for your usage.  The data
values are orthogonal to the time values.

[] I would add the child_start/_exit events to the stack.  This will
give you the names of non-builtin/shell commands and hooks.  The
various "child_class" and "use_shell" and "hook_name" fields will help
you avoid duplicate stack frames (which you'll get for builtin
commands).

Jeff
