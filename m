Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785E320437
	for <e@80x24.org>; Mon, 16 Oct 2017 16:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbdJPQtN (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 12:49:13 -0400
Received: from mout.web.de ([212.227.15.14]:65034 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753132AbdJPQtL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 12:49:11 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lo0M4-1dbQbN2tuy-00g3u8; Mon, 16
 Oct 2017 18:49:10 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] Introduce git add --renormalize .
Date:   Mon, 16 Oct 2017 18:49:07 +0200
Message-Id: <20171016164907.4201-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.729.g59c0ea183a
In-Reply-To: <xmqqo9pm8e4l.fsf@gitster.mtv.corp.google.com>
References: <xmqqo9pm8e4l.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Fov8MD0yBgFO91NoSH2dY0Ui5REu19JX7xlyd8e8SjBh6MTi6Zr
 8Ba6EbTFbmuu2sgu2Ofbc4Tpb+Hu9WtiA3LEgPN5yJrrud1eGMMZ0UDUbVdq5mDnKx8iT+R
 aPCG3eyQr+SDUYix/mw7paY2V2IgfsYFUlAMXytTbQTJz6rLn77QgEqa+CwOhU94iXxfyDb
 RxzHqLurebfApeC02anSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O7seuA3Q5hw=:OTCZ0cV/hw0eFCHafPbqms
 CO9lPptg05q8yAh/85G7M3vlV4Ir5HNbVw406NxX5wm3+3xwyGyrlmMOoylNOoJlab0ofEeLr
 1Ca8+DqdP8476/7pWv6HIpIZqvQDxQVzmJlv2Mnyxe2iod9EfWs+rOGtiUB9bdfN+39MJ8r9g
 23IlhCw5WN0fLmWjWlzZgiLQL+NQnOwpmSl+RKVRfeQJI9xJpjmG21AVMECDoIcGAfB7u6Z9y
 /YgWgv4j8ulle+y0Vrm8Sq0UovNzN+9RHFz/sJJn9gruU/KdEYqug5OFYTm8uSwIENzdg//f4
 UxZXh8HDGLUisHy3RM8sDSHsXFCzO9b2ptV57z/eheBh4jp9+G01crYHS0JpijQGw1vnc3rlm
 nQ7si80ut/T8SQ9LR0dzMgFJ0G8k8bsucAzCEYikABqW19Lc7I0/SeJDtePz9ROW3kWevuzpn
 a7JjvU+V9HpzrnKcFFdWNT0RwNPVLF9pR8o8AZ9eh6XsPAVbPEgYAaulovFeLeH3NyqTgHmfr
 LaF1KhySqZBXT/kyT+E1st7yLoOhNQuNAmzUbkdTSIrySDw1cTHWMInhzn16VY1xcOIPs6NFy
 OrdoBxoA3huvQtV7OcH6FA3ZjmWNQTsGoh4EUN05WVxDqUsWerBI2TpiLqOqBxpLK/+2HiXqM
 +sahrumcbq4YK/84CCeWPKJDWClVBhwpiGD+J9QI3RMJ2ohY57tDxS/tfxulLJ1RlCO1yUewi
 idfi4hi5yEcGTJVLskr82tI9f49ym1UzwRITfkBo7JlVuwQgHvS20cQy/XJWFJmX+lIaCnDgv
 J72Fhlfv2q3hC0Tz+Sc5VQYGnBEbqPCrCojven8kXsIgrAV9Is=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Make it safer to normalize the line endings in a repository:
Files that had been commited with CRLF will be commited with LF.
(Unless core.autorclf and .gitattributes specify that Git
 should not do line ending conversions)

The old way to normalize a repo was like this:
 # Make sure that there are not untracked files
 $ echo "* text=auto" >.gitattributes
 $ git read-tree --empty
 $ git add .
 $ git commit -m "Introduce end-of-line normalization"

The new method is one step shorter, more intuitive and does not
add untracked files:
 $ echo "* text=auto" >.gitattributes
 $ git add --renormalize .
 $ git commit -m "Introduce end-of-line normalization"

Note that "git add --renormalize <pathspec>" is the short form for
"git add -u --renormalize <pathspec>".

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/git-add.txt       |  8 +++++++-
 Documentation/gitattributes.txt |  3 +--
 builtin/add.c                   | 27 +++++++++++++++++++++++++--
 cache.h                         |  1 +
 convert.c                       |  1 +
 environment.c                   |  1 +
 read-cache.c                    | 24 ++++++++++++++----------
 t/t0025-crlf-renormalize.sh     | 30 ++++++++++++++++++++++++++++++
 8 files changed, 80 insertions(+), 15 deletions(-)
 create mode 100755 t/t0025-crlf-renormalize.sh

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index f4169fb1ec..b6e431903d 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
-	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
+	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
 	  [--chmod=(+|-)x] [--] [<pathspec>...]
 
 DESCRIPTION
@@ -172,6 +172,12 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	warning (e.g., if you are manually performing operations on
 	submodules).
 
+--renormalize::
+	Normalizes the line endings from CRLF to LF of tracked files.
+	This applies to files which are either "text" or "text=auto"
+	in .gitattributes (or core.autocrlf is true or input)
+        --renormalize implies -u
+
 --chmod=(+|-)x::
 	Override the executable bit of the added files.  The executable
 	bit is only changed in the index, the files on disk are left
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4c68bc19d5..071dec2bc4 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -232,8 +232,7 @@ From a clean working directory:
 
 -------------------------------------------------
 $ echo "* text=auto" >.gitattributes
-$ git read-tree --empty   # Clean index, force re-scan of working directory
-$ git add .
+$ git add --renormalize .
 $ git status        # Show files that will be normalized
 $ git commit -m "Introduce end-of-line normalization"
 -------------------------------------------------
diff --git a/builtin/add.c b/builtin/add.c
index a648cf4c56..ee8e756fdc 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -123,6 +123,25 @@ int add_files_to_cache(const char *prefix,
 	return !!data.add_errors;
 }
 
+static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
+{
+	int i, retval = 0;
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+
+		if (ce_stage(ce))
+			continue; /* do not touch unmerged paths */
+		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
+			continue; /* do not touch non blobs */
+		if (pathspec && !ce_path_match(ce, pathspec, NULL))
+			continue;
+		retval |= add_file_to_cache(ce->name, flags);
+	}
+
+	return retval;
+}
+
 static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec, int prefix)
 {
 	char *seen;
@@ -276,6 +295,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files")),
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
+	OPT_BOOL(0, "renormalize", &add_renormalize, N_("renormalize EOL of tracked files (implies -u)")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
 	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
 	{ OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
@@ -406,7 +426,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			  chmod_arg[1] != 'x' || chmod_arg[2]))
 		die(_("--chmod param '%s' must be either -x or +x"), chmod_arg);
 
-	add_new_files = !take_worktree_changes && !refresh_only;
+	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
 	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
@@ -500,7 +520,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	plug_bulk_checkin();
 
-	exit_status |= add_files_to_cache(prefix, &pathspec, flags);
+	if (add_renormalize)
+		exit_status |= renormalize_tracked_files(&pathspec, flags);
+	else
+		exit_status |= add_files_to_cache(prefix, &pathspec, flags);
 
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
diff --git a/cache.h b/cache.h
index a916bc79e3..d4e8f86696 100644
--- a/cache.h
+++ b/cache.h
@@ -489,6 +489,7 @@ extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_super_prefix(void);
 extern const char *get_git_work_tree(void);
+extern int add_renormalize;
 
 /*
  * Return true if the given path is a git directory; note that this _just_
diff --git a/convert.c b/convert.c
index a09935cb81..70a37b0942 100644
--- a/convert.c
+++ b/convert.c
@@ -290,6 +290,7 @@ static int crlf_to_git(const struct index_state *istate,
 		 * cherry-pick.
 		 */
 		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
+		    !add_renormalize &&
 		    has_cr_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
diff --git a/environment.c b/environment.c
index f1f934b6fd..16fbce1123 100644
--- a/environment.c
+++ b/environment.c
@@ -87,6 +87,7 @@ int auto_comment_line_char;
 /* Parallel index stat data preload? */
 int core_preload_index = 1;
 
+int add_renormalize;
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
  * ensure that they do not modify the untracked cache when reading it.
diff --git a/read-cache.c b/read-cache.c
index b211c57af6..3388c5053f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -630,7 +630,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 {
 	int size, namelen, was_same;
 	mode_t st_mode = st->st_mode;
-	struct cache_entry *ce, *alias;
+	struct cache_entry *ce, *alias = NULL;
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_RACY_IS_DIRTY;
 	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
 	int pretend = flags & ADD_CACHE_PRETEND;
@@ -677,16 +677,20 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	if (ignore_case) {
 		adjust_dirname_case(istate, ce->name);
 	}
+	if (!add_renormalize) {
+		alias = index_file_exists(istate, ce->name,
+					  ce_namelen(ce), ignore_case);
+		if (alias &&
+		    !ce_stage(alias) &&
+		    !ie_match_stat(istate, alias, st, ce_option)) {
+			/* Nothing changed, really */
+			if (!S_ISGITLINK(alias->ce_mode))
+				ce_mark_uptodate(alias);
+			alias->ce_flags |= CE_ADDED;
 
-	alias = index_file_exists(istate, ce->name, ce_namelen(ce), ignore_case);
-	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce_option)) {
-		/* Nothing changed, really */
-		if (!S_ISGITLINK(alias->ce_mode))
-			ce_mark_uptodate(alias);
-		alias->ce_flags |= CE_ADDED;
-
-		free(ce);
-		return 0;
+			free(ce);
+			return 0;
+		}
 	}
 	if (!intent_only) {
 		if (index_path(&ce->oid, path, st, HASH_WRITE_OBJECT)) {
diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
new file mode 100755
index 0000000000..fb1ed631d2
--- /dev/null
+++ b/t/t0025-crlf-renormalize.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='CRLF renormalization'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git config core.autocrlf false &&
+	printf "LINEONE\nLINETWO\nLINETHREE"     >LF.txt &&
+	printf "LINEONE\r\nLINETWO\r\nLINETHREE" >CRLF.txt &&
+	printf "LINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF.txt &&
+	git add . &&
+	git commit -m initial
+'
+
+test_expect_success 'renormalize CRLF in repo' '
+	echo "*.txt text=auto" >.gitattributes &&
+	git add --renormalize "*.txt" &&
+cat >expect <<EOF &&
+i/lf w/crlf attr/text=auto CRLF.txt
+i/lf w/lf attr/text=auto LF.txt
+i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
+EOF
+	git ls-files --eol |
+	sed -e "s/	/ /g" -e "s/  */ /g" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.14.1.729.g59c0ea183a

