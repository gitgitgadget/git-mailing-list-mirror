From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 09/19] ls-files.c: use index api
Date: Fri, 12 Jul 2013 19:26:54 +0200
Message-ID: <1373650024-3001-10-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:29:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh9g-0003tu-GD
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107Ab3GLR3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:29:11 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52885 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964904Ab3GLR3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:29:10 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so9222557pab.22
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qiimqnn5KVGABY+UUXGXSGB5YG5vXU4lDb7PXugzvzk=;
        b=vstvGe+tCQLFi28lABXrMYFnRKXciV8zN2uCdcJDagaF+zztn8k8lBQxVsIS3HDfuw
         fZnDu11rBd8j5YgkfBHrmdKB8KPuZM2Zlam+OIS/D3yAQZ9sypCo8Jvm7JJr9Wmj4dpy
         W8jqJN4LakJ2wnWTM8HFu4xTrE59yWRYyP7XA7pqLVEw62JfwPdjBCbhd39p5dldSKjm
         5e/avFG79BdtPrsKY/fWngKD/ViVM0Ys+2Xdoev2Ozr+7ZlQN0W5gz1p+KXGbakUDG32
         iAblFW8aOeNlu7E0/xb5bfYagQEnUDtzW1YE69d885utQGaeER0iZAs5gKIlMuqwZ2IN
         AI9g==
X-Received: by 10.66.154.132 with SMTP id vo4mr43645653pab.63.1373650149531;
        Fri, 12 Jul 2013 10:29:09 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id y6sm46409703pbl.23.2013.07.12.10.29.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:29:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230219>

Use the index api to read only part of the index, if the on-disk version
of the index is index-v5.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/ls-files.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 08d9786..80cc398 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -31,6 +31,7 @@ static const char *prefix;
 static int max_prefix_len;
 static int prefix_len;
 static const char **pathspec;
+static struct pathspec pathspec_struct;
 static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
@@ -457,6 +458,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	struct dir_struct dir;
 	struct exclude_list *el;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
+	struct filter_opts *opts = xmalloc(sizeof(*opts));
 	struct option builtin_ls_files_options[] = {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
 			N_("paths are separated with NUL character"),
@@ -522,9 +524,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		prefix_len = strlen(prefix);
 	git_config(git_default_config, NULL);
 
-	if (read_cache() < 0)
-		die("index file corrupt");
-
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
@@ -556,14 +555,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		setup_work_tree();
 
 	pathspec = get_pathspec(prefix, argv);
-
-	/* be nice with submodule paths ending in a slash */
-	if (pathspec)
-		strip_trailing_slash_from_submodules();
-
-	/* Find common prefix for all pathspec's */
-	max_prefix = common_prefix(pathspec);
-	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
+	init_pathspec(&pathspec_struct, pathspec);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec && error_unmatch) {
@@ -573,6 +565,23 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		ps_matched = xcalloc(1, num);
 	}
 
+	if (!with_tree) {
+		memset(opts, 0, sizeof(*opts));
+		opts->pathspec = &pathspec_struct;
+		opts->read_staged = 1;
+		if (show_resolve_undo)
+			opts->read_resolve_undo = 1;
+		read_cache_filtered(opts);
+	} else {
+		read_cache();
+	}
+	/* be nice with submodule paths ending in a slash */
+	if (pathspec)
+		strip_trailing_slash_from_submodules();
+
+	max_prefix = common_prefix(pathspec);
+	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
+
 	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
 		die("ls-files --ignored needs some exclude pattern");
 
-- 
1.8.3.453.g1dfc63d
