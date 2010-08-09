From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/5] unpack_trees: group error messages by type
Date: Mon,  9 Aug 2010 16:20:01 +0200
Message-ID: <1281363602-27856-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 09 16:22:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiTFQ-0003U4-CR
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 16:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733Ab0HIOWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 10:22:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55016 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756725Ab0HIOWc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 10:22:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o79E9TDX028321
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Aug 2010 16:09:30 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiTD5-0006RK-Rz; Mon, 09 Aug 2010 16:20:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiTD5-00009E-QM; Mon, 09 Aug 2010 16:20:15 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 09 Aug 2010 16:09:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o79E9TDX028321
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281967775.27584@CT7hUBTfHNozL4PBm/EWcQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152969>

When an error is encountered, it calls add_rejected_file() which either
- directly displays the error message and stops if in plumbing mode
  (i.e. if show_all_errors is not initialized at 1)
- or stores it so that it will be displayed at the end with display_error_msgs(),

Storing the files by error type permits to have a list of files for
which there is the same error instead of having a serie of almost
identical errors.

As each bind_overlap error combines a file and an old file, a list cannot be
done, therefore, theses errors are not stored but directly displayed.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/technical/api-tree-walking.txt |    2 +
 builtin/checkout.c                           |    1 +
 builtin/merge.c                              |    1 +
 merge-recursive.c                            |   25 ++++++--
 t/t3030-merge-recursive.sh                   |    2 +-
 t/t3400-rebase.sh                            |    3 +-
 t/t3404-rebase-interactive.sh                |    3 +-
 tree-walk.c                                  |   11 +++-
 tree-walk.h                                  |    1 +
 unpack-trees.c                               |   78 ++++++++++++++++++++++++-
 unpack-trees.h                               |   13 ++++-
 11 files changed, 123 insertions(+), 17 deletions(-)

diff --git a/Documentation/technical/api-tree-walking.txt b/Documentation/technical/api-tree-walking.txt
index 55b7286..14af37c 100644
--- a/Documentation/technical/api-tree-walking.txt
+++ b/Documentation/technical/api-tree-walking.txt
@@ -42,6 +42,8 @@ information.
 
 * `data` can be anything the `fn` callback would want to use.
 
+* `show_all_errors` tells whether to stop at the first error or not.
+
 Initializing
 ------------
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 22bf47c..894bb84 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -392,6 +392,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.dir = xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |= DIR_SHOW_IGNORED;
 		topts.dir->exclude_per_dir = ".gitignore";
+		topts.show_all_errors = 1;
 		tree = parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   (unsigned char *)EMPTY_TREE_SHA1_BIN);
diff --git a/builtin/merge.c b/builtin/merge.c
index de5a0f6..1bcf7fd 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -704,6 +704,7 @@ int checkout_fast_forward(const unsigned char *head, const unsigned char *remote
 	opts.verbose_update = 1;
 	opts.merge = 1;
 	opts.fn = twoway_merge;
+	opts.show_all_errors = 1;
 	set_porcelain_error_msgs(opts.msgs, "merge");
 
 	trees[nr_trees] = parse_tree_indirect(head);
diff --git a/merge-recursive.c b/merge-recursive.c
index 8c1b189..e292d6e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1184,29 +1184,42 @@ void set_porcelain_error_msgs(const char **msgs, const char *cmd)
 	char *tmp;
 	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
 	if (advice_commit_before_merge)
-		msg = "Your local changes to '%%s' would be overwritten by %s.  Aborting.\n"
+		msg = "Your local changes to the following files would be overwritten by %s:\n%%s"
 			"Please, commit your changes or stash them before you can %s.";
 	else
-		msg = "Your local changes to '%%s' would be overwritten by %s.  Aborting.";
-	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 3);
+		msg = "Your local changes to the following files would be overwritten by %s:\n%%s";
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 2);
 	sprintf(tmp, msg, cmd, cmd2);
 	msgs[would_overwrite] = tmp;
 	msgs[not_uptodate_file] = tmp;
 
 	msgs[not_uptodate_dir] =
-		"Updating '%s' would lose untracked files in it.  Aborting.";
+		"Updating the following directories would lose untracked files in it:\n%s";
 
 	if (advice_commit_before_merge)
-		msg = "Untracked working tree file '%%s' would be %s by %s.  Aborting"
+		msg = "The following untracked working tree files would be %s by %s:\n%%s"
 			"Please move or remove them before you can %s.";
 	else
-		msg = "Untracked working tree file '%%s' would be %s by %s.  Aborting";
+		msg = "The following untracked working tree files would be %s by %s:\n%%s";
 	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("removed") + strlen(cmd2) - 4);
 	sprintf(tmp, msg, "removed", cmd, cmd2);
 	msgs[would_lose_untracked_removed] = tmp;
 	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("overwritten") + strlen(cmd2) - 4);
 	sprintf(tmp, msg, "overwritten", cmd, cmd2);
 	msgs[would_lose_untracked_overwritten] = tmp;
+
+	/*
+	 * Special case: bind_overlap refers to a pair of paths, we
+	 * cannot easily display it as a list.
+	 */
+	msgs[bind_overlap] = "Entry '%s' overlaps with '%s'.  Cannot bind.";
+
+	msgs[sparse_not_uptodate_file] =
+		"Cannot update sparse checkout: the following entries are not up-to-date:\n%s";
+	msgs[would_lose_orphaned_overwritten] =
+		"The following Working tree files would be overwritten by sparse checkout update:\n%s";
+	msgs[would_lose_orphaned_removed] =
+		"The following Working tree files would be removed by sparse checkout update:\n%s";
 }
 
 int merge_trees(struct merge_options *o,
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index d541544..efe2900 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -294,7 +294,7 @@ test_expect_success 'fail if the index has unresolved entries' '
 	grep "You have not concluded your merge" out &&
 	rm -f .git/MERGE_HEAD &&
 	test_must_fail git merge "$c5" 2> out &&
-	grep "Your local changes to .* would be overwritten by merge." out
+	grep "Your local changes to the following files would be overwritten by merge:" out
 '
 
 test_expect_success 'merge-recursive remove conflict' '
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index d98c7b5..45ef282 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -129,7 +129,8 @@ test_expect_success 'rebase a single mode change' '
 test_expect_success 'Show verbose error when HEAD could not be detached' '
      : > B &&
      test_must_fail git rebase topic 2> output.err > output.out &&
-     grep "Untracked working tree file .B. would be overwritten" output.err
+     grep "The following untracked working tree files would be overwritten by checkout:" output.err &&
+     grep B output.err
 '
 rm -f B
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9f03ce6..3af3f60 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -150,8 +150,9 @@ test_expect_success 'abort with error when new base cannot be checked out' '
 	git rm --cached file1 &&
 	git commit -m "remove file in base" &&
 	test_must_fail git rebase -i master > output 2>&1 &&
-	grep "Untracked working tree file .file1. would be overwritten" \
+	grep "The following untracked working tree files would be overwritten by checkout:" \
 		output &&
+	grep "file1" output &&
 	! test -d .git/rebase-merge &&
 	git reset --hard HEAD^
 '
diff --git a/tree-walk.c b/tree-walk.c
index 67a9a0c..a9bbf4e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tree-walk.h"
+#include "unpack-trees.h"
 #include "tree.h"
 
 static const char *get_mode(const char *str, unsigned int *modep)
@@ -310,6 +311,7 @@ static void free_extended_entry(struct tree_desc_x *t)
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 {
 	int ret = 0;
+	int error = 0;
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
 	int i;
 	struct tree_desc_x *tx = xcalloc(n, sizeof(*tx));
@@ -377,8 +379,11 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		if (!mask)
 			break;
 		ret = info->fn(n, mask, dirmask, entry, info);
-		if (ret < 0)
-			break;
+		if (ret < 0) {
+			error = ret;
+			if (!info->show_all_errors)
+				break;
+		}
 		mask &= ret;
 		ret = 0;
 		for (i = 0; i < n; i++)
@@ -389,7 +394,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	for (i = 0; i < n; i++)
 		free_extended_entry(tx + i);
 	free(tx);
-	return ret;
+	return error;
 }
 
 static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result, unsigned *mode)
diff --git a/tree-walk.h b/tree-walk.h
index 42110a4..88ea7e9 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -45,6 +45,7 @@ struct traverse_info {
 	unsigned long conflicts;
 	traverse_callback_t fn;
 	void *data;
+	int show_all_errors;
 };
 
 int get_tree_entry(const unsigned char *, const char *, unsigned char *, unsigned *);
diff --git a/unpack-trees.c b/unpack-trees.c
index 143f897..75249db 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -66,6 +66,73 @@ static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 }
 
 /*
+ * add error messages on path <path>
+ * corresponding to the type <e> with the message <msg>
+ * indicating if it should be display in porcelain or not
+ */
+static int add_rejected_path(struct unpack_trees_options *o,
+			     enum unpack_trees_error_types e,
+			     const char *path)
+{
+	struct rejected_paths_list *newentry;
+	int porcelain = o && (o)->msgs[e];
+	/*
+	 * simply display the given error message if in plumbing mode
+	 */
+	if (!porcelain)
+		o->show_all_errors = 0;
+	if (!o->show_all_errors)
+		return error(ERRORMSG(o, e), path);
+
+	/*
+	 * Otherwise, insert in a list for future display by
+	 * display_error_msgs()
+	 */
+	newentry = xmalloc(sizeof(struct rejected_paths_list));
+	newentry->path = (char *)path;
+	newentry->next = o->unpack_rejects[e];
+	o->unpack_rejects[e] = newentry;
+	return -1;
+}
+
+/*
+ * free all the structures allocated for the error <e>
+ */
+static void free_rejected_paths(struct unpack_trees_options *o,
+				enum unpack_trees_error_types e)
+{
+	while (o->unpack_rejects[e]) {
+		struct rejected_paths_list *del = o->unpack_rejects[e];
+		o->unpack_rejects[e] = o->unpack_rejects[e]->next;
+		free(del);
+	}
+	free(o->unpack_rejects[e]);
+}
+
+/*
+ * display all the error messages stored in a nice way
+ */
+static void display_error_msgs(struct unpack_trees_options *o)
+{
+	int e;
+	int something_displayed = 0;
+	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
+		if (o->unpack_rejects[e]) {
+			struct rejected_paths_list *rp;
+			struct strbuf path = STRBUF_INIT;
+			something_displayed = 1;
+			for (rp = o->unpack_rejects[e]; rp; rp = rp->next)
+				strbuf_addf(&path, "\t%s\n", rp->path);
+			error(ERRORMSG(o, e), path.buf);
+			strbuf_release(&path);
+			free_rejected_paths(o, e);
+		}
+	}
+	if (something_displayed)
+		printf("Aborting\n");
+}
+
+/*
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
@@ -756,6 +823,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		setup_traverse_info(&info, prefix);
 		info.fn = unpack_callback;
 		info.data = o;
+		info.show_all_errors = o->show_all_errors;
 
 		if (o->prefix) {
 			/*
@@ -835,6 +903,8 @@ done:
 	return ret;
 
 return_failed:
+	if (o->show_all_errors)
+		display_error_msgs(o);
 	mark_all_ce_unused(o->src_index);
 	ret = unpack_failed(o, NULL);
 	goto done;
@@ -844,7 +914,7 @@ return_failed:
 
 static int reject_merge(struct cache_entry *ce, struct unpack_trees_options *o)
 {
-	return error(ERRORMSG(o, would_overwrite), ce->name);
+	return add_rejected_path(o, would_overwrite, ce->name);
 }
 
 static int same(struct cache_entry *a, struct cache_entry *b)
@@ -891,7 +961,7 @@ static int verify_uptodate_1(struct cache_entry *ce,
 	if (errno == ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error(ERRORMSG(o, error_type), ce->name);
+		add_rejected_path(o, error_type, ce->name);
 }
 
 static int verify_uptodate(struct cache_entry *ce,
@@ -994,7 +1064,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce,
 	i = read_directory(&d, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
-			error(ERRORMSG(o, not_uptodate_dir), ce->name);
+			add_rejected_path(o, not_uptodate_dir, ce->name);
 	free(pathbuf);
 	return cnt;
 }
@@ -1076,7 +1146,7 @@ static int verify_absent_1(struct cache_entry *ce,
 		}
 
 		return o->gently ? -1 :
-			error(ERRORMSG(o, error_type), ce->name);
+			add_rejected_path(o, error_type, ce->name);
 	}
 	return 0;
 }
diff --git a/unpack-trees.h b/unpack-trees.h
index edda877..785bc10 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -22,6 +22,11 @@ enum unpack_trees_error_types {
 	NB_UNPACK_TREES_ERROR_TYPES
 };
 
+struct rejected_paths_list {
+	char *path;
+	struct rejected_paths_list *next;
+};
+
 struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
@@ -36,12 +41,18 @@ struct unpack_trees_options {
 		     diff_index_cached,
 		     debug_unpack,
 		     skip_sparse_checkout,
-		     gently;
+		     gently,
+		     show_all_errors;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
+	/*
+	 * Store error messages in an array, each case
+	 * corresponding to a error message type
+	 */
+	struct rejected_paths_list *unpack_rejects[NB_UNPACK_TREES_ERROR_TYPES];
 
 	int head_idx;
 	int merge_size;
-- 
1.7.2.1.52.g95e25.dirty
