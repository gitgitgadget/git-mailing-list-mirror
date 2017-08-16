Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837831F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbdHPURO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:17:14 -0400
Received: from vie01a-dmta-pe04-1.mx.upcmail.net ([62.179.121.163]:40720 "EHLO
        vie01a-dmta-pe04-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752567AbdHPUQx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:53 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kG-0005Ls-Mu
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:52 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGn1v0145BuuEg01wGoNH; Wed, 16 Aug 2017 22:16:48 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 7D1FF45D4512; Wed, 16 Aug 2017 22:16:47 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 18/19] Convert tree-walk to size_t
Date:   Wed, 16 Aug 2017 22:16:30 +0200
Message-Id: <1502914591-26215-19-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 tree-walk.c | 17 +++++++++--------
 tree-walk.h |  4 ++--
 tree.h      |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 7c9f9e3..a7d8b2a 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -22,10 +22,11 @@ static const char *get_mode(const char *str, unsigned int *modep)
 	return str;
 }
 
-static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
+static int decode_tree_entry(struct tree_desc *desc, const char *buf, size_t size, struct strbuf *err)
 {
 	const char *path;
-	unsigned int mode, len;
+	unsigned int mode;
+	size_t len;
 
 	if (size < 23 || buf[size - 21]) {
 		strbuf_addstr(err, _("too-short tree object"));
@@ -51,7 +52,7 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 	return 0;
 }
 
-static int init_tree_desc_internal(struct tree_desc *desc, const void *buffer, unsigned long size, struct strbuf *err)
+static int init_tree_desc_internal(struct tree_desc *desc, const void *buffer, size_t size, struct strbuf *err)
 {
 	desc->buffer = buffer;
 	desc->size = size;
@@ -60,7 +61,7 @@ static int init_tree_desc_internal(struct tree_desc *desc, const void *buffer, u
 	return 0;
 }
 
-void init_tree_desc(struct tree_desc *desc, const void *buffer, unsigned long size)
+void init_tree_desc(struct tree_desc *desc, const void *buffer, size_t size)
 {
 	struct strbuf err = STRBUF_INIT;
 	if (init_tree_desc_internal(desc, buffer, size, &err))
@@ -68,7 +69,7 @@ void init_tree_desc(struct tree_desc *desc, const void *buffer, unsigned long si
 	strbuf_release(&err);
 }
 
-int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, unsigned long size)
+int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, size_t size)
 {
 	struct strbuf err = STRBUF_INIT;
 	int result = init_tree_desc_internal(desc, buffer, size, &err);
@@ -106,8 +107,8 @@ static int update_tree_entry_internal(struct tree_desc *desc, struct strbuf *err
 {
 	const void *buf = desc->buffer;
 	const unsigned char *end = desc->entry.oid->hash + 20;
-	unsigned long size = desc->size;
-	unsigned long len = end - (const unsigned char *)buf;
+	size_t size = desc->size;
+	size_t len = end - (const unsigned char *)buf;
 
 	if (size < len)
 		die(_("too-short tree file"));
@@ -487,7 +488,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 
 struct dir_state {
 	void *tree;
-	unsigned long size;
+	size_t size;
 	unsigned char sha1[20];
 };
 
diff --git a/tree-walk.h b/tree-walk.h
index 68bb78b..9160cc2 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -32,8 +32,8 @@ static inline int tree_entry_len(const struct name_entry *ne)
 
 void update_tree_entry(struct tree_desc *);
 int update_tree_entry_gently(struct tree_desc *);
-void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
-int init_tree_desc_gently(struct tree_desc *desc, const void *buf, unsigned long size);
+void init_tree_desc(struct tree_desc *desc, const void *buf, size_t size);
+int init_tree_desc_gently(struct tree_desc *desc, const void *buf, size_t size);
 
 /*
  * Helper function that does both tree_entry_extract() and update_tree_entry()
diff --git a/tree.h b/tree.h
index 1dac7fc..69b9233 100644
--- a/tree.h
+++ b/tree.h
@@ -9,7 +9,7 @@ struct strbuf;
 struct tree {
 	struct object object;
 	void *buffer;
-	unsigned long size;
+	size_t size;
 };
 
 struct tree *lookup_tree(const struct object_id *oid);
-- 
2.1.4

