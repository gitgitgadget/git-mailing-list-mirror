Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2AEC43462
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 15:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3179160FEF
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 15:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhDBPCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 11:02:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:49696 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235077AbhDBPCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 11:02:15 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 63D633F4162;
        Fri,  2 Apr 2021 11:02:14 -0400 (EDT)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 315623F414D;
        Fri,  2 Apr 2021 11:02:14 -0400 (EDT)
Subject: Re: Detecting when bulk file-system operations complete
To:     Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Drew Noakes <drew@drewnoakes.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <CAJd66x6XT7m5Njg2kRyGJ80rU6WNcLifijS98=onJeBz+74rrA@mail.gmail.com>
 <5a1abc6b-52a3-fc12-166f-8af5e7bdff48@iee.email>
 <9c09459b-2d27-6997-63c1-46c8df52eda7@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <365c1b90-73f4-18de-ae37-a13e52104e9c@jeffhostetler.com>
Date:   Fri, 2 Apr 2021 11:02:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9c09459b-2d27-6997-63c1-46c8df52eda7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/1/21 9:10 AM, Derrick Stolee wrote:
> On 3/31/2021 12:03 PM, Philip Oakley wrote:
>> Hi Drew,
>>
>> On 31/03/2021 04:39, Drew Noakes wrote:
>>> Hi,
>>>
>>> I develop IDE tooling that watches a repo's workspace and reacts to changes.
>>>
>>> Bulk file-system changes (i.e. branch switch, rebase, merge,
>>> cherry-pick) trigger lots of file system events, and my tooling should
>>> ignore intermediary updates. Currently I debounce events with a fixed
>>> time span, but would like a more reliable and performant approach to
>>> scheduling this reactive work.
>>>
>>> Can this be done by monitoring the GITDIR in some way? For example, is
>>> there a file that's present when these operations are in flight, and
>>> which is removed when they complete?
>>>
>>> If an operation is interrupted (i.e. merge or rebase that hits a
>>> conflict) my tooling should consider the bulk operation as complete.
>>> This means that detecting a git-rebase-todo file or
>>> rebase-merge/rebase-apply folder is not adequate.
>>>
>>> Any help appreciated. Thanks!
>>>
>>> Drew.
>> You may want to look at the various bits of work on `fsmonitor` etc on
>> the mailing list archive
>>
>> https://lore.kernel.org/git/?q=fsmonitor
>>
>> to ensure that all the different approaches inter-operate with
>> reasonable efficiency..
> 
> This is an important suggestion. There is an issue with the current
> approach of using FS Monitor with Watchman along with Visual Studio
> Code and certain Git plugins:
> 
> 1. When "git status" runs, the FS Monitor hook asks Watchman for
>     changes. Watchman puts a "cookie file" in the working directory
>     so it knows when the file system events are flushed.
> 
> 2. VS Code notices this cookie file was written, so it interprets
>     that a file was changed in the working directory. It calls
>     "git status" to update its markers on the modified files.
> 
> This loops forever.
> 
> The new version of FS Monitor that Jeff Hostetler is working on
> writes the cookie file into the .git directory, which VS Code (and
> hopefully other IDEs) do not consider a trigger for running commands
> like "git status".
> 
> This is just one example of the trickiness that ensues when using
> filesystem events.

It sounds like you want to watch the contents of the .git directory
for creation/deletion of various control files.  Something like a
begin- and end-transaction marker.  I'm not sure that Git has such
a clear marker.  Git commands often invoke child commands, rebase
might invoke checkout and then run some other commands for example,
so the marker would need to be recursive.  And some commands can be
paused, an interactive rebase can stop and let the user edit a command
and then continue with the next step in the rebase.

So you would have to decide what the boundaries are that you want
to bracket between your GUI refreshes -- do you freeze during the
whole rebase, or do you incrementally update the display after each
checkout or merge within the rebase?

Having said that, you might look at the `.git/index.lock`.  That file
is present when a particular command is running and modifying things.
It is a start, but probably not sufficient.  And it is possible for
commands to abort (crash) and fail to delete that file, so be careful.

You could have a FS watcher to keep track of the contents of the .git
directory.  But you'd have to do some research on which control files
are created and when and see what makes sense for your application.
I'm not saying it is impossible, but it probably won't be easy to
get right.

Jeff
