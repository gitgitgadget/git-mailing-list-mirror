Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34168C7EE22
	for <git@archiver.kernel.org>; Fri, 12 May 2023 00:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbjELAA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 20:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbjELAAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 20:00:38 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9B87ED4
        for <git@vger.kernel.org>; Thu, 11 May 2023 17:00:16 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-394690088acso252335b6e.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 17:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683849593; x=1686441593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGFAddDlxRxMHQSU+wadSFsNIdAoAf84B2phUcVkY0k=;
        b=NfyZVTaJsxlNIs3E+6Hhhj7bSHPWCxPlIAPs/5Ztv3ADkAUmbMZks11WjdwCQzuKWy
         tw4bXt0zkny21g7QcoK11dUTfPmxcVjzLHD+Nb4Tpxg362wXL7f5mBEW2XSaoGbspJr8
         gF8FlGmd/qhmrfbxGTUscOwnKOhJBzZLJmFXUNkzBv/Lv/XEijRWY+gG+9j3zl955s0b
         O4t5fQeT9ay0R57u/tP59K67lDreNRABIzJY8MU51BXltS5htukuPOrE9vs8cdfZMos+
         DQ0YWvVLhCTtAjWTmeSiyP6t14uPiXkNSKLziP+HaklK/Lt65EJG/gEQHilYX3+U77ah
         j7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683849593; x=1686441593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGFAddDlxRxMHQSU+wadSFsNIdAoAf84B2phUcVkY0k=;
        b=jg1jJSW4ocwRsAcWYwGmDp4KJl02/G8yAzP4WfXbaH7hyY0jdNvY8JQpelcsCbJFv2
         VrjnJy41G284t3dOYLgmnnWDq70KbHKTjTXLyRNFPFCIv2l5d6lRHHshxV3tk06dHfFD
         2REZoAIJnfrlWCdlkAisEqbHxvm/u1yyw4eYxr2shx7GmWiMYGxLuBllxh6ZPhoj/GXw
         c10Y/W2hR3A7ewzISwva7Ph9Q4AP0janlFG3CtCMrJwA7//zGFl2u85ObYEpQYQXr2N7
         jWajTEjhOcBFkPoSDX1z9tBDurXrXFEgyPHUfX7IY9YmLjK3WmT7B3UNeOJNiNzgZ8a5
         o9KQ==
X-Gm-Message-State: AC+VfDx3XRXQsq9IDMb/N+f69lR5Lp3qdcDlmTN1YsZesUGo07o7EoO0
        HHoP7ME7ZSLUqmNWNJ9UNHYYSUdEuO0=
X-Google-Smtp-Source: ACHHUZ65JfcUzNec8SFS/6T3hnP+nGJjdYptvbayAi38jL7/cIzrSGBBhaAwwi6Dr2X2CYA9DxMHVA==
X-Received: by 2002:a54:4194:0:b0:390:9226:2c75 with SMTP id 20-20020a544194000000b0039092262c75mr6038975oiy.55.1683849592882;
        Thu, 11 May 2023 16:59:52 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r81-20020acaf354000000b0038ee0c3b38esm3894103oih.44.2023.05.11.16.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:59:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Fix merge_recursive_config()
Date:   Thu, 11 May 2023 17:59:51 -0600
Message-Id: <20230511235951.2309462-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The configuration shouldn't be loaded whenever, it should be loaded
*before* command options are parsed, so the code has the opportunity to
override the configuration.

merge_recursive_config() erroneously calls git_xmerge_config() directly,
overriding any previous options, for example `--confligt=diff3`.

To do this properly git_xmerge_config is explicitly called at the top
level of all the commands that call merge_recursive_config() directly or
indirectly.

Some commands already do this, for example `git checkout`, others
probably don't need it, like `git bisect` or `git diff-tree`. For the
rest it's added.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/am.c              | 3 ++-
 builtin/log.c             | 5 +++++
 builtin/merge-recursive.c | 3 +++
 builtin/merge-tree.c      | 4 ++++
 builtin/merge.c           | 4 ++++
 builtin/stash.c           | 5 +++++
 merge-recursive.c         | 1 -
 sequencer.c               | 4 ++++
 8 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5c83f2e003..9d56b434d9 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -44,6 +44,7 @@
 #include "repository.h"
 #include "pretty.h"
 #include "wrapper.h"
+#include "xdiff-interface.h"
 
 /**
  * Returns the length of the first line of msg.
@@ -2433,7 +2434,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage, options);
 
-	git_config(git_default_config, NULL);
+	git_config(git_xmerge_config, NULL);
 
 	am_state_init(&state);
 
diff --git a/builtin/log.c b/builtin/log.c
index 676de107d6..50cb422494 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -46,6 +46,7 @@
 #include "tmp-objdir.h"
 #include "tree.h"
 #include "write-or-die.h"
+#include "xdiff-interface.h"
 
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
@@ -567,6 +568,7 @@ static int cmd_log_walk(struct rev_info *rev)
 static int git_log_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
+	int status;
 
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
@@ -613,6 +615,9 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	status = git_xmerge_config(var, value, NULL);
+	if (status)
+		return status;
 	return git_diff_ui_config(var, value, cb);
 }
 
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index b9e980384a..2bcc354788 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -9,6 +9,7 @@
 #include "object-name.h"
 #include "repository.h"
 #include "xdiff-interface.h"
+#include "config.h"
 
 static const char builtin_merge_recursive_usage[] =
 	"git %s <base>... -- <head> <remote> ...";
@@ -35,6 +36,8 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix UNUSED)
 	char *better1, *better2;
 	struct commit *result;
 
+	git_config(git_xmerge_config, NULL);
+
 	init_merge_options(&o, the_repository);
 	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index aa8040c2a6..59b0323640 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -17,6 +17,8 @@
 #include "merge-blobs.h"
 #include "quote.h"
 #include "tree.h"
+#include "config.h"
+#include "xdiff-interface.h"
 
 static int line_termination = '\n';
 
@@ -548,6 +550,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	git_config(git_xmerge_config, NULL);
+
 	/* Parse arguments */
 	original_argc = argc - 1; /* ignoring argv[0] */
 	argc = parse_options(argc, argv, prefix, mt_options,
diff --git a/builtin/merge.c b/builtin/merge.c
index 8da3e46abb..0c41e89c60 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -53,6 +53,7 @@
 #include "wt-status.h"
 #include "commit-graph.h"
 #include "wrapper.h"
+#include "xdiff-interface.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -669,6 +670,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
+	if (status)
+		return status;
+	status = git_xmerge_config(k, v, NULL);
 	if (status)
 		return status;
 	return git_diff_ui_config(k, v, cb);
diff --git a/builtin/stash.c b/builtin/stash.c
index a7e17ffe38..355ea1034c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -25,6 +25,7 @@
 #include "exec-cmd.h"
 #include "reflog.h"
 #include "add-interactive.h"
+#include "xdiff-interface.h"
 
 #define INCLUDE_ALL_FILES 2
 
@@ -839,6 +840,7 @@ static int show_include_untracked;
 
 static int git_stash_config(const char *var, const char *value, void *cb)
 {
+	int status;
 	if (!strcmp(var, "stash.showstat")) {
 		show_stat = git_config_bool(var, value);
 		return 0;
@@ -851,6 +853,9 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 		show_include_untracked = git_config_bool(var, value);
 		return 0;
 	}
+	status = git_xmerge_config(var, value, NULL);
+	if (status)
+		return status;
 	return git_diff_basic_config(var, value, cb);
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 8e87b6386d..226603f7f8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3881,7 +3881,6 @@ static void merge_recursive_config(struct merge_options *opt)
 		} /* avoid erroring on values from future versions of git */
 		free(value);
 	}
-	git_config(git_xmerge_config, NULL);
 }
 
 void init_merge_options(struct merge_options *opt,
diff --git a/sequencer.c b/sequencer.c
index b553b49fbb..22c8530649 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -47,6 +47,7 @@
 #include "reset.h"
 #include "branch.h"
 #include "wrapper.h"
+#include "xdiff-interface.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -274,6 +275,9 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 	if (opts->action == REPLAY_REVERT && !strcmp(k, "revert.reference"))
 		opts->commit_use_reference = git_config_bool(k, v);
 
+	status = git_xmerge_config(k, v, NULL);
+	if (status)
+		return status;
 	return git_diff_basic_config(k, v, NULL);
 }
 
-- 
2.40.0+fc1

