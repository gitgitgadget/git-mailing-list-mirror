Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7341FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 21:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754292AbcLTVrP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 16:47:15 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:46408 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753944AbcLTVrP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 16:47:15 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tjrwc3fzWz5tlJ;
        Tue, 20 Dec 2016 22:47:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 007AF2222;
        Tue, 20 Dec 2016 22:47:11 +0100 (CET)
Subject: Re: [PATCHv4 3/5] run-command: add {run,start,finish}_command_or_die
To:     Stefan Beller <sbeller@google.com>
References: <20161219232828.5075-1-sbeller@google.com>
 <20161219232828.5075-4-sbeller@google.com>
 <aad0af97-7588-632d-a113-5d8372b8b7a8@kdbg.org>
 <CAGZ79kYNKWfnEXWJfyRUutFyaQiRD9qW--LkK4Nbwdf7FtdPQA@mail.gmail.com>
 <f14ee492-8297-c8ec-f80f-f8f24caf91e1@kdbg.org>
 <CAGZ79kYG-veuWNFh6G1g5MiQHBGk2i1qbH_NBtnMS6jFcoWocg@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <48970168-ba4b-e125-6624-e4c37b8a7180@kdbg.org>
Date:   Tue, 20 Dec 2016 22:47:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYG-veuWNFh6G1g5MiQHBGk2i1qbH_NBtnMS6jFcoWocg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.12.2016 um 21:49 schrieb Stefan Beller:
> On Tue, Dec 20, 2016 at 12:12 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> I have to ask, though: Is it so much necessary to report the exact command
>> line in an error message?
>
> Have a look at https://github.com/git/git/blob/master/submodule.c#L1122
>
>     die("Could not run 'git status --porcelain -uall \
>         --ignore-submodules=none' in submodule %s", path);
>
> There are 2 things:
> 1) The error message is not very informative, as your question hints at.
>     I consider changing it to add more meaning. I think the end user
>     would also be interested in "Why did we run this command?".

You don't have to. start_command() and finish_command() report any 
low-level errors (exec failed, signal received...). If the exit code of 
the program is non-zero, finish_command() reports nothing because the 
command *itself* will have written some error message ("working 
directory dirty", "object database corrupt", "xyz: no such file or 
directory"...). At this level, it only makes sense to leave a trace in 
which submodule an error occured. So I think it would be sufficient to  just

     die("could not run 'git status' in submodule %s", path);
or
     die("'git status' in submodule %s failed", path);

> 2) We really want to report the correct command line here.

Why? We do not do this anywhere else.

>     Currently that is the case, but if you look at the prior patch that extends
>     the arguments conditionally (and then also uses the same condition
>     to format the error message... that hints at hard to maintain error
>     messages.)

This does not explain why the *complete and detailed* invocation must be 
reported. I haven't followed this topic at all, so I may be missing some 
cruical detail. (If you say "it must happen" one more time, then I will 
believe you, because for me that's simpler than to plough through a 
flock of submodule topics. ;-)

-- Hannes

