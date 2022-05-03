Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928BBC433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 15:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiECPDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiECPD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 11:03:26 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A539816
        for <git@vger.kernel.org>; Tue,  3 May 2022 07:59:53 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1E49C3F47F0;
        Tue,  3 May 2022 10:59:53 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EC7843F4139;
        Tue,  3 May 2022 10:59:52 -0400 (EDT)
Subject: Re: [PATCH] run-command: don't spam trace2_child_exit()
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
References: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
 <xmqqr15gev94.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <75f62c9e-e083-d333-6339-2d12e0788400@jeffhostetler.com>
Date:   Tue, 3 May 2022 10:59:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr15gev94.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/28/22 5:46 PM, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
>> In rare cases, wait_or_whine() cannot determine a child process's exit
>> status (and will return -1 in this case). This can cause Git to issue
>> trace2 child_exit events despite the fact that the child is still
>> running.

I'm curious what is causing the spurious return values.
Could you instrument wait_or_whine() and see which of the
if/else arms are causing the -1 to be returned?

That routine is rather complicated and looks like it has 3
different ways that a -1 could be returned.


> 
> Rather, we do not even know if the child is still running when it
> happens, right?  It is curious what "rare cases" makes the symptom
> appear.  Do we know?
> 
> The patch looks OK from the "we do not know the child exited in this
> case, so we shouldn't be reporting the child exit" point of view, of
> course.  Having one event that started a child in the log and then
> having millions of events that reports the exit of the (same) child
> is way too broken.  With this change, we remove these phoney exit
> events from the log.
> 
> Do we know, for such a child process that caused these millions
> phoney exit events, we got a real exit event at the end?  Otherwise,
> we'd still have a similar problem in the opposite direction, i.e. a
> child has a start event recorded, many exit event discarded but the
> log lacks the true exit event for the child, implying that the child
> is still running because we failed to log its exit?
> 
>>   int finish_command_in_signal(struct child_process *cmd)
>>   {
>>   	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
>> -	trace2_child_exit(cmd, ret);
>> +	if (ret != -1)
>> +		trace2_child_exit(cmd, ret);
>>   	return ret;
>>   }

Since this is only called from pager.c and is used to setup the
pager, I have to wonder if you're only getting these spurious events
for the pager process or for any of the other random child processes.

And whether they are received while the pager is alive and working
properly, or when you're trying to quit the pager or when the pager
is trying to signal eof.

> 
> Will queue; thanks.
> 
