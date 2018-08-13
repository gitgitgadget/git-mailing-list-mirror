Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29BD31F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeHMXt2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:49:28 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:47725 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729063AbeHMXt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:49:28 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41q7Y812WPz5tl9;
        Mon, 13 Aug 2018 23:05:32 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6A62B1DB0;
        Mon, 13 Aug 2018 23:05:31 +0200 (CEST)
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.17.git.gitgitgadget@gmail.com>
 <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
 <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
 <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
 <xmqqr2j23tnb.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <84c749fd-23d2-0bc5-225b-74f8d31502b6@kdbg.org>
Date:   Mon, 13 Aug 2018 23:05:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqr2j23tnb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.2018 um 22:20 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> The Windows CRT implements O_APPEND "manually": on write() calls, the
>> file pointer is set to EOF before the data is written. Clearly, this is
>> not atomic. And in fact, this is the root cause of failures observed in
>> t5552-skipping-fetch-negotiator.sh and t5503-tagfollow.sh, where
>> different processes write to the same trace file simultanously; it also
>> occurred in t5400-send-pack.sh, but there it was worked around in
>> 71406ed4d6 ("t5400: avoid concurrent writes into a trace file",
>> 2017-05-18).
>>
>> Fortunately, Windows does support atomic O_APPEND semantics using the
>> file access mode FILE_APPEND_DATA. Provide an implementation that does.
>>
>> This implementation is minimal in such a way that it only implements
>> the open modes that are actually used in the Git code base. Emulation
>> for other modes can be added as necessary later. To become aware of
>> the necessity early, the unusal error ENOSYS is reported if an
>> unsupported mode is encountered.
>>
>> Diagnosed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>   compat/mingw.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 39 insertions(+), 2 deletions(-)
> 
> Nice.
> 
> I wonder how much more expensive using this implementation is
> compared with the original "race susceptible" open(), when raciness
> is known not to be an issue (e.g. there is higher level lock that
> protects the appending).

Certainly, the former way that uses two syscalls 
(SetFilePointer+WriteFile) is more costly than this new way with just 
one syscall (WriteFile). Of course, I don't know how atomic append would 
be implemented in the kernel, but I can't think of a reason why it 
should be slow on Windows, but fast on POSIX.

(But I can't provide numbers to back up my gut feeling...)

(And I also assume that you are not worried about the performance of 
open() itself.)

> ...[define race_safe_append_open]... and replace
> the call to open(... O_APPEND ...) in trace.c::get_trace_fd() with a
> call to that wrapper.  That way, other codepaths that use O_APPEND
> (namely, reflog and todo-list writers) can avoid the additional
> cost, if any.
> 
> Some may find it beneficial from code readability POV because that
> approach marks the codepath that needs to have non-racy fd more
> explicitly.

O_APPEND is POSIX and means race-free append. If you mark some call 
sites with O_APPEND, then that must be the ones that need race-free 
append. Hence, you would have to go the other route: Mark those call 
sites that do _not_ need race-free append with some custom 
function/macro. (Or mark both with different helpers and avoid writing 
down O_APPEND.)

-- Hannes
