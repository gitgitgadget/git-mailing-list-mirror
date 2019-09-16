Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822C21F463
	for <e@80x24.org>; Mon, 16 Sep 2019 14:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbfIPOLY (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 10:11:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:64206 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfIPOLY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 10:11:24 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E49123F40CB;
        Mon, 16 Sep 2019 10:11:23 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:a141:d490:d6f1:dba7] (unknown [IPv6:2001:4898:a800:1010:5277:d490:d6f1:dba7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9BCF43F40DA;
        Mon, 16 Sep 2019 10:11:23 -0400 (EDT)
Subject: Re: [RFC PATCH v3 3/3] trace2: write overload message to sentinel
 files
To:     Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     szeder.dev@gmail.com
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1568419818.git.steadmon@google.com>
 <bab45cb735ad658e6c838a9b2bdb9a8c74b9d179.1568419818.git.steadmon@google.com>
 <2bb4edc6-f35c-e1e2-7957-17fd994707a0@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4aa3022d-743b-2ff6-8a8b-9cd9dc8692a2@jeffhostetler.com>
Date:   Mon, 16 Sep 2019 10:11:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2bb4edc6-f35c-e1e2-7957-17fd994707a0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/16/2019 8:07 AM, Derrick Stolee wrote:
> On 9/13/2019 8:26 PM, Josh Steadmon wrote:
>> Add a new "overload" event type for trace2 event destinations. Write
>> this event into the sentinel file created by the trace2.maxFiles
>> feature. Bump up the event format version since we've added a new event
>> type.
>>
>> Writing this message into the sentinel file is useful for tracking how
>> often the overload protection feature is triggered in practice.
> 
> Putting meaningful data into the sentinel file is valuable. It's
> important to know a bit about when and why this happened. A user
> would be able to inspect the modified time, and the directory info
> you include is unnecessary. The data you include is only for the
> log aggregator to keep valuable data around overloads.
>   
>> +`"overload"`::
>> +	This event is created in a sentinel file if we are overloading a target
>> +	trace directory (see the trace2.maxFiles config option).
>> ++
>> +------------
>> +{
>> +	"event":"overload",
>> +	...
>> +	"dir":"/trace/target/dir/", # The configured trace2 target directory
>> +	"evt":"2",		    # EVENT format version
>> +}
> That said, do we really need to resort to a new event format and
> event type? Could we instead use the "data" event with a key
> "overload" and put the target dir in the value?
> 
> Thanks,
> -Stolee
> 

If I understand the code here, the overload event/message is
only written to the sentinel file -- it is not written to a
regular trace2 log file, so regular log file consumers will
never see this event, right?

That message could be in any format, right?  And you could write
as much or as little data into the sentinel file as you want.

There's no compelling reason to extend the existing trace2 format
to have a new message type, so I'm not seeing a reason to add the
event-type nor to increment the version number.

The existing trace2 formats and messages/event-types are defined
and driven by the Trace2 API calls presented to upper layers
(consumers of the public trace2_*() functions and macros defined
in trace2.h).  This overload event doesn't fit that model.

I think it'd be better to just directly write() a message -- in
plain-text or JSON or whatever -- in tr2_create_sentinel() and
not try to piggy-back on the existing format machinery in the
tr2_tgt_*.c files.

Jeff
