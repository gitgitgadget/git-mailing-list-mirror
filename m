Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D223C201A0
	for <e@80x24.org>; Thu, 11 May 2017 22:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756234AbdEKWEl (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 18:04:41 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35099 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdEKWEg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 18:04:36 -0400
Received: by mail-pf0-f177.google.com with SMTP id n23so15183490pfb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=79L0rIdFZdpF1Ggv6A0WsDEhHBOIDW891yqIQgIQNu0=;
        b=dokK8tg+9pZkHMpKxgafnISnahJdCP7gzAeuhVoD2eEAoU5L3wiF/i5Xv72h2gWll4
         5kVcs9pg2VY0tamO2ht8UyREa+ZW0aG7YXaU6lvc7rieVQCvCKmSvCTmBEC1EQiFuqPz
         OXD6brWDbhfU8Wuz7wOtUGsD7wpdW5nPe2qBYKrUTovmy7opnghuZwNr8WeVc4Yuvsfv
         +gfyh3mVYzPOUAb8yptLytoBet1IHgMmMa00S9tKiKTszAOvtcSjH2xh35VdC32avFoH
         e4SwijFLz0S1IqfwoTGMu0zJONJAuf0ThsvYypbtZpUfFVbG5ROvvZSa/f4Iy8tvkHK4
         1zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=79L0rIdFZdpF1Ggv6A0WsDEhHBOIDW891yqIQgIQNu0=;
        b=TuRA/NNpuDnVKl7T9Uqq+6EM8i3zJ//cYAfZT3CEn+ierpg5VX/iBrM/b+eJToB7Iq
         X+t6Nkni3sxzxtWKQ4oI9oKmyAsiyWQxE3R6t+xe2ex2xrdWg8vVlVL/Zt3yvWDVcDpz
         DZ4mFse6dHeLb68da7vT5XzbtZxh9+7iemkM4ZlzUZ9ELvtJTPfuijKwE7tMZdUJHAe+
         Og9hiLIOFvdbm+h47CRAPFjY+AdbPBA8XgSvgyy6HIOBefUL0FarZWAi2cW2474CJ9Op
         ZON1T0QwKC09MOnBkjHhuVecoUjpKki06DIymfHuWD4f5bL2Ty55YwOYi+SQ10dQo2iy
         hMqw==
X-Gm-Message-State: AODbwcAXmIBCxnNoiPvKCaXJR2H4JZeDSrRG+jub5GDP1GMwr0xecYj9
        R5jKVhcj1/MR2Tll
X-Received: by 10.99.66.5 with SMTP id p5mr706795pga.107.1494540275777;
        Thu, 11 May 2017 15:04:35 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s68sm1873335pgc.5.2017.05.11.15.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 15:04:34 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 3/6] pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
Date:   Thu, 11 May 2017 15:04:24 -0700
Message-Id: <20170511220427.192627-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170511220427.192627-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
 <20170511220427.192627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since (ae8d08242 pathspec: pass directory indicator to
match_pathspec_item()) the path matching logic has been able to cope
with submodules without needing to strip off a trailing slash if a path
refers to a submodule.

Since the stripping the trailing slash is no longer necessary, remove
the PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag.  In addition, factor
out the logic which dies if a path decends into a submodule so that it
can still be used as a check after a pathspec struct has been
initialized.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c          |  5 +++--
 builtin/check-ignore.c |  4 +++-
 pathspec.c             | 29 -----------------------------
 pathspec.h             | 14 +++-----------
 submodule.c            | 33 +++++++++++++++++++++++++++++++++
 submodule.h            |  2 ++
 6 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ec58e3679..86770d6af 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -388,10 +388,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	 */
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
-		       PATHSPEC_SYMLINK_LEADING_PATH |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE,
+		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
 
+	die_path_inside_submodule(&the_index, &pathspec);
+
 	if (add_new_files) {
 		int baselen;
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 1d73d3ca3..91040a4b0 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -4,6 +4,7 @@
 #include "quote.h"
 #include "pathspec.h"
 #include "parse-options.h"
+#include "submodule.h"
 
 static int quiet, verbose, stdin_paths, show_non_matching, no_index;
 static const char * const check_ignore_usage[] = {
@@ -87,10 +88,11 @@ static int check_ignore(struct dir_struct *dir,
 	parse_pathspec(&pathspec,
 		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
 		       PATHSPEC_SYMLINK_LEADING_PATH |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE |
 		       PATHSPEC_KEEP_ORDER,
 		       prefix, argv);
 
+	die_path_inside_submodule(&the_index, &pathspec);
+
 	/*
 	 * look for pathspecs matching entries in the index, since these
 	 * should not be ignored, in order to be consistent with
diff --git a/pathspec.c b/pathspec.c
index 9b7634c5a..e42431278 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -398,32 +398,6 @@ static void strip_submodule_slash_cheap(struct pathspec_item *item)
 	}
 }
 
-static void strip_submodule_slash_expensive(struct pathspec_item *item)
-{
-	int i;
-
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		int ce_len = ce_namelen(ce);
-
-		if (!S_ISGITLINK(ce->ce_mode))
-			continue;
-
-		if (item->len <= ce_len || item->match[ce_len] != '/' ||
-		    memcmp(ce->name, item->match, ce_len))
-			continue;
-
-		if (item->len == ce_len + 1) {
-			/* strip trailing slash */
-			item->len--;
-			item->match[item->len] = '\0';
-		} else {
-			die(_("Pathspec '%s' is in submodule '%.*s'"),
-			    item->original, ce_len, ce->name);
-		}
-	}
-}
-
 /*
  * Perform the initialization of a pathspec_item based on a pathspec element.
  */
@@ -499,9 +473,6 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
 		strip_submodule_slash_cheap(item);
 
-	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
-		strip_submodule_slash_expensive(item);
-
 	if (magic & PATHSPEC_LITERAL) {
 		item->nowildcard_len = item->len;
 	} else {
diff --git a/pathspec.h b/pathspec.h
index 55e976972..3729efa85 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -62,23 +62,15 @@ struct pathspec {
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<3)
 /* die if a symlink is part of the given path's directory */
 #define PATHSPEC_SYMLINK_LEADING_PATH (1<<4)
-/*
- * This is like a combination of ..LEADING_PATH and .._SLASH_CHEAP
- * (but not the same): it strips the trailing slash if the given path
- * is a gitlink but also checks and dies if gitlink is part of the
- * leading path (i.e. the given path goes beyond a submodule). It's
- * safer than _SLASH_CHEAP and also more expensive.
- */
-#define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<5)
-#define PATHSPEC_PREFIX_ORIGIN (1<<6)
-#define PATHSPEC_KEEP_ORDER (1<<7)
+#define PATHSPEC_PREFIX_ORIGIN (1<<5)
+#define PATHSPEC_KEEP_ORDER (1<<6)
 /*
  * For the callers that just need pure paths from somewhere else, not
  * from command line. Global --*-pathspecs options are ignored. No
  * magic is parsed in each pathspec either. If PATHSPEC_LITERAL is
  * allowed, then it will automatically set for every pathspec.
  */
-#define PATHSPEC_LITERAL_PATH (1<<8)
+#define PATHSPEC_LITERAL_PATH (1<<7)
 
 extern void parse_pathspec(struct pathspec *pathspec,
 			   unsigned magic_mask,
diff --git a/submodule.c b/submodule.c
index 885663c42..80851d044 100644
--- a/submodule.c
+++ b/submodule.c
@@ -312,6 +312,39 @@ void die_in_unpopulated_submodule(const struct index_state *istate,
 	}
 }
 
+/*
+ * Dies if any paths in the provided pathspec descends into a submodule
+ */
+void die_path_inside_submodule(const struct index_state *istate,
+			       const struct pathspec *ps)
+{
+	int i, j;
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		int ce_len = ce_namelen(ce);
+
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+
+		for (j = 0; j < ps->nr ; j++) {
+			const struct pathspec_item *item = &ps->items[j];
+
+			if (item->len <= ce_len)
+				continue;
+			if (item->match[ce_len] != '/')
+				continue;
+			if (strncmp(ce->name, item->match, ce_len))
+				continue;
+			if (item->len == ce_len + 1)
+				continue;
+
+			die(_("Pathspec '%s' is in submodule '%.*s'"),
+			    item->original, ce_len, ce->name);
+		}
+	}
+}
+
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst)
 {
diff --git a/submodule.h b/submodule.h
index d11b4da40..266d81f1c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -51,6 +51,8 @@ extern int is_submodule_initialized(const char *path);
 extern int is_submodule_populated_gently(const char *path, int *return_error_code);
 extern void die_in_unpopulated_submodule(const struct index_state *istate,
 					 const char *prefix);
+extern void die_path_inside_submodule(const struct index_state *istate,
+				      const struct pathspec *ps);
 extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-- 
2.13.0.rc2.291.g57267f2277-goog

