Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D8220357
	for <e@80x24.org>; Mon, 10 Jul 2017 20:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932097AbdGJUC2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 16:02:28 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48225 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932077AbdGJUC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 16:02:27 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id j82Q1v00118PUFB0182R9e; Mon, 10 Jul 2017 21:02:25 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=mDV3o1hIAAAA:8 a=-3BjKxIydEC2PMrN7yYA:9
 a=v3Q-ytTE9il85BdD:21 a=WYcJBxUQ_Tqfo-05:21 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22 a=_FVE-zBwftR9WsbkzFJk:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/5] Makefile: add helper for compiling with -fsanitize
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
 <20170710132442.epsox4rawxlyvrw3@sigill.intra.peff.net>
 <xmqqefto6vqb.fsf@gitster.mtv.corp.google.com>
 <20170710174454.jbkednmzwts7yr7z@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <752db1ea-8416-3a98-babf-78b766432f0f@ramsayjones.plus.com>
Date:   Mon, 10 Jul 2017 21:02:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170710174454.jbkednmzwts7yr7z@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/07/17 18:44, Jeff King wrote:
> On Mon, Jul 10, 2017 at 10:35:24AM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> You can already build and test with ASan by doing:
>>>
>>>   make CFLAGS=-fsanitize=address test
>>>
>>> but there are a few slight annoyances:
>>>
>>>   1. It's a little long to type.
>>>
>>>   2. It override your CFLAGS completely. You'd probably
>>>      still want -O2, for instance.
>>>
>>>   3. It's a good idea to also turn off "recovery", which
>>>      lets the program keep running after a problem is
>>>      detected (with the intention of finding as many bugs as
>>>      possible in a given run). Since Git's test suite should
>>>      generally run without triggering any problems, it's
>>>      better to abort immediately and fail the test when we
>>>      do find an issue.
>>
>> Unfortunately I do not think Comparing between versions in
>> https://gcc.gnu.org/onlinedocs, it appears that -fsanitize-recover
>> is not configurable for folks still with GCC 4.x series, and this
>> patch is not very useful unless you disable the recovery for the
>> purpose of running our tests as you said X-<.
> 
> I didn't actually dig into the history of gcc support at all. Back in
> the 4.x time-frame I tried using ASan and couldn't get it to work at
> all. I ended up just always building with clang (which from my
> mostly-ignorant view seems to to be the primary platform for ASan
> development).
> 
> Since this is an optional build that doesn't need to be available
> everywhere, I'd actually be fine with saying "just use clang". But as
> far as I can tell, gcc seems to work fine these days. I consider this
> mostly a best-effort tool.
> 
> I'm also not sure of the behavior without -fno-sanitize-recover. I think
> ASan may barf either way. The commit message for my config.mak from a
> year or two ago claims that the problem was actually with UBSan. It
> would be useful in the long run for that to work, too.

Just FYI, I had a quick look at this tonight. I applied your
patches to master, the tried 'make SANITIZE=address test', which
worked fine. I then tried 'make SANITIZE=undefined test' and I had
to control+C it after nearly two hours on one test! ;-) (somewhere
in the t4xxx - unfortunately I overwrote the output file without
thinking).

[BTW I am on Linux Mint 18.2 x86_64, gcc version 5.4.0]

After a quick look at the ./t0000-basic.sh test, I managed to get
the test to complete (with 15 tests failing), with the following
patch applied:

-- >8 --
diff --git a/Makefile b/Makefile
index 3c341b2a6..8e6433738 100644
--- a/Makefile
+++ b/Makefile
@@ -1016,7 +1016,7 @@ ifdef SANITIZE
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
 BASIC_CFLAGS += -fno-omit-frame-pointer
 ifeq ($(SANITIZE),undefined)
-BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
+BASIC_CFLAGS += -DNO_UNALIGNED_LOADS -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
 endif
 
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 25eded139..3baddc636 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -118,6 +118,10 @@
 #define SHA1DC_ALLOW_UNALIGNED_ACCESS
 #endif /*UNALIGNMENT DETECTION*/
 
+#if defined(SHA1DC_ALLOW_UNALIGNED_ACCESS) && defined(SHA1DC_FORCE_ALIGNED_ACCESS)
+#undef SHA1DC_ALLOW_UNALIGNED_ACCESS
+#endif
+
 
 #define rotate_right(x,n) (((x)>>(n))|((x)<<(32-(n))))
 #define rotate_left(x,n)  (((x)<<(n))|((x)>>(32-(n))))
--------

Hmm, hopefully that is not whitespace damaged.

ATB,
Ramsay Jones

