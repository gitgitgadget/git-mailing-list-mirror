From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/5] merge-recursive: distinguish "removed" and "overwritten" messages
Date: Mon,  9 Aug 2010 16:20:00 +0200
Message-ID: <1281363602-27856-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 09 16:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiTIo-0004vC-P6
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 16:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703Ab0HIO0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 10:26:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:56901 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab0HIO0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 10:26:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o79EKDaq003739
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Aug 2010 16:20:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiTD3-0006Qq-1v; Mon, 09 Aug 2010 16:20:13 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiTD3-0008Uj-0u; Mon, 09 Aug 2010 16:20:13 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 09 Aug 2010 16:20:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152970>

To limit the number of possible error messages, the error messages for
the case would_lose_untracked_file and would_lose_orphaned in
unpack_trees_options.msgs were handled with a single string,
parameterized by an action string ("overwritten" or "removed").

Instead, we consider them as two different cases, with unparameterized
string. This will make it easier to make separate lists sorted by error
types later.

Only the bind_overlap case still takes two %s parameters, but that's
unavoidable.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 merge-recursive.c |   13 ++++++----
 unpack-trees.c    |   64 ++++++++++++++++++++++++++++++++--------------------
 unpack-trees.h    |    6 +++-
 3 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index bd26497..8c1b189 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1197,13 +1197,16 @@ void set_porcelain_error_msgs(const char **msgs, const char *cmd)
 		"Updating '%s' would lose untracked files in it.  Aborting.";
 
 	if (advice_commit_before_merge)
-		msg = "Untracked working tree file '%%s' would be %%s by %s.  Aborting"
+		msg = "Untracked working tree file '%%s' would be %s by %s.  Aborting"
 			"Please move or remove them before you can %s.";
 	else
-		msg = "Untracked working tree file '%%s' would be %%s by %s.  Aborting";
-	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 3);
-	sprintf(tmp, msg, cmd, cmd2);
-	msgs[would_lose_untracked_file] = tmp;
+		msg = "Untracked working tree file '%%s' would be %s by %s.  Aborting";
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("removed") + strlen(cmd2) - 4);
+	sprintf(tmp, msg, "removed", cmd, cmd2);
+	msgs[would_lose_untracked_removed] = tmp;
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("overwritten") + strlen(cmd2) - 4);
+	sprintf(tmp, msg, "overwritten", cmd, cmd2);
+	msgs[would_lose_untracked_overwritten] = tmp;
 }
 
 int merge_trees(struct merge_options *o,
diff --git a/unpack-trees.c b/unpack-trees.c
index 538f228..143f897 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -27,8 +27,11 @@ const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* not_uptodate_dir */
 	"Updating '%s' would lose untracked files in it",
 
-	/* would_lose_untracked_file */
-	"Untracked working tree file '%s' would be %s by merge.",
+	/* would_lose_untracked_overwritten */
+	"Untracked working tree file '%s' would be overwritten by merge.",
+
+	/* would_lose_untracked_removed */
+	"Untracked working tree file '%s' would be removed by merge.",
 
 	/* bind_overlap */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
@@ -36,8 +39,11 @@ const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* sparse_not_uptodate_file */
 	"Entry '%s' not uptodate. Cannot update sparse checkout.",
 
-	/* would_lose_orphaned */
-	"Working tree file '%s' would be %s by sparse checkout update.",
+	/* would_lose_orphaned_overwritten */
+	"Working tree file '%s' would be overwritten by sparse checkout update.",
+
+	/* would_lose_orphaned_removed */
+	"Working tree file '%s' would be removed by sparse checkout update.",
 };
 
 #define ERRORMSG(o,type) \
@@ -132,7 +138,7 @@ static int check_updates(struct unpack_trees_options *o)
 }
 
 static int verify_uptodate_sparse(struct cache_entry *ce, struct unpack_trees_options *o);
-static int verify_absent_sparse(struct cache_entry *ce, const char *action, struct unpack_trees_options *o);
+static int verify_absent_sparse(struct cache_entry *ce, enum unpack_trees_error_types, struct unpack_trees_options *o);
 
 static int will_have_skip_worktree(const struct cache_entry *ce, struct unpack_trees_options *o)
 {
@@ -175,7 +181,7 @@ static int apply_sparse_checkout(struct cache_entry *ce, struct unpack_trees_opt
 		ce->ce_flags |= CE_WT_REMOVE;
 	}
 	if (was_skip_worktree && !ce_skip_worktree(ce)) {
-		if (verify_absent_sparse(ce, "overwritten", o))
+		if (verify_absent_sparse(ce, would_lose_untracked_overwritten, o))
 			return -1;
 		ce->ce_flags |= CE_UPDATE;
 	}
@@ -860,7 +866,7 @@ static int same(struct cache_entry *a, struct cache_entry *b)
  */
 static int verify_uptodate_1(struct cache_entry *ce,
 				   struct unpack_trees_options *o,
-				   const char *error_msg)
+				   enum unpack_trees_error_types error_type)
 {
 	struct stat st;
 
@@ -885,7 +891,7 @@ static int verify_uptodate_1(struct cache_entry *ce,
 	if (errno == ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error(error_msg, ce->name);
+		error(ERRORMSG(o, error_type), ce->name);
 }
 
 static int verify_uptodate(struct cache_entry *ce,
@@ -893,13 +899,13 @@ static int verify_uptodate(struct cache_entry *ce,
 {
 	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
 		return 0;
-	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
+	return verify_uptodate_1(ce, o, not_uptodate_file);
 }
 
 static int verify_uptodate_sparse(struct cache_entry *ce,
 				  struct unpack_trees_options *o)
 {
-	return verify_uptodate_1(ce, o, ERRORMSG(o, sparse_not_uptodate_file));
+	return verify_uptodate_1(ce, o, sparse_not_uptodate_file);
 }
 
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_trees_options *o)
@@ -915,13 +921,15 @@ static void invalidate_ce_path(struct cache_entry *ce, struct unpack_trees_optio
  * Currently, git does not checkout subprojects during a superproject
  * checkout, so it is not going to overwrite anything.
  */
-static int verify_clean_submodule(struct cache_entry *ce, const char *action,
+static int verify_clean_submodule(struct cache_entry *ce,
+				      enum unpack_trees_error_types error_type,
 				      struct unpack_trees_options *o)
 {
 	return 0;
 }
 
-static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
+static int verify_clean_subdirectory(struct cache_entry *ce,
+				      enum unpack_trees_error_types error_type,
 				      struct unpack_trees_options *o)
 {
 	/*
@@ -942,7 +950,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 		 */
 		if (!hashcmp(sha1, ce->sha1))
 			return 0;
-		return verify_clean_submodule(ce, action, o);
+		return verify_clean_submodule(ce, error_type, o);
 	}
 
 	/*
@@ -1011,9 +1019,9 @@ static int icase_exists(struct unpack_trees_options *o, struct cache_entry *dst,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static int verify_absent_1(struct cache_entry *ce, const char *action,
-				 struct unpack_trees_options *o,
-				 const char *error_msg)
+static int verify_absent_1(struct cache_entry *ce,
+				 enum unpack_trees_error_types error_type,
+				 struct unpack_trees_options *o)
 {
 	struct stat st;
 
@@ -1051,7 +1059,7 @@ static int verify_absent_1(struct cache_entry *ce, const char *action,
 			 * files that are in "foo/" we would lose
 			 * them.
 			 */
-			if (verify_clean_subdirectory(ce, action, o) < 0)
+			if (verify_clean_subdirectory(ce, error_type, o) < 0)
 				return -1;
 			return 0;
 		}
@@ -1068,22 +1076,28 @@ static int verify_absent_1(struct cache_entry *ce, const char *action,
 		}
 
 		return o->gently ? -1 :
-			error(ERRORMSG(o, would_lose_untracked_file), ce->name, action);
+			error(ERRORMSG(o, error_type), ce->name);
 	}
 	return 0;
 }
-static int verify_absent(struct cache_entry *ce, const char *action,
+static int verify_absent(struct cache_entry *ce,
+			 enum unpack_trees_error_types error_type,
 			 struct unpack_trees_options *o)
 {
 	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
 		return 0;
-	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracked_file));
+	return verify_absent_1(ce, error_type, o);
 }
 
-static int verify_absent_sparse(struct cache_entry *ce, const char *action,
+static int verify_absent_sparse(struct cache_entry *ce,
+			 enum unpack_trees_error_types error_type,
 			 struct unpack_trees_options *o)
 {
-	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_orphaned));
+	enum unpack_trees_error_types orphaned_error = error_type;
+	if (orphaned_error == would_lose_untracked_overwritten)
+		orphaned_error = would_lose_orphaned_overwritten;
+
+	return verify_absent_1(ce, orphaned_error, o);
 }
 
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
@@ -1092,7 +1106,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 	int update = CE_UPDATE;
 
 	if (!old) {
-		if (verify_absent(merge, "overwritten", o))
+		if (verify_absent(merge, would_lose_untracked_overwritten, o))
 			return -1;
 		invalidate_ce_path(merge, o);
 	} else if (!(old->ce_flags & CE_CONFLICTED)) {
@@ -1130,7 +1144,7 @@ static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 {
 	/* Did it exist in the index? */
 	if (!old) {
-		if (verify_absent(ce, "removed", o))
+		if (verify_absent(ce, would_lose_untracked_removed, o))
 			return -1;
 		return 0;
 	}
@@ -1279,7 +1293,7 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 			if (index)
 				return deleted_entry(index, index, o);
 			if (ce && !head_deleted) {
-				if (verify_absent(ce, "removed", o))
+				if (verify_absent(ce, would_lose_untracked_removed, o))
 					return -1;
 			}
 			return 0;
diff --git a/unpack-trees.h b/unpack-trees.h
index 3a6d2b4..edda877 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -13,10 +13,12 @@ enum unpack_trees_error_types {
 	would_overwrite = 0,
 	not_uptodate_file,
 	not_uptodate_dir,
-	would_lose_untracked_file,
+	would_lose_untracked_overwritten,
+	would_lose_untracked_removed,
 	bind_overlap,
 	sparse_not_uptodate_file,
-	would_lose_orphaned,
+	would_lose_orphaned_overwritten,
+	would_lose_orphaned_removed,
 	NB_UNPACK_TREES_ERROR_TYPES
 };
 
-- 
1.7.2.1.52.g95e25.dirty
