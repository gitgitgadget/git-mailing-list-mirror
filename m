Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC81FC2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 18:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC2320692
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 18:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbgDMSmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:42:49 -0400
Received: from siwi.pair.com ([209.68.5.199]:54649 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733067AbgDMSmq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 14:42:46 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 305FD3F40DA;
        Mon, 13 Apr 2020 14:42:45 -0400 (EDT)
Received: from [IPv6:2600:1004:b08b:5986:58d8:ace0:4465:677e] (unknown [IPv6:2600:1004:b08b:5986:58d8:ace0:4465:677e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CCE423F40C2;
        Mon, 13 Apr 2020 14:42:44 -0400 (EDT)
Subject: Re: Git pull stuck when Trace2 target set to Unix Stream Socket
To:     Jeff King <peff@peff.net>, Son Luong Ngoc <sluongng@gmail.com>
Cc:     git@vger.kernel.org, Jeff.Hostetler@microsoft.com
References: <CAL3xRKceuniEOq+PqN15FC4-mxsWJd4+e2fu1Ku9q_+8JmR9pw@mail.gmail.com>
 <20200413171812.GA8183@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <dde14102-1eeb-71dc-5333-30b21a1ef17a@jeffhostetler.com>
Date:   Mon, 13 Apr 2020 14:42:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20200413171812.GA8183@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/13/2020 1:18 PM, Jeff King wrote:
> On Mon, Apr 13, 2020 at 02:05:00PM +0200, Son Luong Ngoc wrote:
> 
>> I am trying to write a simple git trace2 event collector and I notice
>> that when git doing git pull with trace events being sent to a unix
>> stream socket, the entire operation halted.
>>
>> Reproduce as follow:
>> ```
>> cd git/git
>> git config trace2.eventTarget af_unix:stream:/tmp/git_trace.sock
>> git config trace2.eventBrief false
>> (rm /tmp/git_trace.sock | ) &&  nc -lkU /tmp/git_trace.sock
>>
>> # In a different terminal
>> git pull # Pull stuck and never complete
>> ```
> 
> I think the issue is the use of netcat as the server side.
> 
> Your git-pull involves multiple simultaneously-running Git processes.
> But "nc -k" will only accept() a new client once the old one has
> disconnected. So we'd deadlock any time we have this situation:
> 
>    - process A opens a stream to the socket, and keeps it open
> 
>    - process A spawns process B and waits for it to finish
> 
>    - process B tries to open a stream to the socket, which will block
>      waiting for netcat to accept()
> 
> Now A cannot make forward progress until B finishes, but B will not make
> forward progress until A closes the socket.
> 
> I was able to reproduce the issue locally, and process "A" was git-pull
> and process "B" was git-merge.

Thanks for the great explanation.  Yes, each Git command will open
its own connection to the socket, so you need your server to be
able to process multiple incoming requests, such as the usual listen()
loop.

There is a "trace2.destinationdebug" aka GIT_TRACE2_DST_DEBUG which
when set to a positive integer will print warning messages when
attempting to open the trace2 files or sockets.  This might help you
track down issues.  (These aren't on by default.)

You might find it easier to set the trace2 path to that of an existing
directory.  Then each Git command will create a file, so you don't have
to worry about interleaved output or having your server be alive at all
times.  You could just let the files accumulate in that directory and
have a cron job process and delete them periodically.

Jeff
