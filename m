Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5211F453
	for <e@80x24.org>; Fri, 28 Sep 2018 20:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeI2Czb (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 22:55:31 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38046 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeI2Czb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 22:55:31 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 5zOmgYSu2jlDz5zOog89b3; Fri, 28 Sep 2018 21:30:06 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=S-R3Yig_cHmwMKfdPzcA:9
 a=6vj_DqVr9Vop3kNg:21 a=xZXRE4967WxUruWD:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v6 4/7] config: add new index.threads config setting
To:     Ben Peart <peartben@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
 <20180926195442.1380-5-benpeart@microsoft.com>
 <20180928002627.GO27036@localhost>
 <cbc48a95-62f5-a098-fb70-97b6cf241920@gmail.com>
 <xmqqsh1tczyz.fsf@gitster-ct.c.googlers.com>
 <a58a5cce-b3c2-62a2-598b-6b7dbe1a86fc@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <bf0c24ac-6e2a-9a3e-835f-f21e763ab2c7@ramsayjones.plus.com>
Date:   Fri, 28 Sep 2018 21:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a58a5cce-b3c2-62a2-598b-6b7dbe1a86fc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMqNDffAwwMwoDdA9Un4Xw/eWX1+4bzbX0UkcL9N38UY4wjqqh4LxJMYslUUzeU23OmbfEfKqpv2pPzZPJRanEFsh5kGijqV1xHZzpIdCN7lAbuM/J6t
 ykf0sOJFx/e4C+MjqTSB2Hfh7fiatEjlwb1Jm1KkriHvBNZxUTVW2ZoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/09/18 20:41, Ben Peart wrote:
> 
> 
> On 9/28/2018 1:07 PM, Junio C Hamano wrote:
>> Ben Peart <peartben@gmail.com> writes:
>>
>>>> Why does multithreading have to be disabled in this test?
>>>
>>> If multi-threading is enabled, it will write out the IEOT extension
>>> which changes the SHA and causes the test to fail.
>>
>> I think it is a design mistake to let the writing processes's
>> capability decide what is written in the file to be read later by a
>> different process, which possibly may have different capability.  If
>> you are not writing with multiple threads, it should not matter if
>> that writer process is capable of and configured to spawn 8 threads
>> if the process were reading the file---as it is not reading the file
>> it is writing right now.
>>
>> I can understand if the design is to write IEOT only if the
>> resulting index is expected to become large enough (above an
>> arbitrary threshold like 100k entries) to matter.  I also can
>> understand if IEOT is omitted when the repository configuration says
>> that no process is allowed to read the index with multi-threaded
>> codepath in that repository.
>>
> 
> There are two different paths which determine how many blocks are written to the IEOT.  The first is the default path.  On this path, the number of blocks is determined by the number of cache entries divided by the THREAD_COST.  If there are sufficient entries to make it faster to use threading, then it will automatically use enough blocks to optimize the performance of reading the entries across multiple threads.
> 
> I currently cap the maximum number of blocks to be the number of cores that would be available to process them on that same machine purely as an optimization.  The majority of the time, the index will be read from the same machine that it was written on so this works well.  Before I added that logic, you would usually end up with more blocks than available threads which meant some threads had more to do than the other threads and resulted in worse performance.  For example, 4 blocks across 3 threads results in the 1st thread having twice as much work to do as the other threads.
> 
> If the index is copied to a machine with a different number of cores, it will still all work - it just may not be optimal for that machine.  This is self correcting because as soon as the index is written out, it will be optimized for that machine.
> 
> If the "automatically try to make it perform optimally" logic doesn't work for some reason, we have path #2.
> 
> The second path is when the user specifies a specific number of blocks via the GIT_TEST_INDEX_THREADS=<n> environment variable or the index.threads=<n> config setting.  If they ask for n blocks, they will get n blocks.  This is the "I know what I'm doing and want to control the behavior" path.
> 
> I just added one additional test (see patch below) to avoid a divide by zero bug and simplify things a bit.  With this change, if there are fewer than two blocks, the IEOT extension is not written out as it isn't needed.  The load would be single threaded anyway so there is no reason to write out a IEOT extensions that won't be used.
> 
> 
> 
> diff --git a/read-cache.c b/read-cache.c
> index f5d766088d..a1006fa824 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2751,18 +2751,23 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfil
> e,
>                  */
>                 if (!nr) {
>                         ieot_blocks = istate->cache_nr / THREAD_COST;
> -                       if (ieot_blocks < 1)
> -                               ieot_blocks = 1;
>                         cpus = online_cpus();
>                         if (ieot_blocks > cpus - 1)
>                                 ieot_blocks = cpus - 1;

So, am I reading this correctly - you need cpus > 2 before an
IEOT extension block is written out?

OK.

ATB,
Ramsay Jones

>                 } else {
>                         ieot_blocks = nr;
>                 }
> -               ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
> -                       + (ieot_blocks * sizeof(struct index_entry_offset)));
> -               ieot->nr = 0;
> -               ieot_work = DIV_ROUND_UP(entries, ieot_blocks);
> +
> +               /*
> +                * no reason to write out the IEOT extension if we don't
> +                * have enough blocks to utilize multi-threading
> +                */
> +               if (ieot_blocks > 1) {
> +                       ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
> +                               + (ieot_blocks * sizeof(struct index_entry_offset)));
> +                       ieot->nr = 0;
> +                       ieot_work = DIV_ROUND_UP(entries, ieot_blocks);
> +               }
>         }
>  #endif
> 
> 
