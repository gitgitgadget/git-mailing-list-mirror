From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 08/15] cache_tree_update(): Require relevant tree to be passed
Date: Sat,  4 Sep 2010 18:14:00 -0600
Message-ID: <1283645647-1891-9-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rf-0008IQ-1M
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558Ab0IEANO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:14 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60884 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab0IEANM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:12 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so579626pxi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rBWOLtLaLodYz3hsLRdKj760wLfYvYOOKbasiHT3QPY=;
        b=XSkPFI4gE6ydI5T/F27mBeTWe5+R1GEvNL+D/A6yoSrbVagGRPBHECNsk5XTDBhX0u
         17tpY6q8epq1bOoXb1TA0MRdQSga6jC4uvU8r/qD12gzqdGalgQvq8Vh6C0F/ZY2p/rd
         elpTrFOC/+u/002VmE7MZ26cU3hsTyNm3jxvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BLftiDEkjhjks9Uhx+BHB4D+oP7/S4lXfsB4KZLoCmbmeWqZf+HEPEnznADzDsfikQ
         nMB+Pv9lHLyrFHARxp3+/BnUpK9lXr7QFL1QvYnoN+cHCgX8Oy4KNaePuel1DK+oAjsT
         5hprxDRExwKoWEHB9qFPJI5TJDz7ngjfxZtvQ=
Received: by 10.115.77.17 with SMTP id e17mr1389890wal.108.1283645591833;
        Sat, 04 Sep 2010 17:13:11 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155392>

This updates the callers of cache_tree_update() to provide it a tree, so
that cache_tree_update() can use it for paths outside the sparse limits
together with index entries to write out a new set of trees.  In cases
where there is no obvious tree to provide: if in a sparse repository, the
code dies; if in a non-sparse repository, a NULL tree is provided (in the
non-sparse case, the tree provided is irrelevant since the index is
complete).

FIXME: The changes to buildin/merge.c and merge-recursive.[ch] are probably
wrong; a new tree needs to be generated via some trivial merge algorithm
and then used, rather than just using the HEAD commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c                  |    2 +-
 builtin/commit.c                    |   15 +++++++++++----
 builtin/merge.c                     |   19 ++++++++++---------
 builtin/revert.c                    |    7 ++++++-
 builtin/write-tree.c                |    6 +++++-
 cache-tree.c                        |    6 ++++--
 cache-tree.h                        |    4 ++--
 merge-recursive.c                   |    6 +++---
 merge-recursive.h                   |    2 +-
 t/t5720-sparse-repository-basics.sh |    2 +-
 test-dump-cache-tree.c              |    3 ++-
 11 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b10e8a2..3299aeb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -454,7 +454,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 			 */
 			init_merge_options(&o);
 			o.verbosity = 0;
-			work = write_tree_from_memory(&o);
+			work = write_tree_from_memory(&o, old->commit->tree);
 
 			ret = reset_tree(new->commit->tree, opts, 1);
 			if (ret)
diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..ad6ecb2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -550,8 +550,8 @@ static int ends_rfc2822_footer(struct strbuf *sb)
 	return 1;
 }
 
-static int prepare_to_commit(const char *index_file, const char *prefix,
-			     struct wt_status *s)
+static int prepare_to_commit(const char *index_file, struct tree *head,
+			     const char *prefix, struct wt_status *s)
 {
 	struct stat statbuf;
 	int commitable, saved_color_setting;
@@ -733,7 +733,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (!active_cache_tree)
 		active_cache_tree = cache_tree();
 	if (cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0) < 0) {
+			      active_cache, active_nr, head, 0, 0) < 0) {
 		error("Error building trees");
 		return 0;
 	}
@@ -1246,6 +1246,7 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
+	struct tree *head_tree = NULL;
 	const char *index_file, *reflog_msg;
 	char *nl, *p;
 	unsigned char commit_sha1[20];
@@ -1273,7 +1274,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  */
-	if (!prepare_to_commit(index_file, prefix, &s)) {
+	if (git_sparse_pathspecs && !initial_commit) {
+		head_tree = parse_tree_indirect(head_sha1);
+		if (!head_tree)
+			die("failed to unpack HEAD tree object");
+		parse_tree(head_tree);
+	}
+	if (!prepare_to_commit(index_file, head_tree, prefix, &s)) {
 		rollback_index_files();
 		return 1;
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index cbb6c0d..f6fe51e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -557,9 +557,9 @@ static int read_tree_trivial(unsigned char *common, unsigned char *head,
 	return 0;
 }
 
-static void write_tree_trivial(unsigned char *sha1)
+static void write_tree_trivial(unsigned char *sha1, struct tree *head_tree)
 {
-	if (write_cache_as_tree(sha1, 0, NULL))
+	if (write_cache_as_tree(sha1, 0, head_tree, NULL))
 		die("git write-tree failed to write a tree");
 }
 
@@ -778,12 +778,12 @@ static void add_strategies(const char *string, unsigned attr)
 
 }
 
-static int merge_trivial(void)
+static int merge_trivial(struct tree *head_tree)
 {
 	unsigned char result_tree[20], result_commit[20];
 	struct commit_list *parent = xmalloc(sizeof(*parent));
 
-	write_tree_trivial(result_tree);
+	write_tree_trivial(result_tree, head_tree);
 	printf("Wonderful.\n");
 	parent->item = lookup_commit(head);
 	parent->next = xmalloc(sizeof(*parent->next));
@@ -901,6 +901,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	const char *head_arg;
 	int flag, head_invalid = 0, i;
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
+	struct commit *head_commit;
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
@@ -1056,12 +1057,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			allow_trivial = 0;
 	}
 
+	head_commit = lookup_commit(head);
 	if (!remoteheads->next)
-		common = get_merge_bases(lookup_commit(head),
-				remoteheads->item, 1);
+		common = get_merge_bases(head_commit, remoteheads->item, 1);
 	else {
 		struct commit_list *list = remoteheads;
-		commit_list_insert(lookup_commit(head), &list);
+		commit_list_insert(head_commit, &list);
 		common = get_octopus_merge_bases(list);
 		free(list);
 	}
@@ -1127,7 +1128,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			printf("Trying really trivial in-index merge...\n");
 			if (!read_tree_trivial(common->item->object.sha1,
 					head, remoteheads->item->object.sha1))
-				return merge_trivial();
+				return merge_trivial(head_commit->tree);
 			printf("Nope.\n");
 		}
 	} else {
@@ -1232,7 +1233,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 
 		/* Automerge succeeded. */
-		write_tree_trivial(result_tree);
+		write_tree_trivial(result_tree, head_commit->tree);
 		automerge_was_ok = 1;
 		break;
 	}
diff --git a/builtin/revert.c b/builtin/revert.c
index 4b47ace..4e95589 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -404,7 +404,12 @@ static int do_pick_commit(void)
 		 * that represents the "current" state for merge-recursive
 		 * to work on.
 		 */
-		if (write_cache_as_tree(head, 0, NULL))
+		struct tree *non_sparse_tree;
+		if (get_sha1("HEAD", head))
+			non_sparse_tree = NULL;
+		else
+			non_sparse_tree = lookup_commit(head)->tree;
+		if (write_cache_as_tree(head, 0, non_sparse_tree, NULL))
 			die ("Your index file is unmerged.");
 	} else {
 		if (get_sha1("HEAD", head))
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index b223af4..1e459b6 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -19,6 +19,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	int flags = 0, ret;
 	const char *prefix = NULL;
 	unsigned char sha1[20];
+	struct tree *non_sparse_tree = NULL;
 	const char *me = "git-write-tree";
 	struct option write_tree_options[] = {
 		OPT_BIT(0, "missing-ok", &flags, "allow missing objects",
@@ -37,7 +38,10 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
-	ret = write_cache_as_tree(sha1, flags, prefix);
+	if (git_sparse_pathspecs)
+		/* FIXME: Let user specify non_sparse_tree?  Just use HEAD? */
+		die("Error: write-tree in a sparse repository would clip paths outside sparse region.");
+	ret = write_cache_as_tree(sha1, flags, non_sparse_tree, prefix);
 	switch (ret) {
 	case 0:
 		printf("%s\n", sha1_to_hex(sha1));
diff --git a/cache-tree.c b/cache-tree.c
index 2ba6a76..4309fa8 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -452,6 +452,7 @@ static int update_one(struct cache_tree *it,
 int cache_tree_update(struct cache_tree *it,
 		      struct cache_entry **cache,
 		      int entries,
+		      struct tree *head,
 		      int missing_ok,
 		      int dryrun)
 {
@@ -460,7 +461,7 @@ int cache_tree_update(struct cache_tree *it,
 	if (i)
 		return i;
 
-	i = update_one(it, cache, entries, NULL, "", 0, missing_ok, dryrun);
+	i = update_one(it, cache, entries, head, "", 0, missing_ok, dryrun);
 	if (i < 0)
 		return i;
 	return 0;
@@ -629,7 +630,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 	return it;
 }
 
-int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
+int write_cache_as_tree(unsigned char *sha1, int flags, struct tree *head, const char *prefix)
 {
 	int entries, was_valid, newfd;
 	struct lock_file *lock_file;
@@ -657,6 +658,7 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 
 		if (cache_tree_update(active_cache_tree,
 				      active_cache, active_nr,
+				      head,
 				      missing_ok, 0) < 0)
 			return WRITE_TREE_UNMERGED_INDEX;
 		if (0 <= newfd) {
diff --git a/cache-tree.h b/cache-tree.h
index 3df641f..85cc016 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -29,7 +29,7 @@ void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct cache_tree *);
-int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int, int);
+int cache_tree_update(struct cache_tree *, struct cache_entry **, int, struct tree*, int, int);
 
 /* bitmasks to write_cache_as_tree flags */
 #define WRITE_TREE_MISSING_OK 1
@@ -40,7 +40,7 @@ int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int, int)
 #define WRITE_TREE_UNMERGED_INDEX (-2)
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
-int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix);
+int write_cache_as_tree(unsigned char *sha1, int flags, struct tree *head, const char *prefix);
 void prime_cache_tree(struct cache_tree **, struct tree *);
 
 extern int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
diff --git a/merge-recursive.c b/merge-recursive.c
index 325a97b..b74c29f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -191,7 +191,7 @@ static int git_merge_trees(int index_only,
 	return rc;
 }
 
-struct tree *write_tree_from_memory(struct merge_options *o)
+struct tree *write_tree_from_memory(struct merge_options *o, struct tree *head)
 {
 	struct tree *result = NULL;
 
@@ -212,7 +212,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
 	    cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0) < 0)
+			      active_cache, active_nr, head, 0, 0) < 0)
 		die("error building trees");
 
 	result = lookup_tree(active_cache_tree->sha1);
@@ -1361,7 +1361,7 @@ int merge_trees(struct merge_options *o,
 		clean = 1;
 
 	if (o->call_depth)
-		*result = write_tree_from_memory(o);
+		*result = write_tree_from_memory(o, head);
 
 	return clean;
 }
diff --git a/merge-recursive.h b/merge-recursive.h
index 2eb5d1a..26110e2 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -51,7 +51,7 @@ int merge_recursive_generic(struct merge_options *o,
 			    struct commit **result);
 
 void init_merge_options(struct merge_options *o);
-struct tree *write_tree_from_memory(struct merge_options *o);
+struct tree *write_tree_from_memory(struct merge_options *o, struct tree *head);
 
 int parse_merge_opt(struct merge_options *out, const char *s);
 
diff --git a/t/t5720-sparse-repository-basics.sh b/t/t5720-sparse-repository-basics.sh
index d04e171..88f40ab 100755
--- a/t/t5720-sparse-repository-basics.sh
+++ b/t/t5720-sparse-repository-basics.sh
@@ -115,7 +115,7 @@ test_expect_success 'basic: add works' '
 	git add sub/b/whatever
 '
 
-test_expect_failure 'basic: commit works' '
+test_expect_success 'basic: commit works' '
 	git commit -m "Commit in a sparse clone" &&
 	git rev-parse master^{tree} &&
 	git rev-parse master:sub &&
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index 1f73f1e..ef0644f 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -57,8 +57,9 @@ static int dump_cache_tree(struct cache_tree *it,
 int main(int ac, char **av)
 {
 	struct cache_tree *another = cache_tree();
+	struct tree *non_sparse_tree = NULL; /* We don't test sparse clones */
 	if (read_cache() < 0)
 		die("unable to read index file");
-	cache_tree_update(another, active_cache, active_nr, 0, 1);
+	cache_tree_update(another, active_cache, active_nr, non_sparse_tree, 0, 1);
 	return dump_cache_tree(active_cache_tree, another, "");
 }
-- 
1.7.2.2.140.gd06af
