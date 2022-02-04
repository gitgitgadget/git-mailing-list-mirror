Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6129C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbiBDVVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbiBDVVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:21:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9DBC06173D
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 13:21:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id h125so75372wmh.1
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 13:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VN22oQbZbH3ffCASLix+KIA464ouTp81Bu6OboYKdcE=;
        b=PrEXlNkQKy2ALaA8FfTMePWgcY8gTSRiLvNFQyjTNYZX9sPhuAc0LatcffA7obb3TN
         DXqaEFCAtES7UC9PbwTQVEOeSvGQbrzI6o8RbSQAyKsirmXN/G+mfxbG25PHO1Bs0TJV
         L9YqBP8RuZl2dAPKiMTDyjW4heM630931eHgOgjDjdqclOBpGVO7aaUgU3UccR2vXNJo
         DF9sp3yxYaSV0S1RnDCVhxNzpL3tqOyuNgfDr6Ov8VT5dzMEKH965+XXXdji27em5P5j
         xXdZ4MSp5ksZv3qI3SkXh568EBbsYHMBqmM2Bq1i8kBmfJ03jt4d/nE/gCJ2GJQpVAO/
         ijQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VN22oQbZbH3ffCASLix+KIA464ouTp81Bu6OboYKdcE=;
        b=fldnnLx2QkQnAgGBWnVKiwcibrs+MVHpD9B25yRrEM0Q+CWW9Y87raYFEgzp/LWiOm
         rMxdU4jIf2cNZ6RwkKABkitpFD2m13qzyZfTuilbp++OYlXVaOF9y5UcFus4iPxF0AP2
         9O+Ms2Y9wZ3xbSWr5GzYgoNoaTPvxGN/NjcWVk5FTsl8YETs1ovW9uaCDBp8BdOb46B9
         MgRPUJYs24/5MhHqI/Q8scVecZNFiLlOtPqOnLu6zIa/6XJpIns8gLs/wg86fqRXVyrF
         /x0ldHS5gBGt8RRk/nbGRbBdHtgbvyMgdUASPukvv4IFk/B7Ylo1bcIu+N7prRym7Bd8
         U4wQ==
X-Gm-Message-State: AOAM530OxD9OS/awZlFKYXHIkU0wHDMPg1b7ifqDejZ/+yK0rMpFshwX
        7ClsMfX7m3mP87VcwD5Ger3jCFzPiG1dAA==
X-Google-Smtp-Source: ABdhPJxhc+YyAgZO86gCL3vNbwcauEFURjfV4zomlv2AvcDIPgT9YzQ/igTKN82SduywTgEY8CWKEQ==
X-Received: by 2002:a05:600c:1ca2:: with SMTP id k34mr480152wms.171.1644009658326;
        Fri, 04 Feb 2022 13:20:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o21sm2321598wmh.36.2022.02.04.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:20:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 4/9] built-ins: trust the "prefix" from run_builtin()
Date:   Fri,  4 Feb 2022 22:20:46 +0100
Message-Id: <patch-v10-4.9-c6ada96298a-20220204T211534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com> <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code in "builtin/grep.c" and "builtin/ls-tree.c" to trust the
"prefix" passed from "run_builtin()". The "prefix" we get from setup.c
is either going to be NULL or a string of length >0, never "".

So we can drop the "prefix && *prefix" checks added for
"builtin/grep.c" in 0d042fecf2f (git-grep: show pathnames relative to
the current directory, 2006-08-11), and for "builtin/ls-tree.c" in
a69dd585fca (ls-tree: chomp leading directories when run from a
subdirectory, 2005-12-23).

As seen in code in revision.c that was added in cd676a51367 (diff
--relative: output paths as relative to the current subdirectory,
2008-02-12) we already have existing code that does away with this
assertion.

This makes it easier to reason about a subsequent change to the
"prefix_length" code in grep.c in a subsequent commit, and since we're
going to the trouble of doing that let's leave behind an assert() to
promise this to any future callers.

For "builtin/grep.c" it would be painful to pass the "prefix" down the
callchain of:

    cmd_grep -> grep_tree -> grep_submodule -> grep_cache -> grep_oid ->
    grep_source_name

So for the code that needs it in grep_source_name() let's add a
"grep_prefix" variable similar to the existing "ls_tree_prefix".

While at it let's move the code in cmd_ls_tree() around so that we
assign to the "ls_tree_prefix" right after declaring the variables,
and stop assigning to "prefix". We only subsequently used that
variable later in the function after clobbering it. Let's just use our
own "grep_prefix" instead.

Let's also add an assert() in git.c, so that we'll make this promise
about the "prefix" to any current and future callers, as well as to
any readers of the code.

Code history:

 * The strlen() in "grep.c" hasn't been used since 493b7a08d80 (grep:
   accept relative paths outside current working directory, 2009-09-05).

   When that code was added in 0d042fecf2f (git-grep: show pathnames
   relative to the current directory, 2006-08-11) we used the length.

   But since 493b7a08d80 we haven't used it for anything except a
   boolean check that we could have done on the "prefix" member
   itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c    | 13 ++++++++-----
 builtin/ls-tree.c |  2 +-
 git.c             |  1 +
 grep.c            |  4 +---
 grep.h            |  4 +---
 revision.c        |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9e34a820ad4..d85cbabea67 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -26,6 +26,8 @@
 #include "object-store.h"
 #include "packfile.h"
 
+static const char *grep_prefix;
+
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
 	NULL
@@ -315,11 +317,11 @@ static void grep_source_name(struct grep_opt *opt, const char *filename,
 	strbuf_reset(out);
 
 	if (opt->null_following_name) {
-		if (opt->relative && opt->prefix_length) {
+		if (opt->relative && grep_prefix) {
 			struct strbuf rel_buf = STRBUF_INIT;
 			const char *rel_name =
 				relative_path(filename + tree_name_len,
-					      opt->prefix, &rel_buf);
+					      grep_prefix, &rel_buf);
 
 			if (tree_name_len)
 				strbuf_add(out, filename, tree_name_len);
@@ -332,8 +334,8 @@ static void grep_source_name(struct grep_opt *opt, const char *filename,
 		return;
 	}
 
-	if (opt->relative && opt->prefix_length)
-		quote_path(filename + tree_name_len, opt->prefix, out, 0);
+	if (opt->relative && grep_prefix)
+		quote_path(filename + tree_name_len, grep_prefix, out, 0);
 	else
 		quote_c_style(filename + tree_name_len, out, NULL, 0);
 
@@ -962,9 +964,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
+	grep_prefix = prefix;
 
 	git_config(grep_cmd_config, NULL);
-	grep_init(&opt, the_repository, prefix);
+	grep_init(&opt, the_repository);
 
 	/*
 	 * If there is no -- then the paths must exist in the working
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c71..6cb554cbb0a 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -150,7 +150,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	ls_tree_prefix = prefix;
-	if (prefix && *prefix)
+	if (prefix)
 		chomp_prefix = strlen(prefix);
 
 	argc = parse_options(argc, argv, prefix, ls_tree_options,
diff --git a/git.c b/git.c
index edda922ce6d..9d257e092da 100644
--- a/git.c
+++ b/git.c
@@ -436,6 +436,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	} else {
 		prefix = NULL;
 	}
+	assert(!prefix || *prefix);
 	precompose_argv_prefix(argc, argv, NULL);
 	if (use_pager == -1 && run_setup &&
 		!(p->option & DELAY_PAGER_CONFIG))
diff --git a/grep.c b/grep.c
index 7bb0360869a..8421dc55486 100644
--- a/grep.c
+++ b/grep.c
@@ -139,13 +139,11 @@ int grep_config(const char *var, const char *value, void *cb)
  * default values from the template we read the configuration
  * information in an earlier call to git_config(grep_config).
  */
-void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
+void grep_init(struct grep_opt *opt, struct repository *repo)
 {
 	*opt = grep_defaults;
 
 	opt->repo = repo;
-	opt->prefix = prefix;
-	opt->prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
 	opt->pattern_tail = &opt->pattern_list;
 	opt->header_tail = &opt->header_list;
 }
diff --git a/grep.h b/grep.h
index 400172676a1..23a2a41d2c4 100644
--- a/grep.h
+++ b/grep.h
@@ -134,8 +134,6 @@ struct grep_opt {
 	 */
 	struct repository *repo;
 
-	const char *prefix;
-	int prefix_length;
 	int linenum;
 	int columnnum;
 	int invert;
@@ -182,7 +180,7 @@ struct grep_opt {
 };
 
 int grep_config(const char *var, const char *value, void *);
-void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
+void grep_init(struct grep_opt *, struct repository *repo);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
diff --git a/revision.c b/revision.c
index ad4286fbdde..d6e0e2b23b5 100644
--- a/revision.c
+++ b/revision.c
@@ -1838,7 +1838,7 @@ void repo_init_revisions(struct repository *r,
 	revs->commit_format = CMIT_FMT_DEFAULT;
 	revs->expand_tabs_in_log_default = 8;
 
-	grep_init(&revs->grep_filter, revs->repo, prefix);
+	grep_init(&revs->grep_filter, revs->repo);
 	revs->grep_filter.status_only = 1;
 
 	repo_diff_setup(revs->repo, &revs->diffopt);
-- 
2.35.1.940.ge7a5b4b05f2

