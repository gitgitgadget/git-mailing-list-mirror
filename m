Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0421F404
	for <e@80x24.org>; Wed,  5 Sep 2018 15:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeIETcP (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:32:15 -0400
Received: from siwi.pair.com ([209.68.5.199]:25789 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbeIETcP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:32:15 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A5E183F4808;
        Wed,  5 Sep 2018 11:01:38 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 681253F411A;
        Wed,  5 Sep 2018 11:01:38 -0400 (EDT)
Subject: Re: [PATCH 1/8] trace2: create new combined trace facility
To:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.29.git.gitgitgadget@gmail.com>
 <82885700379efe6d6a83629cac4d943b99b393bf.1535734192.git.gitgitgadget@gmail.com>
 <CAGZ79kbUYDAKi-K2uHpkffPjMxGYtH=QUMhvfq4HTc5+a7-eBA@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <dfdd9e8e-68f0-d36c-9479-79a9be08eeda@jeffhostetler.com>
Date:   Wed, 5 Sep 2018 11:01:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbUYDAKi-K2uHpkffPjMxGYtH=QUMhvfq4HTc5+a7-eBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/4/2018 6:12 PM, Stefan Beller wrote:
>> Create GIT_TR2 trace-key to replace GIT_TRACE, GIT_TR2_PERFORMANCE to
>> replace GIT_TRACE_PERFORMANCE, and a new trace-key GIT_TR2_EVENT to
>> generate JSON data for telemetry purposes.  Other structured formats
>> can easily be added later using this new existing model.
> 
> So the idea is to use the GIT_TR2 instead of GIT_TRACE and we
> get the same output as well as a new form of structured logging here?
> (Then GIT_TRACE could be retired, and we'd use the new API to add
> more events, which are also more structured as the API allows for more
> than just a string printed?)
> 
>> Define a higher-level event API that selectively writes to all of the
>> new GIT_TR2_* targets (depending on event type) without needing to call
>> different trace_printf*() or trace_performance_*() routines.
>>
>> The API defines both fixed-field and printf-style functions.
>>
>> The trace2 performance tracing includes thread-specific function
>> nesting and timings.
> 
> So this only adds the new API, and we need to merge the TRACE
> into the TRACE2 later?
> 
>> +++ b/trace2.c
>> @@ -0,0 +1,1592 @@
> [...]
>> +
>> +/*****************************************************************
>> + * TODO remove this section header
>> + *****************************************************************/
> 
> Yes, please.
> 
>> +/*
>> + * Compute a "unique" session id (SID) for the current process.  All events
>> + * from this process will have this label.  If we were started by another
>> + * git instance, use our parent's SID as a prefix and count the number of
>> + * nested git processes.  (This lets us track parent/child relationships
>> + * even if there is an intermediate shell process.)
> 
> How does this work with threading. From this description we can have
> two threads starting new child processes and they have the same ID
> (<our id>-2)

Threads are not involved here.

A git process computes its own unique session id.  It is constructed
from { [<inherited-parent-sid>], <current-time>, <current-pid> }.
So in the following example, fetch spawned rev-list and gc.  (I've
stripped out fields irrelevant to this discussion.)

"sid":"1536153920286494-12592",
"argv":["C:\\work\\gfw\\git.exe","--exec-path=.","fetch","gh"]

"sid":"1536153920286494-12592/1536153925520530-23024",
"argv":["git","rev-list","--objects","--stdin", ...]

"sid":"1536153920286494-12592/1536153926081533-23992",
"argv":["git","gc","--auto"]

So 2 child processes simultaneously spawned from 2 threads in the
top-level git command, would still have unique SIDs since their PIDs
are unique over the time interval of their execution.

In the above example, if rev-list spawned a child git process, that
child's SID would have 3 components (the prefix that it inherited
plus its own time and pid):
     1536153920286494-12592/1536153925520530-23024/<time>-<pid>

The above model works even if there is a shell command between the
top-level git command and the child git processes.

> 
>> +
>> +/*****************************************************************
>> + * TODO remove this section header
>> + *****************************************************************/
> 
> This looks like a reoccurring pattern. Did you have a tool
> that needs these? Does the tool want to enforce some level of
> documentation on each function?

No, this is just an <hr> that helps me see the different sections
as different sections in the editor and helps me group like items.
I might change that to a group-level comment that describes the
overall concept/purpose of the section.  Either way I'll get rid of
the stars.

> 
>> +
>> +/*
>> + * Each thread (including the main thread) has a stack of nested regions.
>> + * This is used to indent messages and provide nested perf times.  The
>> + * limit here is for simplicity.  Note that the region stack is per-thread
>> + * and not per-trace_key.
> 
> What are the (nested) regions used for? I would imagine recursive
> operations, e.g. unpacking trees? Where am I supposed to read
> up on those?

Unpacking trees would be a good usage. Duy did something similar in a
recent patch series.

Nested regions are intended for perf times.  The 8th patch in
this series demonstrates adding trace2_region_enter() and _leave()
calls inside read_directory_recursive().  The second column here
shows the elapsed time between the _enter and _leave.  (Again, I've
stripped out fields not currently relevant.)

| region_enter |           | status_untracked
| region_enter |           | ..read_directory_recursive:
| region_enter |           | ....read_directory_recursive:.github/
| region_leave |  0.000095 | ....read_directory_recursive:.github/
| region_enter |           | ....read_directory_recursive:block-sha1/
| region_leave |  0.000086 | ....read_directory_recursive:block-sha1/
| region_enter |           | ....read_directory_recursive:builtin/
| region_leave |  0.000716 | ....read_directory_recursive:builtin/
| region_enter |           | ....read_directory_recursive:ci/
| region_enter |           | ......read_directory_recursive:ci/util/
| region_leave |  0.000087 | ......read_directory_recursive:ci/util/
| region_leave |  0.000250 | ....read_directory_recursive:ci/
| region_enter |           | ....read_directory_recursive:compat/
| region_enter |           | 
......read_directory_recursive:compat/nedmalloc/
| region_leave |  0.000128 | 
......read_directory_recursive:compat/nedmalloc/
| region_enter |           | ......read_directory_recursive:compat/poll/
| region_leave |  0.000124 | ......read_directory_recursive:compat/poll/
| region_enter |           | ......read_directory_recursive:compat/regex/
| region_leave |  0.000129 | ......read_directory_recursive:compat/regex/
| region_leave |  0.017700 | ....read_directory_recursive:compat/
...
| region_leave |  0.053924 | ..read_directory_recursive:
| region_leave |  0.054127 | status_untracked

I include the read_directory_recursive() commit as an example of
how the API works.  I consider those particular calls as something
a developer would add while studying a problem, but not keep long term.
The calls in status_untracked() are probably keepers, since it would
compliment the existing warning about untracked file detection taking
too long.

The trace2_data_intmax() and trace2_data_string() routines work with
this nesting (are similarly ".." indented).  I don't have an example
in the V1 patch, but you might want to print the number of files touched
at each step in the recursion, for example.

> 
>> + */
>> +#define TR2_MAX_REGION_NESTING (100)
>> +#define TR2_INDENT (2)
>> +#define TR2_INDENT_LENGTH(ctx) (((ctx)->nr_open_regions - 1) * TR2_INDENT)
> 
> In the structured part of the logging the indentation would not be
> needed and we'd rather want to store the nesting level as an int,
> this is solely for printing locally I'd assume.
> 
>> +#define TR2_MAX_THREAD_NAME (24)
> 
> This is the max length for a thread name including all the prefixes?

A thread name does not have a SID-related prefix.  It is just a number
and a supplied label, such as the name of the thread-proc function.
I clip it for column alignment purposes.  For example, the 6th commit
in the patch series shows it being used in preload_index().  Again, this
is the perf view.

...
| main                     | region_enter |           | preload_index
| th01:preload_thread      | thread_start |           |
| th01:preload_thread      | printf       |           | preload {offset 
      0}{count     567}
| th02:preload_thread      | thread_start |           |
| th02:preload_thread      | printf       |           | preload {offset 
    567}{count     567}
| th03:preload_thread      | thread_start |           |
| th03:preload_thread      | printf       |           | preload {offset 
   1134}{count     567}
| th04:preload_thread      | thread_start |           |
| th04:preload_thread      | printf       |           | preload {offset 
   1701}{count     567}
| th05:preload_thread      | thread_start |           |
| th05:preload_thread      | printf       |           | preload {offset 
   2268}{count     567}
| th06:preload_thread      | thread_start |           |
| th06:preload_thread      | printf       |           | preload {offset 
   2835}{count     562}
| th03:preload_thread      | thread_exit  |  0.034892 |
| th06:preload_thread      | thread_exit  |  0.038585 |
| th04:preload_thread      | thread_exit  |  0.042468 |
| th02:preload_thread      | thread_exit  |  0.042601 |
| th01:preload_thread      | thread_exit  |  0.046107 |
| th05:preload_thread      | thread_exit  |  0.047696 |
| main                     | region_leave |  0.048093 | preload_index
...

This shows interleaved racy messages from each of the 6 threads started
in preload_index().  The thread_exit messages give the elapsed time of
each thread.

The thread_start/thread_exit events implicitly define a region (as
described earlier) so that region_enter, region_leave, and data events
will be ".." indented relative to the thread.  One could image building
a threaded version of status_untracked where read_directory_recursive
is spread across different threads.  The perf tracing here would let
us see timings for each thread.  Granted, the events are interleaved
and therefore racy, but you could post-process that thread-by-thread.

> 
> 
>> +static void tr2tls_unset_self(void)
>> +{
>> +       struct tr2tls_thread_ctx * ctx;
>> +
>> +       ctx = tr2tls_get_self();
>> +
>> +       pthread_setspecific(tr2tls_key, NULL);
> 
> Would we also need to free tr2tls_key ?

I free the ctx for each thread (including the main thread) after
disassociating it from the TLS slot when the thread is ending.

But the TLS slot (tr2tls_key) needs to remain until all the atexit
handler runs.  See tr2tls_release().

> 
> 
>> +/*****************************************************************
>> + * TODO remove this section header
>> + *****************************************************************/
>> +
>> +static void tr2io_write_line(struct trace_key *key, struct strbuf *buf_line)
>> +{
>> +       strbuf_complete_line(buf_line); /* ensure final NL on buffer */
>> +
>> +       // TODO we don't really want short-writes to try again when
>> +       // TODO we are in append mode...
> 
> A different kind of TODO in a // comment?
> 

Sorry, didn't want to forget to actually do it.   :-)

thanks for the review,
Jeff
