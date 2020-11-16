Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A17C5519F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 15:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB92137B
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgKPPTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:19:12 -0500
Received: from siwi.pair.com ([209.68.5.199]:11543 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729499AbgKPPTM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 10:19:12 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 931743F5FC4;
        Mon, 16 Nov 2020 10:19:10 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6A86B3F5FB7;
        Mon, 16 Nov 2020 10:19:10 -0500 (EST)
Subject: Re: RFC: auto-enabling parallel-checkout on NFS
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     gerardu@amazon.com
References: <20201115194359.67901-1-matheus.bernardino@usp.br>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9c999e38-34db-84bb-3a91-ae2a62b964b5@jeffhostetler.com>
Date:   Mon, 16 Nov 2020 10:19:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201115194359.67901-1-matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/15/20 2:43 PM, Matheus Tavares wrote:
> Hi, everyone
> 
> I've been testing the parallel checkout code on some different machines,
> to benchmark its performance against the sequential version. As
> discussed in [1], the biggest speedups, on Linux, are usually seen on
> SSDs and NFS volumes. (I haven't got the chance to benchmark on
> Windows or OSX yet.)
> 
> Regarding NFS, I got some 2~3.4x speedups even when the NFS client and
> server were both running on single-core machines. Here are some runtimes
> for a linux-v5.8 clone (means of 5 cold-cache executions):
> 
>      nfs 3.0              nfs 4.0              nfs 4.1
> 1:  183.708 s ± 3.290 s  205.851 s ± 0.844 s  217.317 s ± 3.047 s
> 2:  130.510 s ± 3.917 s  139.124 s ± 0.772 s  142.963 s ± 0.765 s
> 4:   89.611 s ± 1.032 s  102.701 s ± 1.665 s   94.728 s ± 1.014 s
> 8:   68.097 s ± 0.820 s  104.914 s ± 1.239 s   69.359 s ± 0.619 s
> 16:  63.999 s ± 0.820 s  104.808 s ± 2.279 s   64.843 s ± 0.587 s
> 32:  62.316 s ± 2.095 s  102.105 s ± 1.537 s   64.122 s ± 0.374 s
> 64:  63.699 s ± 0.841 s  103.103 s ± 1.319 s   63.532 s ± 0.734 s
> 
> The parallel version was also faster for some smaller checkouts. For
> example, the following numbers come from a bat-v0.16.0 clone
> (251 files, ~3MB):
> 
>       nfs 3.0             nfs 4.0             nfs 4.1
> 1:   0.853 s ± 0.080 s   0.814 s ± 0.020 s   0.876 s ± 0.065 s
> 2:   0.671 s ± 0.020 s   0.702 s ± 0.030 s   0.705 s ± 0.030 s
> 4:   0.530 s ± 0.024 s   0.595 s ± 0.020 s   0.570 s ± 0.030 s
> 8:   0.470 s ± 0.033 s   0.609 s ± 0.025 s   0.510 s ± 0.031 s
> 16:  0.469 s ± 0.037 s   0.616 s ± 0.022 s   0.513 s ± 0.030 s
> 32:  0.487 s ± 0.030 s   0.639 s ± 0.018 s   0.527 s ± 0.028 s
> 64:  0.520 s ± 0.022 s   0.680 s ± 0.028 s   0.562 s ± 0.026 s
> 
> While looking at these numbers with Geert (in CC), he had the idea that
> we could try to detect when the checkout path is within an NFS mount,
> and auto-enable paralellism for this case. This way, users in NFS would
> get the best performance by default. And it seems that using ~16 workers
> would produce good results regardless of the NFS version that they might
> be running.
> 
> The major downside is that detecting the file system type is quite
> platform-dependent, so there is no simple and portable solution. (Also,
> I'm not sure if the optimal number of workers would be the same on
> different OSes). But we decided to give it a try, so this is a
> rough prototype that would work for Linux:
> https://github.com/matheustavares/git/commit/2e2c787e2a1742fed8c35dba185b7cd208603de9
> 
> Any thoughts on this idea? Or alternative suggestions?
> 
> Thanks,
> Matheus
> 
> [1]: https://lore.kernel.org/git/815137685ac3e41444201316f537db9797dcacd2.1604521276.git.matheus.bernardino@usp.br/
> 

I can't really speak to NFS performance, but I have to wonder if there's
not something else affecting the results -- 4 and/or 8 core results are
better than 16+ results in some columns.  And we get diminishing returns
after ~16.

I'm wondering if during these test runs, you were IO vs CPU bound and if
VM was a problem.  I'm wondering if setting thread affinity would help
here.

Jeff

