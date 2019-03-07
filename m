Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222A320248
	for <e@80x24.org>; Thu,  7 Mar 2019 17:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCGR34 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 12:29:56 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:64540 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfCGR3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 12:29:55 -0500
Received: from [192.168.1.12] ([92.29.14.153])
        by smtp.talktalk.net with SMTP
        id 1wq8h46yUniZT1wq8h8eCO; Thu, 07 Mar 2019 17:29:53 +0000
X-Originating-IP: [92.29.14.153]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=BLrICWmQs9+T7cG0JL9/VQ==:117
 a=BLrICWmQs9+T7cG0JL9/VQ==:17 a=IkcTkHD0fZMA:10 a=aulWLQ49AAAA:20
 a=5rxgeBVgAAAA:8 a=YQiaTBv1VFt1_NtPTsoA:9 a=9MjCkU2Y01z2aLZf:21
 a=Sa13rYyxp4XkPQAD:21 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22
Subject: Re: Large object issue (Windows)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Hogg <phogg@novamoon.net>,
        git-for-windows@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAFOcBz=+XZtcxPxeE3j6dpHXA79R_BOyDCtNbwSu+nbBpPzGrw@mail.gmail.com>
 <20190305033526.GH601925@genre.crustytoothpaste.net>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <44f5c2ae-149f-2b7c-77ac-90476ed7bd9d@iee.org>
Date:   Thu, 7 Mar 2019 17:29:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190305033526.GH601925@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfCH1LP6yW/7mnT6PNwA/1wpWSTDOU6q+hHhBQWJ1wjpMX3UDw8+UxB3mKDFONWax5Gb79yqIKT+bHGmihCF4UeQm6rOrs9ueLmI+jIuSOWIydr4XcgHr
 mnlFavocfJipWs0a5nRQq/q6g6wHprlV72ZqhQztbop+7WWwNOHd0FkVf3wi6nhAPfE5mtc9MxxJAFCVpTbK7nJjkfdvmZwAzdDkZOTVp1gvGMvJEY2Po/Zy
 vRoGUa9SCrEiq7UEPR61UxAkgUYKpHcHKuwWJTaPpHzY+dVJrn4Xz7RIeH5QlhU6XgAAy/OyQtPTnh8SHTN+qo8RLLv7apir9X4itbVfogk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/03/2019 03:35, brian m. carlson wrote:
> On Mon, Mar 04, 2019 at 07:04:02PM -0500, Patrick Hogg wrote:
>> Hi all,
>>
>> While investigating the last issue I reported (and fixed) I was trying
>> to come up with a good test case for repos with large objects. In the
>> process I found an issue on Windows with objects at least 4g large:
>>
>> git init test
>> cd test
>> echo "*.exe binary" > .gitattributes
>> truncate -s 4g nullbytes.exe
>> git stage .
>> git commit -m "Test"
>> # This will break, complaining that the object is corrupt.
>> git fsck --full
>> # This will also break, complaining that the object is corrupt.
>> #git gc
>>
>> I did some investigation and I think that this is a porting issue.
>> unpack_object_header_buffer in packfile.c uses an unsigned long for the
>> size. On Linux this will be 64 bits (at least on the Linux systems I've
>> tried) but on Windows it's 32 bits. The code then decides that the
>> object header is bad and bombs. However, if I move the repo to a Linux
>> machine it can handle the data just fine. (And ironically git generated
>> the object header when storing the object!)
>>
>> Is there any reason not to switch the unsigned longs in
>> unpack_object_header_buffer (and its callers, wherever that may lead)
>> to uint64_t? (Or any potential pitfalls in doing so that I would need
>> to look out for?)
> It's known that there are several problems with this, affecting various
> parts of the code. Patches to fix this are of course welcome.
>
> I think we've chosen to specify size_t for values which are stored
> entirely in memory, since a buffer can't be larger than this size, and
> off_t for sizes which refer to files or object sizes. The latter will be
> 64-bit on 32-bit systems when compiled with _FILE_OFFSET_BITS set to 64,
> while the former will be 32-bit.

Hi Patrick,

There is also a thread on the Git-for-Windows list at 
https://github.com/git-for-windows/git/issues/1063 and also here at 
https://public-inbox.org/git/994568940.109648.1548957557643@ox.hosteurope.de/ 


Part of the issues is that zlib on windows 'sort of' fails to do >4Gb - 
see their FAQ32 - in that the length value is only 'long' which is only 
32 bit, while in fact the zlib copes fine but returns a length modulo 
that limit.

Trying to get all the places that should be upcast to size_t (ptr) or 
ptdiff_t rather than coerced down to windows 32bit long is part of the 
struggle.

Philip

