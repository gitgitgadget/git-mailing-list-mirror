Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E66E207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 21:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1173327AbdDXVCY (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 17:02:24 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:15643 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1173131AbdDXVCW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 17:02:22 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wBf130Zcwz5tl9;
        Mon, 24 Apr 2017 23:02:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 847E242D2;
        Mon, 24 Apr 2017 23:02:14 +0200 (CEST)
Subject: Re: [PATCH v3 4/5] archive-zip: support archives bigger than 4GB
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <02ddca3c-a11f-7c0c-947e-5ca87a62cdee@web.de>
 <alpine.DEB.2.11.1704241912510.30460@perkele.intern.softwolves.pp.se>
 <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de>
Cc:     Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <13bc4fd9-984d-8b37-a18a-c7d273fbba36@kdbg.org>
Date:   Mon, 24 Apr 2017 23:02:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 22:06 schrieb René Scharfe:
> Am 24.04.2017 um 20:24 schrieb Peter Krefting:
>> René Scharfe:
>>
>>> @@ -433,6 +446,11 @@ static int write_zip_entry(struct archiver_args
>>> *args,
>>>     free(deflated);
>>>     free(buffer);
>>>
>>> +    if (offset > 0xffffffff) {
>>> +        zip64_dir_extra_payload_size += 8;
>>> +        zip_dir_extra_size += 2 + 2 + zip64_dir_extra_payload_size;
>>> +    }
>>> +
>>>     strbuf_add_le(&zip_dir, 4, 0x02014b50);    /* magic */
>>>     strbuf_add_le(&zip_dir, 2, creator_version);
>>>     strbuf_add_le(&zip_dir, 2, 10);        /* version */
>>
>> This needs to be >=. The spec says that if the value is 0xffffffff,
>> there should be a zip64 record with the actual size (even if it is
>> 0xffffffff).
>
> Could you please cite the relevant part?
>
> Here's how I read it: If a value doesn't fit into a 32-bit field it is
> set to 0xffffffff, a zip64 extra is added and a 64-bit field stores the
> actual value.  The magic value 0xffffffff indicates that a corresponding
> 64-bit field is present in the zip64 extra.  That means even if a value
> is 0xffffffff (and thus fits) we need to add it to the zip64 extra.  If
> there is no zip64 extra then we can store 0xffffffff in the 32-bit
> field, though.

The reader I wrote recently interprets 0xffffffff as special if the 
version is 45. Then, if there is no zip64 extra record, it is a broken 
ZIP archive. You are saying that my reader is wrong in this special case...

-- Hannes

