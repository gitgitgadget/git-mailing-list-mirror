Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D811F404
	for <e@80x24.org>; Mon, 10 Sep 2018 15:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeIJUjj (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 16:39:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:56211 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbeIJUjj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 16:39:39 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A4E703F4008;
        Mon, 10 Sep 2018 11:44:57 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 69AAD3F4000;
        Mon, 10 Sep 2018 11:44:57 -0400 (EDT)
Subject: Re: [PATCH 2/2] mingw: fix mingw_open_append to work with named pipes
To:     Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.35.git.gitgitgadget@gmail.com>
 <f433937d55974b75750cfc7d579a6a56109259a4.1536344387.git.gitgitgadget@gmail.com>
 <1c524f56-2021-a961-168f-e5c6d7914ec2@kdbg.org>
 <f207bc28-a303-5d63-e9f4-da8e4d466bd5@kdbg.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0d38ec8e-3f4b-c0fb-ba6f-e2cef39e4db4@jeffhostetler.com>
Date:   Mon, 10 Sep 2018 11:44:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f207bc28-a303-5d63-e9f4-da8e4d466bd5@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/8/2018 2:31 PM, Johannes Sixt wrote:
> Am 08.09.2018 um 11:26 schrieb Johannes Sixt:
>> Am 07.09.2018 um 20:19 schrieb Jeff Hostetler via GitGitGadget:
>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>> index 858ca14a57..ef03bbe5d2 100644
>>> --- a/compat/mingw.c
>>> +++ b/compat/mingw.c
>>> @@ -355,7 +355,7 @@ static int mingw_open_append(wchar_t const 
>>> *wfilename, int oflags, ...)
>>>        * FILE_SHARE_WRITE is required to permit child processes
>>>        * to append to the file.
>>>        */
>>> -    handle = CreateFileW(wfilename, FILE_APPEND_DATA,
>>> +    handle = CreateFileW(wfilename, FILE_WRITE_DATA | FILE_APPEND_DATA,
>>>               FILE_SHARE_WRITE | FILE_SHARE_READ,
>>>               NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
>>>       if (handle == INVALID_HANDLE_VALUE)
>>>
>>
>> I did not go with this version because the documentation 
>> https://docs.microsoft.com/en-us/windows/desktop/fileio/file-access-rights-constants 
>> says:
>>
>> FILE_APPEND_DATA: For a file object, the right to append data to the 
>> file. (For local files, write operations will not overwrite existing 
>> data if this flag is specified without FILE_WRITE_DATA.) [...]
>>
>> which could be interpreted as: Only if FILE_WRITE_DATA is not set, we 
>> have the guarantee that existing data in local files is not 
>> overwritten, i.e., new data is appended atomically.
>>
>> Is this interpretation too narrow and we do get atomicity even when 
>> FILE_WRITE_DATA is set?
> 
> Here is are some comments on stackoverflow which let me think that 
> FILE_APPEND_DATA with FILE_WRITE_DATA is no longer atomic:
> 
> https://stackoverflow.com/questions/20093571/difference-between-file-write-data-and-file-append-data#comment29995346_20108249 
> 
> 
> -- Hannes

Yeah, this whole thing is a little under-documented for my tastes.
Let's leave it as you have it.  I'll re-roll with a fix to route
named pipes to the existing _wopen() code.

thanks
Jeff
