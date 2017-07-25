Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1705A1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbdGYVjz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:39:55 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33967 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdGYVjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:53 -0400
Received: by mail-pf0-f171.google.com with SMTP id q85so63074449pfq.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0sCxPOUu9brJZ49+rAqrP2INgHSSjwh6DnRAxlORTIo=;
        b=YtXxKTeEoQYXS9L+RVAcaVYgFXBXOskbhS+wnsKuZQqhSORWQZ0m1YCwHlBEppZoq1
         9ERYVCZ6noZxlimLQ93tR6f3ZKxXtKqNS8hohOXI/UO0a44blOIcf2QFbwlvf57EE9yk
         3T0/6mTxpDay7PGr/nEFZfvpXXKo+oX5fVEbtAOXQF75TGI4NTLzDdO/vfIwlS/q7+Sx
         UVPZnXK4hqhfR9DaT02lSkc5f75YRWuR5PgBQvuZMpuqyudrFinwsAq19Ioj5M422XqD
         G30S9Kwg+vyRJKdc+lbzDlzhUSqcXG3LuTBvkLPKQijrH0D+WRtNk23BY6zAnlaW2m+m
         VgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0sCxPOUu9brJZ49+rAqrP2INgHSSjwh6DnRAxlORTIo=;
        b=F8Eb76OHVOEtc+zsi/lY7ZB8s/u+HmDo7c8xr/EGd4gagp19D0dkFpwG7LW98BG9qc
         fgyI88YDn2qv1U3nnlFQNJw63vb+JU8dbZtZqkdWFyRtoq6DvokTL10NG8e2/F+ZKIhP
         0/fIIz1tVlWLv5HAx5jiC53rvCyg6lPxm6RB+pPuGfZO9K4VcPkRlZtR3gfbgwksRNNi
         dOw3RSEa4LOe/98SKUWtm46i0gxXrcXZRbziOcD6kIow1QEovK0At55RT39h/Dqzdecj
         1Oo8pSk3wXUYWLxTYZnshqWKagM/eoT/JstR31M1t3KlXfi/flrInw53dG7NpiJcSeTt
         taNA==
X-Gm-Message-State: AIVw110x2hE3jI+hOywp/Ce2yVOkCwi8cuQJPwYTeFL5ylzgSZs+a43R
        eBIatpuiudE9UH4rJp5XRA==
X-Received: by 10.101.77.72 with SMTP id j8mr13678034pgt.133.1501018792424;
        Tue, 25 Jul 2017 14:39:52 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:51 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 08/15] unpack-trees: don't rely on overlayed config
Date:   Tue, 25 Jul 2017 14:39:21 -0700
Message-Id: <20170725213928.125998-9-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't rely on overlaying the repository's config on top of the
submodule-config, instead query the repository's config directory for
the submodule's update strategy.

Also remove the overlaying of the repository's config (via using
'submodule_config()') from the commands which use the unpack-trees
logic (checkout, read-tree, reset).

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/checkout.c |  2 +-
 submodule.c        |  1 -
 unpack-trees.c     | 12 +++++++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9661e1bcb..246e0cd16 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -858,7 +858,7 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	}
 
 	if (starts_with(var, "submodule."))
-		return submodule_config(var, value, NULL);
+		return git_default_submodule_config(var, value, NULL);
 
 	return git_xmerge_config(var, value, NULL);
 }
diff --git a/submodule.c b/submodule.c
index f86b82fbb..13380fed1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -235,7 +235,6 @@ void load_submodule_cache(void)
 		return;
 
 	gitmodules_config();
-	git_config(submodule_config, NULL);
 }
 
 static int gitmodules_cb(const char *var, const char *value, void *data)
diff --git a/unpack-trees.c b/unpack-trees.c
index dd535bc84..dc66b880d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,5 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "dir.h"
 #include "tree.h"
@@ -255,13 +256,16 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 {
 	unsigned flags = SUBMODULE_MOVE_HEAD_DRY_RUN;
 	const struct submodule *sub = submodule_from_ce(ce);
+	struct submodule_update_strategy update;
+
 	if (!sub)
 		return 0;
 
 	if (o->reset)
 		flags |= SUBMODULE_MOVE_HEAD_FORCE;
 
-	switch (sub->update_strategy.type) {
+	update = submodule_strategy_with_config_overlayed(the_repository, sub);
+	switch (update.type) {
 	case SM_UPDATE_UNSPECIFIED:
 	case SM_UPDATE_CHECKOUT:
 		if (submodule_move_head(ce->name, old_id, new_id, flags))
@@ -293,7 +297,6 @@ static void reload_gitmodules_file(struct index_state *index,
 				submodule_free();
 				checkout_entry(ce, state, NULL);
 				gitmodules_config();
-				git_config(submodule_config, NULL);
 			} else
 				break;
 		}
@@ -308,7 +311,10 @@ static void unlink_entry(const struct cache_entry *ce)
 {
 	const struct submodule *sub = submodule_from_ce(ce);
 	if (sub) {
-		switch (sub->update_strategy.type) {
+		struct submodule_update_strategy update =
+			submodule_strategy_with_config_overlayed(the_repository,
+								 sub);
+		switch (update.type) {
 		case SM_UPDATE_UNSPECIFIED:
 		case SM_UPDATE_CHECKOUT:
 		case SM_UPDATE_REBASE:
-- 
2.14.0.rc0.400.g1c36432dff-goog

