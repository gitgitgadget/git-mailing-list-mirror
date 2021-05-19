Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF155C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9051961353
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347353AbhESObC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 10:31:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:37525 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346545AbhESObA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 10:31:00 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6AA973F4098;
        Wed, 19 May 2021 10:29:40 -0400 (EDT)
Received: from MININT-MG8E6GJ.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 458173F4095;
        Wed, 19 May 2021 10:29:40 -0400 (EDT)
Subject: Re: [PATCH] simple-ipc: correct ifdefs when NO_PTHREADS is defined
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.955.git.1621352192238.gitgitgadget@gmail.com>
 <xmqqk0nv1rc4.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <79bf42e7-3923-a901-53eb-1aac13c53e6b@jeffhostetler.com>
Date:   Wed, 19 May 2021 10:29:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0nv1rc4.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/18/21 8:48 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +# Simple-ipc requires threads and platform-specific IPC support.
>> +# (We group all Unix variants in the top-level else because Windows
>> +# also defines NO_UNIX_SOCKETS.)
>>   ifdef USE_WIN32_IPC
>> +	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
>>   	LIB_OBJS += compat/simple-ipc/ipc-shared.o
>>   	LIB_OBJS += compat/simple-ipc/ipc-win32.o
>> +else
>> +ifndef NO_PTHREADS
>> +ifndef NO_UNIX_SOCKETS
>> +	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
>> +	LIB_OBJS += compat/simple-ipc/ipc-shared.o
>> +	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
>> +endif
>> +endif
> 
> OK, so "!defined(NO_PTHREADS) && !defined(NO_UNIX_SOCKETS)" is the
> requirement for SIMPLE_IPC unless you are on Windows.
> 
>> diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
>> index 38689b278df3..c23b17973983 100644
>> --- a/compat/simple-ipc/ipc-unix-socket.c
>> +++ b/compat/simple-ipc/ipc-unix-socket.c
>> @@ -6,10 +6,16 @@
>>   #include "unix-socket.h"
>>   #include "unix-stream-server.h"
>>   
>> +#ifdef SUPPORTS_SIMPLE_IPC
>> +
>>   #ifdef NO_UNIX_SOCKETS
>>   #error compat/simple-ipc/ipc-unix-socket.c requires Unix sockets
>>   #endif
>>   
>> +#ifdef NO_PTHREADS
>> +#error compat/simple-ipc/ipc-unix-socket.c requires pthreads
>> +#endif
>> +
> 
> Do we want to duplicate the requirement here and risk them drifting
> apart?
> 
>> @@ -997,3 +1003,5 @@ void ipc_server_free(struct ipc_server_data *server_data)
>>   	free(server_data->fifo_fds);
>>   	free(server_data);
>>   }
>> +
>> +#endif /* SUPPORTS_SIMPLE_IPC */
> 
> If anything, I do not think we want a huge #ifdef/#endif around the
> whole file.  Feeding this source to your compiler when these three C
> proprocessor macros do not agree with its use is an error, so perhaps
> lose all of these #ifdef/#endif around the three macros and refer human
> readers to the top-level Makefile with a comment, e.g.
> 
> /*
>   * Non Windows platforms need !NO_UNIX_SOCKETS and !NO_PTHREADS
>   * to compile and use this file.  See the top-level Makefile.
>   */
> 
> if we really wanted to have a way to help builders identify the
> reason why their build is failing.
> 

Would it be better to just have something like the following at the
top of the source files and leave the details to the Makefile:


#ifndef SUPPORTS_SIMPLE_IPC
/*
  * This source file should only be included when Simple IPC
  * is supported.  See the top-level Makefile.
  */
#error SUPPORTS_SIMPLE_IPC not defined
#endif

