Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB54C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 10:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiAHKyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 05:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiAHKyn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 05:54:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5A1C061574
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 02:54:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k18so16070659wrg.11
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 02:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j8UBFMs6Ty3D+geMZJvbcW4Ke0i9m04j8vje4wyWuGo=;
        b=m1Rzpf8GSW48tquXnF2abYhwG70sGdstXRiggBUO97YMCv5eyURz71ChXLZvQZpjK/
         aPofB5AP+B+tMZn9LAAN0M+fS/7CY8xfpc6OmOoSH8QxehW8s/WLVkK5fkALd0JW/DPL
         nYJOPrXO4ENoRl92wcyGIaNmj/SXnrvPbnjSHCX8Ogtc8xtwsVmD38eeyncFwd8S3MsD
         yBAZBPyQdotvvtHgF9pQBWL0X8MvjJuSZ3tx6URrhgWprIG59VLLXMxzHNBFHSARvfTy
         olM7XC4djnl+esM61d2nK6743NZGwFZESg4k4r4touqrmBqNzEkFc4HLkeh9VsxKBTMQ
         w6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j8UBFMs6Ty3D+geMZJvbcW4Ke0i9m04j8vje4wyWuGo=;
        b=lInmhLddGFnCUm0tVhrhUd/kd76xoTZbZ2X2XJXErSve9WceHMUk54m4CpcJZKa9wp
         bs0NocWrvbgzYLWaRQxkh5a6lzOQxhr7ZJ7H60WX1xOIhJT2Wg1uO3bZAmoM4EaPDnTa
         5zbEgBkOKY+pWUZxkX9LsoPqHXEmcAyo+YYEjS01UW1+XCJa9+6sa7nk6MtLqLwhR7DM
         OxGK83Sb1Iu4MT6pA1tDbRi9qnVN3CrGbKvAbjeAeNyct73mymV6fnS1xi5vkx/niJcw
         Gt7j+Z+Rg+VLqAUr1A48IE1CVPiRpFbeDaEwwLXA3MfyHcTQwWupzxU6J1ylChNgvg4X
         Znzw==
X-Gm-Message-State: AOAM531a6hwcMId1ZRSw5urMUEX15bxnBo9knVLgq0n9B6/XyU9y45s1
        7UoaS9/EvDwdobeZxE9I3e4=
X-Google-Smtp-Source: ABdhPJxBQoiBhpwu/wDGgSCwNPyRTQXrMWAe3gdDTjuMmNsRokM/miR47JTRf2IHheCZQBPA5K5dOA==
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr4542907wrc.276.1641639281131;
        Sat, 08 Jan 2022 02:54:41 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id c7sm1408299wri.21.2022.01.08.02.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 02:54:40 -0800 (PST)
Message-ID: <2d8c1619-74ab-62b3-3a30-8e500a16649e@gmail.com>
Date:   Sat, 8 Jan 2022 10:54:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] fetch: fix deadlock when cleaning up lockfiles in
 async signals
Content-Language: en-GB-large
To:     Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, iwiedler@gitlab.com
References: <cover.1641552500.git.ps@pks.im>
 <555ec6717ecab0fe6ef5660bcf0d61d59f84ef8b.1641552500.git.ps@pks.im>
 <YdjBkZsnYd+zYne1@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YdjBkZsnYd+zYne1@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 07/01/2022 22:41, Taylor Blau wrote:
> On Fri, Jan 07, 2022 at 11:55:47AM +0100, Patrick Steinhardt wrote:
>> diff --git a/transport.c b/transport.c
>> index 92ab9a3fa6..2a3e324154 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -1456,13 +1456,18 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
>>   	return rc;
>>   }
>>
>> -void transport_unlock_pack(struct transport *transport)
>> +void transport_unlock_pack(struct transport *transport, unsigned int flags)
>>   {
>> +	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
>>   	int i;
>>
>>   	for (i = 0; i < transport->pack_lockfiles.nr; i++)
>> -		unlink_or_warn(transport->pack_lockfiles.items[i].string);
>> -	string_list_clear(&transport->pack_lockfiles, 0);
>> +		if (in_signal_handler)
>> +			unlink(transport->pack_lockfiles.items[i].string);
>> +		else
>> +			unlink_or_warn(transport->pack_lockfiles.items[i].string);
> 
> This puzzled me when I first read it. But unlink_or_warn() isn't
> reentrant because it performs buffered IO on stderr, so if we reached
> this signal handler while executing another function call modifying
> those same buffers, the call within the signal handler would have
> undefined behavior.
> 
> So that makes sense: freeing (with string_list_clear() below) and
> performing buffered IO (with unlink_or_warn() here as just described)
> are certainly off the table.
> 
> But is unlink() safe as-is? I'm not so sure. Reading signal-safety(7),
> it's clearly on the list of functions that are OK to call. But reading
> the errno section:
> 
>      errno
>        Fetching and setting the value of errno is async-signal-safe
>        provided that the signal handler saves errno on entry and restores
>        its value before returning.
> 
> We certainly not doing that, though that's nothing new, and so I wonder
> why it doesn't seem to be an issue in practice.

Because in this case we re-raise the signal and exit it does not matter 
if unlink() clobbers errno. If instead the program were to continue 
after handling the signal then we would have to save and restore errno 
to avoid interfering with the code that was running when the signal 
handler was called.

Best Wishes

Phillip

> Thanks,
> Taylor
