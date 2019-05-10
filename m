Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE82B1F45F
	for <e@80x24.org>; Fri, 10 May 2019 06:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEJGVN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 02:21:13 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:8984 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfEJGVN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 02:21:13 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 450g862C4cz5tlD;
        Fri, 10 May 2019 08:21:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CA53F496F;
        Fri, 10 May 2019 08:21:08 +0200 (CEST)
Subject: Re: en/fast-export-encoding, was Re: What's cooking in git.git (May
 2019, #01; Thu, 9)
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1905092243080.44@tvgsbejvaqbjf.bet>
 <CABPp-BGfLrggLTmo+9LuLH_iGJoRNv7SHATw4XQCNx4Rk6wc7g@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f8eb246f-a936-e9df-4bb4-068b86a62baf@kdbg.org>
Date:   Fri, 10 May 2019 08:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BGfLrggLTmo+9LuLH_iGJoRNv7SHATw4XQCNx4Rk6wc7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.05.19 um 02:14 schrieb Elijah Newren:
> Hi Johannes,
> 
> On Thu, May 9, 2019 at 1:46 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> Hi Junio & Elijah,
>>
>> On Thu, 9 May 2019, Junio C Hamano wrote:
>>
>>> * en/fast-export-encoding (2019-05-07) 5 commits
>>>  - fast-export: do automatic reencoding of commit messages only if requested
>>>  - fast-export: differentiate between explicitly utf-8 and implicitly utf-8
>>>  - fast-export: avoid stripping encoding header if we cannot reencode
>>>  - fast-import: support 'encoding' commit header
>>>  - t9350: fix encoding test to actually test reencoding
>>>
>>>  The "git fast-export/import" pair has been taught to handle commits
>>>  with log messages in encoding other than UTF-8 better.
>>
>> This breaks on Windows, see
>> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=8298&view=ms.vss-test-web.build-test-results-tab
>>
>> Sadly, I ran out of time looking at it in detail.
> 
> Thanks for the heads up, and for taking some time to check it out.
> The error doesn't seem obvious from the log.  Does Azure Pipelines
> have anything like CircleCI's "Debug with SSH" feature[1]?  (Where one
> can click a "Rerun job with SSH", and it'll restart the pipeline but
> also print out an ssh command someone can use to directly access the
> box on which the test is running, in order to be able to investigate.)
>  Failing that, assuming I can find a Windows system somewhere, is
> there a list of steps for setting up a development environment and
> building git on Windows?

I'll just tell you why things go wrong here:

In these cases, a byte that is intended to be an ISO8859-something
characters is passed via the command line. This cannot work as intended
on Windows, because the command line is not just a stream of bytes, but
a string of characters. On Windows (and presumably also on macOS), the
command line bytes are interpreted as UTF-8. As such, the bytes undergo
some encoding conversions between UTF-8 and UTF-16LE. That cannot work
when the bytes are not correct UTF-8 characters.

To make the tests pass you have to pass the ISO8859-something characters
via a file.

-- Hannes
