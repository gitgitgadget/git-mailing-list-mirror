Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7E4C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 17:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiD0Rwz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 Apr 2022 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiD0Rwr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 13:52:47 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FF846141
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:49:34 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23RHnWPi048243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Apr 2022 13:49:32 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <phillip.wood@dunelm.org.uk>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Carlo Arenas'" <carenas@gmail.com>
Cc:     <git@vger.kernel.org>, <philipoakley@iee.email>, <me@ttaylorr.com>,
        <guy.j@maurel.de>, <szeder.dev@gmail.com>,
        <johannes.Schindelin@gmx.de>, <derrickstolee@github.com>
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com> <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com> <xmqqczh2o5xg.fsf@gitster.g> <ed2cdc8f-1908-a095-ddf1-660ef8b5a90b@gmail.com>
In-Reply-To: <ed2cdc8f-1908-a095-ddf1-660ef8b5a90b@gmail.com>
Subject: RE: [PATCH] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Wed, 27 Apr 2022 13:49:28 -0400
Organization: Nexbridge Inc.
Message-ID: <00ab01d85a5f$2831e0a0$7895a1e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKW87AjxA2cdMBJpUJ6sUXK7KFdYwFanWTqAZPhW0MBIEH92gDqbA5BAl+YXlqrTBA4AA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 27, 2022 1:22 PM, Phillip Wood wrote:
>On 27/04/2022 17:19, Junio C Hamano wrote:
>> Carlo Arenas <carenas@gmail.com> writes:
>>>> The standard is silent on what happens to error when the value is
>>>> out of range.
>>
>> Actually the standard is is very clear what happens to endptr (no,
>> don't call it "error", that is not the point of the parameter).
> >
>>      A pointer to the final string shall be stored in the object
>>      pointed to by endptr, provided that endptr is not a null
>>      pointer.
>>
>> where "final string" has a precise definition much earlier:
>>
>>      First, they decompose the input string into three parts:
>>
>>      1. An initial, possibly empty, sequence of white-space
>>         characters (as specified by isspace())
>>
>>      2. A subject sequence interpreted as an integer represented in
>>         some radix determined by the value of base
>>
>>      3. A final string of one or more unrecognized characters,
>>         including the terminating null byte of the input string.
>>
>>      Then they shall attempt to convert the subject sequence to an
>>      integer, and return the result.
>>
>> So, leading whitespace is stripped, then "subject sequence" that is
>> the sequence of digits (with optional +/- sign) to be turned into a
>> long is recognised, and what remains is the "final string".  endptr is
>> made to point at that "final string", and it does not matter what kind
>> of value the interpretation of "subject sequence" yields.
>
>Oh I think I misunderstood when I read the standard this morning. Just to check I
>do understand now, in the case of overflow entptr points to the final string (i.e. to
>the character following the last digit) even though the "subject sequence" cannot
>be successfully converted?

I can confirm this on multiple 32-bit platforms. With strtol("123456789012345678", &endptr, 10) returns 2147483647 and *endptr == '\0' just beyond the last 8.

