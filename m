Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D301F404
	for <e@80x24.org>; Fri, 14 Sep 2018 23:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeIOEqB (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 00:46:01 -0400
Received: from avasout06.plus.net ([212.159.14.18]:43221 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeIOEqB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 00:46:01 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 0xWcg6RG5WLW20xWdgsirF; Sat, 15 Sep 2018 00:29:24 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=9kUiEBAvZ1GatkcJHBQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] read-cache.c: fix a sparse warning
Message-ID: <c92b2f25-315d-141b-8974-dd05d7fd2b9e@ramsayjones.plus.com>
Date:   Sat, 15 Sep 2018 00:29:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfN33B43BSkh6NjLLPXiaTLA/dDNRyBHDaBM2yvjatRo0aObgMfRg+ra4QupxW57rirpKhlFKnKUs0xhaX1c981Q4l+G8ACH1OhcpzkaHhyw2G1GSQpZ0
 SOqujADaeK3zQXaNd1Wg8iVANj6ebqA7HkBWrrwgnsr42EN5cevq9qeTzMgJVOFJy7kUF3K1AzLj5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


At one time, the POSIX standard required the type used to represent
a thread handle (pthread_t) be an arithmetic type. This is no longer
the case, probably because different platforms used to regularly
ignore that requirement.  For example, on cygwin a pthread_t is a
pointer to a structure (a quite common choice), whereas on Linux it
is defined as an 'unsigned long int'.

On cygwin, but not on Linux, 'sparse' currently complains about an
initialiser used on a 'struct load_index_extensions' variable, whose
first field may be a pthread handle (if not compiled with NO_PTHREADS
set).

In order to fix the warning, move the (conditional) pthread field to
the end of the struct and change the initialiser to use a NULL, since
the new (unconditional) first field is a pointer type.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Ben,

If you need to re-roll your 'bp/read-cache-parallel' branch, could you
please squash this into the relevant patch (commit a090af334,
"read-cache: load cache extensions on a worker thread", 2018-09-12).

Thanks.

ATB,
Ramsay Jones

 read-cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index b27dc01696..6254291742 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1908,13 +1908,13 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
 
 struct load_index_extensions
 {
-#ifndef NO_PTHREADS
-	pthread_t pthread;
-#endif
 	struct index_state *istate;
 	const char *mmap;
 	size_t mmap_size;
 	unsigned long src_offset;
+#ifndef NO_PTHREADS
+	pthread_t pthread;
+#endif
 };
 
 static void *load_index_extensions(void *data)
@@ -2145,7 +2145,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	const struct cache_header *hdr;
 	const char *mmap;
 	size_t mmap_size;
-	struct load_index_extensions p = { 0 };
+	struct load_index_extensions p = { NULL };
 	unsigned long extension_offset = 0;
 #ifndef NO_PTHREADS
 	int cpus, nr_threads;
-- 
2.19.0
