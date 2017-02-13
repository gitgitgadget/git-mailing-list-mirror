Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3892F1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 17:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdBMRqj (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 12:46:39 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:30250 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbdBMRqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 12:46:38 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vMXzc1tfYz5tlC;
        Mon, 13 Feb 2017 18:46:36 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 89B362AA8;
        Mon, 13 Feb 2017 18:46:35 +0100 (CET)
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
 <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702101647340.3496@virtualbox>
 <20170210160458.pcp7mupdz24m6cms@sigill.intra.peff.net>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9913e513-553e-eba6-e81a-9c21030dd767@kdbg.org>
Date:   Mon, 13 Feb 2017 18:46:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170210160458.pcp7mupdz24m6cms@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.02.2017 um 17:04 schrieb Jeff King:
> On Fri, Feb 10, 2017 at 04:49:02PM +0100, Johannes Schindelin wrote:
>
>>> I think this is only half the story. A heavy-sha1 workload is faster,
>>> which is good. But one of the original reasons to prefer blk-sha1 (at
>>> least on Linux) is that resolving libcrypto.so symbols takes a
>>> non-trivial amount of time. I just timed it again, and it seems to be
>>> consistently 1ms slower to run "git rev-parse --git-dir" on my machine
>>> (from the top-level of a repo).
>>>
>>> 1ms is mostly irrelevant, but it adds up on scripted workloads that
>>> start a lot of git processes.
>>
>> You know my answer to that. If scripting slows things down, we should
>> avoid it in production code. As it is, scripting slows us down. Therefore
>> I work slowly but steadily to get rid of scripting where it hurts most.
>
> Well, yes. My question is more "what does it look like on normal Git
> workloads?". Are you trading off an optimization for your giant 450MB
> index workload (which _also_ could be fixed by trying do the slow
> operation less, rather than micro-optimizing it) in a way that hurts
> people working with more normal sized repos?
>
> For instance, "make BLK_SHA1=Yes test" is measurably faster for me than
> "make BLK_SHA1= test".

The patch does add a new runtime dependency on libcrypto.dll in my 
environment. I would be surprised if it does not also with your modern 
build tools.

I haven't had time to compare test suite runtimes.

> I'm open to the argument that it doesn't matter in practice for normal
> git users. But it's not _just_ scripting. It depends on the user's
> pattern of invoking git commands (and how expensive the symbol
> resolution is on their system).

It can be argued that in normal interactive use, it is hard to notice 
that another DLL is loaded. Don't forget, though, that on Windows it is 
not only the pure time to resolve the entry points, but also that 
typically virus scanners inspect every executable file that is loaded, 
which adds another share of time.

I'll use the patch for daily work for a while to see whether it hurts.

-- Hannes

