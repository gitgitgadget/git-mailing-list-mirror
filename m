Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65610C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC1UyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC1UyP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:54:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D471FDD
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:54:14 -0700 (PDT)
Received: (qmail 2238 invoked by uid 109); 28 Mar 2023 20:54:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:54:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2209 invoked by uid 111); 28 Mar 2023 20:54:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:54:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:54:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/7] fast-import: fix file access when run from subdir
Message-ID: <20230328205413.GA1754055@coredump.intra.peff.net>
References: <20230328205253.GA1753925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328205253.GA1753925@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cmd_fast_import(), we ignore the "prefix" argument entirely, even
though it tells us how we may have changed directory to the root of the
repository earlier in the process. Which means that if you run it from a
subdir and point to paths in the filesystem, like:

  cd subdir
  git fast-import --import-marks=foo <dump

then it will look for "foo" in the root of the repository, not the
current directory ("subdir/") which the user would have expected.

We can fix this by recording the prefix and using it as appropriate
whenever we open a file for reading or writing. I found each of these by
looking for cases where we call fopen() within fast-import.c, so this
should cover all cases. The new test triggers each one, as well as
making sure we don't accidentally apply the prefix when --relative-marks
is in use (since that option interprets some paths as relative to a
specific directory).

Signed-off-by: Jeff King <peff@peff.net>
---
It's curious that several of the file-writing options do not respect the
"relative-marks" feature. I'm not sure if that is a bug, but if so, it
is orthogonal to this patch (and arguably fixing it now may create more
confusion than it's worth).

I also wondered if this bug was introduced when we switched fast-import
to a builtin. But nope, before that it did call setup_git_directory()
itself, but ignored the prefix value which was returned.

 builtin/fast-import.c        | 10 ++++++++--
 t/t9304-fast-import-marks.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index f7548ff4a35..19427e05f1c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -176,6 +176,7 @@ static FILE *pack_edges;
 static unsigned int show_stats = 1;
 static int global_argc;
 static const char **global_argv;
+static const char *global_prefix;
 
 /* Memory pools */
 static struct mem_pool fi_mem_pool = {
@@ -3246,7 +3247,7 @@ static void parse_alias(void)
 static char* make_fast_import_path(const char *path)
 {
 	if (!relative_marks_paths || is_absolute_path(path))
-		return xstrdup(path);
+		return prefix_filename(global_prefix, path);
 	return git_pathdup("info/fast-import/%s", path);
 }
 
@@ -3317,9 +3318,11 @@ static void option_cat_blob_fd(const char *fd)
 
 static void option_export_pack_edges(const char *edges)
 {
+	char *fn = prefix_filename(global_prefix, edges);
 	if (pack_edges)
 		fclose(pack_edges);
-	pack_edges = xfopen(edges, "a");
+	pack_edges = xfopen(fn, "a");
+	free(fn);
 }
 
 static void option_rewrite_submodules(const char *arg, struct string_list *list)
@@ -3334,11 +3337,13 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	f++;
 	CALLOC_ARRAY(ms, 1);
 
+	f = prefix_filename(global_prefix, f);
 	fp = fopen(f, "r");
 	if (!fp)
 		die_errno("cannot read '%s'", f);
 	read_mark_file(&ms, fp, insert_oid_entry);
 	fclose(fp);
+	free(f);
 
 	string_list_insert(list, s)->util = ms;
 }
@@ -3552,6 +3557,7 @@ int cmd_fast_import(int argc, const char **argv, const char *prefix)
 
 	global_argc = argc;
 	global_argv = argv;
+	global_prefix = prefix;
 
 	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
 	for (i = 0; i < (cmd_save - 1); i++)
diff --git a/t/t9304-fast-import-marks.sh b/t/t9304-fast-import-marks.sh
index a98ef032d94..410a871c52a 100755
--- a/t/t9304-fast-import-marks.sh
+++ b/t/t9304-fast-import-marks.sh
@@ -49,4 +49,33 @@ test_expect_success 'import with submodule mapping' '
 	test_cmp expect actual
 '
 
+test_expect_success 'paths adjusted for relative subdir' '
+	git init deep-dst &&
+	mkdir deep-dst/subdir &&
+	>deep-dst/subdir/empty-marks &&
+	git -C deep-dst/subdir fast-import \
+		--rewrite-submodules-from=sub:../../from \
+		--rewrite-submodules-to=sub:../../to \
+		--import-marks=empty-marks \
+		--export-marks=exported-marks \
+		--export-pack-edges=exported-edges \
+		<dump &&
+	# we do not bother checking resulting repo; we just care that nothing
+	# complained about failing to open files for reading, and that files
+	# for writing were created in the expected spot
+	test_path_is_file deep-dst/subdir/exported-marks &&
+	test_path_is_file deep-dst/subdir/exported-edges
+'
+
+test_expect_success 'relative marks are not affected by subdir' '
+	git init deep-relative &&
+	mkdir deep-relative/subdir &&
+	git -C deep-relative/subdir fast-import \
+		--relative-marks \
+		--export-marks=exported-marks \
+		<dump &&
+	test_path_is_missing deep-relative/subdir/exported-marks &&
+	test_path_is_file deep-relative/.git/info/fast-import/exported-marks
+'
+
 test_done
-- 
2.40.0.675.gb17cd5d94c8

