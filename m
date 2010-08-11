From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/5 v2] Turn unpack_trees_options.msgs into an array + enum
Date: Wed, 11 Aug 2010 10:38:04 +0200
Message-ID: <1281515888-31089-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq8w4fse8w.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 11 10:38:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6ph-0002Qo-Bw
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082Ab0HKIik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 04:38:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53633 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab0HKIij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 04:38:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7B8RK9G000675
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Aug 2010 10:27:20 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oj6p9-00022e-FU; Wed, 11 Aug 2010 10:38:11 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oj6p9-000867-EE; Wed, 11 Aug 2010 10:38:11 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <vpq8w4fse8w.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 11 Aug 2010 10:27:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7B8RK9G000675
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1282120042.05103@Gi01+PFVjF34AEcBmTzDpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153207>

The list of error messages was introduced as a structure, but an array
indexed over an enum is more flexible, since it allows one to store a
type of error message (index in the array) in a variable.

This change needs to rename would_lose_untracked ->
would_lose_untracked_file to avoid a clash with the function
would_lose_untracked in merge-recursive.c.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> If you are to change them to enum, I would actually suggest renaming them
>> a bit more to make them stand out.  Perhaps spell them all in caps,
>> perhaps have them share the same short prefix (UTEM_ - unpack trees error
>> messages), etc.
>
> I'd say just "ERROR_*" (UTEM seems hard to read, and won't be used
> often enough for people to remember it), but I'm fine with all caps +
> prefix, yes. A quick grep shows this is how the rest of Git does.

So, here it is. BTW, git filter-branch rocks ;-).

Doing this change, I noticed a comment about "git checkout" overriding
only the "not_uptodate_file" case only, which I fixed, but there's no
other change compared to v1.

 builtin/checkout.c |    2 +-
 builtin/merge.c    |    2 +-
 merge-recursive.c  |   29 +++++++++++------------------
 merge-recursive.h  |    4 ++--
 unpack-trees.c     |   42 +++++++++++++++++++++---------------------
 unpack-trees.h     |   19 ++++++++++---------
 6 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1994be9..7d1706e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -373,7 +373,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.src_index = &the_index;
 		topts.dst_index = &the_index;
 
-		topts.msgs.not_uptodate_file = "You have local changes to '%s'; cannot switch branches.";
+		topts.msgs[ERROR_NOT_UPTODATE_FILE] = "You have local changes to '%s'; cannot switch branches.";
 
 		refresh_cache(REFRESH_QUIET);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..115a288 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -704,7 +704,7 @@ int checkout_fast_forward(const unsigned char *head, const unsigned char *remote
 	opts.verbose_update = 1;
 	opts.merge = 1;
 	opts.fn = twoway_merge;
-	opts.msgs = get_porcelain_error_msgs();
+	set_porcelain_error_msgs(opts.msgs);
 
 	trees[nr_trees] = parse_tree_indirect(head);
 	if (!trees[nr_trees++])
diff --git a/merge-recursive.c b/merge-recursive.c
index fb6aa4a..d3bd963 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -185,7 +185,7 @@ static int git_merge_trees(int index_only,
 	opts.fn = threeway_merge;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
-	opts.msgs = get_porcelain_error_msgs();
+	set_porcelain_error_msgs(opts.msgs);
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
@@ -1178,26 +1178,19 @@ static int process_entry(struct merge_options *o,
 	return clean_merge;
 }
 
-struct unpack_trees_error_msgs get_porcelain_error_msgs(void)
+void set_porcelain_error_msgs(const char **msgs)
 {
-	struct unpack_trees_error_msgs msgs = {
-		/* would_overwrite */
-		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
-		/* not_uptodate_file */
-		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
-		/* not_uptodate_dir */
-		"Updating '%s' would lose untracked files in it.  Aborting.",
-		/* would_lose_untracked */
-		"Untracked working tree file '%s' would be %s by merge.  Aborting",
-		/* bind_overlap -- will not happen here */
-		NULL,
-	};
-	if (advice_commit_before_merge) {
-		msgs.would_overwrite = msgs.not_uptodate_file =
+	if (advice_commit_before_merge)
+		msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
 			"Your local changes to '%s' would be overwritten by merge.  Aborting.\n"
 			"Please, commit your changes or stash them before you can merge.";
-	}
-	return msgs;
+	else
+		msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
+			"Your local changes to '%s' would be overwritten by merge.  Aborting.";
+	msgs[ERROR_NOT_UPTODATE_DIR] =
+		"Updating '%s' would lose untracked files in it.  Aborting.";
+	msgs[ERROR_WOULD_LOSE_UNTRACKED] =
+		"Untracked working tree file '%s' would be %s by merge.  Aborting";
 }
 
 int merge_trees(struct merge_options *o,
diff --git a/merge-recursive.h b/merge-recursive.h
index b831293..8412db8 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -23,8 +23,8 @@ struct merge_options {
 	struct string_list current_directory_set;
 };
 
-/* Return a list of user-friendly error messages to be used by merge */
-struct unpack_trees_error_msgs get_porcelain_error_msgs(void);
+/* Sets the list of user-friendly error messages to be used by merge */
+void set_porcelain_error_msgs(const char **msgs);
 
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
diff --git a/unpack-trees.c b/unpack-trees.c
index 8cf0da3..304e59a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -13,37 +13,37 @@
  * Error messages expected by scripts out of plumbing commands such as
  * read-tree.  Non-scripted Porcelain is not required to use these messages
  * and in fact are encouraged to reword them to better suit their particular
- * situation better.  See how "git checkout" replaces not_uptodate_file to
+ * situation better.  See how "git checkout" replaces ERROR_NOT_UPTODATE_FILE to
  * explain why it does not allow switching between branches when you have
  * local changes, for example.
  */
-static struct unpack_trees_error_msgs unpack_plumbing_errors = {
-	/* would_overwrite */
+const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
+	/* ERROR_WOULD_OVERWRITE */
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
 
-	/* not_uptodate_file */
+	/* ERROR_NOT_UPTODATE_FILE */
 	"Entry '%s' not uptodate. Cannot merge.",
 
-	/* not_uptodate_dir */
+	/* ERROR_NOT_UPTODATE_DIR */
 	"Updating '%s' would lose untracked files in it",
 
-	/* would_lose_untracked */
+	/* ERROR_WOULD_LOSE_UNTRACKED */
 	"Untracked working tree file '%s' would be %s by merge.",
 
-	/* bind_overlap */
+	/* ERROR_BIND_OVERLAP */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
 
-	/* sparse_not_uptodate_file */
+	/* ERROR_SPARSE_NOT_UPTODATE_FILE */
 	"Entry '%s' not uptodate. Cannot update sparse checkout.",
 
-	/* would_lose_orphaned */
+	/* ERROR_WOULD_LOSE_ORPHANED */
 	"Working tree file '%s' would be %s by sparse checkout update.",
 };
 
-#define ERRORMSG(o,fld) \
-	( ((o) && (o)->msgs.fld) \
-	? ((o)->msgs.fld) \
-	: (unpack_plumbing_errors.fld) )
+#define ERRORMSG(o,type) \
+	( ((o) && (o)->msgs[(type)]) \
+	  ? ((o)->msgs[(type)])      \
+	  : (unpack_plumbing_errors[(type)]) )
 
 static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	unsigned int set, unsigned int clear)
@@ -838,7 +838,7 @@ return_failed:
 
 static int reject_merge(struct cache_entry *ce, struct unpack_trees_options *o)
 {
-	return error(ERRORMSG(o, would_overwrite), ce->name);
+	return error(ERRORMSG(o, ERROR_WOULD_OVERWRITE), ce->name);
 }
 
 static int same(struct cache_entry *a, struct cache_entry *b)
@@ -893,13 +893,13 @@ static int verify_uptodate(struct cache_entry *ce,
 {
 	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
 		return 0;
-	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
+	return verify_uptodate_1(ce, o, ERRORMSG(o, ERROR_NOT_UPTODATE_FILE));
 }
 
 static int verify_uptodate_sparse(struct cache_entry *ce,
 				  struct unpack_trees_options *o)
 {
-	return verify_uptodate_1(ce, o, ERRORMSG(o, sparse_not_uptodate_file));
+	return verify_uptodate_1(ce, o, ERRORMSG(o, ERROR_SPARSE_NOT_UPTODATE_FILE));
 }
 
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_trees_options *o)
@@ -986,7 +986,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	i = read_directory(&d, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
-			error(ERRORMSG(o, not_uptodate_dir), ce->name);
+			error(ERRORMSG(o, ERROR_NOT_UPTODATE_DIR), ce->name);
 	free(pathbuf);
 	return cnt;
 }
@@ -1068,7 +1068,7 @@ static int verify_absent_1(struct cache_entry *ce, const char *action,
 		}
 
 		return o->gently ? -1 :
-			error(ERRORMSG(o, would_lose_untracked), ce->name, action);
+			error(ERRORMSG(o, ERROR_WOULD_LOSE_UNTRACKED), ce->name, action);
 	}
 	return 0;
 }
@@ -1077,13 +1077,13 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 {
 	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
 		return 0;
-	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracked));
+	return verify_absent_1(ce, action, o, ERRORMSG(o, ERROR_WOULD_LOSE_UNTRACKED));
 }
 
 static int verify_absent_sparse(struct cache_entry *ce, const char *action,
 			 struct unpack_trees_options *o)
 {
-	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_orphaned));
+	return verify_absent_1(ce, action, o, ERRORMSG(o, ERROR_WOULD_LOSE_ORPHANED));
 }
 
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
@@ -1412,7 +1412,7 @@ int bind_merge(struct cache_entry **src,
 			     o->merge_size);
 	if (a && old)
 		return o->gently ? -1 :
-			error(ERRORMSG(o, bind_overlap), a->name, old->name);
+			error(ERRORMSG(o, ERROR_BIND_OVERLAP), a->name, old->name);
 	if (!a)
 		return keep_entry(old, o);
 	else
diff --git a/unpack-trees.h b/unpack-trees.h
index ef70eab..09e2252 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -9,14 +9,15 @@ struct exclude_list;
 typedef int (*merge_fn_t)(struct cache_entry **src,
 		struct unpack_trees_options *options);
 
-struct unpack_trees_error_msgs {
-	const char *would_overwrite;
-	const char *not_uptodate_file;
-	const char *not_uptodate_dir;
-	const char *would_lose_untracked;
-	const char *bind_overlap;
-	const char *sparse_not_uptodate_file;
-	const char *would_lose_orphaned;
+enum unpack_trees_error_types {
+	ERROR_WOULD_OVERWRITE = 0,
+	ERROR_NOT_UPTODATE_FILE,
+	ERROR_NOT_UPTODATE_DIR,
+	ERROR_WOULD_LOSE_UNTRACKED,
+	ERROR_BIND_OVERLAP,
+	ERROR_SPARSE_NOT_UPTODATE_FILE,
+	ERROR_WOULD_LOSE_ORPHANED,
+	NB_UNPACK_TREES_ERROR_TYPES
 };
 
 struct unpack_trees_options {
@@ -38,7 +39,7 @@ struct unpack_trees_options {
 	int cache_bottom;
 	struct dir_struct *dir;
 	merge_fn_t fn;
-	struct unpack_trees_error_msgs msgs;
+	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
 
 	int head_idx;
 	int merge_size;
-- 
1.7.2.1.52.g95e25.dirty
