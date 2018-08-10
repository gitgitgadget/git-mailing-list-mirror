Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25B11F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeHJSqK (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 14:46:10 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:48641 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbeHJSqK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 14:46:10 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41n9G12hvpz5tlM;
        Fri, 10 Aug 2018 18:15:37 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AEAE3204B;
        Fri, 10 Aug 2018 18:15:36 +0200 (CEST)
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking
 for GIT_TRACE
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
Date:   Fri, 10 Aug 2018 18:15:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <pull.17.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.2018 um 19:35 schrieb Johannes Schindelin via GitGitGadget:
> I reported a couple of times that t5552 is not passing reliably. It has now
> reached next, and will no doubt infect master soon.
> 
> Turns out that it is not a Windows-specific issue, even if it occurs a lot
> more often on Windows than elsewhere.
> 
> The culprit is that two processes try simultaneously to write to the same
> file specified via GIT_TRACE_PACKET, and it is not well defined how that
> should work, even on Linux.

Thanks for digging down to the root cause. As has been said, the 
behavior of O_APPEND is well-defined under POSIX, but last time I looked 
for equivalent feature on Windows, I did not find any.

Last time was when I worked around the same failure in 
t5503-tagfollow.sh in my private builds:

https://github.com/j6t/git/commit/9a447a6844b50b43746d9765b3ac809e2793d742

It is basically the same as Peff suggests: log only one side of the fetch.

As this buglet looks like a recurring theme, and a proper fix is 
preferable over repeated work-arounds. To me it looks like we need some 
sort of locking on Windows. Unless your friends at Microsoft have an ace 
in their sleeves that lets us have atomic O_APPEND the POSIX way...

-- Hannes
