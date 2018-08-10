Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D882C1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeHJT2Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:28:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:16653 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbeHJT2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:28:15 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6E4143F40F4;
        Fri, 10 Aug 2018 12:57:35 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2EBB23F40F1;
        Fri, 10 Aug 2018 12:57:35 -0400 (EDT)
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking
 for GIT_TRACE
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
 <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
 <70b25098-bf96-d362-56cd-2bb17cadf162@jeffhostetler.com>
Message-ID: <5773077b-8912-c6be-9017-1fc1f3e13b02@jeffhostetler.com>
Date:   Fri, 10 Aug 2018 12:57:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <70b25098-bf96-d362-56cd-2bb17cadf162@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/10/2018 12:51 PM, Jeff Hostetler wrote:
> 
> 
> On 8/10/2018 12:15 PM, Johannes Sixt wrote:
>> Am 09.08.2018 um 19:35 schrieb Johannes Schindelin via GitGitGadget:
>>> I reported a couple of times that t5552 is not passing reliably. It 
>>> has now
>>> reached next, and will no doubt infect master soon.
>>>
>>> Turns out that it is not a Windows-specific issue, even if it occurs 
>>> a lot
>>> more often on Windows than elsewhere.
>>>
>>> The culprit is that two processes try simultaneously to write to the 
>>> same
>>> file specified via GIT_TRACE_PACKET, and it is not well defined how that
>>> should work, even on Linux.
>>
>> Thanks for digging down to the root cause. As has been said, the 
>> behavior of O_APPEND is well-defined under POSIX, but last time I 
>> looked for equivalent feature on Windows, I did not find any.
>>
>> Last time was when I worked around the same failure in 
>> t5503-tagfollow.sh in my private builds:
>>
>> https://github.com/j6t/git/commit/9a447a6844b50b43746d9765b3ac809e2793d742 
>>
>>
>> It is basically the same as Peff suggests: log only one side of the 
>> fetch.
>>
>> As this buglet looks like a recurring theme, and a proper fix is 
>> preferable over repeated work-arounds. To me it looks like we need 
>> some sort of locking on Windows. Unless your friends at Microsoft have 
>> an ace in their sleeves that lets us have atomic O_APPEND the POSIX 
>> way...
> 
> The official Windows CRT for open() does document an O_APPEND, but after
> looking at the distributed source, I'm not sure I trust it.
> 
> I have not looked at the MSYS version of the CRT yet so I cannot comment
> on it.
> 
> I did find that the following code does what we want.  Notice the use of
> FILE_APPEND_DATA in place of the usual GENERIC_READ.  (And yes, the docs
> are very vague here.)

d'oh

s/GENERIC_READ/GENERIC_WRITE/

> 
> Before we try a locking solution, perhaps we should tweak mingw_open()
> to use something like this to get a proper HANDLE directly and then use
> _open_osfhandle() to get a "fd" for it.
> 
> Jeff
> 
> ---------------------------------------------------------------------
> 
> #include <Windows.h>
> 
> int main()
> {
>      HANDLE h = CreateFileW(L"foo.txt",
>          FILE_APPEND_DATA,
>          FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
>          NULL, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
> 
>      const char * buf = "this is a test\n";
>      DWORD len = strlen(buf);
>      DWORD nbw;
> 
>      WriteFile(h, buf, len, &nbw, NULL);
>      CloseHandle(h);
> 
>      return 0;
> }
