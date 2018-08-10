Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E231F404
	for <e@80x24.org>; Fri, 10 Aug 2018 17:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeHJTjZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:39:25 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:50101 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeHJTjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:39:25 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41nBRD6hG0z5tlC;
        Fri, 10 Aug 2018 19:08:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A09081CC6;
        Fri, 10 Aug 2018 19:08:40 +0200 (CEST)
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking
 for GIT_TRACE
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
 <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
 <70b25098-bf96-d362-56cd-2bb17cadf162@jeffhostetler.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0eb43493-ca10-dd09-efdb-93783cc01611@kdbg.org>
Date:   Fri, 10 Aug 2018 19:08:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <70b25098-bf96-d362-56cd-2bb17cadf162@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.2018 um 18:51 schrieb Jeff Hostetler:
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

I looked at the CRT code, too, and no, we can't trust it.

> I have not looked at the MSYS version of the CRT yet so I cannot comment
> on it.
> 
> I did find that the following code does what we want.  Notice the use of
> FILE_APPEND_DATA in place of the usual GENERIC_READ.  (And yes, the docs
> are very vague here.)

As far as I understand, FILE_APPEND_DATA is just a permission flag (I'm 
not sure why that would be necessary), but at least the documentation 
states that it is still necessary for the caller to set the file pointer.

But I haven't tried your code below, yet. Should it append the line of 
text on each invocation? And if so, is it an atomic operation?

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
> 

