Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092A81FBF4
	for <e@80x24.org>; Sat, 28 Oct 2017 00:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdJ1ApL (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 20:45:11 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:54478 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdJ1ApK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 20:45:10 -0400
Received: by mail-io0-f195.google.com with SMTP id e89so16132287ioi.11
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 17:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VpFuDJSpbiYf621oNlSRB/Cy6L/OYU5vx5+unA2xBUk=;
        b=DBW52XXCyqL15d8KofZYu8DXOuuls0Xy21CPyJXbltqEohK77++92tuJf7PAnoOK2p
         rOOacOQn694b/y7ft3BdqiAmoPZNx1HO3lFoGTMRHEhzyZCv1ndltmcJPdK8qfdO9sEG
         tvneCkJx+ILTgR96VcKeIUjJAPe968Lm79h9MO6QxkReuCKraxUE8Vro30OysaKbnX/8
         ozxUMB0b/BjCNapQzQB2eDYRO6r8GoaO4Lc4dGV9TEa/C471yWPn7YqxfTIJNNVbWLzd
         sZSaQhdN+pyeiLSIcsOODKu86KXFjed5FDDOENLUvYAeSC8tofOgDdQagkKl+avYsx8Q
         8hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VpFuDJSpbiYf621oNlSRB/Cy6L/OYU5vx5+unA2xBUk=;
        b=iFbG1K6wiNOf8IDO9jEjGUiaO10iuMiM4sJW0dpaqFBD58OoWkTc+q/M7wcHE+WBqA
         EQW/AZQHOtzJoUPA+ybLxxnqpHEAVr6722ooff9xRYbluf44Xzsa2o6eXOzD77hy+o1w
         kKWDehDOeAODOHDz+ZnD12/+XAOtqzOfgKykFrkNnXIjzRrHtAqZTT97yl15WFfZJaiB
         tGxF9YjVtrkvZOw8OSNmNhg+85qELHMbZkh4QBcz4ULuyCjnh/RIAz/kdej9cd29S79X
         fULo51FthCTH6KtWuIAcpbSKXFIkWfx+KhFwaIpigEwkTdjgJiJslP7COVMOp77E88fK
         MkGQ==
X-Gm-Message-State: AMCzsaUBkctBEzvDtZNj53izLJLwwCTT3Sk/kAIPZuAUtnhywT8xH71f
        4ixGFvot7f3xef915hXTicI6Sg==
X-Google-Smtp-Source: ABhQp+SKhgajMHhM1hrZlDQBA4joQ7Mdy65tm9eDpbDEu9WkMwLy8+RYArNTZ2aq82tFAQYzfeYlIQ==
X-Received: by 10.36.246.74 with SMTP id u71mr2857696ith.104.1509151509066;
        Fri, 27 Oct 2017 17:45:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1da7:34ee:3ff4:f700])
        by smtp.gmail.com with ESMTPSA id z2sm1477755ite.26.2017.10.27.17.45.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 17:45:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 1/3] list-objects.c: factor out traverse_trees_and_blobs
Date:   Fri, 27 Oct 2017 17:45:04 -0700
Message-Id: <20171028004506.10253-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171028004419.10139-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With traverse_trees_and_blobs factored out of the main traverse function,
the next patch can introduce an in-order revision walking with ease.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 list-objects.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index b3931fa434..0ee0551604 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -183,25 +183,13 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
 
-void traverse_commit_list(struct rev_info *revs,
-			  show_commit_fn show_commit,
-			  show_object_fn show_object,
-			  void *data)
+static void traverse_trees_and_blobs(struct rev_info *revs,
+				     struct strbuf *base,
+				     show_object_fn show_object,
+				     void *data)
 {
 	int i;
-	struct commit *commit;
-	struct strbuf base;
 
-	strbuf_init(&base, PATH_MAX);
-	while ((commit = get_revision(revs)) != NULL) {
-		/*
-		 * an uninteresting boundary commit may not have its tree
-		 * parsed yet, but we are not going to show them anyway
-		 */
-		if (commit->tree)
-			add_pending_tree(revs, commit->tree);
-		show_commit(commit, data);
-	}
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
 		struct object *obj = pending->item;
@@ -218,17 +206,39 @@ void traverse_commit_list(struct rev_info *revs,
 			path = "";
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     &base, path, data);
+				     base, path, data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
-				     &base, path, data);
+				     base, path, data);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
 		    oid_to_hex(&obj->oid), name);
 	}
 	object_array_clear(&revs->pending);
+}
+
+void traverse_commit_list(struct rev_info *revs,
+			  show_commit_fn show_commit,
+			  show_object_fn show_object,
+			  void *data)
+{
+	struct commit *commit;
+	struct strbuf base;
+	strbuf_init(&base, PATH_MAX);
+
+	while ((commit = get_revision(revs)) != NULL) {
+		/*
+		 * an uninteresting boundary commit may not have its tree
+		 * parsed yet, but we are not going to show them anyway
+		 */
+		if (commit->tree)
+			add_pending_tree(revs, commit->tree);
+		show_commit(commit, data);
+	}
+	traverse_trees_and_blobs(revs, &base, show_object, data);
+
 	strbuf_release(&base);
 }
-- 
2.15.0.rc2.443.gfcc3b81c0a

