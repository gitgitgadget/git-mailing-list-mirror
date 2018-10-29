Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8C871F453
	for <e@80x24.org>; Mon, 29 Oct 2018 23:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbeJ3Iuw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 04:50:52 -0400
Received: from avasout03.plus.net ([84.93.230.244]:55668 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeJ3Iuw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 04:50:52 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id HHRhgjykyd3rWHHRigvh7b; Mon, 29 Oct 2018 23:59:47 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uv9Nyd4B c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=GijT4eCBIAauml8wW4kA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/3] commit-reach.h: add missing declarations (hdr-check)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <88102e3a-8a02-fca4-4daf-ab428008afc7@ramsayjones.plus.com>
 <xmqq1s89a72a.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <57d29642-ba3b-d11a-2524-701c6f8c709e@ramsayjones.plus.com>
Date:   Mon, 29 Oct 2018 23:59:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq1s89a72a.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMPEIXA/9IooUR7G8DwIF0LaLaNAXef65oYesKUT38E+QcUBOhDZxVQELPKfdHIoEv58+qwUNwgMZVey8NmyhyGQ9hMajzN10R1OEUWiLNv4fEnwT/9R
 J3tMDd6M0kpU5zmIsbPiK2npttung4t6f6Yygy8pUGY6rtQxcdzApU6Dn8JxlfJ3DbzHkaJLX3fjvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/10/2018 01:13, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> ...
>>        24 clear_contains_cache
>>   $
>>
>> you will find 24 copies of the commit-slab routines for the contains_cache.
>> Of course, when you enable optimizations again, these duplicate static
>> functions (mostly) disappear. Compiling with gcc at -O2, leaves two static
>> functions, thus:
>>
>>   $ nm commit-reach.o | grep contains_cache
>>   0000000000000870 t contains_cache_at_peek.isra.1.constprop.6
>>   $ nm ref-filter.o | grep contains_cache
>>   00000000000002b0 t clear_contains_cache.isra.14
>>   $
>>
>> However, using a shared 'contains_cache' would result in all six of the
>> above functions as external public functions in the git binary.
> 
> Sorry, but you lost me here.  Where does the 6 in above 'all six'
> come from?  I saw 24 (from unoptimized), and I saw 2 (from
> optimized), but...

As you already gathered, the 'six of the above functions' was the
list of 6 functions which were each duplicated 24 times (you only
left the last one un-snipped above) in the unoptimized git binary.

> Ah, OK, the slab system gives us a familiy of 6 helper functions to
> deal with the "contains_cache" slab, and we call only 3 of them
> (i.e. the implementation of other three are left unused).  Makes
> sense.

Yep, only clear_contains_cache(), contains_cache_at() and
init_contains_cache() are called.

>> At present,
>> only three of these functions are actually called, so the trade-off
>> seems to favour letting the compiler inline the commit-slab functions.
> 
> OK.  I vaguely recall using a linker that can excise the
> implementation an unused public function out of the resulting
> executable in the past, which may tip the balance in the opposite
> direction, 

Yes, and I thought I was using such a linker - I was surprised that
seems not to be the case! ;-) [I know I have used such a linker, and
I could have sworn it was on Linux ... ]

As I said in [1], the first version of this patch actually used a
shared contains_cache (so as not to #include "commit.h"). I changed
that just before sending it out, because I felt the patch conflated
two issues - I fully intended to send a "let's use a shared contains
cache instead" follow up patch! (Again, see [1] for the initial version
of that follow up patch).

But then Derrick said he preferred this version of the patch and I
couldn't really justify the follow up patch, other than to say "you
are making your compiler work harder than it needs to ..." - not very
convincing! :-P

For example, applying the RFC/PATCH from [1] on top of this patch
we can see:

  $ nm git | grep contains_cache
  00000000000d21f0 T clear_contains_cache
  00000000000d2400 T contains_cache_at
  00000000000d2240 T contains_cache_at_peek
  00000000000d2410 T contains_cache_peek
  00000000000d21d0 T init_contains_cache
  00000000000d2190 T init_contains_cache_with_stride
  $ size git
     text	   data	    bss	    dec	    hex	filename
  2531234	  70736	 274832	2876802	 2be582	git
  $ 

whereas, without that patch on top (ie this patch):

  $ nm git | grep contains_cache
  0000000000161e30 t clear_contains_cache.isra.14
  00000000000d2190 t contains_cache_at_peek.isra.1.constprop.6
  $ size git
     text	   data	    bss	    dec	    hex	filename
  2530962	  70736	 274832	2876530	 2be472	git
  $ 

which means the 'shared contains_cache' patch leads to a +272 bytes
of bloat in text section. (from the 3 unused external functions).


[1] https://public-inbox.org/git/2809251f-6eba-b0ac-68fe-b972809ccff7@ramsayjones.plus.com/

>             but the above reasonong certainly makes sense to me.

Thanks!

ATB,
Ramsay Jones

