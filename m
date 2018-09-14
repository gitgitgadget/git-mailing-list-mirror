Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2613A1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 00:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeINGH6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 02:07:58 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:37202 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeINGH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 02:07:58 -0400
Received: by mail-io1-f74.google.com with SMTP id l6-v6so6656452iog.4
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 17:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IWMtfmkF75GsybnM11356Qak2u2LcOOZFz9T3sTmvEw=;
        b=GighBETpxnQq1oo0A4XCHSOvXRt9TF6NpnGIe4WcvpnTWBc6EbLfVBB4ZMfEak6KQQ
         BVg1DP9WXZqX8mjT/DE+K/gRRLuFp0Q/jZ9ll3hSOLFdoFJZlRMlSBfZO2ff4a0jrvKq
         MLyQND/YbTcjvAk2nDGpZxREEPcCJSiC7HBkulfZumSErwDHnh5EZOk60jHwrKR5i6Xn
         13qWv8cdNzAxTwikmt2jVz8udcnwTesGLfW0OFQMgjt/oWe1KncibSAljq4lpdBqIbj+
         GBVLxyz7D3FpQndjibsZS8sq7PWFfv4AGiy/ZHTYwCe2Uo+fk9Emj8tS1/0ux19kr/XS
         1A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWMtfmkF75GsybnM11356Qak2u2LcOOZFz9T3sTmvEw=;
        b=ZSyr0TGNMNT5CzGQl7zOYkeE1zdC0TYD83GHJyfhMqAxPHJfbXoV+ESM32OlAESlu/
         CHU+cPKAGRJxt5ZaJB94WYppZB1qJnLntkPmGD8SKL3CVSg7UiyaQKei+mNng3I6JqS5
         Icb/AR9cGmqHGDsPPwMfADGa6O3gJw6+9yKm4z0htAa/EGUbkcGwgcAWuAVvZFEVcDfL
         4vWDwlqECyQIfQEoWv6LGKomVKDiboNR2ObmmLnS5K6zY0lDsdpB2Gi3hWpnJb6e1Kfu
         kdhE8eBcmyzspiZJpglWP61+SdMS9Oe1h+aqYSX3GhE9blMSeyLTJNGWNx5vkGivLF6w
         iz3Q==
X-Gm-Message-State: APzg51DAdubx/nVTJqfTDWzMCpOzWhUwG0x/4V03bBradCH4ew/ItXM1
        P7C0KB7q94wS/W8hVfc96YLYEW8bDAs=
X-Google-Smtp-Source: ANB0VdYWle6z0JiPed/xVxGBjOsTzN79QvbmqbE+h7NEfCdvra6eflKpscBl/rTCXAMM6U3x9jz3wXQBqTNt
X-Received: by 2002:a6b:ac45:: with SMTP id v66-v6mr7307127ioe.101.1536886562565;
 Thu, 13 Sep 2018 17:56:02 -0700 (PDT)
Date:   Thu, 13 Sep 2018 17:55:22 -0700
In-Reply-To: <cover.1536885967.git.matvore@google.com>
Message-Id: <ecdcb996c9f26e612259ea028076df07e25b6c10.1536885967.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536885967.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH v8 2/7] list-objects: refactor to process_tree_contents
From:   Matthew DeVore <matvore@google.com>
To:     sbeller@google.com, git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be used in a follow-up patch to reduce indentation needed when
invoking the logic conditionally. i.e. rather than:

if (foo) {
	while (...) {
		/* this is very indented */
	}
}

we will have:

if (foo)
	process_tree_contents(...);

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c | 68 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 584518a3f..ccc529e5e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -94,6 +94,46 @@ static void process_gitlink(struct traversal_context *ctx,
 	/* Nothing to do */
 }
 
+static void process_tree(struct traversal_context *ctx,
+			 struct tree *tree,
+			 struct strbuf *base,
+			 const char *name);
+
+static void process_tree_contents(struct traversal_context *ctx,
+				  struct tree *tree,
+				  struct strbuf *base)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	enum interesting match = ctx->revs->diffopt.pathspec.nr == 0 ?
+		all_entries_interesting : entry_not_interesting;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+
+	while (tree_entry(&desc, &entry)) {
+		if (match != all_entries_interesting) {
+			match = tree_entry_interesting(&entry, base, 0,
+						       &ctx->revs->diffopt.pathspec);
+			if (match == all_entries_not_interesting)
+				break;
+			if (match == entry_not_interesting)
+				continue;
+		}
+
+		if (S_ISDIR(entry.mode))
+			process_tree(ctx,
+				     lookup_tree(the_repository, entry.oid),
+				     base, entry.path);
+		else if (S_ISGITLINK(entry.mode))
+			process_gitlink(ctx, entry.oid->hash,
+					base, entry.path);
+		else
+			process_blob(ctx,
+				     lookup_blob(the_repository, entry.oid),
+				     base, entry.path);
+	}
+}
+
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
@@ -101,10 +141,6 @@ static void process_tree(struct traversal_context *ctx,
 {
 	struct object *obj = &tree->object;
 	struct rev_info *revs = ctx->revs;
-	struct tree_desc desc;
-	struct name_entry entry;
-	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
-		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
 	int gently = revs->ignore_missing_links ||
@@ -144,29 +180,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (base->len)
 		strbuf_addch(base, '/');
 
-	init_tree_desc(&desc, tree->buffer, tree->size);
-
-	while (tree_entry(&desc, &entry)) {
-		if (match != all_entries_interesting) {
-			match = tree_entry_interesting(&entry, base, 0,
-						       &revs->diffopt.pathspec);
-			if (match == all_entries_not_interesting)
-				break;
-			if (match == entry_not_interesting)
-				continue;
-		}
-
-		if (S_ISDIR(entry.mode))
-			process_tree(ctx,
-				     lookup_tree(the_repository, entry.oid),
-				     base, entry.path);
-		else if (S_ISGITLINK(entry.mode))
-			process_gitlink(ctx, entry.oid->hash, base, entry.path);
-		else
-			process_blob(ctx,
-				     lookup_blob(the_repository, entry.oid),
-				     base, entry.path);
-	}
+	process_tree_contents(ctx, tree, base);
 
 	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
-- 
2.19.0.397.gdd90340f6a-goog

