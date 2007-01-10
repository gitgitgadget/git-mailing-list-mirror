From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Wed, 10 Jan 2007 11:28:14 -0800
Message-ID: <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 20:28:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4j7j-0001YY-Do
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 20:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbXAJT2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 14:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbXAJT2b
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 14:28:31 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:46727 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965032AbXAJT2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 14:28:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110192830.SUF2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 14:28:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9XTf1W00K1kojtg0000000; Wed, 10 Jan 2007 14:27:39 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20070107163112.GA9336@steel.home> (Alex Riesen's message of
	"Sun, 7 Jan 2007 17:31:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36525>

This comes on top of yours.  

I'm reproducing all the merges in linux-2.6 history to make sure
the base one, yours and this produce the same result (the same
clean merge, or the same unmerged index and the same diff from
HEAD).  So far it is looking good.

-- >8 --
From: Junio C Hamano <junkio@cox.net>
Date: Wed, 10 Jan 2007 11:20:58 -0800
Subject: [PATCH] merge-recursive: do not use on-file index when not needed.

This revamps the merge-recursive implementation following the
outline in:

	Message-ID: <7v8xgileza.fsf@assigned-by-dhcp.cox.net>

There is no need to write out the index until the very end just
once from merge-recursive.  Also there is no need to write out
the resulting tree object for the simple case of merging with a
single merge base.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-recursive.c |  169 ++++++++++++++--------------------------------------
 1 files changed, 46 insertions(+), 123 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index aab4c34..5237021 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -110,35 +110,6 @@ static void output_commit_title(struct commit *commit)
 	}
 }
 
-static const char *current_index_file = NULL;
-static const char *original_index_file;
-static const char *temporary_index_file;
-static int cache_dirty = 0;
-
-static int flush_cache(void)
-{
-	/* flush temporary index */
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int fd = hold_lock_file_for_update(lock, current_index_file, 1);
-	if (write_cache(fd, active_cache, active_nr) ||
-			close(fd) || commit_lock_file(lock))
-		die ("unable to write %s", current_index_file);
-	discard_cache();
-	cache_dirty = 0;
-	return 0;
-}
-
-static void setup_index(int temp)
-{
-	current_index_file = temp ? temporary_index_file: original_index_file;
-	if (cache_dirty) {
-		discard_cache();
-		cache_dirty = 0;
-	}
-	unlink(temporary_index_file);
-	discard_cache();
-}
-
 static struct cache_entry *make_cache_entry(unsigned int mode,
 		const unsigned char *sha1, const char *path, int stage, int refresh)
 {
@@ -167,9 +138,6 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 		const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
-	if (!cache_dirty)
-		read_cache_from(current_index_file);
-	cache_dirty++;
 	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, refresh);
 	if (!ce)
 		return error("cache_addinfo failed: %s", strerror(cache_errno));
@@ -187,26 +155,6 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
  */
 static int index_only = 0;
 
-static int git_read_tree(struct tree *tree)
-{
-	int rc;
-	struct object_list *trees = NULL;
-	struct unpack_trees_options opts;
-
-	if (cache_dirty)
-		die("read-tree with dirty cache");
-
-	memset(&opts, 0, sizeof(opts));
-	object_list_append(&tree->object, &trees);
-	rc = unpack_trees(trees, &opts);
-	cache_tree_free(&active_cache_tree);
-
-	if (rc == 0)
-		cache_dirty = 1;
-
-	return rc;
-}
-
 static int git_merge_trees(int index_only,
 			   struct tree *common,
 			   struct tree *head,
@@ -216,11 +164,6 @@ static int git_merge_trees(int index_only,
 	struct object_list *trees = NULL;
 	struct unpack_trees_options opts;
 
-	if (!cache_dirty) {
-		read_cache_from(current_index_file);
-		cache_dirty = 1;
-	}
-
 	memset(&opts, 0, sizeof(opts));
 	if (index_only)
 		opts.index_only = 1;
@@ -236,39 +179,37 @@ static int git_merge_trees(int index_only,
 
 	rc = unpack_trees(trees, &opts);
 	cache_tree_free(&active_cache_tree);
-
-	cache_dirty = 1;
-
 	return rc;
 }
 
+static int unmerged_index(void)
+{
+	int i;
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (ce_stage(ce))
+			return 1;
+	}
+	return 0;
+}
+
 static struct tree *git_write_tree(void)
 {
 	struct tree *result = NULL;
 
-	if (cache_dirty) {
-		unsigned i;
-		for (i = 0; i < active_nr; i++) {
-			struct cache_entry *ce = active_cache[i];
-			if (ce_stage(ce))
-				return NULL;
-		}
-	} else
-		read_cache_from(current_index_file);
+	if (unmerged_index())
+		return NULL;
 
 	if (!active_cache_tree)
 		active_cache_tree = cache_tree();
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
-			cache_tree_update(active_cache_tree,
-				active_cache, active_nr, 0, 0) < 0)
+	    cache_tree_update(active_cache_tree,
+			      active_cache, active_nr, 0, 0) < 0)
 		die("error building trees");
 
 	result = lookup_tree(active_cache_tree->sha1);
 
-	flush_cache();
-	cache_dirty = 0;
-
 	return result;
 }
 
@@ -331,10 +272,7 @@ static struct path_list *get_unmerged(void)
 	int i;
 
 	unmerged->strdup_paths = 1;
-	if (!cache_dirty) {
-		read_cache_from(current_index_file);
-		cache_dirty++;
-	}
+
 	for (i = 0; i < active_nr; i++) {
 		struct path_list_item *item;
 		struct stage_data *e;
@@ -469,9 +407,6 @@ static int remove_file(int clean, const char *path, int no_wd)
 	int update_working_directory = !index_only && !no_wd;
 
 	if (update_cache) {
-		if (!cache_dirty)
-			read_cache_from(current_index_file);
-		cache_dirty++;
 		if (remove_file_from_cache(path))
 			return -1;
 	}
@@ -1105,9 +1040,7 @@ static int merge_trees(struct tree *head,
 		    sha1_to_hex(head->object.sha1),
 		    sha1_to_hex(merge->object.sha1));
 
-	*result = git_write_tree();
-
-	if (!*result) {
+	if (unmerged_index()) {
 		struct path_list *entries, *re_head, *re_merge;
 		int i;
 		path_list_clear(&current_file_set, 1);
@@ -1128,17 +1061,11 @@ static int merge_trees(struct tree *head,
 			if (!process_entry(path, e, branch1, branch2))
 				clean = 0;
 		}
-		if (cache_dirty)
-			flush_cache();
 
 		path_list_clear(re_merge, 0);
 		path_list_clear(re_head, 0);
 		path_list_clear(entries, 1);
 
-		if (clean || index_only)
-			*result = git_write_tree();
-		else
-			*result = NULL;
 	} else {
 		clean = 1;
 		printf("merging of trees %s and %s resulted in %s\n",
@@ -1146,6 +1073,8 @@ static int merge_trees(struct tree *head,
 		       sha1_to_hex(merge->object.sha1),
 		       sha1_to_hex((*result)->object.sha1));
 	}
+	if (index_only)
+		*result = git_write_tree();
 
 	return clean;
 }
@@ -1170,10 +1099,10 @@ static int merge(struct commit *h1,
 		 const char *branch1,
 		 const char *branch2,
 		 int call_depth /* =0 */,
-		 struct commit *ancestor /* =None */,
+		 struct commit_list *ca,
 		 struct commit **result)
 {
-	struct commit_list *ca = NULL, *iter;
+	struct commit_list *iter;
 	struct commit *merged_common_ancestors;
 	struct tree *mrtree;
 	int clean;
@@ -1182,10 +1111,10 @@ static int merge(struct commit *h1,
 	output_commit_title(h1);
 	output_commit_title(h2);
 
-	if (ancestor)
-		commit_list_insert(ancestor, &ca);
-	else
-		ca = reverse_commit_list(get_merge_bases(h1, h2, 1));
+	if (!ca) {
+		ca = get_merge_bases(h1, h2, 1);
+		ca = reverse_commit_list(ca);
+	}
 
 	output("found %u common ancestor(s):", commit_list_count(ca));
 	for (iter = ca; iter; iter = iter->next)
@@ -1211,6 +1140,7 @@ static int merge(struct commit *h1,
 		 * merge_trees has always overwritten it: the commited
 		 * "conflicts" were already resolved.
 		 */
+		discard_cache();
 		merge(merged_common_ancestors, iter->item,
 		      "Temporary merge branch 1",
 		      "Temporary merge branch 2",
@@ -1223,25 +1153,21 @@ static int merge(struct commit *h1,
 			die("merge returned no commit");
 	}
 
+	discard_cache();
 	if (call_depth == 0) {
-		setup_index(0 /* $GIT_DIR/index */);
+		read_cache();
 		index_only = 0;
-	} else {
-		setup_index(1 /* temporary index */);
-		git_read_tree(h1->tree);
+	} else
 		index_only = 1;
-	}
 
 	clean = merge_trees(h1->tree, h2->tree, merged_common_ancestors->tree,
 			    branch1, branch2, &mrtree);
 
-	if (!ancestor && (clean || index_only)) {
+	if (index_only) {
 		*result = make_virtual_commit(mrtree, "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
-	} else
-		*result = NULL;
-
+	}
 	return clean;
 }
 
@@ -1277,19 +1203,16 @@ static struct commit *get_ref(const char *ref)
 
 int main(int argc, char *argv[])
 {
-	static const char *bases[2];
+	static const char *bases[20];
 	static unsigned bases_count = 0;
 	int i, clean;
 	const char *branch1, *branch2;
 	struct commit *result, *h1, *h2;
+	struct commit_list *ca = NULL;
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	int index_fd;
 
 	git_config(git_default_config); /* core.filemode */
-	original_index_file = getenv(INDEX_ENVIRONMENT);
-
-	if (!original_index_file)
-		original_index_file = xstrdup(git_path("index"));
-
-	temporary_index_file = xstrdup(git_path("mrg-rcrsv-tmp-idx"));
 
 	if (argc < 4)
 		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
@@ -1313,18 +1236,18 @@ int main(int argc, char *argv[])
 	branch2 = better_branch_name(branch2);
 	printf("Merging %s with %s\n", branch1, branch2);
 
-	if (bases_count == 1) {
-		struct commit *ancestor = get_ref(bases[0]);
-		clean = merge(h1, h2, branch1, branch2, 0, ancestor, &result);
-	} else
-		clean = merge(h1, h2, branch1, branch2, 0, NULL, &result);
+	index_fd = hold_lock_file_for_update(lock, get_index_file(), 1);
 
-	if (cache_dirty)
-		flush_cache();
+	for (i = 0; i < bases_count; i++) {
+		struct commit *ancestor = get_ref(bases[i]);
+		ca = commit_list_insert(ancestor, &ca);
+	}
+	clean = merge(h1, h2, branch1, branch2, 0, ca, &result);
+
+	if (active_cache_changed &&
+	    (write_cache(index_fd, active_cache, active_nr) ||
+	     close(index_fd) || commit_lock_file(lock)))
+			die ("unable to write %s", get_index_file());
 
 	return clean ? 0: 1;
 }
-
-/*
-vim: sw=8 noet
-*/
-- 
1.4.4.4.gc3d6
