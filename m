From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/5] Turn unpack_trees_options.msgs into an array + enum
Date: Mon,  9 Aug 2010 16:19:58 +0200
Message-ID: <1281363602-27856-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 09 16:22:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiTF6-0003L5-2J
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 16:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694Ab0HIOWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 10:22:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46141 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756199Ab0HIOWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 10:22:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o79EHiUh001038
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Aug 2010 16:17:44 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiTCx-0006QJ-Do; Mon, 09 Aug 2010 16:20:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiTCx-0008IR-Cm; Mon, 09 Aug 2010 16:20:07 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Aug 2010 16:17:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o79EHiUh001038
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281968265.09109@M5ZAq7qNKruALydtQt5PjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152968>

The list of error messages was introduced as a structure, but an array
indexed over an enum is more flexible, since it allows one to store a
type of error message (index in the array) in a variable.

This change needs to rename would_lose_untracked ->
would_lose_untracked_file to avoid a clash with the function
would_lose_untracked in merge-recursive.c.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/checkout.c |    2 +-
 builtin/merge.c    |    2 +-
 merge-recursive.c  |   29 +++++++++++------------------
 merge-recursive.h  |    4 ++--
 unpack-trees.c     |   16 ++++++++--------
 unpack-trees.h     |   19 ++++++++++---------
 6 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1994be9..8854aab 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -373,7 +373,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.src_index = &the_index;
 		topts.dst_index = &the_index;
 
-		topts.msgs.not_uptodate_file = "You have local changes to '%s'; cannot switch branches.";
+		topts.msgs[not_uptodate_file] = "You have local changes to '%s'; cannot switch branches.";
 
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
index fb6aa4a..755f530 100644
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
+		msgs[would_overwrite] = msgs[not_uptodate_file] =
 			"Your local changes to '%s' would be overwritten by merge.  Aborting.\n"
 			"Please, commit your changes or stash them before you can merge.";
-	}
-	return msgs;
+	else
+		msgs[would_overwrite] = msgs[not_uptodate_file] =
+			"Your local changes to '%s' would be overwritten by merge.  Aborting.";
+	msgs[not_uptodate_dir] =
+		"Updating '%s' would lose untracked files in it.  Aborting.";
+	msgs[would_lose_untracked_file] =
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
index 8cf0da3..538f228 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -17,7 +17,7 @@
  * explain why it does not allow switching between branches when you have
  * local changes, for example.
  */
-static struct unpack_trees_error_msgs unpack_plumbing_errors = {
+const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* would_overwrite */
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
 
@@ -27,7 +27,7 @@ static struct unpack_trees_error_msgs unpack_plumbing_errors = {
 	/* not_uptodate_dir */
 	"Updating '%s' would lose untracked files in it",
 
-	/* would_lose_untracked */
+	/* would_lose_untracked_file */
 	"Untracked working tree file '%s' would be %s by merge.",
 
 	/* bind_overlap */
@@ -40,10 +40,10 @@ static struct unpack_trees_error_msgs unpack_plumbing_errors = {
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
@@ -1068,7 +1068,7 @@ static int verify_absent_1(struct cache_entry *ce, const char *action,
 		}
 
 		return o->gently ? -1 :
-			error(ERRORMSG(o, would_lose_untracked), ce->name, action);
+			error(ERRORMSG(o, would_lose_untracked_file), ce->name, action);
 	}
 	return 0;
 }
@@ -1077,7 +1077,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 {
 	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
 		return 0;
-	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracked));
+	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracked_file));
 }
 
 static int verify_absent_sparse(struct cache_entry *ce, const char *action,
diff --git a/unpack-trees.h b/unpack-trees.h
index ef70eab..3a6d2b4 100644
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
+	would_overwrite = 0,
+	not_uptodate_file,
+	not_uptodate_dir,
+	would_lose_untracked_file,
+	bind_overlap,
+	sparse_not_uptodate_file,
+	would_lose_orphaned,
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
