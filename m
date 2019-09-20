Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCF31F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfITP7K (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:59:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:16337 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbfITP7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:59:10 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2B7733F4090;
        Fri, 20 Sep 2019 11:59:09 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:257b:42cb:93e8:b7e3] (unknown [IPv6:2001:4898:a800:1010:d6b0:42cb:93e8:b7e3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D62443F4051;
        Fri, 20 Sep 2019 11:59:08 -0400 (EDT)
Subject: Re: [RFC PATCH v3 3/3] trace2: write overload message to sentinel
 files
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        szeder.dev@gmail.com
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1568419818.git.steadmon@google.com>
 <bab45cb735ad658e6c838a9b2bdb9a8c74b9d179.1568419818.git.steadmon@google.com>
 <2bb4edc6-f35c-e1e2-7957-17fd994707a0@gmail.com>
 <4aa3022d-743b-2ff6-8a8b-9cd9dc8692a2@jeffhostetler.com>
 <20190916182030.GB11295@google.com>
 <479d4db5-14a0-e15b-8a0b-4732a2b9682c@jeffhostetler.com>
 <20190919224733.GA224668@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f6645671-b010-856c-821e-3b6b0ad5265a@jeffhostetler.com>
Date:   Fri, 20 Sep 2019 11:59:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190919224733.GA224668@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/19/2019 6:47 PM, Josh Steadmon wrote:
> On 2019.09.19 14:23, Jeff Hostetler wrote:
>>
>>
>> On 9/16/2019 2:20 PM, Josh Steadmon wrote:
>>> On 2019.09.16 10:11, Jeff Hostetler wrote:
>>>>
>>>>
>>>> On 9/16/2019 8:07 AM, Derrick Stolee wrote:
>>>>> On 9/13/2019 8:26 PM, Josh Steadmon wrote:
>>>>>> Add a new "overload" event type for trace2 event destinations. Write
>>>>>> this event into the sentinel file created by the trace2.maxFiles
>>>>>> feature. Bump up the event format version since we've added a new event
>>>>>> type.
>>>>>>
>>>>>> Writing this message into the sentinel file is useful for tracking how
>>>>>> often the overload protection feature is triggered in practice.
>>>>>
>>>>> Putting meaningful data into the sentinel file is valuable. It's
>>>>> important to know a bit about when and why this happened. A user
>>>>> would be able to inspect the modified time, and the directory info
>>>>> you include is unnecessary. The data you include is only for the
>>>>> log aggregator to keep valuable data around overloads.
>>>>>> +`"overload"`::
>>>>>> +	This event is created in a sentinel file if we are overloading a target
>>>>>> +	trace directory (see the trace2.maxFiles config option).
>>>>>> ++
>>>>>> +------------
>>>>>> +{
>>>>>> +	"event":"overload",
>>>>>> +	...
>>>>>> +	"dir":"/trace/target/dir/", # The configured trace2 target directory
>>>>>> +	"evt":"2",		    # EVENT format version
>>>>>> +}
>>>>> That said, do we really need to resort to a new event format and
>>>>> event type? Could we instead use the "data" event with a key
>>>>> "overload" and put the target dir in the value?
>>>>>
>>>>> Thanks,
>>>>> -Stolee
>>>>>
>>>>
>>>> If I understand the code here, the overload event/message is
>>>> only written to the sentinel file -- it is not written to a
>>>> regular trace2 log file, so regular log file consumers will
>>>> never see this event, right?
>>>
>>> Well, I guess it's hard to define what is a "regular log file consumer".
>>> In our case, our collection system will treat sentinel files like any
>>> other trace file, so it's useful to have it match the expected trace
>>> format.
>>>
>>> At least for our use, we don't want the sentinel files treated
>>> specially, because we want the log collection system to just do its
>>> thing and remove the file after processing, which lets Git know that
>>> it's ok to start writing traces again.
>>>
>>>> That message could be in any format, right?  And you could write
>>>> as much or as little data into the sentinel file as you want.
>>>
>>> To me it seems that it would be less surprising on the users' side if
>>> any data written to the sentinel file matches the format of the
>>> requested traces. If I have an automated process that's reading JSON
>>> from a directory full of files, I don't want to have to add a special
>>> case where one file might have perf-format data (or vice versa).
>>>
>>>> There's no compelling reason to extend the existing trace2 format
>>>> to have a new message type, so I'm not seeing a reason to add the
>>>> event-type nor to increment the version number.
>>>>
>>>> The existing trace2 formats and messages/event-types are defined
>>>> and driven by the Trace2 API calls presented to upper layers
>>>> (consumers of the public trace2_*() functions and macros defined
>>>> in trace2.h).  This overload event doesn't fit that model.
>>>
>>> Yeah, I did feel like this might be overkill. Do you think Stolee's
>>> suggestion to use a "data" event instead would be acceptable?
>>>
>>>> I think it'd be better to just directly write() a message -- in
>>>> plain-text or JSON or whatever -- in tr2_create_sentinel() and
>>>> not try to piggy-back on the existing format machinery in the
>>>> tr2_tgt_*.c files.
>>>
>>> I had a version that did this originally, but I don't really like having
>>> an unexpected special case where we just write a static JSON string. It
>>> feels like an ugly corner case, and would be surprising to users, IMO.
>>> But if everyone thinks this is a better approach, I suppose I could just
>>> add a switch statement in tr2_create_sentinel() that looks at the
>>> sysenv_var field of the tr2_dst.
>>>
>>
>>
>> You make some good points.  I suppose it would be good to be able
>> to parse the overload file using the same reader/scheme as the
>> other events.  Well, at least for the JSON format; the other formats
>> don't really matter for your purposes anyway.
>>
>> I am concerned that the new "overload" event will be the only event
>> in the file and therefore replace the "version" event in those files.
>> That is, we'll break the invariant that all JSON files begin with a
>> "version" event that containing the event version string.  That is,
>> in the current proposal, the format becomes:
>>
>>      v2 ::= <overload> | <<v1>>
>>      v1 ::= <version> <start> ... <atexit>
>>
>> V1 readers were promised that the first event in the file would
>> always be a <version> event.
> 
> Ah interesting, I wasn't aware of this. Thanks for clarifying. I do see
> that there's a recommendation that trace2_initialize() should be called
> "as early as possible", but perhaps I should add a note to the docs?
> 
> 
>> And that they can dispatch on the
>> version.evt field.  V1 readers won't recognize the <overload> event
>> and they won't know to look at the overload.evt field.  That might
>> cause V1 parsers to throw a harder error than a simpler version
>> mismatch.
>>
>> Just using a "data" event also feels wrong for the same reasons.
>> At that point in tr2_create_sentinel(), a new "data" event would
>> just give us:
>>
>>      V2 ::= <data key="overload", value="true"> | <<v1>>
>>      v1 ::= <version> <start> ... <atexit>
>>
>> Having said that I wonder if it would be better to have
>> tr2_create_sentinel() just set a flag (and leave the fd open).
>> And then either add the new event as:
>>
>>      V2 ::= <version evt=2> <overload dir=path, max=n> | <<v1>>
>>
>> or just add a column to the <version> event (and go ahead and
>> let the overload file be a full trace2 log from the command):
>>
>>      V1 ::= <version evt=1, [overload=true]> <start> ... <atexit>
>>
>> Does that make sense??
> 
> Yeah, that seems reasonable. We're already adding one more file to the
> target directory, so we might as well include the traces from this run.
> 
> However, you're still keeping evt=1 here; do we make any promises about
> fields within events being constant in a particular event version? After
> scanning api-trace2.txt, I don't see any explicit description of what
> may or may not change within a version, and the idea that we might add
> new fields would be surprising at least to me. I'm fine either way so
> long as it's documented. Would a section like the following in
> api-trace2.txt be acceptable?
> 
> """
> Adding new fields to events does not require a change in the EVT.
> Removing fields, or adding or removing event types does require an
> increment to the EVT.
> """

Um, good point.  Adding fields to an existing event is probably
safe -- unless it conveys a more significant change in behavior.
Something, for example, that changes the interpretation of existing
events or fields would require a version change.

I could go either way on this.  Perhaps it would be better to just
update the version number and add the event.  (Sorry to be wishy-washy
on this.)

     json ::=   <version evt=1> <<body>>
              | <version evt=2> [<overload>] [<<body>>]
     body ::= <start> ... <atexit>

That has a bit of a cleaner feel (in hindsight).

Jeff



