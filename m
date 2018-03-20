Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFAE41F404
	for <e@80x24.org>; Tue, 20 Mar 2018 22:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeCTWlJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 18:41:09 -0400
Received: from avasout04.plus.net ([212.159.14.19]:54515 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeCTWlI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 18:41:08 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id yPwHear58sD7byPwIe97kq; Tue, 20 Mar 2018 22:41:07 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=3ohQRX-c_rq-WxYga68A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/2] -Wuninitialized
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
References: <8f6d8e2e-aba4-128c-f17c-6c1b9c12436c@ramsayjones.plus.com>
 <20180320043225.GB13302@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ce46b318-2c37-4562-7e57-526f511cd6a8@ramsayjones.plus.com>
Date:   Tue, 20 Mar 2018 22:41:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320043225.GB13302@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL+eRGYdEnW6q+PxWxrC2H6EszDe0tNhfYzZRw164PG7RfsGHL85mymL7+hU6br2nLa6tq2e5Klxh+Pg8uXIK9nb/HKF3YvL2f2jbbnUFuVcbxzfyqU0
 sG1AYDBkhGSGfb9Qp3AIvuWlYZ4kQ9pRrCEQWwEI7kTg16zl/7BaEH5WJyWuCwy50Fc3zQKGS6iqLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/03/18 04:32, Jeff King wrote:
> On Mon, Mar 19, 2018 at 05:53:09PM +0000, Ramsay Jones wrote:
 
>> If we now add a patch to remove all self-initialization, which would be the
>> first patch plus the obvious change to 'saved_namelen' in read-cache.c, then
>> note the warnings issued by various compilers at various optimization levels
>> on several different platforms [5]:
>>
>>                     O0      O1      O2      O3      Os       Og
>>  1) gcc 4.8.3   |   -      1,20     1    1,18-19  1-4,21-23  1,5-17
>>  2) gcc 4.8.4   |   -      1,20     1       1     1-4,21-23  1,5-8,10-13,15-16 
>>  3) clang 3.4   |   -       -       -       -        -       n/a 
>>  4) gcc 5.4.0   |   -       1       1       1     1,3-4,21   1,5-8,10-13,16-16
>>  5) clang 3.8.0 |   -       -       -       -        -       n/a 
>>  6) gcc 5.4.0   |   -       1       1       1       1-4     1,5-17 
>>  7) clang 3.8.0 |   -       -       -       -        -       n/a 
>>  8) gcc 6.4.0   |   -       1       1    1,18-19    1,4     1,5-17
>>  9) clang 5.0.1 |   -       -       -       -        -        -
>> 10) gcc 7.2.1   |   -       1       1       1       1,4     1,5-17
> 
> So I guess this could create headaches for people using DEVELOPER=1 on
> as ancient a compiler as 4.8.4, but most other people should be OK. I
> think I can live with that as a cutoff, and the Travis builds should
> work there.

Yeah, I have an even older laptop (Windows 95 era), but I'm not
sure if it will even boot these days. (It does have gcc on it
IIRC, but who knows which version). ;-)

> (And if we do the detect-compiler stuff from the other nearby thread,
> somebody who cares can even loosen the warnings for those old gcc
> versions).
> 
> I'm neglecting anybody doing -O3 or -Os here, but IMHO those are
> sufficiently rare that the builder can tweak their own settings.

I have occasionally used -O3, never used -Os (except for this
exercise) and have been meaning to try -Og (in anger) for a while. ;-)

> I wonder if people use -Og, though? I don't (I usually do -O0 for my
> edit-compile-debug cycle).

In the gcc documentation, the -Og description says:

  "... It should be the optimization level of choice for the standard
   edit-compile-debug cycle, ..."

Like you, I use -O0 (very old habits). As I said above, I have been
meaning to try -Og, but, well round tuits ... ;-)

[BTW, gcc also supports -Ofast, but I don't think we want to go
there ...]

ATB,
Ramsay Jones




