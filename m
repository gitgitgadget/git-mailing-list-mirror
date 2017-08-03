Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D171F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdHCSUc (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:32 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35701 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdHCSUa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:30 -0400
Received: by mail-pf0-f174.google.com with SMTP id t86so9381971pfe.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MZzWKT8JbmpZ+X7gzNcw2+B9XClnfwrj7Ym2/TKADaI=;
        b=WBls2jMb2i7wWLBahr3HeT6bpjzboGbYaB8t4zXGq6sx/cBHq47eC771j5gB/pej/q
         k3R8fbxLGz0Oe7bmz2CgDGz0o0KMqQnmZSOgHZ3gmV5LBFZxpsTrafv31nYh7uKuSlSL
         tc26IVwUvML1GwtSaiViw14BV0br4oeTT1zRYtIA8fDjDIFiPYfwTBu1RJJLrCp4WhQs
         suYtbnZVMMhGRIPZAdqLgQE1nK2ktekFCFrjVRjBlrBvpiaHY0V1CLDgzFgWkV4DV6No
         Npxypw0xyyGsUcu84WSe0Zr1wfQCcTuIV1bmhlwPPbiPTutTgeVTvj6bWMj8t857avY9
         92vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MZzWKT8JbmpZ+X7gzNcw2+B9XClnfwrj7Ym2/TKADaI=;
        b=U4YizH29eh5D1xGzZwXt4QimPGexxEmHO2QYeToGV2mAcHMi396LNQVtSQ+KqyLjGj
         pFwdUWQjtGvB+Ge7FK9B0/CBv16ebXpc1iRwZtS9VIoG1M2o7ddhwHxoW0TNQ4yxkKjn
         3uzApx65VK5Rc03UdiUSHVswT2RmadNgIVCQvBn1CONhINjHoOy6aOeRKr+/aPhELjC5
         7aQaRePVxRjU+WweVKLNaTz4xbsQ/B3INdcxnPl49C745NOQZi8FF92G1xNJSgQjdWKC
         RUE8DCO4lbNhe38BSl//0LPP3Bp+cMHHGU5UaDQZLXk0zGawOwDWiN2HZdcO5HF3eULX
         s7fA==
X-Gm-Message-State: AIVw112cARtIExmDrJGufEB75EIYZeWRXjwAzUWhyj/5eD103iOOMZ6g
        EiMsza96GymgzDk/kEqtig==
X-Received: by 10.84.172.1 with SMTP id m1mr2843364plb.174.1501784429295;
        Thu, 03 Aug 2017 11:20:29 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:28 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 14/15] unpack-trees: improve loading of .gitmodules
Date:   Thu,  3 Aug 2017 11:19:59 -0700
Message-Id: <20170803182000.179328-15-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
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
 unpack-trees.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5dce7ff7d..3c7f464fa 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,5 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "dir.h"
 #include "tree.h"
@@ -268,22 +269,28 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 	return 0;
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
-			int r = strcmp(ce->name, GITMODULES_FILE);
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
@@ -343,6 +350,10 @@ static int check_updates(struct unpack_trees_options *o)
 
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
+
+	if (should_update_submodules() && o->update && !o->dry_run)
+		load_gitmodules_file(index, NULL);
+
 	for (i = 0; i < index->cache_nr; i++) {
 		const struct cache_entry *ce = index->cache[i];
 
@@ -356,7 +367,7 @@ static int check_updates(struct unpack_trees_options *o)
 	remove_scheduled_dirs();
 
 	if (should_update_submodules() && o->update && !o->dry_run)
-		reload_gitmodules_file(index, &state);
+		load_gitmodules_file(index, &state);
 
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

