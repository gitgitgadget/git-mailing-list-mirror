Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDD6203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 20:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935602AbcKKU1K (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 15:27:10 -0500
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:38874 "EHLO
        koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755669AbcKKU1F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 15:27:05 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Nov 2016 15:27:05 EST
Received: from hurricane.home.kaarsemaker.net (unknown [145.132.209.114])
        by koekblik.kaarsemaker.net (Postfix) with ESMTP id E515D807B1;
        Fri, 11 Nov 2016 21:19:58 +0100 (CET)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 1/2] diff --no-index: add option to follow symlinks
Date:   Fri, 11 Nov 2016 21:19:57 +0100
Message-Id: <20161111201958.2175-2-dennis@kaarsemaker.net>
X-Mailer: git-send-email 2.11.0-rc0-22-gcc0501c
In-Reply-To: <20161111201958.2175-1-dennis@kaarsemaker.net>
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's diff machinery does not follow symlinks, which makes sense as git
itself also does not, but stores the symlink destination.

In --no-index mode however, it is useful for diff to be able to follow
symlinks, matching the behaviour of ordinary diff.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 diff-no-index.c |  7 ++++---
 diff.c          | 10 ++++++++--
 diff.h          |  2 +-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index f420786..15811c2 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -40,7 +40,7 @@ static int read_directory_contents(const char *path, struct string_list *list)
  */
 static const char file_from_standard_input[] = "-";
 
-static int get_mode(const char *path, int *mode)
+static int get_mode(const char *path, int *mode, int follow_symlinks)
 {
 	struct stat st;
 
@@ -52,7 +52,7 @@ static int get_mode(const char *path, int *mode)
 #endif
 	else if (path == file_from_standard_input)
 		*mode = create_ce_mode(0666);
-	else if (lstat(path, &st))
+	else if (follow_symlinks ? stat(path, &st) : lstat(path, &st))
 		return error("Could not access '%s'", path);
 	else
 		*mode = st.st_mode;
@@ -93,7 +93,8 @@ static int queue_diff(struct diff_options *o,
 {
 	int mode1 = 0, mode2 = 0;
 
-	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
+	if (get_mode(name1, &mode1, DIFF_OPT_TST(o, FOLLOW_SYMLINKS)) ||
+		get_mode(name2, &mode2, DIFF_OPT_TST(o, FOLLOW_SYMLINKS)))
 		return -1;
 
 	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
diff --git a/diff.c b/diff.c
index be11e4e..1eaf604 100644
--- a/diff.c
+++ b/diff.c
@@ -2815,7 +2815,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		s->size = xsize_t(st.st_size);
 		if (!s->size)
 			goto empty;
-		if (S_ISLNK(st.st_mode)) {
+		if (S_ISLNK(s->mode)) {
 			struct strbuf sb = STRBUF_INIT;
 
 			if (strbuf_readlink(&sb, s->path, s->size))
@@ -2825,6 +2825,10 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 			s->should_free = 1;
 			return 0;
 		}
+		if (S_ISLNK(st.st_mode)) {
+			stat(s->path, &st);
+			s->size = xsize_t(st.st_size);
+		}
 		if (size_only)
 			return 0;
 		if ((flags & CHECK_BINARY) &&
@@ -3884,7 +3888,9 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-follow")) {
 		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
 		DIFF_OPT_CLR(options, DEFAULT_FOLLOW_RENAMES);
-	} else if (!strcmp(arg, "--color"))
+	} else if (!strcmp(arg, "--follow-symlinks"))
+		DIFF_OPT_SET(options, FOLLOW_SYMLINKS);
+	else if (!strcmp(arg, "--color"))
 		options->use_color = 1;
 	else if (skip_prefix(arg, "--color=", &arg)) {
 		int value = git_config_colorbool(NULL, arg);
diff --git a/diff.h b/diff.h
index 25ae60d..22b0c5a 100644
--- a/diff.h
+++ b/diff.h
@@ -69,7 +69,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
 #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
-/* (1 <<  9) unused */
+#define DIFF_OPT_FOLLOW_SYMLINKS     (1 <<  9)
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
 #define DIFF_OPT_QUICK               (1 << 11)
 #define DIFF_OPT_NO_INDEX            (1 << 12)
-- 
2.10.1-449-gab0f84c

