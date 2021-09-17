Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35832C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 18:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188D76121F
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 18:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245473AbhIQSME (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 14:12:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:34180 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233022AbhIQSMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 14:12:03 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 323C03F40D5;
        Fri, 17 Sep 2021 14:10:41 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1004:b109:12e8:cc1c:b3d3:708a:a5be])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B85493F4095;
        Fri, 17 Sep 2021 14:10:40 -0400 (EDT)
Subject: Re: [PATCH 5/7] simple-ipc/ipc-win32: add Windows ACL to named pipe
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <5eadf71929559968cafa18d03c3a623b1adff926.1631738177.git.gitgitgadget@gmail.com>
 <877dfhm5ki.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9b1c8691-936f-c481-e3af-dd94efa57152@jeffhostetler.com>
Date:   Fri, 17 Sep 2021 14:10:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <877dfhm5ki.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/16/21 1:47 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Sep 15 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> +struct my_sa_data
>> +{
>> +	PSID pEveryoneSID;
>> +	PACL pACL;
>> +	PSECURITY_DESCRIPTOR pSD;
>> +	LPSECURITY_ATTRIBUTES lpSA;
>> +};
>> +
>> +static void init_sa(struct my_sa_data *d)
>> +{
>> +	memset(d, 0, sizeof(*d));
>> +}
>> +
>> +static void release_sa(struct my_sa_data *d)
>> +{
>> +	if (d->pEveryoneSID)
>> +		FreeSid(d->pEveryoneSID);
>> +	if (d->pACL)
>> +		LocalFree(d->pACL);
>> +	if (d->pSD)
>> +		LocalFree(d->pSD);
>> +	if (d->lpSA)
>> +		LocalFree(d->lpSA);
>> +
>> +	memset(d, 0, sizeof(*d));
>> +}
> 
> [...]
> 
>> +fail:
>> +	release_sa(d);
>> +	return NULL;
>> +}
>> +
>>   static HANDLE create_new_pipe(wchar_t *wpath, int is_first)
>>   {
>>   	HANDLE hPipe;
>>   	DWORD dwOpenMode, dwPipeMode;
>> -	LPSECURITY_ATTRIBUTES lpsa = NULL;
>> +	struct my_sa_data my_sa_data;
>> +
>> +	init_sa(&my_sa_data);
>>   
> 
> [...]
> 
>>   	hPipe = CreateNamedPipeW(wpath, dwOpenMode, dwPipeMode,
>> -				 PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, lpsa);
>> +				 PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0,
>> +				 my_sa_data.lpSA);
>> +
>> +	release_sa(&my_sa_data);
>>   
>>   	return hPipe;
>>   }
> 
> Just a nit on the init pattern, since we always allocate this on the
> stack (this as all the relevant "struct my_sa_data") I'd have thought to
> see:
> 
>      #define INIT_MY_SA_DATA { 0 }
>      [...]
>      struct my_sa_data my_sa_data = INIT_MY_SA_DATA;
> 
> Which gets rid of the need for an init_sa() function.

The current "my_sa_data" is just a set of 4 pointers, so yes your
INIT_MY_SA_DATA macro and my init_sa function are equivalent.
(And assuming that mine and memset are inlined by the compiler, they
are both probably exactly equivalent.)   So it really doesn't matter
one way or the other.

> 
> Also having the release_sa() do a memset() is a bit odd, usually we have
> a reset*() function do that if the intent is to re-use, but it doesn't
> appear to be in this case, and we don't return this data anywhere, do
> we?
> 

I use the release_sa() function inside my "fail:" label in get_sa()
to cleanup if any of the component parts of the SA cannot be created.
So the return value of get_sa() is either fully constructed or contains
NULL pointers.

(The docs are jargon heavy and little obscure and circular and it
is not at all clear if/when we might fail to create some of these
sub-structures.)

So I allow the SA failure to be silently ignored and we create the named
pipe without an ACL.  Normally, this is fine since the daemon usually
isn't elevated.

In create_new_pipe we always call release_sa to free the pointers if
necessary.  (So in case of a failure in get_sa, we won't double free
the pointers when create_new_pipe calls release_sa.)

Another way to think of it is that in release_sa, I'd like to have
FREE_AND_NULL() variants for FreeSid() and LocalFree(), but a simple
memset is sufficient.


Jeff
