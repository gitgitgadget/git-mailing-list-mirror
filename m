Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A889C1F85A
	for <e@80x24.org>; Mon,  9 Jul 2018 19:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932980AbeGIT0F (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:26:05 -0400
Received: from s019.cyon.net ([149.126.4.28]:33904 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932800AbeGIT0C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M5P3hP3fE+m7orEo19IInlPXNJBOdvUea5Apd3zwwl8=; b=LU8K8xyjKRPLTOhGzpFSAhQYay
        yFij4lwwz8vqFPe2fvtzmc8fLN2OMRJTG49NA8InVKK/Rgh0Dzo8tuHdlIzxyjEBByyvXggzCFgj2
        30FL0KNs2IijOeirgC8RmNW3dFiOHxzbKpy6/tPiTz+Fu5QhEMokmg5VjL2oEMN+q0h/uWL5S0yxy
        5Necxk4X8wqg5i9wus1NDn4N2/35GZnF93RqGBgw7ZkDxeBSZDX6a40zeEonminX6tnWfhDc6Y4CO
        KcsEdzolIwJN3qZ+qXh6Yz2EDE0DvSmvX33n5LEqPDwZ6T1RjraKLNQmSMLu/YSxMmJPpZY7dffmf
        9nXgyqQw==;
Received: from [10.20.10.230] (port=60060 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcbnL-00Ck4L-Rx; Mon, 09 Jul 2018 21:26:01 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 83C89234F6; Mon,  9 Jul 2018 21:25:59 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 5/6] string-list.c: avoid conversion from void * to function pointer
Date:   Mon,  9 Jul 2018 21:25:36 +0200
Message-Id: <20180709192537.18564-6-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180708144342.11922-1-dev+git@drbeat.li>
References: <20180708144342.11922-1-dev+git@drbeat.li>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ISO C forbids the conversion of void pointers to function pointers.
Introduce a context struct that encapsulates the function pointer.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 string-list.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/string-list.c b/string-list.c
index a0cf0cfe88..771c455098 100644
--- a/string-list.c
+++ b/string-list.c
@@ -224,18 +224,28 @@ struct string_list_item *string_list_append(struct string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
+/*
+ * Encapsulate the compare function pointer because ISO C99 forbids
+ * casting from void * to a function pointer and vice versa.
+ */
+struct string_list_sort_ctx
+{
+	compare_strings_fn cmp;
+};
+
 static int cmp_items(const void *a, const void *b, void *ctx)
 {
-	compare_strings_fn cmp = ctx;
+	struct string_list_sort_ctx *sort_ctx = ctx;
 	const struct string_list_item *one = a;
 	const struct string_list_item *two = b;
-	return cmp(one->string, two->string);
+	return sort_ctx->cmp(one->string, two->string);
 }
 
 void string_list_sort(struct string_list *list)
 {
-	QSORT_S(list->items, list->nr, cmp_items,
-		list->cmp ? list->cmp : strcmp);
+	struct string_list_sort_ctx sort_ctx = {list->cmp ? list->cmp : strcmp};
+
+	QSORT_S(list->items, list->nr, cmp_items, &sort_ctx);
 }
 
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
-- 
2.18.0.203.gfac676dfb9

