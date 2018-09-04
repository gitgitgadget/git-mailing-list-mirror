Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D0B1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 18:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeIDWcW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 18:32:22 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:56044 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeIDWcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 18:32:21 -0400
Received: by mail-vk0-f73.google.com with SMTP id j80-v6so1687658vke.22
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o26MQ9d1E6xW9NUviY0MLCbxSB0rda8sqVAFOSAuH2w=;
        b=UOMN2yY1N91q5zll5KQ/h4xGhIQxoF+xMOCXx6MrcsmFZavZhyDrolb1BpBT02wewg
         nidPTdEZ2kDI9m8rJuZL1HWTC1uc4tepiwYHeTrr3ZNAkAEBXN/h4Xb2U7fPE9P0NgQ1
         1l5TvMlRHF9oDlZlpPrzIA1DXQAWsHYm1vU5t6lq0PFjNmbykVGxlLzCSzAkOzNXxaqi
         kqoJhpiTrxu/t5ZjEuSD19tCKq1HDSuE4PhuGhRv9osrR+S8CZ3LjjUjOGAZ4j6Rfzn6
         369rtYBdmRTU7DTbDs7xpXne/y+DsdVsScStLObWWdHQUSlGRqEgmBF5HY8CXQCwO0C6
         zWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o26MQ9d1E6xW9NUviY0MLCbxSB0rda8sqVAFOSAuH2w=;
        b=sQDnNpDoZrpam2hN2jSocri4H8EVAKE2Hnr5yKtmzJFzkr6ec6JywxUv8MstvDr3zh
         dRsS457NtgYqot98COei3ftUDIWFx8rphzJnIYN8fNTEOu5zFo1lFRcQh6dfS5+PiiYJ
         LXGqE2w8B1brk/N/2OsVF5TmJmtzWhKwZE5vAFcsxg+99Jl8SpxkqpWibgI/I/iwgln5
         jRfesBjJBW2Kp0L+FcoyAexagFxRAHa+CnBac4QTtKsFvrsGWe270gQAq00ZLfRlb0YO
         pfZcv6BvXY77QlTrilSMc9cutN6yNJEUiu9d5gnW6o5kw9FbOwUZrzYHeT3h17lcX5ob
         x+0Q==
X-Gm-Message-State: APzg51Auh6QnyZEfmoH8gpb01MpdzV+ls/iUOy0e8eMf0gvJM2hV9Ml2
        GK6olipp3YtaEDh1lHyIsxe/scEQ2kA=
X-Google-Smtp-Source: ANB0VdbXxNOdXHr9qrB6Mmh4xSxQDBSe+6B5QEHQ7tRNho6zah5xEZ5b0M0IUiOM48Hi6cJai8j4e33NvRLA
X-Received: by 2002:ab0:2612:: with SMTP id c18-v6mr14388301uao.33.1536084367757;
 Tue, 04 Sep 2018 11:06:07 -0700 (PDT)
Date:   Tue,  4 Sep 2018 11:05:45 -0700
In-Reply-To: <cover.1536081438.git.matvore@google.com>
Message-Id: <f753322f09757bdafe62dae89fa53171956ed69e.1536081438.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536081438.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH v7 2/7] list-objects: refactor to process_tree_contents
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
2.19.0.rc1.350.ge57e33dbd1-goog

