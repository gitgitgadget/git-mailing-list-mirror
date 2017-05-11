Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5945B201A0
	for <e@80x24.org>; Thu, 11 May 2017 22:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756627AbdEKWEt (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 18:04:49 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36569 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755470AbdEKWEj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 18:04:39 -0400
Received: by mail-pg0-f50.google.com with SMTP id x64so1343615pgd.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 15:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lIn8eTN8Lo+MCtMjDof1rEKLxHH6dR1fBNRKBlbKrHI=;
        b=GwPlXBRUKhuXqHIOOW1ECAoC92Ea1VGgrYGQvxZf4abfa3x+4i9N2yGJJbuyPnCCQL
         PNUbI3+fZ9XACoLLcS9IggVWTo828rhh/TwgZ7UwoaV4AjFpes6lJX2afApkp7mWh1FW
         rO/g1oG+XiCzc5QImdGd/y/wkymcbiSwFgDSJE7DKvcF9P78BM/IikAj/NxJ1MZ2w7/D
         1ze+05Z4RhblHq4ChCLpElXcF50s4LqtVDm7LQGUnWiAYqLOUkB4C1wE7MEt+HwXHJm0
         B0xpsbmDQ+UTnIxROeQlBeuFQAWXFSfH1Z2KAIAXe9ZUfUVwea7Lvy2krYM6KlUqmCnY
         /BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lIn8eTN8Lo+MCtMjDof1rEKLxHH6dR1fBNRKBlbKrHI=;
        b=GF8NIKcnVAvupRaIf3moIrfvaWXdaY+T1hY1tMZQ5ha5yuYuoaJuDBERFOttXohvP2
         FyFMPb0Kf3KPHXW0IbuNkC0enWIE19NjVnD0vVK872w9hUfu7wWtd0L0EDebP7LHttkM
         ak1pz9hivRZBSUjbcByTWk4NnUOmWzqyDSCQQ2KAlEzmJeQdB9ZvffN29ujQ1YOxr0Ug
         1+4gbxQPrD/Ce7xuGVX7V0N10S20ta56CGlzWg+buYPTpIhqLmrMT39AukPyNbandk7J
         1bzAa+66vh7r+iAYnXby34rZ3H7FEpvs8Qlm3kfb/jqPBw2BVx6JQ/rsqD74ahe3FqLR
         qF8w==
X-Gm-Message-State: AODbwcCMARGfMOqY9OocfLJDe6hcoJEK97H8/EsREAF+0b83/ObbN2GN
        PDsO9xlxXl047UE5
X-Received: by 10.99.6.2 with SMTP id 2mr735871pgg.122.1494540278688;
        Thu, 11 May 2017 15:04:38 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s68sm1873335pgc.5.2017.05.11.15.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 15:04:37 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 5/6] pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
Date:   Thu, 11 May 2017 15:04:26 -0700
Message-Id: <20170511220427.192627-6-bmwill@google.com>
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

Since stripping the slash is no longer necessary, remove the
PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/reset.c             |  1 -
 builtin/rm.c                |  3 +--
 builtin/submodule--helper.c |  3 +--
 pathspec.c                  | 15 ---------------
 pathspec.h                  | 10 ++++------
 5 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index fc3b906c4..5db2adc4c 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -236,7 +236,6 @@ static void parse_args(struct pathspec *pathspec,
 
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
 		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
 		       prefix, argv);
 }
diff --git a/builtin/rm.c b/builtin/rm.c
index fb79dcab1..7c323d012 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -271,8 +271,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		die(_("index file corrupt"));
 
 	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       PATHSPEC_PREFER_CWD,
 		       prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 566a5b6a6..8cc648d85 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -233,8 +233,7 @@ static int module_list_compute(int argc, const char **argv,
 	int i, result = 0;
 	char *ps_matched = NULL;
 	parse_pathspec(pathspec, 0,
-		       PATHSPEC_PREFER_FULL |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
 	if (pathspec->nr)
diff --git a/pathspec.c b/pathspec.c
index e42431278..1e5df2316 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -386,18 +386,6 @@ static const char *parse_element_magic(unsigned *magic, int *prefix_len,
 		return parse_short_magic(magic, elem);
 }
 
-static void strip_submodule_slash_cheap(struct pathspec_item *item)
-{
-	if (item->len >= 1 && item->match[item->len - 1] == '/') {
-		int i = cache_name_pos(item->match, item->len - 1);
-
-		if (i >= 0 && S_ISGITLINK(active_cache[i]->ce_mode)) {
-			item->len--;
-			item->match[item->len] = '\0';
-		}
-	}
-}
-
 /*
  * Perform the initialization of a pathspec_item based on a pathspec element.
  */
@@ -470,9 +458,6 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		item->original = xstrdup(elt);
 	}
 
-	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
-		strip_submodule_slash_cheap(item);
-
 	if (magic & PATHSPEC_LITERAL) {
 		item->nowildcard_len = item->len;
 	} else {
diff --git a/pathspec.h b/pathspec.h
index 3729efa85..6671b9577 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -58,19 +58,17 @@ struct pathspec {
 #define PATHSPEC_PREFER_CWD (1<<0) /* No args means match cwd */
 #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everything */
 #define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid */
-/* strip the trailing slash if the given path is a gitlink */
-#define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<3)
 /* die if a symlink is part of the given path's directory */
-#define PATHSPEC_SYMLINK_LEADING_PATH (1<<4)
-#define PATHSPEC_PREFIX_ORIGIN (1<<5)
-#define PATHSPEC_KEEP_ORDER (1<<6)
+#define PATHSPEC_SYMLINK_LEADING_PATH (1<<3)
+#define PATHSPEC_PREFIX_ORIGIN (1<<4)
+#define PATHSPEC_KEEP_ORDER (1<<5)
 /*
  * For the callers that just need pure paths from somewhere else, not
  * from command line. Global --*-pathspecs options are ignored. No
  * magic is parsed in each pathspec either. If PATHSPEC_LITERAL is
  * allowed, then it will automatically set for every pathspec.
  */
-#define PATHSPEC_LITERAL_PATH (1<<7)
+#define PATHSPEC_LITERAL_PATH (1<<6)
 
 extern void parse_pathspec(struct pathspec *pathspec,
 			   unsigned magic_mask,
-- 
2.13.0.rc2.291.g57267f2277-goog

