Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0891F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbeI1EpN (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:45:13 -0400
Received: from avasout07.plus.net ([84.93.230.235]:36557 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1EpN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:45:13 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 5ei9gWnZUjlDz5eiAg7YGY; Thu, 27 Sep 2018 23:24:43 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=UR-nH_2hBq7ztSmMy8wA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] read-cache: fix division by zero core-dump
Message-ID: <476b5678-41b2-d2f8-1890-ba315354ebc0@ramsayjones.plus.com>
Date:   Thu, 27 Sep 2018 23:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJHRj+why3N5c2ur6VR7V3mxAi04NIrwnfPvbZ81HUfWPHBy5Qg/Uok3S3Bq1WtWXVymlFqnMzWSLvfk75/K/SVtggssx6/GU+/0H6evMY+mwIs+nxUW
 4aTggppnc5YPrxbZI+Gw8GhPTIaDpYb1DiiOMbb1ahvL/TA/pF7Nbqh5FWq76Vh2II5XPf8hbwSoNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


commit 225df8a468 ("ieot: add Index Entry Offset Table (IEOT)
extension", 2018-09-26) added a 'DIV_ROUND_UP(entries, ieot_blocks)
expression, where ieot_blocks was set to zero for a single cpu
platform. This caused an SIGFPE and a core dump in practically
every test in the test-suite, until test t4056-diff-order.sh, which
then went into an infinite loop!

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Ben,

Could you please squash this into the relevant commits on your
'bp/read-cache-parallel' branch. (The first hunk fixes a sparse
warning about using an integer as a NULL pointer).

Thanks!

ATB,
Ramsay Jones

 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 6755d58877..40f096f70a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2141,7 +2141,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	size_t extension_offset = 0;
 #ifndef NO_PTHREADS
 	int nr_threads, cpus;
-	struct index_entry_offset_table *ieot = 0;
+	struct index_entry_offset_table *ieot = NULL;
 #endif
 
 	if (istate->initialized)
@@ -2771,7 +2771,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			if (ieot_blocks < 1)
 				ieot_blocks = 1;
 			cpus = online_cpus();
-			if (ieot_blocks > cpus - 1)
+			if (cpus > 1 && ieot_blocks > cpus - 1)
 				ieot_blocks = cpus - 1;
 		} else {
 			ieot_blocks = nr;
-- 
2.19.0
