Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A90D20984
	for <e@80x24.org>; Tue, 13 Sep 2016 17:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756356AbcIMRzK (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 13:55:10 -0400
Received: from mout.web.de ([212.227.15.14]:54711 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755300AbcIMRzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 13:55:09 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LtCm3-1b0f2r2HZz-012mqu; Tue, 13 Sep 2016 19:54:54
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1_file: use llist_mergesort() for sorting packs
Message-ID: <a313343b-173e-4a07-f383-859a6f262651@web.de>
Date:   Tue, 13 Sep 2016 19:54:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:rV+Cf9vw/xauuRMLTEkFQHOQsmUnHNgasjt/+mriWjK8GxgB5yu
 ZzZ+NsiVLQ8UvY1LliEmF0GWyLDRbtmK3rH9rIzDq+QIjU3/hDdxY54LAN94uOmdzrkhLRO
 QTk5jPqq6EQ6O9/CCturVnNVQ8yoVFJ6gy/yoM+m5TF4tAy8wNqZ1hmcqP7/wGPUySbvk9y
 6Kx/fnlqxUMbV7NvuG1Qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V6L9GvRN/iQ=:0ALoOFkHgjKRicggbS2XKO
 c30hDS3acqmTDK/jmHd9Km8uiQE30ZpC8w4Woh3IZRWx9Qx0V8jHnlawNs06EDKfAvN7AW3AV
 jC1NJO8mqomHHYpx/a7HM4weY0fyrJjUYOkkypi86+9DD7qNq3A09a2pLFR+5rR0Jp1AfS0Lp
 2sMIfLQxHVpcLaLACSyIc9n41tE79OFujnr5gye96QZeahnLD9p/KHEIVr+SE/hIb1g0gpbb3
 Fo57AGKfkJRya0FOthdDcjyy6/R3uS0lGWUd+Pmn4J8gv3nE/C4bbc7OzI8mGW0B4Aa0zZf02
 b8gDQ/wJ+KHdiPuJCHu5n1Ufs3BAGFv2MQmT6Cpe/6SyaVhVxjWPhD6VxVqETM6r0Fytd6IUr
 BYzZe85Lz+R6gPucBaUZaPN0XFjwPStwDatjnGaT3EnUxiI4xY31jJFxrfmaCJaxNcNWxd6t5
 Ey3mr1E02to5LEUIHIlxzXAuzvPuaRHb2WxwkXk03eDRKOkm/s3yKOajM/UgvcFP5zW5Po3sM
 T7oNddtUWDqiHQUbuQadZ2wZ169JwJ0lrtbzZYBb4LXX2oYu673+URJQmE811a3bfjIBmoV3I
 Jx9RKH5ycwK4ZjeRA/EMrr2rAG6fHRhZ2QfxSrT3vK4THx/Xv96prkcajFNTdWUeizkcOUr1R
 OWSYMNxVJXqqqjzhwBy4HcKH44Rxdh1frNRL0fEZYUsCMILo5o/9g6K6zAofKuI/CLz9wYeZi
 svJT4zDJc/BBYnwG0wklos3NXbuSlTbSxZLU+PXhFUrmMaqPCokwcEVWYRGiSoBPKuvgz/mTx
 r37tdUL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sort the linked list of packs directly using llist_mergesort() instead
of building an array, calling qsort(3) and fixing up the list pointers.
This is shorter and less complicated.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Peff: Or do you have other plans, e.g. to replace packed_git with
packed_git_mru completely?

 sha1_file.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 472ccb2..66dccaa 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -25,6 +25,7 @@
 #include "dir.h"
 #include "mru.h"
 #include "list.h"
+#include "mergesort.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -1380,10 +1381,20 @@ static void prepare_packed_git_one(char *objdir, int local)
 	strbuf_release(&path);
 }
 
+static void *get_next_packed_git(const void *p)
+{
+	return ((const struct packed_git *)p)->next;
+}
+
+static void set_next_packed_git(void *p, void *next)
+{
+	((struct packed_git *)p)->next = next;
+}
+
 static int sort_pack(const void *a_, const void *b_)
 {
-	struct packed_git *a = *((struct packed_git **)a_);
-	struct packed_git *b = *((struct packed_git **)b_);
+	const struct packed_git *a = a_;
+	const struct packed_git *b = b_;
 	int st;
 
 	/*
@@ -1410,28 +1421,8 @@ static int sort_pack(const void *a_, const void *b_)
 
 static void rearrange_packed_git(void)
 {
-	struct packed_git **ary, *p;
-	int i, n;
-
-	for (n = 0, p = packed_git; p; p = p->next)
-		n++;
-	if (n < 2)
-		return;
-
-	/* prepare an array of packed_git for easier sorting */
-	ary = xcalloc(n, sizeof(struct packed_git *));
-	for (n = 0, p = packed_git; p; p = p->next)
-		ary[n++] = p;
-
-	qsort(ary, n, sizeof(struct packed_git *), sort_pack);
-
-	/* link them back again */
-	for (i = 0; i < n - 1; i++)
-		ary[i]->next = ary[i + 1];
-	ary[n - 1]->next = NULL;
-	packed_git = ary[0];
-
-	free(ary);
+	packed_git = llist_mergesort(packed_git, get_next_packed_git,
+				     set_next_packed_git, sort_pack);
 }
 
 static void prepare_packed_git_mru(void)
-- 
2.10.0

