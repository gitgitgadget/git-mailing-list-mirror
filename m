From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 2/2] read-tree: migrate to parse-options
Date: Thu, 25 Jun 2009 22:14:10 -0700
Message-ID: <1245993250-8213-2-git-send-email-bebarino@gmail.com>
References: <1245817672-25483-1-git-send-email-bebarino@gmail.com>
 <1245993250-8213-1-git-send-email-bebarino@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 07:14:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3lX-0000pl-7Q
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 07:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbZFZFOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 01:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZFZFOP
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 01:14:15 -0400
Received: from mail-pz0-f202.google.com ([209.85.222.202]:59979 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbZFZFOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 01:14:14 -0400
Received: by pzk40 with SMTP id 40so14930pzk.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 22:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=wA2NOv+0Ia1MG8gFxDLIsj+wOkXQ5AFYLUbFy5lB+uQ=;
        b=hqj1ubeI7nwf68fR/pwaO9N8f0CFyzL7DGxlE/YqSZV3wVNxU74XkCwySjVmpoeiXI
         P7fwdqzJdtjD0WtmD7xDY3qh+5Zc/l0c5qgnxuMesdXNlun4mwREBZjnrujeE3mvzEFW
         7Uno/n3hYm79Rhkhz3BN4UcuASqXY7luKMuZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XgKjIyQbPh/rkhwCClFC6ZkF+iGMVH5ZuWV2h6KCR98jCPvXoQ+0rFZC05UXC/Vkv7
         xvzIHirpB3TZ4QA5i61CTpG8oMS5ywo0PYFCToLI6Rdm2v8xI5wRmfQ0Pv4qfOD+S8Fm
         /tNPCLxgqFy8Kv4SQvyyVzZrLMuGmtu36+03o=
Received: by 10.115.111.3 with SMTP id o3mr5342731wam.210.1245993257767;
        Thu, 25 Jun 2009 22:14:17 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id k37sm5136634waf.7.2009.06.25.22.14.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 22:14:16 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 25 Jun 2009 22:14:13 -0700
X-Mailer: git-send-email 1.6.3.3.334.g916e1
In-Reply-To: <1245993250-8213-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122277>

Cleanup the documentation to explicitly state that --exclude-directory
is only meaningful when used with -u. Also make the documentation more
consistent with the usage message printed with read-tree --help-all.

The -m, --prefix, --reset options are performing similar actions
(setting some flags, read_cache_unmerged(), checking for illegal option
combinations). Instead of performing these actions when the options are
parsed, we delay performing them until after parse-opts has finished.

The bit fields in struct unpack_trees_options have been promoted to full
unsigned ints. This is necessary to avoid "foo ? 1 : 0" constructs to
set these fields.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

After some more thought, Hannes has convinced me that removing the first
mode is OK. I was trying to rewrite the documentation, and it just seemed
better the way it was.

A couple changes here:
    - reordered read_tree_options a bit to group the options with their
      dependent options better.
    - replaced OPT_BOOLEAN with OPT_SET_INT to avoid increment nature of
      OPT_BOOLEAN messing up logic depending on 1's and 0's only.

 Documentation/git-read-tree.txt |    5 +-
 builtin-read-tree.c             |  174 +++++++++++++++++----------------------
 unpack-trees.h                  |   24 +++---
 3 files changed, 92 insertions(+), 111 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 7160fa1..4a932b0 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -8,7 +8,10 @@ git-read-tree - Reads tree information into the index
 
 SYNOPSIS
 --------
-'git read-tree' (<tree-ish> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
+'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
+		[-u [--exclude-per-directory=<gitignore>] | -i]]
+		[--index-output=<file>]
+		<tree-ish1> [<tree-ish2> [<tree-ish3>]]
 
 
 DESCRIPTION
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 17c9631..9c2d634 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -12,6 +12,7 @@
 #include "unpack-trees.h"
 #include "dir.h"
 #include "builtin.h"
+#include "parse-options.h"
 
 static int nr_trees;
 static struct tree *trees[MAX_UNPACK_TREES];
@@ -29,7 +30,39 @@ static int list_tree(unsigned char *sha1)
 	return 0;
 }
 
-static const char read_tree_usage[] = "git read-tree (<sha> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
+static const char * const read_tree_usage[] = {
+	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u [--exclude-per-directory=<gitignore>] | -i]]  [--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]]",
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
 
@@ -39,6 +72,34 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	unsigned char sha1[20];
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
+	int prefix_set = 0;
+	const struct option read_tree_options[] = {
+		{ OPTION_CALLBACK, 0, "index-output", NULL, "FILE",
+		  "write resulting index to <FILE>",
+		  PARSE_OPT_NONEG, index_output_cb },
+		OPT__VERBOSE(&opts.verbose_update),
+		OPT_GROUP("Merging"),
+		OPT_SET_INT('m', NULL, &opts.merge,
+			    "perform a merge in addition to a read", 1),
+		OPT_SET_INT(0, "trivial", &opts.trivial_merges_only,
+			    "3-way merge if no file level merging required", 1),
+		OPT_SET_INT(0, "aggressive", &opts.aggressive,
+			    "3-way merge in presence of adds and removes", 1),
+		OPT_SET_INT(0, "reset", &opts.reset,
+			    "same as -m, but discard unmerged entries", 1),
+		{ OPTION_STRING, 0, "prefix", &opts.prefix, "<subdirectory>/",
+		  "read the tree into the index under <subdirectory>/",
+		  PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP },
+		OPT_SET_INT('u', NULL, &opts.update,
+			    "update working tree with merge result", 1),
+		{ OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
+		  "gitignore",
+		  "allow explicitly ignored files to be overwritten",
+		  PARSE_OPT_NONEG, exclude_per_directory_cb },
+		OPT_SET_INT('i', NULL, &opts.index_only,
+			    "don't check the working tree after merging", 1),
+		OPT_END()
+	};
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
@@ -49,104 +110,19 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
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
-
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
-
-		if (!strcmp(arg, "--trivial")) {
-			opts.trivial_merges_only = 1;
-			continue;
-		}
-
-		if (!strcmp(arg, "--aggressive")) {
-			opts.aggressive = 1;
-			continue;
-		}
+	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
+			     read_tree_usage, 0);
 
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
+	if (read_cache_unmerged() && (opts.prefix || opts.merge))
+		die("You need to resolve your current index first");
 
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
+	prefix_set = opts.prefix ? 1 : 0;
+	if (1 < opts.merge + opts.reset + prefix_set)
+		die("Which one? -m, --reset, or --prefix?");
+	stage = opts.merge = (opts.reset || opts.merge || prefix_set);
 
-		if (1 < opts.index_only + opts.update)
-			die("-u and -i at the same time makes no sense");
+	for (i = 0; i < argc; i++) {
+		const char *arg = argv[i];
 
 		if (get_sha1(arg, sha1))
 			die("Not a valid object name %s", arg);
@@ -154,6 +130,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			die("failed to unpack tree object %s", arg);
 		stage++;
 	}
+	if (1 < opts.index_only + opts.update)
+		die("-u and -i at the same time makes no sense");
 	if ((opts.update||opts.index_only) && !opts.merge)
 		die("%s is meaningless without -m, --reset, or --prefix",
 		    opts.update ? "-u" : "-i");
diff --git a/unpack-trees.h b/unpack-trees.h
index 1e0e232..d19df44 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -17,18 +17,18 @@ struct unpack_trees_error_msgs {
 };
 
 struct unpack_trees_options {
-	unsigned int reset:1,
-		     merge:1,
-		     update:1,
-		     index_only:1,
-		     nontrivial_merge:1,
-		     trivial_merges_only:1,
-		     verbose_update:1,
-		     aggressive:1,
-		     skip_unmerged:1,
-		     initial_checkout:1,
-		     diff_index_cached:1,
-		     gently:1;
+	unsigned int reset,
+		     merge,
+		     update,
+		     index_only,
+		     nontrivial_merge,
+		     trivial_merges_only,
+		     verbose_update,
+		     aggressive,
+		     skip_unmerged,
+		     initial_checkout,
+		     diff_index_cached,
+		     gently;
 	const char *prefix;
 	int pos;
 	struct dir_struct *dir;
-- 
1.6.3.3.334.g916e1
