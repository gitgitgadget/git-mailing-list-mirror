Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36212C2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 14:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5C524698
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 14:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgKSOEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 09:04:37 -0500
Received: from siwi.pair.com ([209.68.5.199]:14032 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbgKSOEg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 09:04:36 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 396153F5FBF;
        Thu, 19 Nov 2020 09:04:35 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0D07F3F5FB9;
        Thu, 19 Nov 2020 09:04:35 -0500 (EST)
Subject: Re: RFC: auto-enabling parallel-checkout on NFS
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     gerardu@amazon.com, git@vger.kernel.org
References: <9c999e38-34db-84bb-3a91-ae2a62b964b5@jeffhostetler.com>
 <20201119040117.67914-1-matheus.bernardino@usp.br>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <212a2def-6811-b6e4-0550-ecae2fe0c02c@jeffhostetler.com>
Date:   Thu, 19 Nov 2020 09:04:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201119040117.67914-1-matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/18/20 11:01 PM, Matheus Tavares wrote:
> Hi, Jeff
> 
> On Mon, Nov 16, 2020 at 12:19 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>> I can't really speak to NFS performance, but I have to wonder if there's
>> not something else affecting the results -- 4 and/or 8 core results are
>> better than 16+ results in some columns.  And we get diminishing returns
>> after ~16.
> 
> Yeah, that's a good point. I'm not sure yet what's causing the
> diminishing returns, but Geert and I are investigating. Maybe we are
> hitting some limit for parallelism in this scenario.

I seem to recall back when I was working on this problem that
the unzip of each blob was a major pain point.  Combine this
long delta-chains and each worker would need multiple rounds of
read/memmap, unzip, and de-delta before it had the complete blob
and could then smudge and write.

This makes me wonder if repacking the repo with shorter delta-chains
affects the checkout times.  And improves the perf when there are
more workers.  I'm not saying that this is a solution, but rather
an experiment to see if it changes anything and maybe adjust our
focus.

> 
>> I'm wondering if during these test runs, you were IO vs CPU bound and if
>> VM was a problem.
> 
> I would say we are more IO bound during these tests. While a sequential
> linux-v5.8 checkout usually uses 100% of one core in my laptop's SSD,
> in this setup, it only used 5% to 10%. And even with 64 workers (on a
> single core), CPU usage stays around 60% most of the time.
> 
> About memory, the peak PSS was around 1.75GB, with 64 workers, and the
> machine has 10GB of RAM. But are there other numbers that I should keep
> an eye on while running the test?
> 
>> I'm wondering if setting thread affinity would help here.
> 
> Hmm, I only had one core online during the benchmark, so I think thread
> affinity wouldn't impact the runtime.

I wasn't really thinking about the 64 workers on 1 core case.  I was
more thinking about the 64 workers on 64 cores case and wondering
if workers were being randomly bounced from core to core and we were
thrashing.

> 
> Thanks,
> Matheus
> 
