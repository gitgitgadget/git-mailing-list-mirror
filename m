Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D9BC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 19:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347957AbiCUT1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 15:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiCUT1l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 15:27:41 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5335A12B773
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:26:16 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6F0463F4802;
        Mon, 21 Mar 2022 15:26:15 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 38F173F47F9;
        Mon, 21 Mar 2022 15:26:15 -0400 (EDT)
Subject: Re: [PATCH 05/16] fsmonitor--daemon: refactor cookie handling for
 readability
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
 <84df95be620c76afed73d1679722459e2ff32018.1647033303.git.gitgitgadget@gmail.com>
 <220314.86bky9ezdw.gmgdl@evledraar.gmail.com>
 <7ddeffc4-3442-b4a1-e6f4-e68b3aa3f5ec@github.com>
 <xmqqo828s9xw.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <49f2dbd2-b596-7378-ca65-ca5104121af5@jeffhostetler.com>
Date:   Mon, 21 Mar 2022 15:26:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqo828s9xw.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/14/22 1:47 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> On 3/14/2022 4:00 AM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Fri, Mar 11 2022, Jeff Hostetler via GitGitGadget wrote:
>>
>>>> +	/*
>>>> +	 * Technically, close() and unlink() can fail, but we don't
>>>> +	 * care here.  We only created the file to trigger a watch
>>>> +	 * event from the FS to know that when we're up to date.
>>>> +	 */
>>>> +	close(fd);
>>>
>>> It still seems odd to explicitly want to ignore close() return values.
>>>
>>> I realize that we do in (too many) existing places, but why wouldn't we
>>> want to e.g. catch an I/O error here early?
>>
>> What exactly do you propose we do here if there is an I/O error
>> during close()?
> 
> We created the file to trigger a watch event, but now we have a
> reason to suspect that the wished-for watch event may not come.
> 
> We only did so to know that when we're up to date.  Now we may never
> know?  We may go without realizing we are already up to date a bit
> longer than the reality?
> 
> How much damage would it cause us to miss a watch event in this
> case?  Very little?  Is it a thing that sysadmins may care if we see
> too many of, but there is nothing the end user can immediately do
> about?  If it is, perhaps a trace2 event to report it (and other "we
> do not care here" syscalls that fail)?
> 
> 
> 

The open(... O_CREAT ...) succeeded, so we actually created a
new file and expect a FS event for it.  That FS event (when seen
by the FS listener thread) will cause our condition to be
signaled and allow this thread to wake up and respond to the client.

The odds of the close() failing on a plain file (after a successful
open()) are very slim.  And there's nothing that we can do about
the failure anyway.  (And we're not relying on an FS event from the
close() succeeding, so it really doesn't matter.)   Technically, it
is possible that the daemon could run out of fd's if this close()
fails often, so at some point the daemon might not be able to create
new cookie files.  But the daemon currently defaults to sending a
trivial response to the client -- if this turns out to be a real
issue, we could have the daemon restart or something, but I'm not
going to worry about that right now.

The odds of a failure in unlink() is a little more interesting.
This would mean that a stale cookie file would be left in the
cookie directory (and waste a little disk space).  But that is
not likely either (for a plain file that we just created).
Since we're not relying on the FS event for the unlink(), the
failure here won't block the current thread either.  Deleting
stale cookie files is something that we could try to address
in the future if it turns out to be a problem.

Jeff

