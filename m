Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DECE1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 23:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfJFXar (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 19:30:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39044 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfJFXar (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 19:30:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C22BD1F4BE;
        Sun,  6 Oct 2019 23:30:43 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 01/20] diff: use hashmap_entry_init on moved_entry.ent
Date:   Sun,  6 Oct 2019 23:30:24 +0000
Message-Id: <20191006233043.3516-2-e@80x24.org>
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
References: <20191006233043.3516-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise, the hashmap_entry.next field appears to remain
uninitialized, which can lead to problems when
add_lines_to_move_detection calls hashmap_add.

I found this through manual inspection when converting
hashmap_add callers to take "struct hashmap_entry *".

Signed-off-by: Eric Wong <e@80x24.org>
Reviewed-by: Derrick Stolee <stolee@gmail.com>
---
 diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index efe42b341a..02491ee684 100644
--- a/diff.c
+++ b/diff.c
@@ -964,8 +964,9 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
+	unsigned int hash = xdiff_hash_string(l->line, l->len, flags);
 
-	ret->ent.hash = xdiff_hash_string(l->line, l->len, flags);
+	hashmap_entry_init(&ret->ent, hash);
 	ret->es = l;
 	ret->next_line = NULL;
 
