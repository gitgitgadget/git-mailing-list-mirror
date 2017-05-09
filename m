Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDE31FDEA
	for <e@80x24.org>; Tue,  9 May 2017 19:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbdEITSj (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:18:39 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:32919 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754560AbdEITSg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:18:36 -0400
Received: by mail-pg0-f53.google.com with SMTP id u187so4412098pgb.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3V0t8m0WhgaqO1AcLVSQLrU6m4M7iA+ozSf02Bu7GDw=;
        b=Q4V2HqQ0Xod//fnblwXylU6yjSH7yC1TiD+a6SixygUstB7LjhK4R8zmDJB+qiJkXu
         f+DMeH/XDunx3mYoXVKnIWNNoStC3H25q1HCiitQsTATHDf5VM3D4xQoO6fQYqmK9Cpv
         XACbYhN9tlWiQckJjPM1euujsakki5SKMC/unlWwlSs5/J+d03lPY8nB9xQ2rAHZPj9G
         OopAXMkIzOlNyV2Ucra8R6Pd6Ss+QD1IRogIzJr8Ql61d/BTBtdcSldNrqrYMWG/Mqun
         hss9BJhnU6T8QiMuk+Xy1R8bEUx8WKeR7QOxBfi+/NYKsyMwW8/ebmibDMEyXkI9yaKv
         mxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3V0t8m0WhgaqO1AcLVSQLrU6m4M7iA+ozSf02Bu7GDw=;
        b=OVaJOESaC1ObaIKDTlXLuNecTQvdbriIeDfawWqooykjmHgCRsqkg8oKgkr89Ex41k
         BL6kHdWHd1DVhA4dAQ6gyMaH2yC9p1CfQa8qtH2R1rq18z0bkIqDMDa6jGhuP8xmp6D5
         zcfbYmImSoKCPde/X8oRFlMoYVhJc+/pK65Sk/bp9D3Yos0Ttqe3YVnUVaUWm/5rFpXb
         11/XvKFqbayg63XfkiA6xDygoJevvO8McAfgH8qj21aaa+VD7NOSCQweUKSLYKgOBsCM
         EvyXXLl4R7KF3WDnn4p8tIsL5eWkooz1E3giWlpBZo90+6ImFTOuuZ9wSj900EKrMQK2
         PFaQ==
X-Gm-Message-State: AODbwcDF0Gh4egaCJWcm45nNbM5y0sVdUD8k2kl3PwfWhbGCX017Qkw0
        6eXC81Yz2tUjAWCmi/NibQ==
X-Received: by 10.99.60.81 with SMTP id i17mr1896501pgn.183.1494357515314;
        Tue, 09 May 2017 12:18:35 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id w23sm1124427pfl.133.2017.05.09.12.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 12:18:34 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 8/8] pathspec: convert parse_pathspec to take an index
Date:   Tue,  9 May 2017 12:18:05 -0700
Message-Id: <20170509191805.176266-9-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170509191805.176266-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'parse_pathspec()' to take an index parameter.

Since the index is only needed when the PATHSPEC_SUBMODULE_LEADING_PATH
and PATHSPEC_STRIP_SUBMODULE_SLASH flags are given, add a check
requiring a non-NULL index when either of these flags are given.
Convert callers which use these two flags to pass in an index while
having other callers pass in NULL.

Now that pathspec.c does not use any cache macros and has no references
to 'the_index', mark it by defining NO_THE_INDEX_COMPATIBILITY_MACROS.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 archive.c                   |  4 ++--
 builtin/add.c               |  4 ++--
 builtin/blame.c             |  2 +-
 builtin/check-ignore.c      |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/clean.c             |  2 +-
 builtin/commit.c            |  4 ++--
 builtin/grep.c              |  2 +-
 builtin/ls-files.c          |  4 ++--
 builtin/ls-tree.c           |  5 +++--
 builtin/rerere.c            |  2 +-
 builtin/reset.c             |  2 +-
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 builtin/update-index.c      |  2 +-
 line-log.c                  |  2 +-
 pathspec.c                  | 13 ++++++++++---
 pathspec.h                  |  1 +
 revision.c                  |  5 +++--
 submodule.c                 |  2 +-
 tree-diff.c                 |  2 +-
 21 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/archive.c b/archive.c
index 60b889198..ce9b30f2e 100644
--- a/archive.c
+++ b/archive.c
@@ -306,7 +306,7 @@ static int path_exists(struct tree *tree, const char *path)
 	struct pathspec pathspec;
 	int ret;
 
-	parse_pathspec(&pathspec, 0, 0, "", paths);
+	parse_pathspec(&pathspec, NULL, 0, 0, "", paths);
 	pathspec.recursive = 1;
 	ret = read_tree_recursive(tree, "", 0, 0, &pathspec,
 				  reject_entry, &pathspec);
@@ -322,7 +322,7 @@ static void parse_pathspec_arg(const char **pathspec,
 	 * Also if pathspec patterns are dependent, we're in big
 	 * trouble as we test each one separately
 	 */
-	parse_pathspec(&ar_args->pathspec, 0,
+	parse_pathspec(&ar_args->pathspec, NULL, 0,
 		       PATHSPEC_PREFER_FULL,
 		       "", pathspec);
 	ar_args->pathspec.recursive = 1;
diff --git a/builtin/add.c b/builtin/add.c
index 4e3bf20c2..23606db39 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -181,7 +181,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 {
 	struct pathspec pathspec;
 
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, NULL, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_SYMLINK_LEADING_PATH |
 		       PATHSPEC_PREFIX_ORIGIN,
@@ -386,7 +386,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	 * Check the "pathspec '%s' did not match any files" block
 	 * below before enabling new magic.
 	 */
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, &the_index, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_SYMLINK_LEADING_PATH |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH |
diff --git a/builtin/blame.c b/builtin/blame.c
index f7aa95f4b..e37837c17 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -557,7 +557,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 	paths[0] = origin->path;
 	paths[1] = NULL;
 
-	parse_pathspec(&diff_opts.pathspec,
+	parse_pathspec(&diff_opts.pathspec, NULL,
 		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 		       PATHSPEC_LITERAL_PATH, "", paths);
 	diff_setup_done(&diff_opts);
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 446b76dcf..90169e79a 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -84,7 +84,7 @@ static int check_ignore(struct dir_struct *dir,
 	 * check-ignore just needs paths. Magic beyond :/ is really
 	 * irrelevant.
 	 */
-	parse_pathspec(&pathspec,
+	parse_pathspec(&pathspec, &the_index,
 		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
 		       PATHSPEC_SYMLINK_LEADING_PATH |
 		       PATHSPEC_SUBMODULE_LEADING_PATH |
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f3..cb8ed09f6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1274,7 +1274,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	}
 
 	if (argc) {
-		parse_pathspec(&opts.pathspec, 0,
+		parse_pathspec(&opts.pathspec, NULL, 0,
 			       opts.patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
 			       prefix, argv);
 
diff --git a/builtin/clean.c b/builtin/clean.c
index d861f836a..ebc980b4f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -926,7 +926,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < exclude_list.nr; i++)
 		add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
 
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, NULL, 0,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc51..014193728 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -342,7 +342,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, NULL, 0,
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
@@ -1373,7 +1373,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
 		s.show_ignored_files = 1;
-	parse_pathspec(&s.pathspec, 0,
+	parse_pathspec(&s.pathspec, NULL, 0,
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 65070c52f..d330a85cb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1212,7 +1212,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			verify_filename(prefix, argv[j], j == i && allow_revs);
 	}
 
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, NULL, 0,
 		       PATHSPEC_PREFER_CWD |
 		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
 		       prefix, argv + i);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e9dee2e41..f5d81ab1d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -429,7 +429,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 	if (prefix) {
 		static const char *(matchbuf[1]);
 		matchbuf[0] = NULL;
-		parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC,
+		parse_pathspec(&pathspec, NULL, PATHSPEC_ALL_MAGIC,
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
@@ -616,7 +616,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		die("ls-files --recurse-submodules does not support "
 		    "--error-unmatch");
 
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, &the_index, 0,
 		       PATHSPEC_PREFER_CWD |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH,
 		       prefix, argv);
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index d7ebeb4ce..1d1083ed7 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,8 +173,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
-				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
+	parse_pathspec(&pathspec, NULL,
+		       PATHSPEC_ALL_MAGIC &
+		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i = 0; i < pathspec.nr; i++)
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 1bf72423b..749599a9c 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -75,7 +75,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		struct pathspec pathspec;
 		if (argc < 2)
 			warning("'git rerere forget' without paths is deprecated");
-		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
+		parse_pathspec(&pathspec, NULL, 0, PATHSPEC_PREFER_CWD,
 			       prefix, argv + 1);
 		return rerere_forget(&pathspec);
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index 529f2f9be..f9da86622 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -234,7 +234,7 @@ static void parse_args(struct pathspec *pathspec,
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-	parse_pathspec(pathspec, 0,
+	parse_pathspec(pathspec, &the_index, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH |
 		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
diff --git a/builtin/rm.c b/builtin/rm.c
index 8fe12d0a7..cffd27c20 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -270,7 +270,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, &the_index, 0,
 		       PATHSPEC_PREFER_CWD |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH,
 		       prefix, argv);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 69149b557..b06d62d80 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -232,7 +232,7 @@ static int module_list_compute(int argc, const char **argv,
 {
 	int i, result = 0;
 	char *ps_matched = NULL;
-	parse_pathspec(pathspec, 0,
+	parse_pathspec(pathspec, &the_index, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH,
 		       prefix, argv);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index ebfc09faa..0aaf7e0da 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -714,7 +714,7 @@ static int do_reupdate(int ac, const char **av,
 	int has_head = 1;
 	struct pathspec pathspec;
 
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, NULL, 0,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, av + 1);
 
diff --git a/line-log.c b/line-log.c
index a23b91047..4c3232639 100644
--- a/line-log.c
+++ b/line-log.c
@@ -754,7 +754,7 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
 			argv_array_push(&array, r->path);
 		paths = argv_array_detach(&array);
 
-		parse_pathspec(&rev->diffopt.pathspec, 0,
+		parse_pathspec(&rev->diffopt.pathspec, NULL, 0,
 			       PATHSPEC_PREFER_FULL, "", paths);
 		/* strings are now owned by pathspec */
 		free(paths);
diff --git a/pathspec.c b/pathspec.c
index c7ed8b3fb..b9c87b8d9 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "dir.h"
 #include "pathspec.h"
@@ -573,6 +574,7 @@ static void NORETURN unsupported_magic(const char *pattern,
  * pathspec. die() if any magic in magic_mask is used.
  */
 void parse_pathspec(struct pathspec *pathspec,
+		    const struct index_state *istate,
 		    unsigned magic_mask, unsigned flags,
 		    const char *prefix, const char **argv)
 {
@@ -593,6 +595,11 @@ void parse_pathspec(struct pathspec *pathspec,
 	    (flags & PATHSPEC_PREFER_FULL))
 		die("BUG: PATHSPEC_PREFER_CWD and PATHSPEC_PREFER_FULL are incompatible");
 
+	if (!istate && ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH) ||
+			(flags & PATHSPEC_SUBMODULE_LEADING_PATH)))
+	    die("BUG: PATHSPEC_STRIP_SUBMODULE_SLASH and "
+		"PATHSPEC_SUBMODULE_LEADING_PATH require an index");
+
 	/* No arguments with prefix -> prefix pathspec */
 	if (!entry) {
 		if (flags & PATHSPEC_PREFER_FULL)
@@ -629,7 +636,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		entry = argv[i];
 
-		init_pathspec_item(item + i, &the_index, flags,
+		init_pathspec_item(item + i, istate, flags,
 				   prefix, prefixlen, entry);
 
 		if (item[i].magic & PATHSPEC_EXCLUDE)
@@ -643,7 +650,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		}
 
 		if (flags & PATHSPEC_SUBMODULE_LEADING_PATH)
-			die_path_inside_submodule(item + i, &the_index);
+			die_path_inside_submodule(item + i, istate);
 
 		if (item[i].nowildcard_len < item[i].len)
 			pathspec->has_wildcard = 1;
@@ -656,7 +663,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	 */
 	if (nr_exclude == n) {
 		int plen = (!(flags & PATHSPEC_PREFER_CWD)) ? 0 : prefixlen;
-		init_pathspec_item(item + n, &the_index, 0, prefix, plen, "");
+		init_pathspec_item(item + n, istate, 0, prefix, plen, "");
 		pathspec->nr++;
 	}
 
diff --git a/pathspec.h b/pathspec.h
index dfb22440a..4d1007572 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -78,6 +78,7 @@ struct pathspec {
 #define PATHSPEC_LITERAL_PATH (1<<8)
 
 extern void parse_pathspec(struct pathspec *pathspec,
+			   const struct index_state *istate,
 			   unsigned magic_mask,
 			   unsigned flags,
 			   const char *prefix,
diff --git a/revision.c b/revision.c
index 7ff61ff5f..6efdb28ac 100644
--- a/revision.c
+++ b/revision.c
@@ -1424,7 +1424,8 @@ static void prepare_show_merge(struct rev_info *revs)
 			i++;
 	}
 	clear_pathspec(&revs->prune_data);
-	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
+	parse_pathspec(&revs->prune_data, NULL,
+		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 		       PATHSPEC_PREFER_FULL | PATHSPEC_LITERAL_PATH, "", prune);
 	revs->limited = 1;
 }
@@ -2276,7 +2277,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		 */
 		ALLOC_GROW(prune_data.path, prune_data.nr + 1, prune_data.alloc);
 		prune_data.path[prune_data.nr++] = NULL;
-		parse_pathspec(&revs->prune_data, 0, 0,
+		parse_pathspec(&revs->prune_data, NULL, 0, 0,
 			       revs->prefix, prune_data.path);
 	}
 
diff --git a/submodule.c b/submodule.c
index 9e0502f25..ba9db9714 100644
--- a/submodule.c
+++ b/submodule.c
@@ -252,7 +252,7 @@ int is_submodule_initialized(const char *path)
 			argv_array_push(&args, item->string);
 		}
 
-		parse_pathspec(&ps, 0, 0, NULL, args.argv);
+		parse_pathspec(&ps, NULL, 0, 0, NULL, args.argv);
 		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
 
 		argv_array_clear(&args);
diff --git a/tree-diff.c b/tree-diff.c
index e164e532b..58c66b5bc 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -641,7 +641,7 @@ static void try_to_follow_renames(const unsigned char *old, const unsigned char
 			path[0] = p->one->path;
 			path[1] = NULL;
 			clear_pathspec(&opt->pathspec);
-			parse_pathspec(&opt->pathspec,
+			parse_pathspec(&opt->pathspec, NULL,
 				       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 				       PATHSPEC_LITERAL_PATH, "", path);
 
-- 
2.13.0.rc2.291.g57267f2277-goog

