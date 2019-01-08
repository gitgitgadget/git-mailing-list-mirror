Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396981F803
	for <e@80x24.org>; Tue,  8 Jan 2019 16:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfAHQnw (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 11:43:52 -0500
Received: from m12-18.163.com ([220.181.12.18]:54125 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbfAHQnw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 11:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LsIYj
        RJr2fWz6KoszIo5gWPVzfvYTT979N3jY00Wg1M=; b=ngOKkcwlv3abMpEn6QzgT
        eoWNzQeMFWGDNIE1F3u2566eLLQJmqNcSKWR0vgJYDFD+HEVK211s93AIogqPE++
        MS3biEd26hItlVkRaXJGm+F7MoN3ZrnV/2JFs2ffCpBGW1x0ZCIblNmfLqLUzvFT
        5X14PTXJQCimtQBW0fIzz8=
Received: from localhost.localdomain (unknown [122.235.191.23])
        by smtp14 (Coremail) with SMTP id EsCowABXquQ70zRcNoshAA--.1465S3;
        Wed, 09 Jan 2019 00:43:40 +0800 (CST)
From:   16657101987@163.com
To:     worldhello.net@gmail.com, git@vger.kernel.org
Cc:     gitster@pobox.com, sunchao9@huawei.com
Subject: [PATCH v4 1/1] pack-redundant: remove unused functions
Date:   Wed,  9 Jan 2019 00:43:33 +0800
Message-Id: <20190108164333.73425-1-16657101987@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190102043456.15652-4-worldhello.net@gmail.com>
References: <20190102043456.15652-4-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowABXquQ70zRcNoshAA--.1465S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry7KFW5Jw4kJr18ur15Arb_yoW5WrW3pr
        43JwnrJaykWr10kr4UJrs5GFyaganrK3W0yrW5C3yftFnIyr4093W3A3yxuayfJ3ykuw1f
        AF4kKFW8GFWUAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07beuWLUUUUU=
X-Originating-IP: [122.235.191.23]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiQxw2glc7F9Xt5QAAsN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

Remove unused functions to find `min` packs, such as `get_permutations`,
`pll_free`, etc.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c | 86 ------------------------------------------------
 1 file changed, 86 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 3655cc7..eac2350 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -35,11 +35,6 @@ static struct pack_list {
 	struct llist *all_objects;
 } *local_packs = NULL, *altodb_packs = NULL;
 
-struct pll {
-	struct pll *next;
-	struct pack_list *pl;
-};
-
 static struct llist_item *free_nodes;
 
 static inline void llist_item_put(struct llist_item *item)
@@ -63,15 +58,6 @@ static inline struct llist_item *llist_item_get(void)
 	return new_item;
 }
 
-static void llist_free(struct llist *list)
-{
-	while ((list->back = list->front)) {
-		list->front = list->front->next;
-		llist_item_put(list->back);
-	}
-	free(list);
-}
-
 static inline void llist_init(struct llist **list)
 {
 	*list = xmalloc(sizeof(struct llist));
@@ -285,78 +271,6 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 	}
 }
 
-static void pll_free(struct pll *l)
-{
-	struct pll *old;
-	struct pack_list *opl;
-
-	while (l) {
-		old = l;
-		while (l->pl) {
-			opl = l->pl;
-			l->pl = opl->next;
-			free(opl);
-		}
-		l = l->next;
-		free(old);
-	}
-}
-
-/* all the permutations have to be free()d at the same time,
- * since they refer to each other
- */
-static struct pll * get_permutations(struct pack_list *list, int n)
-{
-	struct pll *subset, *ret = NULL, *new_pll = NULL;
-
-	if (list == NULL || pack_list_size(list) < n || n == 0)
-		return NULL;
-
-	if (n == 1) {
-		while (list) {
-			new_pll = xmalloc(sizeof(*new_pll));
-			new_pll->pl = NULL;
-			pack_list_insert(&new_pll->pl, list);
-			new_pll->next = ret;
-			ret = new_pll;
-			list = list->next;
-		}
-		return ret;
-	}
-
-	while (list->next) {
-		subset = get_permutations(list->next, n - 1);
-		while (subset) {
-			new_pll = xmalloc(sizeof(*new_pll));
-			new_pll->pl = subset->pl;
-			pack_list_insert(&new_pll->pl, list);
-			new_pll->next = ret;
-			ret = new_pll;
-			subset = subset->next;
-		}
-		list = list->next;
-	}
-	return ret;
-}
-
-static int is_superset(struct pack_list *pl, struct llist *list)
-{
-	struct llist *diff;
-
-	diff = llist_copy(list);
-
-	while (pl) {
-		llist_sorted_difference_inplace(diff, pl->all_objects);
-		if (diff->size == 0) { /* we're done */
-			llist_free(diff);
-			return 1;
-		}
-		pl = pl->next;
-	}
-	llist_free(diff);
-	return 0;
-}
-
 static size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
 {
 	size_t ret = 0;
-- 
2.8.1


