Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F1A1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 01:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeJ0KdT (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 06:33:19 -0400
Received: from avasout03.plus.net ([84.93.230.244]:56903 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJ0KdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 06:33:19 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id GDnagYeyOfmQQGDnbgjEYT; Sat, 27 Oct 2018 02:53:59 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Acuf4UfG c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=m0tRhUayDAoa-ZVbAt0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 3/3] commit-reach.h: add missing declarations (hdr-check)
Message-ID: <88102e3a-8a02-fca4-4daf-ab428008afc7@ramsayjones.plus.com>
Date:   Sat, 27 Oct 2018 02:53:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHV+znjCiE9B679de+JVeZGw+nIUluo8NDuKSXsoD5bot1MboVDt4i9D0f/TF1KFHxnWh5SCgoK+z2gowX49AaUisN3hdcBJuaM0bxb1Vf7+ELX4uyXS
 4WoteR+5Op3HoyKzd//krGZ6X+C3mKIvqHzLv9w59EcsM9H7w2YURxYW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Add the necessary #includes and forward declarations to allow the header
file to pass the 'hdr-check' target.

Note that, since this header includes the commit-slab implementation
header file (indirectly via commit-slab.h), some of the commit-slab
inline functions (e.g contains_cache_at_peek()) will not compile without
the complete type of 'struct commit'. Hence, we replace the forward
declaration of 'struct commit' with the an #include of the 'commit.h'
header file.

It is possible, using the 'commit-slab-{decl,impl}.h' files, to avoid
this inclusion of the 'commit.h' header. Commit a9f1f1f9f8 ("commit-slab.h:
code split", 2018-05-19) separated the commit-slab interface from its
implementation, to allow for the definition of a public commit-slab data
structure. This enabled us to avoid including the commit-slab implementation
in a header file, which could result in the replication of the commit-slab
functions in each compilation unit in which it was included.

Indeed, if you compile with optimizations disabled, then run this script:

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

you will find 24 copies of the commit-slab routines for the contains_cache.
Of course, when you enable optimizations again, these duplicate static
functions (mostly) disappear. Compiling with gcc at -O2, leaves two static
functions, thus:

  $ nm commit-reach.o | grep contains_cache
  0000000000000870 t contains_cache_at_peek.isra.1.constprop.6
  $ nm ref-filter.o | grep contains_cache
  00000000000002b0 t clear_contains_cache.isra.14
  $

However, using a shared 'contains_cache' would result in all six of the
above functions as external public functions in the git binary. At present,
only three of these functions are actually called, so the trade-off
seems to favour letting the compiler inline the commit-slab functions.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 commit-reach.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-reach.h b/commit-reach.h
index 7d313e2975..f41d8f6ba3 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -1,12 +1,13 @@
 #ifndef __COMMIT_REACH_H__
 #define __COMMIT_REACH_H__
 
+#include "commit.h"
 #include "commit-slab.h"
 
-struct commit;
 struct commit_list;
-struct contains_cache;
 struct ref_filter;
+struct object_id;
+struct object_array;
 
 struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
-- 
2.19.0
