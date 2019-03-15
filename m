Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB2E20248
	for <e@80x24.org>; Fri, 15 Mar 2019 18:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfCOSju (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 14:39:50 -0400
Received: from siwi.pair.com ([209.68.5.199]:53094 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfCOSjt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 14:39:49 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 61DD33F4019;
        Fri, 15 Mar 2019 14:39:48 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:d487:82da:e467:b584] (unknown [IPv6:2001:4898:8010:2:bdbb:82da:e467:b584])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 25DCE3F4021;
        Fri, 15 Mar 2019 14:39:48 -0400 (EDT)
Subject: Re: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
References: <cover.1552519463.git.steadmon@google.com>
 <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
 <87h8c6baif.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1431dc76-1b1c-c581-6355-b796591e99a8@jeffhostetler.com>
Date:   Fri, 15 Mar 2019 14:39:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <87h8c6baif.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/13/2019 7:49 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Mar 14 2019, Josh Steadmon wrote:
> 
>> When the value of a trace2 environment variable contains instances of
>> the string "%ISO8601%", expand them into the current UTC timestamp in
>> ISO 8601 format.
> 
> Any reason not to just support feeding the path to strbuf_addftime(), to
> e.g. support a daily/hourly log?
> 
>> When the value of a trace2 environment variable is an absolute path
>> referring to an existing directory, write output to randomly-named
>> files under the given directory. If the value is an absolute path
>> referring to a non-existent file and ends with a dash, use the value as
>> a prefix for randomly named files.
>>
>> The random filenames will consist of the value of the environment
>> variable (after potential timestamp expansion), followed by a 6
>> character random string such as would be produced by mkstemp(3).
>>
>> This makes it more convenient to collect traces for every git
>> invocation by unconditionally setting the relevant trace2 envvar to a
>> constant directory name.
> 
> Hrm, api-trace2.txt already specifies that the "sid" is going to be
> unique, couldn't we just have some mode where we use that?
> 
> But then of course when we have nested processes will contain slashes,
> so we'd either run into deep nesting or need to munge the slashes, in
> which case we might bump against a file length limit (although I haven't
> seen process trees deeper than 3-4).

Using the "sid" would be a good place to start.  Just take the final
component in the string (after the last slash or the whole sid if there
are no slashes).  That will give you a filename with microseconds since
epoch of the command's start time and the PID.

That should be unique, should not require random strings, and not go
deep in the filesystem.  And it will let you correlate files between
child and parent commands, if you need to.

So maybe if GIT_TR2_* is set to a directory, we append the final portion
of the "sid" and create a file inside that directory.

> 
> Just to pry about the use-case since I'm doing similar collecting, why
> are you finding this easier to process?
> 
> With the current O_APPEND semantics you're (unless I've missed
> something) guaranteed to get a single process tree in nested order,
> whereas with this they'll all end up in separate files and you'll need
> to slurp them up, sort the whole thing and stitch it together yourself
> without the benefit of stream-parsing it where you can cheat a bit
> knowing that e.g. a "reflog expire" entry is always coming after the
> corresponding "gc" that invoked it.
> 

Yes, with O_APPEND, you should get a series of events as they happen
on the system all properly interleaved.  And see concurrent activity.
This file should let you grep to see individual processes if you want
to.

Routing each command to a different file is fine if you want, but
that opens you up to having to manage and delete them.

Whether to have 1 file (with occasional rotation) or 1 file-per-command
depends, I guess, on how you want to process them.

I'm routing the Trace2 data to a named-pipe/socket and have a daemon
collecting and filtering, so I have a single pathname for output and
yet get the per-file stream handling that I think Josh is looking for.

Thanks,
Jeff
