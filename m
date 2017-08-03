Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E63A1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdHCSUW (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:22 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34658 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdHCSUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:20 -0400
Received: by mail-pg0-f49.google.com with SMTP id u185so9326646pgb.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PxJtNEapzflt7EqWmxUF1gB7i+Afw+MT9p0++41Wop4=;
        b=dToii3MmXed6aBe7W7RbgkjXLPM0WXyY1ljwU6NOcuD3JHz7tj7I+2TC+wFs8dkxcG
         PDeVHhOjZm7npbPs92I9m2rKEOzmDMHteXkGC/b9RsjNAEjPtoFvzjArDLk8H3j7T7WZ
         0WTVUmi25ElkGXI449gU605lA9MnM/7U5rhWXNep8U14jMkVTGXVbjfejO9pRXPxl7P+
         Vf0jPOzGos+wTBs3mM3ZcXVm2cbdPxJE99vrCbW98ZEy4xxBx9QqCJKOZkUAuvtqlJMe
         iaXbSg9X1mDB3pbfYtYYvxBJnDkhiUQi5oWvccaxsEESFozk3GgFuoPTRlrcnQ6Fzkk/
         J7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PxJtNEapzflt7EqWmxUF1gB7i+Afw+MT9p0++41Wop4=;
        b=POAnQxCbDioJQgt0E54jNCM6ygTJ1BWiVOHASUpWA24o8cQyY5DjnJWm00GQhfQwDu
         EwS2D+7SprXLR4GwQP1GRSeF+nrrqLfyzN0I60MDAEXL8jEbRm3KVOURcEYFmFBSZ+mI
         DFBAXm8/tJbAr15GIVBl258OVIm1+fH5cFWVSdbrgLF2N4Vngi+hU12degR8J7vgn9xU
         iNZ6I456o2dKX9x3MzLMMnIU+JvkRgyvG1fJE6I888yHehj/6++nL5/01JcDkyunMp/6
         yqfPKBNMteZT0l+/TPveQJWsjSUwSXRezOX6PoisM0d5hJjTityUTrnYYS863MedLN1s
         dUFw==
X-Gm-Message-State: AIVw112AAXP87cc4wMXd4I/s2x6y+sIMD3N1ZfvOiEt0YR6B6chCBcdf
        XcmlSKS4gaQw+/EC8tDYnQ==
X-Received: by 10.98.59.82 with SMTP id i79mr2513237pfa.37.1501784419371;
        Thu, 03 Aug 2017 11:20:19 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 08/15] unpack-trees: don't respect submodule.update
Date:   Thu,  3 Aug 2017 11:19:53 -0700
Message-Id: <20170803182000.179328-9-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'submodule.update' config was historically used and respected by the
'submodule update' command because update handled a variety of different
ways it updated a submodule.  As we begin teaching other commands about
submodules it makes more sense for the different settings of
'submodule.update' to be handled by the individual commands themselves
(checkout, rebase, merge, etc) so it shouldn't be respected by the
native checkout command.

Also remove the overlaying of the repository's config (via using
'submodule_config()') from the commands which use the unpack-trees
logic (checkout, read-tree, reset).

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/checkout.c |  2 +-
 submodule.c        |  1 -
 unpack-trees.c     | 38 ++++++++------------------------------
 3 files changed, 9 insertions(+), 32 deletions(-)

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
index a32043893..f913c2341 100644
--- a/submodule.c
+++ b/submodule.c
@@ -235,7 +235,6 @@ void load_submodule_cache(void)
 		return;
 
 	gitmodules_config();
-	git_config(submodule_config, NULL);
 }
 
 static int gitmodules_cb(const char *var, const char *value, void *data)
diff --git a/unpack-trees.c b/unpack-trees.c
index 05335fe5b..5dce7ff7d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -255,28 +255,17 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 {
 	unsigned flags = SUBMODULE_MOVE_HEAD_DRY_RUN;
 	const struct submodule *sub = submodule_from_ce(ce);
+
 	if (!sub)
 		return 0;
 
 	if (o->reset)
 		flags |= SUBMODULE_MOVE_HEAD_FORCE;
 
-	switch (sub->update_strategy.type) {
-	case SM_UPDATE_UNSPECIFIED:
-	case SM_UPDATE_CHECKOUT:
-		if (submodule_move_head(ce->name, old_id, new_id, flags))
-			return o->gently ? -1 :
-				add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
-		return 0;
-	case SM_UPDATE_NONE:
-		return 0;
-	case SM_UPDATE_REBASE:
-	case SM_UPDATE_MERGE:
-	case SM_UPDATE_COMMAND:
-	default:
-		warning(_("submodule update strategy not supported for submodule '%s'"), ce->name);
-		return -1;
-	}
+	if (submodule_move_head(ce->name, old_id, new_id, flags))
+		return o->gently ? -1 :
+				   add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
+	return 0;
 }
 
 static void reload_gitmodules_file(struct index_state *index,
@@ -293,7 +282,6 @@ static void reload_gitmodules_file(struct index_state *index,
 				submodule_free();
 				checkout_entry(ce, state, NULL);
 				gitmodules_config();
-				git_config(submodule_config, NULL);
 			} else
 				break;
 		}
@@ -308,19 +296,9 @@ static void unlink_entry(const struct cache_entry *ce)
 {
 	const struct submodule *sub = submodule_from_ce(ce);
 	if (sub) {
-		switch (sub->update_strategy.type) {
-		case SM_UPDATE_UNSPECIFIED:
-		case SM_UPDATE_CHECKOUT:
-		case SM_UPDATE_REBASE:
-		case SM_UPDATE_MERGE:
-			/* state.force is set at the caller. */
-			submodule_move_head(ce->name, "HEAD", NULL,
-					    SUBMODULE_MOVE_HEAD_FORCE);
-			break;
-		case SM_UPDATE_NONE:
-		case SM_UPDATE_COMMAND:
-			return; /* Do not touch the submodule. */
-		}
+		/* state.force is set at the caller. */
+		submodule_move_head(ce->name, "HEAD", NULL,
+				    SUBMODULE_MOVE_HEAD_FORCE);
 	}
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
 		return;
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

