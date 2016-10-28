Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C7D5203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 05:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbcJ1FzV (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 01:55:21 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:58986 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbcJ1FzU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 01:55:20 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t4tJk2FvRz5tlM;
        Fri, 28 Oct 2016 07:55:18 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9E750143;
        Fri, 28 Oct 2016 07:55:17 +0200 (CEST)
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Jacob Keller <jacob.keller@gmail.com>
References: <20161026215732.16411-1-sbeller@google.com>
 <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
 <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
 <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
 <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org>
 <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
 <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org>
 <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2ddca5e3-3c4d-b555-4309-a180ceed581e@kdbg.org>
Date:   Fri, 28 Oct 2016 07:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.10.2016 um 23:49 schrieb Jacob Keller:
> Ok, so I've been reading this thread. I don't understand your
> objections to emulating in this way.. Could you clearly spell out why
> you believe this solution isn't acceptable? So far all I've understood
> was "it's not critical sections" and "it penalizes Windows too much"
> but... If Windows cannot statically initialize a pthread mutex, then
> we *have* to dynamically initialize it somewhere. This solution adds a
> single check before each lock and is safe due to use of memory
> barriers. Yes, this will cost a tiny bit extra overhead for each use
> of "pthread_mutex_lock" but I fail to see how that is a huge
> penalty...

One point is that the DCLP idiom must be implemented correctly. There 
are solutions, of course, and when the initialization is over, we have a 
miniscule overhead at each pthread_mutex_lock call.

The main point is that the initialization has to solve a chicken-and-egg 
problem: After we have found an uninitialized critical section, we have 
to have mutual exclusion for the initialization. We need another 
critical section for this, but we cannot have one that is initialized. 
For this reason, the solution uses a different kind of mutual exclusion 
primitive, which is more akin to POSIX semaphores and works across 
processes. In the patch proposed by Stefan, a *session-wide* mutex is 
used. That means that all concurrent git invocations in a user's session 
synchronize their initialization of critical section objects.

That's just ridiculous. It's like waiting for a ... no, *the* ... battle 
ship just to get our bouncers in their position. We are talking 
milliseconds here, not nanoseconds.

-- Hannes

