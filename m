Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD5E1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbdBMUlB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:41:01 -0500
Received: from siwi.pair.com ([209.68.5.199]:61660 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbdBMUlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:41:00 -0500
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Feb 2017 15:41:00 EST
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 50164846E6;
        Mon, 13 Feb 2017 15:32:57 -0500 (EST)
Subject: Re: Small regression on Windows
To:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <6bc02b0a-a463-1f0c-3fee-ba27dd2482e4@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8488f55c-37b1-1ded-53c5-7cd268210391@jeffhostetler.com>
Date:   Mon, 13 Feb 2017 15:32:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <6bc02b0a-a463-1f0c-3fee-ba27dd2482e4@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/13/2017 1:00 PM, Johannes Sixt wrote:
> Please type this, preferably outside of any repo to avoid that it is 
> changed; note the command typo:
>
>    git -c help.autocorrect=40 ceckout
>
> Git waits for 4 seconds, but does not write anything until just before 
> it exits. It bisects to
>
> a9b8a09c3c30886c79133da9f48ef9f98c21c3b2 is the first bad commit
> commit a9b8a09c3c30886c79133da9f48ef9f98c21c3b2
> Author: Jeff Hostetler <jeffhost@microsoft.com>
> Date:   Thu Dec 22 18:09:23 2016 +0100
>
>     mingw: replace isatty() hack
>
>     Git for Windows has carried a patch that depended on internals
>     of MSVC runtime, but it does not work correctly with recent MSVC
>     runtime. A replacement was written originally for compiling
>     with VC++. The patch in this message is a backport of that
>     replacement, and it also fixes the previous attempt to make
>     isatty() tell that /dev/null is *not* an interactive terminal.
>
>     Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>     Tested-by: Beat Bolli <dev+git@drbeat.li>
>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> :040000 040000 bc3c75bdfc766fe478e160a9452c31bfef50b505 
> f7183c3a0726fef7161d5f9ff8c997260025f1bb M      compat
>
> Any ideas? I haven't had time to dig any further.

I'm investigating now.

The warning text is being written to stderr and then main thread sleeps 
for the 4 seconds.
However, stderr has been redirected to the pipe connected to the 
console_thread that
handles the coloring/pager.  It is in a blocking ReadFile on the pipe 
and is thus stuck until
the main thread runs the corrected command and closes the pipe.  It then 
sees the EOF
and prints everything in the pipe buffer.

I'll look into fixing this now.

Jeff


