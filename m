Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4711E1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeIKBDM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 21:03:12 -0400
Received: from siwi.pair.com ([209.68.5.199]:32873 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbeIKBDM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 21:03:12 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1F0393F400C;
        Mon, 10 Sep 2018 16:07:28 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D1F2D3F4008;
        Mon, 10 Sep 2018 16:07:27 -0400 (EDT)
Subject: Re: [PATCH v2 2/2] mingw: fix mingw_open_append to work with named
 pipes
To:     Johannes Sixt <j6t@kdbg.org>, jeffhost@microsoft.com
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.35.git.gitgitgadget@gmail.com>
 <pull.35.v2.git.gitgitgadget@gmail.com>
 <f0361dd306d19fa741c813885d240e041dc09a7a.1536599118.git.gitgitgadget@gmail.com>
 <a309396f-bb33-477d-5d92-a98699f5a856@kdbg.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <eedde82a-dedb-88ba-4bb9-fbcfdd7f1b62@jeffhostetler.com>
Date:   Mon, 10 Sep 2018 16:07:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a309396f-bb33-477d-5d92-a98699f5a856@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/10/2018 3:45 PM, Johannes Sixt wrote:
> Am 10.09.18 um 19:05 schrieb Jeff Hostetler via GitGitGadget:
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 858ca14a57..f87376b26a 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -341,6 +341,19 @@ int mingw_mkdir(const char *path, int mode)
>>       return ret;
>>   }
>> +/*
>> + * Calling CreateFile() using FILE_APPEND_DATA and without 
>> FILE_WRITE_DATA
>> + * is documented in [1] as opening a writable file handle in append 
>> mode.
>> + * (It is believed that) this is atomic since it is maintained by the
>> + * kernel unlike the O_APPEND flag which is racily maintained by the 
>> CRT.
>> + *
>> + * [1] 
>> https://docs.microsoft.com/en-us/windows/desktop/fileio/file-access-rights-constants 
>>
>> + *
>> + * This trick does not appear to work for named pipes.  Instead it 
>> creates
>> + * a named pipe client handle that cannot be written to.  Callers should
>> + * just use the regular _wopen() for them.  (And since client handle 
>> gets
>> + * bound to a unique server handle, it isn't really an issue.)
>> + */
>>   static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
>>   {
>>       HANDLE handle;
>> @@ -360,10 +373,12 @@ static int mingw_open_append(wchar_t const 
>> *wfilename, int oflags, ...)
>>               NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
>>       if (handle == INVALID_HANDLE_VALUE)
>>           return errno = err_win_to_posix(GetLastError()), -1;
>> +
>>       /*
>>        * No O_APPEND here, because the CRT uses it only to reset the
>> -     * file pointer to EOF on write(); but that is not necessary
>> -     * for a file created with FILE_APPEND_DATA.
>> +     * file pointer to EOF before each write(); but that is not
>> +     * necessary (and may lead to races) for a file created with
>> +     * FILE_APPEND_DATA.
>>        */
>>       fd = _open_osfhandle((intptr_t)handle, O_BINARY);
>>       if (fd < 0)
>> @@ -371,6 +386,23 @@ static int mingw_open_append(wchar_t const 
>> *wfilename, int oflags, ...)
>>       return fd;
>>   }
>> +#define IS_SBS(ch) (((ch) == '/') || ((ch) == '\\'))
>> +/*
>> + * Does the pathname map to the local named pipe filesystem?
>> + * That is, does it have a "//./pipe/" prefix?
>> + */
>> +static int mingw_is_local_named_pipe_path(const char *filename)
>> +{
>> +    return (IS_SBS(filename[0]) &&
>> +        IS_SBS(filename[1]) &&
>> +        filename[2] == '.'  &&
>> +        IS_SBS(filename[3]) &&
>> +        !strncasecmp(filename+4, "pipe", 4) &&
>> +        IS_SBS(filename[8]) &&
>> +        filename[9]);
>> +}
>> +#undef IS_SBS
>> +
>>   int mingw_open (const char *filename, int oflags, ...)
>>   {
>>       typedef int (*open_fn_t)(wchar_t const *wfilename, int oflags, 
>> ...);
>> @@ -387,7 +419,7 @@ int mingw_open (const char *filename, int oflags, 
>> ...)
>>       if (filename && !strcmp(filename, "/dev/null"))
>>           filename = "nul";
>> -    if (oflags & O_APPEND)
>> +    if ((oflags & O_APPEND) && 
>> !mingw_is_local_named_pipe_path(filename))
>>           open_fn = mingw_open_append;
>>       else
>>           open_fn = _wopen;
> 
> This looks reasonable.

Thanks for the review.

> 
> I wonder which part of the code uses local named pipes. Is it downstream 
> in Git for Windows or one of the topics in flight?
> 
> -- Hannes

I'm wanting to use them as a tracing target option in my trace2 series
currently in progress.

Jeff
