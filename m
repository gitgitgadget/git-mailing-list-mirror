From: skimo@liacs.nl
Subject: [PATCH 07/22] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 00:22:56 +0200
Message-ID: <11799589921419-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFs-0003VS-9c
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759254AbXEWWYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756675AbXEWWYI
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:24:08 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33796 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755293AbXEWWXs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:48 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNGdi011562;
	Thu, 24 May 2007 00:23:21 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 18CA77DDA5; Thu, 24 May 2007 00:23:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48202>

From: Sven Verdoolaege <skimo@kotnet.org>

This option currently has no effect.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Documentation/config.txt |    4 ++++
 builtin-read-tree.c      |   25 ++++++++++++++++++++++---
 cache.h                  |    3 ++-
 unpack-trees.c           |    1 +
 unpack-trees.h           |    1 +
 5 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 179cb17..5045443 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -261,6 +261,10 @@ core.excludeFile::
 	'.git/info/exclude', git looks into this file for patterns
 	of files which are not meant to be tracked.
 
+core.submodules
+	If true, gitlink:git-checkout[1] also checks out submodules.
+	False by default.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
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
index 6ca65ac..873cb8d 100644
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
1.5.2.784.g5532e
