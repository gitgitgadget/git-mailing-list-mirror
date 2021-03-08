Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F3FC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 14:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73DAE6512B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 14:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhCHOPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 09:15:05 -0500
Received: from siwi.pair.com ([209.68.5.199]:34635 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhCHOOy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 09:14:54 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4DE7D3F4096;
        Mon,  8 Mar 2021 09:14:49 -0500 (EST)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 20B783F4047;
        Mon,  8 Mar 2021 09:14:49 -0500 (EST)
Subject: Re: [PATCH 5/8] unix-stream-server: add st_dev and st_mode to socket
 stolen checks
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
 <89100959528c6a3c16622cf86e6920273f5ed2d3.1614889047.git.gitgitgadget@gmail.com>
 <05f4cb97-5d78-4698-795d-311197052e22@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f74c7b94-0378-edfc-6f34-18c896570a3e@jeffhostetler.com>
Date:   Mon, 8 Mar 2021 09:14:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <05f4cb97-5d78-4698-795d-311197052e22@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/6/21 6:42 AM, René Scharfe wrote:
> Am 04.03.21 um 21:17 schrieb Jeff Hostetler via GitGitGadget:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> When checking to see if our unix domain socket was stolen, also check
>> whether the st.st_dev and st.st_mode fields changed (in addition to
>> the st.st_ino field).
>>
>> The inode by itself is not unique; it is only unique on a given
>> device.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   unix-stream-server.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/unix-stream-server.c b/unix-stream-server.c
>> index f00298ca7ec3..366ece69306b 100644
>> --- a/unix-stream-server.c
>> +++ b/unix-stream-server.c
>> @@ -120,8 +120,11 @@ int unix_stream_server__was_stolen(
>>
>>   	if (st_now.st_ino != server_socket->st_socket.st_ino)
>>   		return 1;
>> +	if (st_now.st_dev != server_socket->st_socket.st_dev)
>> +		return 1;
>>
>> -	/* We might also consider the ctime on some platforms. */
> 
> Why remove that comment?  (This change is not mentioned in the commit
> message.)

I added it as a TODO to myself thinking that it might give us
additional assurances on some platforms while I was originally
getting things working.  In hindsight (and now that we have the
lockfile helping us), I didn't think it was actually needed, so
I removed it.

I didn't think it warranted a mention in the commit message.

> 
>> +	if (!S_ISSOCK(st_now.st_mode))
>> +		return 1;
>>
>>   	return 0;
>>   }
>>
> 
