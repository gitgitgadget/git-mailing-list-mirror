Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49832018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2999135AbcHEVBt (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:01:49 -0400
Received: from mout.web.de ([212.227.15.4]:51586 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1427169AbcHEVBp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:01:45 -0400
Received: from [192.168.178.36] ([79.213.113.59]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MT4xK-1bduvm3gms-00S9Ux; Fri, 05 Aug 2016 23:01:36
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] merge: use string_list_split() in add_strategies()
Message-ID: <57A4FEAF.3040208@web.de>
Date:	Fri, 5 Aug 2016 23:01:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:DiUuRu8/N9O2fQ2MyORwaBR+ZhGXVFkowp9d43YcxcN+B4s93xd
 P9lPku4FDn5cjizJOxKl6HxDmjsOUt53gSGsseUKG5V+MvslraOStkSJ0BYKcADQpYcyNRA
 TMG0/dpmQgtfQdSl/YRJNfi2m2w7DnIxKL0W4GOKa1zaOSu8zWUz/FjdIIvE506JaPF22ZV
 ZaG0rcR5tMJyRVqjtBFDw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7COtjtdghMQ=:sNAx4fgqlF1Nj3xyFHzVV6
 UolYmMqIaSM0mWpbWzvasRe0yhnj5QpdhK1dZEktGT2ARPpg0mTGif9xaZNcO3Ip21NVbgB2u
 VY8xlkicRCIzPnw8y5aIF3arOYc9zGWVX6jlHyarrar/TncL8mHoIgGqLRH5dTNJcS7feHbx0
 6plL4CV6Go8nH7kNbsXBCphf2k/XwYXPS8WvtGZ7DnEFRVJbmLV8S50qlqkiFbXEwZNTvuLc9
 7v6SUAiAPGE5BuLi79iH2/icSsFJnJlJBRa+qPk3eH5vtEqPnUPMuYCBPwy4h6RhX/ZrhSLDa
 j+f/gY3GSJ8ewt0B9+qxaLl5V27RFV2KFqBBY/PjNcihkwEB29jHxGAdvosZzirsQyA3xceKL
 CJ36/D2uo7cHKQNtkQW5cJNYtXU1JX0KBh8O2oi6aDlEpYe53Gq2KyNgbnBwsqMUs26rN00bA
 97mDBfv0qpMGrWMc7wNNWtlsoZdKRWlB3IWZqtp3KmuvHbJKQdwUZHBkYrMRGkQJtB04VXFfW
 N6nhnvklDr66aFLo5kZP8WSTUDoQPssMicK/AsvxjVkDJcUKBHOzF0Z6VbPdqbw/tSTEcQm1n
 MGIfO7o7Vou+4hg+olgC6WzQbpP138S3ZOTKuvIq5iKFcsfXq5v3SPQoTI2dWg52PXkXVf/Zn
 a+ayp2KCn6/QLJIy64sKqS4Y9Jz0DXytwFhdneDcfjwds3z2cd3Egc9LkCS4nmBC/J6R5nh+G
 JaXWG4ZLgUSW83AQ14rmnv5+8KKbPn+3HB1bRiaH8grCTkn1ViG7/4HUJSb4BGOKMgUQRuQ+a
 wLO1PSW
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Call string_list_split() for cutting a space separated list into pieces
instead of reimplementing it based on struct strategy.  The attr member
of struct strategy was not used split_merge_strategies(); it was a pure
string operation.  Also be nice and clean up once we're done splitting;
the old code didn't bother freeing any of the allocated memory.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/merge.c | 44 ++++++++++----------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 19b3bc2..a95a801 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -30,6 +30,7 @@
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
 #include "sequencer.h"
+#include "string-list.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -703,42 +704,17 @@ static int count_unmerged_entries(void)
 	return ret;
 }
 
-static void split_merge_strategies(const char *string, struct strategy **list,
-				   int *nr, int *alloc)
-{
-	char *p, *q, *buf;
-
-	if (!string)
-		return;
-
-	buf = xstrdup(string);
-	q = buf;
-	for (;;) {
-		p = strchr(q, ' ');
-		if (!p) {
-			ALLOC_GROW(*list, *nr + 1, *alloc);
-			(*list)[(*nr)++].name = xstrdup(q);
-			free(buf);
-			return;
-		} else {
-			*p = '\0';
-			ALLOC_GROW(*list, *nr + 1, *alloc);
-			(*list)[(*nr)++].name = xstrdup(q);
-			q = ++p;
-		}
-	}
-}
-
 static void add_strategies(const char *string, unsigned attr)
 {
-	struct strategy *list = NULL;
-	int list_alloc = 0, list_nr = 0, i;
-
-	memset(&list, 0, sizeof(list));
-	split_merge_strategies(string, &list, &list_nr, &list_alloc);
-	if (list) {
-		for (i = 0; i < list_nr; i++)
-			append_strategy(get_strategy(list[i].name));
+	int i;
+
+	if (string) {
+		struct string_list list = STRING_LIST_INIT_DUP;
+		struct string_list_item *item;
+		string_list_split(&list, string, ' ', -1);
+		for_each_string_list_item(item, &list)
+			append_strategy(get_strategy(item->string));
+		string_list_clear(&list, 0);
 		return;
 	}
 	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
-- 
2.9.2

