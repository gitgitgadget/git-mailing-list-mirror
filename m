Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5842F1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 02:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfHZCBm (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 22:01:42 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38328 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbfHZCBm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 22:01:42 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1i24K9-0001Eh-8V; Mon, 26 Aug 2019 11:01:37 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stefanbeller@gmail.com
Subject: [PATCH] commit: free the right buffer in release_commit_memory
Date:   Mon, 26 Aug 2019 11:01:37 +0900
Message-Id: <20190826020137.4703-1-mh@glandium.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The index field in the commit object is used to find the buffer
corresponding to that commit in the buffer_slab. Resetting it first
means free_commit_buffer is not going to free the right buffer.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index a98de16e3d..3fe5f8fa9c 100644
--- a/commit.c
+++ b/commit.c
@@ -364,8 +364,8 @@ struct object_id *get_commit_tree_oid(const struct commit *commit)
 void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
 {
 	set_commit_tree(c, NULL);
-	c->index = 0;
 	free_commit_buffer(pool, c);
+	c->index = 0;
 	free_commit_list(c->parents);
 
 	c->object.parsed = 0;
-- 
2.23.0

