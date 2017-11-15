Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F079C202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 00:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756404AbdKOAbH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 19:31:07 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:49331 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755406AbdKOAay (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 19:30:54 -0500
Received: by mail-io0-f193.google.com with SMTP id x63so14189363ioe.6
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 16:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wjI3kFMWbYeQQrGXrF36hWGueequSV2uO6AVl4hAWjI=;
        b=FgWEfciWZuIZrtqy36kfRp5DFahCtwO9ZDPSNqwNVP6h6hr0v8MW4MS5pU4vdiel+v
         J/F9XCTi/yIRam3bLsJEFCqRqvSgNIh9z+7leujij7Yp9s7WGhtdEFQWyPyfeH3iJ3KH
         5nTgXjN2xp1PqMMzE1uKQqgRxzTg8wBdJXKQM7Tliw6Fr+06ZogWOgYA3vBcXd91Fz68
         39wIGmmYx6S/rc0/C4kNoiuYRkgayya5vHCd/rvE7o2nn9UUz/p94Aaqa87WVIx5s9bs
         PvnUnEdXh5AIgF82ydXqjEiSienQ+FONrWaIimZ5ttuJuYGsFPTgXBBdQ7IsBbD+LfvO
         l/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wjI3kFMWbYeQQrGXrF36hWGueequSV2uO6AVl4hAWjI=;
        b=XrYrbcFhzP+pNNMjMWdilBdgWl70VRw1PlNlwzd+XdF/HMYLCbX1mv36aAmGfiH/1i
         hPwh7mfi0lwACCHJC9lRbbJGWw9KTjqy9w5BRcLKZRAd3ojNpfupjNU+IgrwxbkgZbVK
         mHnfd11KKUMtqG286JWvLke8fAL1oddHkA7iTgs7u15HqDnI87lVH83u8tyKfhnQghh2
         vjNbsT/SKTTdxnDtuGN8T0AYy3GpuZopiu3KKs5hsqVXIQC4q9qrxzsGA37Bp3WBJbff
         Q/Pyk/zYMii5kpHgfOGuc79Kkjt62GpXS0wDoTn1x1jcVJQnXnyJ4wWPg1guR/fe7APx
         meYg==
X-Gm-Message-State: AJaThX4E6yTXzxvJAzSeW8BjCzfVSjcRQImjbq5KyiqhOrwldY1aAwi9
        lwRt2gyt6iVeRArc7zJEF1fO+kGpF20=
X-Google-Smtp-Source: AGs4zMYnrqHsCkJpinvzNILA5G86ls536rnYzzEafM5kZ1ngskzTbM4yDZWO32O412V21+gobL41zw==
X-Received: by 10.107.142.16 with SMTP id q16mr5217085iod.138.1510705852874;
        Tue, 14 Nov 2017 16:30:52 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c9fb:9110:c737:8943])
        by smtp.gmail.com with ESMTPSA id b66sm6001434itb.28.2017.11.14.16.30.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 16:30:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/7] list-objects.c: factor out traverse_trees_and_blobs
Date:   Tue, 14 Nov 2017 16:30:38 -0800
Message-Id: <20171115003043.24080-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171115003043.24080-1-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With traverse_trees_and_blobs factored out of the main traverse function,
the next patch can introduce an in-order revision walking with ease.

In the next patch we'll call `traverse_trees_and_blobs` from within the
loop walking the commits, such that we'll have one invocation of that
function per commit.  That is why we do not want to have memory allocations
in that function, such as we'd have if we were to use a strbuf locally.
Pass a strbuf from traverse_commit_list into the blob and tree traversing
function as a scratch pad that only needs to be allocated once.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 list-objects.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index b3931fa434..7c2ce9c4bd 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -183,25 +183,15 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
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
+	assert(base->len == 0);
+
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
 		struct object *obj = pending->item;
@@ -218,17 +208,39 @@ void traverse_commit_list(struct rev_info *revs,
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
-	strbuf_release(&base);
+}
+
+void traverse_commit_list(struct rev_info *revs,
+			  show_commit_fn show_commit,
+			  show_object_fn show_object,
+			  void *data)
+{
+	struct commit *commit;
+	struct strbuf csp; /* callee's scratch pad */
+	strbuf_init(&csp, PATH_MAX);
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
+	traverse_trees_and_blobs(revs, &csp, show_object, data);
+
+	strbuf_release(&csp);
 }
-- 
2.15.0.128.gcadd42da22

