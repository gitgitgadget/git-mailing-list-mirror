Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31AA1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 15:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbeITVTV (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 17:19:21 -0400
Received: from avasout07.plus.net ([84.93.230.235]:48607 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbeITVTV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 17:19:21 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 30z5gKclLjlDz30z7g3mO8; Thu, 20 Sep 2018 16:35:17 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Ej2LrWfMBC6Eeug7ng8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 9/9] commit-reach.h: add missing declarations (hdr-check)
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <089b2111-b7e9-6795-b04a-ed259f78796a@ramsayjones.plus.com>
 <eb77d563-8b3e-9b00-59b8-b050e6378c69@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2809251f-6eba-b0ac-68fe-b972809ccff7@ramsayjones.plus.com>
Date:   Thu, 20 Sep 2018 16:35:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <eb77d563-8b3e-9b00-59b8-b050e6378c69@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfE3F7HlzvK36In7Q9+KDW8WZOnF94IgNwDt4t9Bhf0+XgbED87aPnLdB1Xgy8+Fr4MhIS2OGEaRl3mksqpI4tRTWHnQvi/CsO4pLDoY/zmsu9V4hz+24
 EilAEcq6GGC0l9wQqQIiVV6eyRj22IIfcmTq0cISeUCF0n62YGVYOIQHMaE8XPkP7nj4C9yho8rAEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/09/18 00:38, Derrick Stolee wrote:
> On 9/18/2018 8:15 PM, Ramsay Jones wrote:
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>   commit-reach.h | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/commit-reach.h b/commit-reach.h
>> index 7d313e2975..f41d8f6ba3 100644
>> --- a/commit-reach.h
>> +++ b/commit-reach.h
>> @@ -1,12 +1,13 @@
>>   #ifndef __COMMIT_REACH_H__
>>   #define __COMMIT_REACH_H__
>>   +#include "commit.h"
>>   #include "commit-slab.h"
>>   -struct commit;
>>   struct commit_list;
>> -struct contains_cache;
> 
> Interesting that you needed all of commit.h here, and these 'struct commit' and 'struct contains_cache' were not enough. Was there a reason you needed the entire header file instead of just adding a missing struct declaration?

Actually, the original version of this patch didn't add that
include! I changed my mind just before sending this series
out, since I felt the original patch was conflating two issues.

The reason for the #include of 'commit.h' in this patch, but
not with my original patch, has to to with the inline functions
used in the commit-slab implementation. My original patch used
the 'commit-slab-{decl,impl}.h' header files to sidestep the
need for the definition of 'struct commit'.

I have included an 'RFC on-top' patch below to show you what I
had in mind. NOTE: I had not finished writing the commit message
and you could argue that the 'implement' macro should go in the
ref-filter.c file, since that is were the contains_cache is 
'defined and initialised'. I had not intended to send this to
the list ... :-D

Note that, if you compile with optimizations disabled, then
run this script:

  $ cat -n dup-static.sh
       1 #!/bin/sh
       2 
       3 nm $1 | grep ' t ' | cut -d' ' -f3 | sort | uniq -c |
       4 	sort -rn | grep -v '      1'
  $ 

  $ ./dup-static.sh git | grep contains
       24 init_contains_cache_with_stride
       24 init_contains_cache
       24 contains_cache_peek
       24 contains_cache_at_peek
       24 contains_cache_at
       24 clear_contains_cache
  $ 
  
you will find 24 copies of the commit-slab routines for the
contains_cache. Of course, when you enable optimizations again,
these duplicate static functions (mostly) disappear. (Two static
functions remain, the rest are actually inlined at -O2).

However, if you apply the patch below, you end up with all of
the functions in the contains_cache commit-slab implementation
as external functions. Some of those functions are never called,
so it's not necessarily a win ... ;-)

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] commit-reach: use a shared commit-slab for the contains_cache

Commit a9f1f1f9f8 ("commit-slab.h: code split", 2018-05-19) separated
the commit-slab interface from its implementation, to allow for the
definition of a public commit-slab data structure. This enabled us to
avoid including the commit-slab implementation in a header file, which
could result in the replication of the commit-slab functions in each
compilation unit in which it was included.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 commit-reach.c | 3 +++
 commit-reach.h | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 622eeb313d..7223cacdd1 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "commit-slab-impl.h"
 #include "commit-graph.h"
 #include "decorate.h"
 #include "prio-queue.h"
@@ -18,6 +19,8 @@
 
 static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
 
+implement_shared_commit_slab(contains_cache, enum contains_result);
+
 static int queue_has_nonstale(struct prio_queue *queue)
 {
 	int i;
diff --git a/commit-reach.h b/commit-reach.h
index f41d8f6ba3..acf3b2d188 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -1,9 +1,9 @@
 #ifndef __COMMIT_REACH_H__
 #define __COMMIT_REACH_H__
 
-#include "commit.h"
-#include "commit-slab.h"
+#include "commit-slab-decl.h"
 
+struct commit;
 struct commit_list;
 struct ref_filter;
 struct object_id;
@@ -55,7 +55,7 @@ enum contains_result {
 	CONTAINS_YES
 };
 
-define_commit_slab(contains_cache, enum contains_result);
+define_shared_commit_slab(contains_cache, enum contains_result);
 
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache);
-- 
2.19.0

