Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385A020248
	for <e@80x24.org>; Mon,  8 Apr 2019 09:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfDHJ07 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 05:26:59 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:24709 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHJ07 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 05:26:59 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id DQYIhKjNRniZTDQYIhQl7F; Mon, 08 Apr 2019 10:26:55 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=aulWLQ49AAAA:20 a=CAtTA6jk611Y_yyrQqYA:9
 a=QEXdDO2ut3YA:10
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
 <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <79ecdc5b-2ccf-ae4d-3775-b850641f8c3e@iee.org>
Date:   Mon, 8 Apr 2019 10:26:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfJ+LqflfnWsNfN6dFrE5z2w3B957hUSZ6Q+RHztZPKSL4MFGCpqPdVUlL/i5to4I/HfiMToEH4JT325wMO9x4PkmdfGmyZp6UeVwmENeJchVOPfA2mUk
 fd+DgX4jjqxPUG2PBaU8zgzCx2nf94IaHY2uitIf6kFBRbUJgMkWN4nZGngcUvVa6+Tzafyecj00zPruNaod+fu7QaGwuFr7HEzvPZ7AsqdqWy86UVs4U2X1
 PQ4oNBRffdplU7JXeon7O3gn+Ul+EefI3cBnwwkTNFnw6nFEoBRsLWvzZnHtCqIWjN+ucZNQFeSKvECaocFrdA9FqdEkSnje9lyMVl2A+mkoGdTjO5lVGCwM
 apRQCzGe/lrj+aVXn7PdarHFDnBChuYaacDNBkjfcpIACcBfdAprgcTnDerJ6uxmedcvfRhI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/04/2019 02:23, Duy Nguyen wrote:
> On Mon, Apr 8, 2019 at 5:52 AM Christian Couder
> <christian.couder@gmail.com> wrote:
>>> Git has a very optimized mechanism to compactly store
>>> objects (blobs, trees, commits, etc.) in packfiles[2]. These files are
>>> created by[3]:
>>>
>>> 1. listing objects;
>>> 2. sorting the list with some good heuristics;
>>> 3. traversing the list with a sliding window to find similar objects in
>>> the window, in order to do delta decomposing;
>>> 4. compress the objects with zlib and write them to the packfile.
>>>
>>> What we are calling pack access code in this document, is the set of
>>> functions responsible for retrieving the objects stored at the
>>> packfiles. This process consists, roughly speaking, in three parts:
>>>
>>> 1. Locate and read the blob from packfile, using the index file;
>>> 2. If the blob is a delta, locate and read the base object to apply the
>>> delta on top of it;
>>> 3. Once the full content is read, decompress it (using zlib inflate).
>>>
>>> Note: There is a delta cache for the second step so that if another
>>> delta depends on the same base object, it is already in memory. This
>>> cache is global; also, the sliding windows, are global per packfile.
>> Yeah, but the sliding windows are used only when creating pack files,
>> not when reading them, right?
> These windows are actually for reading. We used to just mmap the whole
> pack file in the early days but that was impossible for 4+ GB packs on
> 32-bit platforms, which was one of the reasons, I think, that sliding
> windows were added, to map just the parts we want to read.

Another "32-bit problem" should also be expressly considered during the 
GSoC work because of the MS Windows definition of uInt / long to be only 
32 bits, leading to much of the Git code failing on the Git for Windows 
port and on the Git LFS (for Windows) for packs and files greater than 
4Gb. https://github.com/git-for-windows/git/issues/1063

Mainly it is just substitution of size_t for long, but there can be 
unexpected coercions when mixed data types get coerced down to a local 
32-bit long. This is made worse by it being implementation defined, so 
one needs to be explicit about some casts up to pointer/memsized types.
>>> # Points to work on
>>>
>>> * Investigate pack access call chains and look for non-thread-safe
>>> operations on then.
>>> * Protect packfile.c read-and-write global variables, such as
>>> pack_open_windows, pack_open_fds and etc., using mutexes.
>> Do you want to work on making both packfile reading and packfile
>> writing thread safe? Or just packfile reading?
> Packfile writing is probably already or pretty close to thread-safe
> (at least the main writing code path in git-pack-objects; the
> streaming blobs to a pack, i'm not so sure).
--
Philip
