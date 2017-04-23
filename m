Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81412207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 19:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1045995AbdDWTt5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 15:49:57 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:61914 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1045955AbdDWTt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 15:49:56 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wB0S20qnXz5tlH;
        Sun, 23 Apr 2017 21:49:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 790412AA7;
        Sun, 23 Apr 2017 21:49:53 +0200 (CEST)
Subject: Re: [PATCH v2] archive-zip: Add zip64 headers when file size is too
 large for 32 bits
To:     Peter Krefting <peter@softwolves.pp.se>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
Date:   Sun, 23 Apr 2017 21:49:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.04.2017 um 16:51 schrieb Peter Krefting:
> Johannes Sixt:
>>> @@ -376,7 +397,7 @@ static int write_zip_entry(struct archiver_args
>>> *args,
>>>      copy_le16(dirent.comment_length, 0);
>>>      copy_le16(dirent.disk, 0);
>>>      copy_le32(dirent.attr2, attr2);
>>> -    copy_le32(dirent.offset, zip_offset);
>>> +    copy_le32(dirent.offset, clamp_max(zip_offset, 0xFFFFFFFFU,
>>> &clamped));
>>
>> I don't see any provisions to write the zip64 extra header in the
>> central directory when this offset is clamped. This means that ZIP
>> archives whose size exceed 4GB are still unsupported.
>
> The clamped flag will trigger the inclusion of the zip64 central
> directory, which contains the 64-bit offset. Should the central
> directory entry also have the zip64 extra field?

There is no "zip64 central directory". There is a "zip64 end of central 
directory record"; it tells where to find the "central directory" in 
case that the ZIP archive exceeds 4GB. The central directory has the 
same format in a non-zip64 and a zip64 archive. But when size, 
compressed size, and offset overflow 4GB, it uses the same zip64 extra 
record like the local header records, except that it has to record an 
offset in addition to the uncompressed and compressed sizes.

The uncompressed and compressed sizes of entries are mentioned in both 
the central directory and the individual local headers. I think that the 
central directory's values are authorative; my reasoning is that it is 
possible that the local header can have a bit set that tells that the 
local header's values size values are garbage.

In summary, yes, when the central directory is constructed, it must use 
the zip64 extra record to note the values of uncompressed size, 
compressed size, and the offset to the local header when they overflow 4GB.

-- Hannes

