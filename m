Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71FA5208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeHHQLX (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35444 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHHQLW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so1308944edr.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fx4hkZfH1JQQr9jOoRq9vfyP06SdNCsK3DoGdzNS7Tg=;
        b=mJAEopyLvFN5Hj1RqF8yWBfJ46wBrPmFhDVGUadNGGEvD/8ncGWGABTjMQg5YTsgU/
         MvPIx34OZNxV2SJwuALrm7AyjSKNTAP4eymgOHB4U1R7iZ15iKcdwG4CM5FitXBsP8i7
         J8Hg9PpB+/UshxY4z7WKgSQDDimidQzusJ9nnm0R5a6lwzkr9z9nQT4UbAUzLLS7uISq
         XG/lqHFnkr5IkRRVA2JhrS5PM1ZNuniSAhaYg15/eGVE1/wBpYWElIGDCoNYai9r6tth
         d5uET6DiYNXU5QZR5NkxiMAKf2hCek+hO6ThPQyc2o2h75QgeJnNNJYL28wj4DW7DEY/
         Ex2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fx4hkZfH1JQQr9jOoRq9vfyP06SdNCsK3DoGdzNS7Tg=;
        b=hkO0h1+/bJCGi585ijT1L1r+QAzFhaW+lY6YeVX42Hdwa+CULlnI7BwkmUkqLS8Wge
         5Ok0F/KCTuddsklGFDLo9viJonb7lR9iPgfn/P2KfmpjMXW0FSsbM5Nsjp6a0ohnwJEY
         jwmjwsP2I7C3mUffHFEQj5AF3rGDNLjTSDsfep1d4yQEx3dasje7INjUgfvLjyOqZrPw
         ZT1Np8HScfH6R/z6FvzAxiWxurtx/IiVOemCeqxF8WRj2ClsJ3iWg95JC5+38bVA48hH
         rpGF+jnZyaKkKYCgPIaVWGKAg/TgMDr44RLHyjt4FgSeNJwwozWNVSyLzrhwQnVdT+05
         rLSg==
X-Gm-Message-State: AOUpUlGolFD6uj33ftaoA2GyVZLoPR69qVBc9usY4bdtw+tGWwuLhF7z
        hg8LpQ4u9XwQoTceNrDAqPmBhb9n
X-Google-Smtp-Source: AA+uWPx5aZZWartAhJy0BGJMZcE0Qa7ssekAWueo4+mcBtFQ18RYXVFVelwVVltoGb8LiYlwBYeJBQ==
X-Received: by 2002:a50:8345:: with SMTP id 63-v6mr3271280edh.5.1533736295033;
        Wed, 08 Aug 2018 06:51:35 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:34 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 07/11] builtin rebase: try to fast forward when possible
Date:   Wed,  8 Aug 2018 19:33:26 +0545
Message-Id: <20180808134830.19949-8-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this commit, we add support to fast forward.

Note: we will need the merge base later, therefore the call to
can_fast_forward() really needs to be the first one when testing whether
we can skip the rebase entirely (otherwise, it would make more sense to
skip the possibly expensive operation if, say, running an interactive
rebase).

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index afef0b0046..52a218cd18 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -20,6 +20,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "wt-status.h"
+#include "revision.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -89,6 +90,12 @@ struct rebase_options {
 	struct strbuf git_am_opt;
 };
 
+static int is_interactive(struct rebase_options *opts)
+{
+	return opts->type == REBASE_INTERACTIVE ||
+		opts->type == REBASE_PRESERVE_MERGES;
+}
+
 /* Returns the filename prefixed by the state_dir */
 static const char *state_dir_path(const char *filename, struct rebase_options *opts)
 {
@@ -334,6 +341,46 @@ static int rebase_config(const char *var, const char *value, void *data)
 	return git_default_config(var, value, data);
 }
 
+/*
+ * Determines whether the commits in from..to are linear, i.e. contain
+ * no merge commits. This function *expects* `from` to be an ancestor of
+ * `to`.
+ */
+static int is_linear_history(struct commit *from, struct commit *to)
+{
+	while (to && to != from) {
+		parse_commit(to);
+		if (!to->parents)
+			return 1;
+		if (to->parents->next)
+			return 0;
+		to = to->parents->item;
+	}
+	return 1;
+}
+
+static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
+			    struct object_id *merge_base)
+{
+	struct commit *head = lookup_commit(the_repository, head_oid);
+	struct commit_list *merge_bases;
+	int res;
+
+	if (!head)
+		return 0;
+
+	merge_bases = get_merge_bases(onto, head);
+	if (merge_bases && !merge_bases->next) {
+		oidcpy(merge_base, &merge_bases->item->object.oid);
+		res = !oidcmp(merge_base, &onto->object.oid);
+	} else {
+		oidcpy(merge_base, &null_oid);
+		res = 0;
+	}
+	free_commit_list(merge_bases);
+	return res && is_linear_history(onto, head);
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
@@ -489,6 +536,31 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
+	/*
+	 * Now we are rebasing commits upstream..orig_head (or with --root,
+	 * everything leading up to orig_head) on top of onto.
+	 */
+
+	/*
+	 * Check if we are already based on onto with linear history,
+	 * but this should be done only when upstream and onto are the same
+	 * and if this is not an interactive rebase.
+	 */
+	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
+	    !is_interactive(&options) && !options.restrict_revision &&
+	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
+		int flag;
+
+		if (!(options.flags & REBASE_NO_QUIET))
+			; /* be quiet */
+		else if (!strcmp(branch_name, "HEAD") &&
+			resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+			puts(_("HEAD is up to date, rebase forced."));
+		else
+			printf(_("Current branch %s is up to date, rebase "
+				 "forced.\n"), branch_name);
+	}
+
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
 	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
-- 
2.18.0

