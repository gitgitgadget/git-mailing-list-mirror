From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] Move set_porcelain_error_msgs to unpack-trees.c and rename it
Date: Thu,  2 Sep 2010 13:57:33 +0200
Message-ID: <1283428655-12680-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq39ttxumz.fsf@bauges.imag.fr>
Cc: Jim Meyering <jim@meyering.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 02 13:59:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or8S8-0007rM-3d
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 13:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219Ab0IBL7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 07:59:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60070 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659Ab0IBL7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 07:59:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o82Bs036001994
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Sep 2010 13:54:00 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Or8QD-0006mo-Av; Thu, 02 Sep 2010 13:57:37 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Or8QD-0003Jh-9Q; Thu, 02 Sep 2010 13:57:37 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
In-Reply-To: <vpq39ttxumz.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 02 Sep 2010 13:54:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o82Bs036001994
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1284033242.8667@fv4XBuGJo0ik8cEo6Welvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155126>

The function is currently dealing only with error messages, but the
intent of calling it is really to notify the unpack-tree mechanics that
it is running in porcelain mode.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/checkout.c |    2 +-
 builtin/merge.c    |    2 +-
 merge-recursive.c  |   46 +---------------------------------------------
 merge-recursive.h  |    6 ------
 unpack-trees.c     |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 unpack-trees.h     |    6 ++++++
 6 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7250e5c..e5c0ef0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -376,7 +376,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.src_index = &the_index;
 		topts.dst_index = &the_index;
 
-		set_porcelain_error_msgs(topts.msgs, "checkout");
+		setup_unpack_trees_porcelain(topts.msgs, "checkout");
 
 		refresh_cache(REFRESH_QUIET);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 47e705b..da52b10 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -706,7 +706,7 @@ int checkout_fast_forward(const unsigned char *head, const unsigned char *remote
 	opts.merge = 1;
 	opts.fn = twoway_merge;
 	opts.show_all_errors = 1;
-	set_porcelain_error_msgs(opts.msgs, "merge");
+	setup_unpack_trees_porcelain(opts.msgs, "merge");
 
 	trees[nr_trees] = parse_tree_indirect(head);
 	if (!trees[nr_trees++])
diff --git a/merge-recursive.c b/merge-recursive.c
index df90be4..61e237b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -180,7 +180,7 @@ static int git_merge_trees(int index_only,
 	opts.fn = threeway_merge;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
-	set_porcelain_error_msgs(opts.msgs, "merge");
+	setup_unpack_trees_porcelain(opts.msgs, "merge");
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
@@ -1238,50 +1238,6 @@ static int process_df_entry(struct merge_options *o,
 	return clean_merge;
 }
 
-void set_porcelain_error_msgs(const char **msgs, const char *cmd)
-{
-	const char *msg;
-	char *tmp;
-	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
-	if (advice_commit_before_merge)
-		msg = "Your local changes to the following files would be overwritten by %s:\n%%s"
-			"Please, commit your changes or stash them before you can %s.";
-	else
-		msg = "Your local changes to the following files would be overwritten by %s:\n%%s";
-	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 2);
-	sprintf(tmp, msg, cmd, cmd2);
-	msgs[ERROR_WOULD_OVERWRITE] = tmp;
-	msgs[ERROR_NOT_UPTODATE_FILE] = tmp;
-
-	msgs[ERROR_NOT_UPTODATE_DIR] =
-		"Updating the following directories would lose untracked files in it:\n%s";
-
-	if (advice_commit_before_merge)
-		msg = "The following untracked working tree files would be %s by %s:\n%%s"
-			"Please move or remove them before you can %s.";
-	else
-		msg = "The following untracked working tree files would be %s by %s:\n%%s";
-	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("removed") + strlen(cmd2) - 4);
-	sprintf(tmp, msg, "removed", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = tmp;
-	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("overwritten") + strlen(cmd2) - 4);
-	sprintf(tmp, msg, "overwritten", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = tmp;
-
-	/*
-	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
-	 * cannot easily display it as a list.
-	 */
-	msgs[ERROR_BIND_OVERLAP] = "Entry '%s' overlaps with '%s'.  Cannot bind.";
-
-	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
-		"Cannot update sparse checkout: the following entries are not up-to-date:\n%s";
-	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
-		"The following Working tree files would be overwritten by sparse checkout update:\n%s";
-	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
-		"The following Working tree files would be removed by sparse checkout update:\n%s";
-}
-
 int merge_trees(struct merge_options *o,
 		struct tree *head,
 		struct tree *merge,
diff --git a/merge-recursive.h b/merge-recursive.h
index 08f9850..f79917c 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -23,12 +23,6 @@ struct merge_options {
 	struct string_list current_directory_set;
 };
 
-/*
- * Sets the list of user-friendly error messages to be used by the
- * command "cmd" (either merge or checkout)
- */
-void set_porcelain_error_msgs(const char **msgs, const char *cmd);
-
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
diff --git a/unpack-trees.c b/unpack-trees.c
index 3c7a7c9..4520aa0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -14,7 +14,7 @@
  * read-tree.  Non-scripted Porcelain is not required to use these messages
  * and in fact are encouraged to reword them to better suit their particular
  * situation better.  See how "git checkout" and "git merge" replaces
- * them using set_porcelain_error_msgs(), for example.
+ * them using setup_unpack_trees_porcelain(), for example.
  */
 const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_WOULD_OVERWRITE */
@@ -50,6 +50,50 @@ const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	  ? ((o)->msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
+void setup_unpack_trees_porcelain(const char **msgs, const char *cmd)
+{
+	const char *msg;
+	char *tmp;
+	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
+	if (advice_commit_before_merge)
+		msg = "Your local changes to the following files would be overwritten by %s:\n%%s"
+			"Please, commit your changes or stash them before you can %s.";
+	else
+		msg = "Your local changes to the following files would be overwritten by %s:\n%%s";
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 2);
+	sprintf(tmp, msg, cmd, cmd2);
+	msgs[ERROR_WOULD_OVERWRITE] = tmp;
+	msgs[ERROR_NOT_UPTODATE_FILE] = tmp;
+
+	msgs[ERROR_NOT_UPTODATE_DIR] =
+		"Updating the following directories would lose untracked files in it:\n%s";
+
+	if (advice_commit_before_merge)
+		msg = "The following untracked working tree files would be %s by %s:\n%%s"
+			"Please move or remove them before you can %s.";
+	else
+		msg = "The following untracked working tree files would be %s by %s:\n%%s";
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("removed") + strlen(cmd2) - 4);
+	sprintf(tmp, msg, "removed", cmd, cmd2);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = tmp;
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("overwritten") + strlen(cmd2) - 4);
+	sprintf(tmp, msg, "overwritten", cmd, cmd2);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = tmp;
+
+	/*
+	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
+	 * cannot easily display it as a list.
+	 */
+	msgs[ERROR_BIND_OVERLAP] = "Entry '%s' overlaps with '%s'.  Cannot bind.";
+
+	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
+		"Cannot update sparse checkout: the following entries are not up-to-date:\n%s";
+	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
+		"The following Working tree files would be overwritten by sparse checkout update:\n%s";
+	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
+		"The following Working tree files would be removed by sparse checkout update:\n%s";
+}
+
 static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	unsigned int set, unsigned int clear)
 {
diff --git a/unpack-trees.h b/unpack-trees.h
index 6e049b0..d62bba9 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -22,6 +22,12 @@ enum unpack_trees_error_types {
 	NB_UNPACK_TREES_ERROR_TYPES
 };
 
+/*
+ * Sets the list of user-friendly error messages to be used by the
+ * command "cmd" (either merge or checkout)
+ */
+void setup_unpack_trees_porcelain(const char **msgs, const char *cmd);
+
 struct rejected_paths_list {
 	char *path;
 	struct rejected_paths_list *next;
-- 
1.7.2.2.175.ga619d.dirty
