Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B6C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhLGSln (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:41:43 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43842 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240597AbhLGSll (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:41:41 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C21DB1F953
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 18:38:10 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH] cbtree: remove broken and unused cb_unlink
Date:   Tue,  7 Dec 2021 18:38:10 +0000
Message-Id: <20211207183810.688481-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cb_unlink is broken once a node is no longer self-referential
due to subsequent insertions.  This is a consequence of an
intrusive implementation and I'm not sure if it's easily fixable
while retaining our cache-friendly intrusive property (I've
tried for several hours in another project).

In any case, we're not using cb_unlink anywhere in our codebase,
just get rid of it to avoid misleading future readers.

Signed-off-by: Eric Wong <e@80x24.org>
---
 cbtree.c | 32 --------------------------------
 cbtree.h |  1 -
 2 files changed, 33 deletions(-)

diff --git a/cbtree.c b/cbtree.c
index b0c65d810f..336e46dbba 100644
--- a/cbtree.c
+++ b/cbtree.c
@@ -95,38 +95,6 @@ struct cb_node *cb_lookup(struct cb_tree *t, const uint8_t *k, size_t klen)
 	return p && !memcmp(p->k, k, klen) ? p : NULL;
 }
 
-struct cb_node *cb_unlink(struct cb_tree *t, const uint8_t *k, size_t klen)
-{
-	struct cb_node **wherep = &t->root;
-	struct cb_node **whereq = NULL;
-	struct cb_node *q = NULL;
-	size_t direction = 0;
-	uint8_t c;
-	struct cb_node *p = t->root;
-
-	if (!p) return NULL;	/* empty tree, nothing to delete */
-
-	/* traverse to find best match, keeping link to parent */
-	while (1 & (uintptr_t)p) {
-		whereq = wherep;
-		q = cb_node_of(p);
-		c = q->byte < klen ? k[q->byte] : 0;
-		direction = (1 + (q->otherbits | c)) >> 8;
-		wherep = q->child + direction;
-		p = *wherep;
-	}
-
-	if (memcmp(p->k, k, klen))
-		return NULL;		/* no match, nothing unlinked */
-
-	/* found an exact match */
-	if (whereq)	/* update parent */
-		*whereq = q->child[1 - direction];
-	else
-		t->root = NULL;
-	return p;
-}
-
 static enum cb_next cb_descend(struct cb_node *p, cb_iter fn, void *arg)
 {
 	if (1 & (uintptr_t)p) {
diff --git a/cbtree.h b/cbtree.h
index dedbb8e2a4..0be14fb7ee 100644
--- a/cbtree.h
+++ b/cbtree.h
@@ -47,7 +47,6 @@ static inline void cb_init(struct cb_tree *t)
 
 struct cb_node *cb_lookup(struct cb_tree *, const uint8_t *k, size_t klen);
 struct cb_node *cb_insert(struct cb_tree *, struct cb_node *, size_t klen);
-struct cb_node *cb_unlink(struct cb_tree *t, const uint8_t *k, size_t klen);
 
 typedef enum cb_next (*cb_iter)(struct cb_node *, void *arg);
 
