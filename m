Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09546201A7
	for <e@80x24.org>; Fri, 12 May 2017 21:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758464AbdELVDC (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 17:03:02 -0400
Received: from avasout08.plus.net ([212.159.14.20]:47231 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758146AbdELVDB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 17:03:01 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id KZ2y1v0081keHif01Z2zUu; Fri, 12 May 2017 22:03:00 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=N659UExz7-8A:10 a=_hnA9iWeDGu5zDH6B2UA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] compat/regex: fix compilation on Windows
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
 <xmqqd1be98kk.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1705121219150.146734@virtualbox>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <413493c2-24ee-e085-f4cc-371b677d2d02@ramsayjones.plus.com>
Date:   Fri, 12 May 2017 22:02:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705121219150.146734@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/05/17 11:25, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Fri, 12 May 2017, Junio C Hamano wrote:
> 
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> The real issue here is that GNU awk's regex implementation assumes a
>>> bit too much about the relative sizes of pointers and long integers.
>>> What they really want is to use intptr_t.
>>
>> Good.  I got annoyed enough to do the same myself before opening my
>> mailbox.  One thing that is curious about your version is that it still
>> has "#include <stdint.h>" behind HAVE_STDINT_H; when I tried to compile
>> an equivalent of your change last night, the compilation failed because
>> intptr_t wasn't available without exposing <stdint.h>
>>
>> Where is Windows build getting its intptr_t, I wonder.
> 
> I'd place a bet on this part of compat/mingw.h for GCC builds:
> 
> 	#ifdef __MINGW64_VERSION_MAJOR
> 	#include <stdint.h>
> 	#include <wchar.h>
> 	typedef _sigset_t sigset_t;
> 	#endif
> 
> and on this part of git-compat-util.h for MSVC builds:
> 
> 	#ifndef NO_INTTYPES_H
> 	#include <inttypes.h>
> 	#else
> 	#include <stdint.h>
> 	#endif
> 
> For the record, it seems that our current version of compat/regex/regex.c
> has this:
> 
> 	/* On some systems, limits.h sets RE_DUP_MAX to a lower value than
> 	   GNU regex allows.  Include it before <regex.h>, which correctly
> 	   #undefs RE_DUP_MAX and sets it to the right value.  */
> 	#include <limits.h>
> 	#include <stdint.h>
> 
> while the one in `pu` lacks the last line. That may be the reason why
> things compiled neatly before, and stopped working for you now.

Yep, see commit bd8f005583. ;-P

So, sparse is, once again, complaining about the SIZE_MAX macro
redefinition. (Along with two other warnings, one of which is a
_very_ long standing warning and one of which is new - I have
yet to investigate).

ATB,
Ramsay Jones

