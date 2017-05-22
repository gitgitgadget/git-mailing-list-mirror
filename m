Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FAAB2023D
	for <e@80x24.org>; Mon, 22 May 2017 14:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933882AbdEVOCe (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:02:34 -0400
Received: from avasout07.plus.net ([84.93.230.235]:57033 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933877AbdEVOCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 10:02:31 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id PS2G1v0051keHif01S2HAx; Mon, 22 May 2017 15:02:29 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=vxfzNK-mxNk2fl23QzIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] usage: add NORETURN to BUG() function definitions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
References: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
 <xmqqpof1psy7.fsf@gitster.mtv.corp.google.com>
 <11cae8d7-46a6-9ab5-5bee-a7e6897c0a88@ramsayjones.plus.com>
 <xmqqh90dpqja.fsf@gitster.mtv.corp.google.com>
 <xmqqd1b1pq1j.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <15d73455-6d0e-e67a-7cf3-eb0ae9aa3b0d@ramsayjones.plus.com>
Date:   Mon, 22 May 2017 15:02:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqd1b1pq1j.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/05/17 03:46, Junio C Hamano wrote:
> Hmph.  I do not know what went wrong.  The one I had in /usr/bin
> that came from the distro was too old that it didn't give any useful
> result and failed, and that was why I got v0.5.0-207-g14964df
> installed in ~/gitstuff/bin/ which is early on my $PATH; I do not
> think I did any other updates but now I am seeing happy results.
> 
>         $ git checkout jk/bug-to-abort^1
>         $ make SP_OBJ=usage.sp sparse
>         GIT_VERSION = 2.13.0.3.g25cd291963
>             SP usage.c
>         usage.c:220:6: error: symbol 'BUG_fl' redeclared with diff...

To save yourself a little typing, if you want to run sparse over a
single file:

    $ make usage.sp  # ie simply replace '.c' with '.sp'

... is the recommended way to do it. This makes sure that the same
flags are passed to cgcc as are passed to gcc as part of the build.

Note that I would not normally run sparse directly on a source file
(except when messing around with different versions!), the idea is
to use cgcc as a frontend (as the Makefile does).

Having said that, I rarely run sparse over just one file (except
when fixing a sparse error/warning). On each branch (master->next->pu)
I do

    $ make sparse >sp-out 2>&1 # nsp-out on 'next', psp-out on 'pu'

... so that I can diff the files from branch to branch. (I check the
master branch file by hand. There is a single warning on Linux that
is actually a sparse problem).

Just FYI, for today's fetch:

    $ diff sp-out nsp-out
    $ diff nsp-out psp-out
    12a13
    >     SP blame.c
    42a44,46
    > diff.c:813:6: warning: symbol 'emit_line' was not declared. Should it be static?
    > diff.c:828:6: warning: symbol 'emit_line_fmt' was not declared. Should it be static?
    > diff.c:1865:6: warning: symbol 'print_stat_summary_0' was not declared. Should it be static?
    54a59
    >     SP fsmonitor.c
    137a143
    >     SP sub-process.c
    170a177
    >     SP compat/fopen.c
    276a284
    > builtin/worktree.c:539:38: warning: Using plain integer as NULL pointer
    296a305
    >     SP t/helper/test-dir-iterator.c
    $ 
    

ATB,
Ramsay Jones


