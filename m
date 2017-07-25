Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709E31F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdGYVkG (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:40:06 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:37916 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdGYVkD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:40:03 -0400
Received: by mail-pg0-f54.google.com with SMTP id k190so9794748pgk.5
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ka/gRcttO2XI2naVT8INJMR6Wtj9wuyeCPPBAjtwBxg=;
        b=k44qtqmhtH7mpv7ju3B+3OC8LS19eRnY8WWCdGQelmKVLyL9S7Q+ep712BjZEl1QXz
         h4DujLaOlm+xzC3NFBXQZ0Uu/PBk+s0X7T64YDuPqS3gc4O+YoQl1Wyaq34ewNK651ih
         /tFSoHlhNV1lFwtYJ1WpFCQH+CXkC40Yy32LEqnXxFciPNwZRUPS8g3phgsMkfDDxAtE
         lZlqsgj7lNeV288vkcaogYVdums132iU5VvIkXeoCPIvB5lJZF9AbjtEO+NaaijR1RDJ
         RnMe+DjwXiDSyCPWwqTJKTpuwQdzsT+oLK3BaDlRhjBMIdp9ysUGbzVFdXmFr1qFpXWl
         iUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ka/gRcttO2XI2naVT8INJMR6Wtj9wuyeCPPBAjtwBxg=;
        b=S7bg4Rh8XlDbSFpJm5TU7n6JI4tACP83kCWCX+Wt6vqsACuG9u6NzyETAe49a0elZw
         StG5iGXVpNGs5468Jvlo6L3SwlGXJJJDJ+kaaUC1pbfKlDE5hL8uf9V6kt6TsBIpNe1t
         P/aPsnUMR6LszwUB2NREaonwZTV4V5s94mgTM1UgKhukbntub1JsfPsddUmm5YgNX56j
         BWI2d5KAQIJJ1dDEWElrGBKiCDoUjhh4glH5ugYZzJDFzWs3ZWVi/fi2Gm/dtgx6gO3X
         1fqH5ttZeWQQkYWYpRGXqYem1gZG9JzLASFcrwsP7KCt9oR0FjyfXtW+DhnYRZgGrgjA
         eHmQ==
X-Gm-Message-State: AIVw11351dEHNn2FLZaOTsbitqC1rDUr2qyHPLljORi9IyHXU4E3rko+
        Mf4laEI58jRNW2OPt9uxJg==
X-Received: by 10.99.1.2 with SMTP id 2mr5892452pgb.213.1501018802291;
        Tue, 25 Jul 2017 14:40:02 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:40:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 14/15] unpack-trees: improve loading of .gitmodules
Date:   Tue, 25 Jul 2017 14:39:27 -0700
Message-Id: <20170725213928.125998-15-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When recursing submodules 'check_updates()' needs to have strict control
over the submodule-config subsystem to ensure that the gitmodules file
has been read before checking cache entries which are marked for
removal as well ensuring the proper gitmodules file is read before
updating cache entries.

Because of this let's not rely on callers of 'check_updates()' to read
the gitmodules file before calling 'check_updates()' and handle the
reading explicitly.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 unpack-trees.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index dc66b880d..144c556c8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -283,22 +283,28 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 	}
 }
 
-static void reload_gitmodules_file(struct index_state *index,
-				   struct checkout *state)
+/*
+ * Preform the loading of the repository's gitmodules file.  This function is
+ * used by 'check_update()' to perform loading of the gitmodules file in two
+ * differnt situations:
+ * (1) before removing entries from the working tree if the gitmodules file has
+ *     been marked for removal.  This situation is specified by 'state' == NULL.
+ * (2) before checking out entries to the working tree if the gitmodules file
+ *     has been marked for update.  This situation is specified by 'state' != NULL.
+ */
+static void load_gitmodules_file(struct index_state *index,
+				 struct checkout *state)
 {
-	int i;
-	for (i = 0; i < index->cache_nr; i++) {
-		struct cache_entry *ce = index->cache[i];
-		if (ce->ce_flags & CE_UPDATE) {
-			int r = strcmp(ce->name, ".gitmodules");
-			if (r < 0)
-				continue;
-			else if (r == 0) {
-				submodule_free();
-				checkout_entry(ce, state, NULL);
-				gitmodules_config();
-			} else
-				break;
+	int pos = index_name_pos(index, GITMODULES_FILE, strlen(GITMODULES_FILE));
+
+	if (pos >= 0) {
+		struct cache_entry *ce = index->cache[pos];
+		if (!state && ce->ce_flags & CE_WT_REMOVE) {
+			repo_read_gitmodules(the_repository);
+		} else if (state && (ce->ce_flags & CE_UPDATE)) {
+			submodule_free();
+			checkout_entry(ce, state, NULL);
+			repo_read_gitmodules(the_repository);
 		}
 	}
 }
@@ -371,6 +377,10 @@ static int check_updates(struct unpack_trees_options *o)
 
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
+
+	if (should_update_submodules() && o->update && !o->dry_run)
+		load_gitmodules_file(index, NULL);
+
 	for (i = 0; i < index->cache_nr; i++) {
 		const struct cache_entry *ce = index->cache[i];
 
@@ -384,7 +394,7 @@ static int check_updates(struct unpack_trees_options *o)
 	remove_scheduled_dirs();
 
 	if (should_update_submodules() && o->update && !o->dry_run)
-		reload_gitmodules_file(index, &state);
+		load_gitmodules_file(index, &state);
 
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
-- 
2.14.0.rc0.400.g1c36432dff-goog

