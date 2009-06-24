From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/2] read-tree: migrate to parse-options
Date: Tue, 23 Jun 2009 21:27:52 -0700
Message-ID: <1245817672-25483-2-git-send-email-bebarino@gmail.com>
References: <1245817672-25483-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 06:30:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJK7V-0001On-B0
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 06:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbZFXE2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 00:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbZFXE17
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 00:27:59 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:39591 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZFXE17 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 00:27:59 -0400
Received: by mail-px0-f190.google.com with SMTP id 28so130579pxi.33
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 21:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=/FMtVLoqgr2ZwmyikYloKK8YkeaqSYulxY5mcAKarBI=;
        b=hdcveMhxSHd7FDLRxfqwRcJBo10vmUyaiZav4gQuv0J7DbKYQjNz1VjqGeqwdeGIPx
         OmVDUDV4pAINTB9gmxRedRtAG2cwIU9FLKVpHwoXmXWUdtK8jYHtsbL3CnQiH8DH7e+y
         2qFHz5SxdPAtn9MLIwlHZGPzfPEQQs+jbckzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vUaBSuZFBlsmS3ZEuQeyxmzK9V/ym6IRA+iaJVyi/3Z+WPtnbj2aerMjb5UXxxZbFO
         irLAsaTzYApHgb2AKpbbFQz6loC12IbFWwbs8xpRUKPz8EF1o1Z9gMx1M9OvWQutrxzH
         n/O2UplUsHwVrWGQ8JOpSKiqndPAJ3f9Bn3QY=
Received: by 10.115.47.1 with SMTP id z1mr1342370waj.44.1245817682099;
        Tue, 23 Jun 2009 21:28:02 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id k37sm1084289waf.7.2009.06.23.21.27.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Jun 2009 21:28:01 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 23 Jun 2009 21:27:57 -0700
X-Mailer: git-send-email 1.6.3.3.334.g916e1
In-Reply-To: <1245817672-25483-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122122>

Cleanup the documentation to explicitly state that --exclude-directory
is only meaningful when used with -u. Also make the documentation more
consistent with the usage message printed with read-tree --help-all.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-read-tree.txt |    5 +-
 builtin-read-tree.c             |  220 +++++++++++++++++++++-----------------
 2 files changed, 126 insertions(+), 99 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 7160fa1..1e0cc8f 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -8,7 +8,10 @@ git-read-tree - Reads tree information into the index
 
 SYNOPSIS
 --------
-'git read-tree' (<tree-ish> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
+'git read-tree' [--index-output=<file>] <treeish>
+'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
+		[-u [--exclude-per-directory=<gitignore>] | -i]]
+		[--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]]
 
 
 DESCRIPTION
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 887e177..adca739 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -12,6 +12,7 @@
 #include "unpack-trees.h"
 #include "dir.h"
 #include "builtin.h"
+#include "parse-options.h"
 
 static int nr_trees;
 static struct tree *trees[MAX_UNPACK_TREES];
@@ -29,7 +30,83 @@ static int list_tree(unsigned char *sha1)
 	return 0;
 }
 
-static const char read_tree_usage[] = "git read-tree (<sha> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
+static const char * const read_tree_usage[] = {
+	"git read-tree [--index-output=<file>] <treeish>",
+	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u [--exclude-per-directory=<gitignore>] | -i]]  [--index-output=<file>] <treeish1> [<treeish2> [<treeish3>]]",
+	NULL
+};
+
+static int index_output_cb(const struct option *opt, const char *arg,
+				 int unset)
+{
+	set_alternate_index_output(arg);
+	return 0;
+}
+
+static int prefix_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct unpack_trees_options *opts;
+	opts = (struct unpack_trees_options *)opt->value;
+
+	if (opts->merge || opts->prefix)
+		return 1;
+	opts->prefix = arg;
+	opts->merge = 1;
+	if (read_cache_unmerged())
+		die("you need to resolve your current index first");
+
+	return 0;
+}
+
+static int reset_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct unpack_trees_options *opts;
+	opts = (struct unpack_trees_options *)opt->value;
+
+	if (opts->merge || opts->prefix)
+		return -1;
+	opts->reset = 1;
+	opts->merge = 1;
+	read_cache_unmerged();
+
+	return 0;
+}
+
+static int merge_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct unpack_trees_options *opts;
+	opts = (struct unpack_trees_options *)opt->value;
+
+	if (opts->merge || opts->prefix)
+		return -1;
+	if (read_cache_unmerged())
+		die("you need to resolve your current index first");
+	opts->merge = 1;
+
+	return 0;
+}
+
+static int exclude_per_directory_cb(const struct option *opt, const char *arg,
+				    int unset)
+{
+	struct dir_struct *dir;
+	struct unpack_trees_options *opts;
+
+	opts = (struct unpack_trees_options *)opt->value;
+
+	if (opts->dir)
+		die("more than one --exclude-per-directory given.");
+
+	dir = xcalloc(1, sizeof(*opts->dir));
+	dir->flags |= DIR_SHOW_IGNORED;
+	dir->exclude_per_dir = arg;
+	opts->dir = dir;
+	/* We do not need to nor want to do read-directory
+	 * here; we are merely interested in reusing the
+	 * per directory ignore stack mechanism.
+	 */
+	return 0;
+}
 
 static struct lock_file lock_file;
 
@@ -39,6 +116,37 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	unsigned char sha1[20];
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
+	int update = 0, index_only = 0, trivial_merges_only = 0, aggressive = 0,
+	    verbose = 0;
+	const struct option read_tree_options[] = {
+		{ OPTION_CALLBACK, 0, "index-output", NULL, "FILE",
+		  "write resulting index to <FILE>",
+		  PARSE_OPT_NONEG, index_output_cb },
+		{ OPTION_CALLBACK, 0, "prefix", &opts, "<subdirectory>/",
+		  "read the tree into the index under <subdirectory>",
+		  PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP, prefix_cb },
+		{ OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
+		  "gitignore",
+		  "allow explicitly ignored files to be overwritten",
+		  PARSE_OPT_NONEG, exclude_per_directory_cb },
+		OPT__VERBOSE(&verbose),
+		OPT_GROUP("Merging"),
+		{ OPTION_CALLBACK, 'm', NULL, &opts, NULL,
+		  "perform a merge in addition to a read",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, merge_cb },
+		{ OPTION_CALLBACK, 0, "reset", &opts, NULL,
+		  "same as -m, except unmerged entries are discarded",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, reset_cb },
+		OPT_BOOLEAN('u', NULL, &update,
+			    "update working tree with merge result"),
+		OPT_BOOLEAN('i', NULL, &index_only,
+			    "don't check the working tree after merging"),
+		OPT_BOOLEAN(0, "trivial", &trivial_merges_only,
+			    "3-way merge if no file level merging required"),
+		OPT_BOOLEAN(0, "aggressive", &aggressive,
+			    "3-way merge in presence of adds and removes"),
+		OPT_END()
+	};
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
@@ -49,104 +157,18 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
 	newfd = hold_locked_index(&lock_file, 1);
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-
-		/* "-u" means "update", meaning that a merge will update
-		 * the working tree.
-		 */
-		if (!strcmp(arg, "-u")) {
-			opts.update = 1;
-			continue;
-		}
-
-		if (!strcmp(arg, "-v")) {
-			opts.verbose_update = 1;
-			continue;
-		}
-
-		/* "-i" means "index only", meaning that a merge will
-		 * not even look at the working tree.
-		 */
-		if (!strcmp(arg, "-i")) {
-			opts.index_only = 1;
-			continue;
-		}
-
-		if (!prefixcmp(arg, "--index-output=")) {
-			set_alternate_index_output(arg + 15);
-			continue;
-		}
-
-		/* "--prefix=<subdirectory>/" means keep the current index
-		 *  entries and put the entries from the tree under the
-		 * given subdirectory.
-		 */
-		if (!prefixcmp(arg, "--prefix=")) {
-			if (stage || opts.merge || opts.prefix)
-				usage(read_tree_usage);
-			opts.prefix = arg + 9;
-			opts.merge = 1;
-			stage = 1;
-			if (read_cache_unmerged())
-				die("you need to resolve your current index first");
-			continue;
-		}
+	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
+			     read_tree_usage, 0);
 
-		/* This differs from "-m" in that we'll silently ignore
-		 * unmerged entries and overwrite working tree files that
-		 * correspond to them.
-		 */
-		if (!strcmp(arg, "--reset")) {
-			if (stage || opts.merge || opts.prefix)
-				usage(read_tree_usage);
-			opts.reset = 1;
-			opts.merge = 1;
-			stage = 1;
-			read_cache_unmerged();
-			continue;
-		}
+	opts.update = update ? 1 : 0;
+	opts.index_only = index_only ? 1 : 0;
+	opts.trivial_merges_only = trivial_merges_only ? 1 : 0;
+	opts.aggressive = aggressive ? 1 : 0;
+	opts.verbose_update = verbose ? 1 : 0;
+	stage = opts.merge;
 
-		if (!strcmp(arg, "--trivial")) {
-			opts.trivial_merges_only = 1;
-			continue;
-		}
-
-		if (!strcmp(arg, "--aggressive")) {
-			opts.aggressive = 1;
-			continue;
-		}
-
-		/* "-m" stands for "merge", meaning we start in stage 1 */
-		if (!strcmp(arg, "-m")) {
-			if (stage || opts.merge || opts.prefix)
-				usage(read_tree_usage);
-			if (read_cache_unmerged())
-				die("you need to resolve your current index first");
-			stage = 1;
-			opts.merge = 1;
-			continue;
-		}
-
-		if (!prefixcmp(arg, "--exclude-per-directory=")) {
-			struct dir_struct *dir;
-
-			if (opts.dir)
-				die("more than one --exclude-per-directory are given.");
-
-			dir = xcalloc(1, sizeof(*opts.dir));
-			dir->flags |= DIR_SHOW_IGNORED;
-			dir->exclude_per_dir = arg + 24;
-			opts.dir = dir;
-			/* We do not need to nor want to do read-directory
-			 * here; we are merely interested in reusing the
-			 * per directory ignore stack mechanism.
-			 */
-			continue;
-		}
-
-		if (1 < opts.index_only + opts.update)
-			die("-u and -i at the same time makes no sense");
+	for (i = 0; i < argc; i++) {
+		const char *arg = argv[i];
 
 		if (get_sha1(arg, sha1))
 			die("Not a valid object name %s", arg);
@@ -154,6 +176,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			die("failed to unpack tree object %s", arg);
 		stage++;
 	}
+	if (1 < opts.index_only + opts.update)
+		die("-u and -i at the same time makes no sense");
 	if ((opts.update||opts.index_only) && !opts.merge)
 		die("%s is meaningless without -m",
 		    opts.update ? "-u" : "-i");
-- 
1.6.3.3.334.g916e1
