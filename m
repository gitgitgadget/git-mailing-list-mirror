Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3408A1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 22:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeACWXc (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 17:23:32 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:44318 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeACWXb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 17:23:31 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zBlnY4ZmMz5tlB;
        Wed,  3 Jan 2018 23:23:27 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 88C4D41DF;
        Wed,  3 Jan 2018 23:23:27 +0100 (CET)
Subject: Re: [PATCH v5 00/34] Add directory rename detection to git
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
References: <20171228041352.27880-1-newren@gmail.com>
 <CABPp-BEnpm=OEXZXMeuaxBaOLimucoEKH643jm516YufrtQ-iA@mail.gmail.com>
 <7ecea1b4-d713-7298-1697-ae25532e26e0@kdbg.org>
 <CABPp-BF0Tby4+Va_MV-j3kC-phV8D84PJboBhE-AR2pXQMwL2g@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e385346f-0e20-dc6a-e49c-15ff61dc1ffd@kdbg.org>
Date:   Wed, 3 Jan 2018 23:23:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BF0Tby4+Va_MV-j3kC-phV8D84PJboBhE-AR2pXQMwL2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.01.2018 um 22:02 schrieb Elijah Newren:
> On Wed, Jan 3, 2018 at 2:57 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> 
>> I tested the series on Windows recently. It requires the patch below.
>> I don't know whether this is indicating some portability issues of grep
>> (^ being used in the middle of a RE instead of at the very beginning) or
>> just a quirk in my setup.
> 
> Thanks for testing it out.  What version of Windows were you running
> on?  With cygwin or without?  I tested previously on cygwin (I think
> on Windows Server 2012??) and got all the tests passing there,
> eventually[1].  I'm not sure I can find access to any other Windows
> systems, but I'd be happy to take a look if I can.
> 
> [1] https://public-inbox.org/git/CABPp-BEJ6-mrY0OCz1WWetrtG_iehKzOdCUOn_PUuKVywaU9Zw@mail.gmail.com/

I have an ancient MinGW setup, where I build "vanilla" Git (not exactly 
vanilla, but also not with the many patches that Git for Windows carries).

> The need to backslash escape a caret for a literal match when it
> appears in the middle of the string makes sense.  Thanks for sending
> along the patch.  Would you prefer I squashed it into the series
> (still sitting in 'pu'), or keep your patch separate?  I'm fine with
> either, I'm just unsure the protocol here.

Please squash into the relevant commits so that the series is bisectable 
if the need arises.

>> But it still does not pass the test suite because the system does not
>> like file names such as y/c~HEAD:
>>
>> ++ grep 'Refusing to lose dirty file at z/c' out
>> Refusing to lose dirty file at z/c
>> ++ grep -q stuff x/b y/a y/c y/c~HEAD z/c
>> grep: y/c: Invalid request code
>> error: last command exited with $?=2
>> not ok 94 - 11d-check: Avoid losing not-uptodate with rename + D/F conflict
> 
> This is exceptionally odd.  The actual line from the testsuite was
>    grep -q stuff */*
> 
> which suggests your shell is both doing the pathname expansion and
> treating the resulting filename not as a string but as something to be
> interpreted that happens to have some kind of special
> characters/commands, and then choking on the result.  Super weird.  I
> could probably work around this by just running
>    grep -q stuff z/c
> 
> I think I had the asterisks in there because I was thinking in terms
> of directory rename detection potentially moving the file, but that's
> probably just overkill.  Does the test pass for you with that change?

I can test on Monday at the earliest. If it's that easy to fix my 
failures, I'd appreciate to go this route. But otherwise, I can deal 
with the situation, so we don't need to complicate things just to please 
my exotic setup.

> (If so, there are also two similar tests that I'd need to make similar
> changes to.)
> 
> However, although that might fix this particular case, it suggests
> some fragility of the tests and filenames for whatever system you
> happen to be using.  merge-recursive.c's unique_path has created
> filenames with tilde's in them for many years, it may just be that I'm
> the first to use the resulting file in combination with grep to ensure
> the contents are as we expect.  There may be other issues lurking
> (even if not yet appearing in the testsuite) for your system when
> dealing with merge conflicts.

I can't recall having seen issues around tildas in file names, either. 
It may be a new situation. I'll investigate.

-- Hannes
