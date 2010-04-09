From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP PATCH 2/4] Add "ignore_submodules" member to "struct unpack_trees_options"
Date: Fri, 09 Apr 2010 23:37:01 +0200
Message-ID: <4BBF9DFD.5080909@web.de>
References: <4BBF9D6F.2000006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 23:37:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Lsz-0007k8-CU
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 23:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab0DIVhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 17:37:04 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35391 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757761Ab0DIVhC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 17:37:02 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 94979156484C0;
	Fri,  9 Apr 2010 23:37:01 +0200 (CEST)
Received: from [80.128.86.62] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0Lsr-00051o-00; Fri, 09 Apr 2010 23:37:01 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BBF9D6F.2000006@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+H2je+bIMOvztf+fUEvYw0riz44jGQWgOHkEYr
	/q6OYLGv8QWcXW5FilvWzCq7tBw+91U8Zm38hA6wus0s6Xwj2e
	oP6RdwuD0L7/3z9nbllg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144476>

To be able to checkout submodule content the new member "ignore_submodules"
is added to "struct unpack_trees_options". In "unpack_callback()" it is
used to initialize the recently introduced member with the same name in
"struct checkout".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 archive.c           |    1 +
 builtin/clone.c     |    1 +
 builtin/commit.c    |    1 +
 builtin/merge.c     |    2 ++
 builtin/read-tree.c |    1 +
 builtin/reset.c     |    1 +
 diff-lib.c          |    2 ++
 merge-recursive.c   |    1 +
 unpack-trees.c      |    2 +-
 unpack-trees.h      |    3 ++-
 10 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index d700af3..d730bab 100644
--- a/archive.c
+++ b/archive.c
@@ -184,6 +184,7 @@ int write_archive_entries(struct archiver_args *args,
 		opts.src_index = &the_index;
 		opts.dst_index = &the_index;
 		opts.fn = oneway_merge;
+		opts.ignore_submodules = 1;
 		init_tree_desc(&t, args->tree->buffer, args->tree->size);
 		if (unpack_trees(1, &t, &opts))
 			return -1;
diff --git a/builtin/clone.c b/builtin/clone.c
index 05be999..f826fe9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -637,6 +637,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		opts.verbose_update = (option_verbosity > 0);
 		opts.src_index = &the_index;
 		opts.dst_index = &the_index;
+		opts.ignore_submodules = 1;

 		tree = parse_tree_indirect(our_head_points_at->old_sha1);
 		parse_tree(tree);
diff --git a/builtin/commit.c b/builtin/commit.c
index 017b8a5..419a4cf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -257,6 +257,7 @@ static void create_base_index(void)
 	opts.dst_index = &the_index;

 	opts.fn = oneway_merge;
+	opts.ignore_submodules = 1;
 	tree = parse_tree_indirect(head_sha1);
 	if (!tree)
 		die("failed to unpack HEAD tree object");
diff --git a/builtin/merge.c b/builtin/merge.c
index 37d414b..e589404 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -532,6 +532,7 @@ static int read_tree_trivial(unsigned char *common, unsigned char *head,
 	if (!trees[nr_trees++])
 		return -1;
 	opts.fn = threeway_merge;
+	opts.ignore_submodules = 1;
 	cache_tree_free(&active_cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
@@ -705,6 +706,7 @@ int checkout_fast_forward(const unsigned char *head, const unsigned char *remote
 	opts.merge = 1;
 	opts.fn = twoway_merge;
 	opts.msgs = get_porcelain_error_msgs();
+	opts.ignore_submodules = 1;

 	trees[nr_trees] = parse_tree_indirect(head);
 	if (!trees[nr_trees++])
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8bdcab1..cd3edfa 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -201,6 +201,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)

 	if (opts.debug_unpack)
 		opts.fn = debug_merge;
+	opts.ignore_submodules = 1;

 	cache_tree_free(&active_cache_tree);
 	for (i = 0; i < nr_trees; i++) {
diff --git a/builtin/reset.c b/builtin/reset.c
index 1283068..0ac7e6f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -98,6 +98,7 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 		nr++;
 		opts.fn = twoway_merge;
 	}
+	opts.ignore_submodules = 1;

 	if (!fill_tree_descriptor(desc + nr - 1, sha1))
 		return error("Failed to find tree of %s.", sha1_to_hex(sha1));
diff --git a/diff-lib.c b/diff-lib.c
index c9f6e05..64264a9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -451,6 +451,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	opts.unpack_data = revs;
 	opts.src_index = &the_index;
 	opts.dst_index = NULL;
+	opts.ignore_submodules = 1;

 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
@@ -509,6 +510,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	opts.unpack_data = &revs;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	opts.ignore_submodules = 1;

 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
diff --git a/merge-recursive.c b/merge-recursive.c
index 206c103..d294e62 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -186,6 +186,7 @@ static int git_merge_trees(int index_only,
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	opts.msgs = get_porcelain_error_msgs();
+	opts.ignore_submodules = 1;

 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
diff --git a/unpack-trees.c b/unpack-trees.c
index 151b422..6821d7d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -711,7 +711,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
-	state.ignore_submodules = 1;
+	state.ignore_submodules = o->ignore_submodules;

 	memset(&el, 0, sizeof(el));
 	if (!core_apply_sparse_checkout || !o->update)
diff --git a/unpack-trees.h b/unpack-trees.h
index ef70eab..bbb49fd 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -33,7 +33,8 @@ struct unpack_trees_options {
 		     diff_index_cached,
 		     debug_unpack,
 		     skip_sparse_checkout,
-		     gently;
+		     gently,
+		     ignore_submodules;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
-- 
1.7.1.rc0.248.g09203
