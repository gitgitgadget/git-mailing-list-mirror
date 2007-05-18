From: skimo@liacs.nl
Subject: [PATCH 07/16] git-read-tree: take --submodules option
Date: Fri, 18 May 2007 21:24:56 +0200
Message-ID: <11795163061588-git-send-email-skimo@liacs.nl>
References: <11795163053812-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:25:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp855-0002MY-N4
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757573AbXERTZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757199AbXERTZe
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:25:34 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:55761 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757573AbXERTZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:25:23 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4IJPDeJ005201;
	Fri, 18 May 2007 21:25:18 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id BEB8C7DDA6; Fri, 18 May 2007 21:25:06 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11795163053812-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47642>

From: Sven Verdoolaege <skimo@kotnet.org>

This option currently has no effect.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 builtin-read-tree.c |   25 ++++++++++++++++++++++---
 cache.h             |    3 ++-
 unpack-trees.c      |    1 +
 unpack-trees.h      |    1 +
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 316fb0f..929dd95 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -87,14 +87,23 @@ static void prime_cache_tree(void)
 static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
 
 static struct lock_file lock_file;
+static struct unpack_trees_options opts;
+
+static int git_read_tree_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "core.submodules")) {
+		opts.submodules = git_config_bool(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value);
+}
 
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 {
 	int i, newfd, stage = 0;
 	unsigned char sha1[20];
-	struct unpack_trees_options opts;
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
 
 	setup_git_directory();
@@ -102,7 +111,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
 	newfd = hold_locked_index(&lock_file, 1);
 
-	git_config(git_default_config);
+	git_config(git_read_tree_config);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -172,6 +181,16 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, "--no-submodules")) {
+			opts.submodules = 0;
+			continue;
+		}
+
+		if (!strcmp(arg, "--submodules")) {
+			opts.submodules = 1;
+			continue;
+		}
+
 		/* "-m" stands for "merge", meaning we start in stage 1 */
 		if (!strcmp(arg, "-m")) {
 			if (stage || opts.merge || opts.prefix)
diff --git a/cache.h b/cache.h
index 6acc330..42a275e 100644
--- a/cache.h
+++ b/cache.h
@@ -406,7 +406,8 @@ struct checkout {
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
-		 refresh_cache:1;
+		 refresh_cache:1,
+		 submodules:1;
 };
 
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
diff --git a/unpack-trees.c b/unpack-trees.c
index 3dac150..5fa637a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -352,6 +352,7 @@ int unpack_trees(struct object_list *trees, struct unpack_trees_options *o)
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
+	state.submodules = o->submodules;
 
 	o->merge_size = len;
 
diff --git a/unpack-trees.h b/unpack-trees.h
index fee7da4..21005d9 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -15,6 +15,7 @@ struct unpack_trees_options {
 	int trivial_merges_only;
 	int verbose_update;
 	int aggressive;
+	int submodules;
 	const char *prefix;
 	int pos;
 	struct dir_struct *dir;
-- 
1.5.2.rc3.783.gc7476-dirty
