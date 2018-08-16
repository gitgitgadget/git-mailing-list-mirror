Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8391F404
	for <e@80x24.org>; Thu, 16 Aug 2018 00:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbeHPDOA (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 23:14:00 -0400
Received: from avasout06.plus.net ([212.159.14.18]:51860 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeHPDOA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 23:14:00 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id q60Vf5z6QWLW2q60WfQKDl; Thu, 16 Aug 2018 01:19:20 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8 a=CnZaMMy8Zn1swIupSSAA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCHv4 0/6] Add missing includes and forward declares
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, jrnieder@gmail.com
References: <https://public-inbox.org/git/20180813171749.10481-1-newren@gmail.com/>
 <20180815175410.5726-1-newren@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b8553a50-6b97-2b45-2f7b-cfe2576548cb@ramsayjones.plus.com>
Date:   Thu, 16 Aug 2018 01:19:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815175410.5726-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCdSXbxCyS3qdFgEIIWdOpmi5evS4mVVIp0zBJlSjoRMAHhqoJ5qijGJUaZiLe5iSRL0biMWepC4NE16TmfCPj4FBnbttwRA/TtSdN6l+HgiEquf9Lfp
 c764A6/8dRSafmWEqdtL2Sgnyssq7kMinMiDstAM/KKlkojCiFyvHosw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/08/18 18:54, Elijah Newren wrote:
> This series fixes compilation errors when using a simple test.c file that
> includes git-compat-util.h and then exactly one other header (and repeating
> this for different headers of git).
> 
[snip]

> 1:  f7d50cef3b ! 1:  e6a93208b2 Add missing includes and forward declares
>     @@ -1,6 +1,13 @@
>      Author: Elijah Newren <newren@gmail.com>
>      
>     -    Add missing includes and forward declares
>     +    Add missing includes and forward declarations
>     +
>     +    I looped over the toplevel header files, creating a temporary two-line C
>     +    program for each consisting of
>     +      #include "git-compat-util.h"
>     +      #include $HEADER
>     +    This patch is the result of manually fixing errors in compiling those
>     +    tiny programs.

As a quick ("just before bedtime") exercise, I tried adding
a Makefile target to perform a similar check. The result is
given below, but I haven't had time to look too closely at
the results:

  $ make -k hdr-check >zzz 2>&1
  $ grep error zzz | wc -l
  18
  $ grep warning zzz | wc -l
  21
  $ grep error zzz | cut -d: -f1 | grep -v make | uniq -c | sort -nr
       11 refs/refs-internal.h
        2 unicode-width.h
        2 json-writer.h
        1 refs/ref-cache.h
        1 commit-slab-impl.h
  $ grep warning zzz | cut -d: -f1 | grep -v make | uniq -c | sort -nr
        7 refs/refs-internal.h
        5 delta-islands.h
        2 unicode-width.h
        2 midx.h
        2 commit-reach.h
        1 refs/ref-cache.h
        1 refs/packed-backend.h
        1 pack-bitmap.h
  $ 
  
BTW, I happen to be on the 'pu' branch.

I think some of the errors are due to missing compiler flags
(-I, -D, etc); which flags did you pass to the compiler?

Well, it killed 15min. before bed! ;-)

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] Makefile: add a hdr-check target

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index 9923db888c..798396c52e 100644
--- a/Makefile
+++ b/Makefile
@@ -2684,6 +2684,16 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
+EXCEPT_HDRS := ./compat% ./xdiff% ./ewah%
+CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
+HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
+
+$(HCO): %.hco: %.h FORCE
+	$(CC) -Wall -include git-compat-util.h -I. -o /dev/null -c -xc $<
+
+.PHONY: hdr-check $(HCO)
+hdr-check: $(HCO)
+
 .PHONY: style
 style:
 	git clang-format --style file --diff --extensions c,h
-- 
2.18.0
