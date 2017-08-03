Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371381F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdHCSUS (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:18 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34640 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbdHCSUP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:15 -0400
Received: by mail-pg0-f54.google.com with SMTP id u185so9325785pgb.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3alwUgH5spuX3NXEIu/YaOF83gncu2J9UVKVqwfN8/o=;
        b=tpQJeOSs9o4VLtr9Jt6jV0hHjBx6koTlXOdiPuM/+DkVo/1qJr3ipgD4TSI4O7s04Y
         Wh1H0uhau9wKiZx/tNufH4qt8iwz8FATkcT3H6Hus2937SyeCtO22xDQkUPjGWFhzH+5
         dFfGhz6tCXnjXnKCyLvgoSqAXdwp/ROSKxN60uGVwP6lhfbyFE32JMGO9PrlZCc7XhI7
         Z2uCfrbzUkvP/BooTyXZCAAgFUAVPSmVRCFTlJZidLaQxetsBUyjZL41HPqUB5IPqGbJ
         wYz0U2aPF0TjULSY35qZbckrWdZiEZdzyZBTFLlIYF4I9wguOtDjpk1umwzCZhwKTVu0
         9t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3alwUgH5spuX3NXEIu/YaOF83gncu2J9UVKVqwfN8/o=;
        b=byNwZsNQzZ/iegLNr5wADH8wUYyJ6JfNBJInn+Mj3RHqUkhr1opK8wox4KGQprMXrJ
         Ps3X3yjI4WVCxnqFVQ8WJJp1BTxNNrlM1hiVvsdHGWVcSnmJkhqxAh6inum4w+yKnwgB
         NwPa63qMoaLy/2N5TPy3B1S+QmHlVoX+7SkllTa49f2yyvZCnh8vysj1qfFy6VA2bEGB
         XDzU7d6u8brZ83jMvqBR86zU1aTEkVtC7Vy77h7Ye7V8o2ZG9NtWjzk8thOariNkTtOF
         S/BojztLD8ajIjyFohxmsqFg4M+E/EKZqRUGsovJk6s7cTamS8sskEVRTXyrfkF6OV5W
         qGsA==
X-Gm-Message-State: AIVw113aaP0t0wDFdIy9dIYqq+mBcOJZxlO1KzJ8fSYu3nyDsVC4D6WK
        z7lBX9Ye9cVsfK1bblwF+A==
X-Received: by 10.84.171.195 with SMTP id l61mr2958313plb.464.1501784414501;
        Thu, 03 Aug 2017 11:20:14 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 05/15] submodule--helper: don't overlay config in update-clone
Date:   Thu,  3 Aug 2017 11:19:50 -0700
Message-Id: <20170803182000.179328-6-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't rely on overlaying the repository's config on top of the
submodule-config, instead query the repository's config directly for the
url and the update strategy configuration.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c | 23 +++++++++++++++++++----
 submodule.c                 | 38 ++++++++++++++++++++++++++------------
 submodule.h                 |  1 +
 3 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f71f4270d..36df7ab78 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -780,6 +780,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 					   struct strbuf *out)
 {
 	const struct submodule *sub = NULL;
+	const char *url = NULL;
+	const char *update_string;
+	enum submodule_update_type update_type;
+	char *key;
 	struct strbuf displaypath_sb = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	const char *displaypath = NULL;
@@ -808,9 +812,17 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		goto cleanup;
 	}
 
+	key = xstrfmt("submodule.%s.update", sub->name);
+	if (!repo_config_get_string_const(the_repository, key, &update_string)) {
+		update_type = parse_submodule_update_type(update_string);
+	} else {
+		update_type = sub->update_strategy.type;
+	}
+	free(key);
+
 	if (suc->update.type == SM_UPDATE_NONE
 	    || (suc->update.type == SM_UPDATE_UNSPECIFIED
-		&& sub->update_strategy.type == SM_UPDATE_NONE)) {
+		&& update_type == SM_UPDATE_NONE)) {
 		strbuf_addf(out, _("Skipping submodule '%s'"), displaypath);
 		strbuf_addch(out, '\n');
 		goto cleanup;
@@ -822,6 +834,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		goto cleanup;
 	}
 
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "submodule.%s.url", sub->name);
+	if (repo_config_get_string_const(the_repository, sb.buf, &url))
+		url = sub->url;
+
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/.git", ce->name);
 	needs_cloning = !file_exists(sb.buf);
@@ -851,7 +868,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, "--depth=1");
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
-	argv_array_pushl(&child->args, "--url", sub->url, NULL);
+	argv_array_pushl(&child->args, "--url", url, NULL);
 	if (suc->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &suc->references)
@@ -1025,9 +1042,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	/* Overlay the parsed .gitmodules file with .git/config */
 	gitmodules_config();
-	git_config(submodule_config, NULL);
 
 	run_processes_parallel(max_jobs,
 			       update_clone_get_next_task,
diff --git a/submodule.c b/submodule.c
index 19bd13bb2..8a9b964ce 100644
--- a/submodule.c
+++ b/submodule.c
@@ -398,24 +398,38 @@ void die_path_inside_submodule(const struct index_state *istate,
 	}
 }
 
-int parse_submodule_update_strategy(const char *value,
-		struct submodule_update_strategy *dst)
+enum submodule_update_type parse_submodule_update_type(const char *value)
 {
-	free((void*)dst->command);
-	dst->command = NULL;
 	if (!strcmp(value, "none"))
-		dst->type = SM_UPDATE_NONE;
+		return SM_UPDATE_NONE;
 	else if (!strcmp(value, "checkout"))
-		dst->type = SM_UPDATE_CHECKOUT;
+		return SM_UPDATE_CHECKOUT;
 	else if (!strcmp(value, "rebase"))
-		dst->type = SM_UPDATE_REBASE;
+		return SM_UPDATE_REBASE;
 	else if (!strcmp(value, "merge"))
-		dst->type = SM_UPDATE_MERGE;
-	else if (skip_prefix(value, "!", &value)) {
-		dst->type = SM_UPDATE_COMMAND;
-		dst->command = xstrdup(value);
-	} else
+		return SM_UPDATE_MERGE;
+	else if (*value == '!')
+		return SM_UPDATE_COMMAND;
+	else
+		return SM_UPDATE_UNSPECIFIED;
+}
+
+int parse_submodule_update_strategy(const char *value,
+		struct submodule_update_strategy *dst)
+{
+	enum submodule_update_type type;
+
+	free((void*)dst->command);
+	dst->command = NULL;
+
+	type = parse_submodule_update_type(value);
+	if (type == SM_UPDATE_UNSPECIFIED)
 		return -1;
+
+	dst->type = type;
+	if (type == SM_UPDATE_COMMAND)
+		dst->command = xstrdup(value + 1);
+
 	return 0;
 }
 
diff --git a/submodule.h b/submodule.h
index e402b004f..48586efe7 100644
--- a/submodule.h
+++ b/submodule.h
@@ -62,6 +62,7 @@ extern void die_in_unpopulated_submodule(const struct index_state *istate,
 					 const char *prefix);
 extern void die_path_inside_submodule(const struct index_state *istate,
 				      const struct pathspec *ps);
+extern enum submodule_update_type parse_submodule_update_type(const char *value);
 extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

