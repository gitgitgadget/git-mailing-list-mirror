Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FB6C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 23:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbiAJXWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 18:22:10 -0500
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:2697 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiAJXWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 18:22:09 -0500
Received: from [91.113.179.170] (helo=[192.168.92.29])
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1n73x7-00022w-C6; Tue, 11 Jan 2022 00:19:49 +0100
Message-ID: <5ab9257c-9eba-a171-86d6-3fe7d3a4faec@syntevo.com>
Date:   Tue, 11 Jan 2022 00:22:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] packfile: avoid overflowing shift during decode
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <20211110234033.3144165-1-jonathantanmy@google.com>
 <xmqqpmr7v4gf.fsf@gitster.g>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
In-Reply-To: <xmqqpmr7v4gf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2021 02:58, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> diff --git a/packfile.c b/packfile.c
>> index 89402cfc69..972c327e29 100644
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -1068,7 +1068,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
>>   	size = c & 15;
>>   	shift = 4;
>>   	while (c & 0x80) {
>> -		if (len <= used || bitsizeof(long) <= shift) {
>> +		if (len <= used || (bitsizeof(long) - 7) <= shift) {

This seems to cause troubles now for 32-bit systems (in my case Git for 
Windows 32-Bit): `shift` will go through 4, 11, 18 and for 25 it finally 
errors out. This means that objects >= 32MB can't be processed anymore. 
The condition should probably be changed to:

+		if (len <= used || (bitsizeof(long) - 7) < shift) {

This still ensures that the shift can never overflow and on 32-bit 
systems restores the maximum size of 4G with a final shift of 127<<25 
(the old condition `bitsizeof(long) <= shift` was perfectly valid for 
32-bit systems).

> Even when we have a packfile that is in a good shape, the current
> machine (especially its wordsize) may not be capable of extracting
> the object we are looking at from the packstream, when the object is
> larger than the current machine's ulong can express.  So it may be
> an indication that your machine cannot use the packed object, but
> may not be an indication that there is anything _wrong_ in the
> object header.

I was actually quite confused by the error message "bad object header". 
It made me investigate all sorts of other things before thoroughly 
stepping through this loop.

-Marc
