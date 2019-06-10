Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5F41F462
	for <e@80x24.org>; Mon, 10 Jun 2019 14:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbfFJOzd (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 10:55:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:30307 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbfFJOzc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 10:55:32 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B32FF3F4135;
        Mon, 10 Jun 2019 10:55:31 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:7414:a9f:53d2:2961] (unknown [IPv6:2001:4898:a800:1010:254a:a9f:53d2:2961])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4058F3F40EB;
        Mon, 10 Jun 2019 10:55:31 -0400 (EDT)
Subject: Re: [PATCH 1/1] diffcore-rename: speed up register_rename_src
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.142.git.gitgitgadget@gmail.com>
 <4ac75dd3635e39f9faa67fb1e88897663e3dc6cd.1560004960.git.gitgitgadget@gmail.com>
 <20190610122632.GA4012@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9c3e18d3-00f4-834f-6a7a-42fd45e69b0e@jeffhostetler.com>
Date:   Mon, 10 Jun 2019 10:55:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610122632.GA4012@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/10/2019 8:26 AM, SZEDER Gábor wrote:
> On Sat, Jun 08, 2019 at 07:42:42AM -0700, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach register_rename_src() to see if new file pair
>> can simply be appended to the rename_src[] array before
>> performing the binary search to find the proper insertion
>> point.
>>
>> This is a performance optimization.  This routine is called
>> during run_diff_files in status and the caller is iterating
>> over the sorted index, so we should expect to be able to
>> append in the normal case.  The existing insert logic is
>> preserved so we don't have to assume that, but simply take
>> advantage of it if possible.
> 
> Could you add a command and performance figures to the commit message
> to show off the benefits of this patch?
> 
>  From the description it's clear that it's a performance optimization,
> but it's unclear whether it has a noticeable, or at least measurable
> effect, or it's "only" a micro-optimization.
> 
> I tried something more substantial than a simple 'git status':
> 
>    # without this patch
>    $ time perf record -g ./git log --oneline -m --name-only v2.20.0 >/dev/null
>    [ ... ]
>    
>    real    2m4.320s
>    user    2m0.913s
>    sys     0m2.284s
>    $ perf report -g none |grep -E '(diffcore_rename|register_rename_src)'
>        52.40%     0.79%  git      git                 [.] diffcore_rename
>         0.01%     0.01%  git      git                 [.] register_rename_src
> 
> but it looks like that while more than half of the considerable
> runtime is spent detecting renames, the time spent in
> register_rename_src(), the function optimized in this patch, is
> negligible.
> 

I just wanted to send an ACK.  I'll include perf numbers
and more clarity after I dig up my notes on this.

Jeff

