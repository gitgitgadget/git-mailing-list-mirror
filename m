From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/5 v2] merge-recursive: distinguish "removed" and "overwritten" messages
Date: Wed, 11 Aug 2010 10:38:06 +0200
Message-ID: <1281515888-31089-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq8w4fse8w.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 11 10:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6qc-0002s6-Hw
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732Ab0HKIjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 04:39:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53650 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932644Ab0HKIi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 04:38:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7B8Rtur000850
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Aug 2010 10:27:55 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oj6pi-00024V-G3; Wed, 11 Aug 2010 10:38:46 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oj6pi-00086M-Ey; Wed, 11 Aug 2010 10:38:46 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <vpq8w4fse8w.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 11 Aug 2010 10:27:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7B8Rtur000850
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1282120077.19328@+5hK++wu8hwRbmnM56/Xyw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153209>

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
index b1e526b..697d948 100644
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
-	msgs[ERROR_WOULD_LOSE_UNTRACKED] = tmp;
+		msg = "Untracked working tree file '%%s' would be %s by %s.  Aborting";
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("removed") + strlen(cmd2) - 4);
+	sprintf(tmp, msg, "removed", cmd, cmd2);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = tmp;
+	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("overwritten") + strlen(cmd2) - 4);
+	sprintf(tmp, msg, "overwritten", cmd, cmd2);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = tmp;
 }
 
 int merge_trees(struct merge_options *o,
diff --git a/unpack-trees.c b/unpack-trees.c
index e325831..342f5ec 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -26,8 +26,11 @@ const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_NOT_UPTODATE_DIR */
 	"Updating '%s' would lose untracked files in it",
 
-	/* ERROR_WOULD_LOSE_UNTRACKED */
-	"Untracked working tree file '%s' would be %s by merge.",
+	/* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
+	"Untracked working tree file '%s' would be overwritten by merge.",
+
+	/* ERROR_WOULD_LOSE_UNTRACKED_REMOVED */
+	"Untracked working tree file '%s' would be removed by merge.",
 
 	/* ERROR_BIND_OVERLAP */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
@@ -35,8 +38,11 @@ const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_SPARSE_NOT_UPTODATE_FILE */
 	"Entry '%s' not uptodate. Cannot update sparse checkout.",
 
-	/* ERROR_WOULD_LOSE_ORPHANED */
-	"Working tree file '%s' would be %s by sparse checkout update.",
+	/* ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN */
+	"Working tree file '%s' would be overwritten by sparse checkout update.",
+
+	/* ERROR_WOULD_LOSE_ORPHANED_REMOVED */
+	"Working tree file '%s' would be removed by sparse checkout update.",
 };
 
 #define ERRORMSG(o,type) \
@@ -131,7 +137,7 @@ static int check_updates(struct unpack_trees_options *o)
 }
 
 static int verify_uptodate_sparse(struct cache_entry *ce, struct unpack_trees_options *o);
-static int verify_absent_sparse(struct cache_entry *ce, const char *action, struct unpack_trees_options *o);
+static int verify_absent_sparse(struct cache_entry *ce, enum unpack_trees_error_types, struct unpack_trees_options *o);
 
 static int will_have_skip_worktree(const struct cache_entry *ce, struct unpack_trees_options *o)
 {
@@ -174,7 +180,7 @@ static int apply_sparse_checkout(struct cache_entry *ce, struct unpack_trees_opt
 		ce->ce_flags |= CE_WT_REMOVE;
 	}
 	if (was_skip_worktree && !ce_skip_worktree(ce)) {
-		if (verify_absent_sparse(ce, "overwritten", o))
+		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
 			return -1;
 		ce->ce_flags |= CE_UPDATE;
 	}
@@ -859,7 +865,7 @@ static int same(struct cache_entry *a, struct cache_entry *b)
  */
 static int verify_uptodate_1(struct cache_entry *ce,
 				   struct unpack_trees_options *o,
-				   const char *error_msg)
+				   enum unpack_trees_error_types error_type)
 {
 	struct stat st;
 
@@ -884,7 +890,7 @@ static int verify_uptodate_1(struct cache_entry *ce,
 	if (errno == ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error(error_msg, ce->name);
+		error(ERRORMSG(o, error_type), ce->name);
 }
 
 static int verify_uptodate(struct cache_entry *ce,
@@ -892,13 +898,13 @@ static int verify_uptodate(struct cache_entry *ce,
 {
 	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
 		return 0;
-	return verify_uptodate_1(ce, o, ERRORMSG(o, ERROR_NOT_UPTODATE_FILE));
+	return verify_uptodate_1(ce, o, ERROR_NOT_UPTODATE_FILE);
 }
 
 static int verify_uptodate_sparse(struct cache_entry *ce,
 				  struct unpack_trees_options *o)
 {
-	return verify_uptodate_1(ce, o, ERRORMSG(o, ERROR_SPARSE_NOT_UPTODATE_FILE));
+	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
 }
 
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_trees_options *o)
@@ -914,13 +920,15 @@ static void invalidate_ce_path(struct cache_entry *ce, struct unpack_trees_optio
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
@@ -941,7 +949,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 		 */
 		if (!hashcmp(sha1, ce->sha1))
 			return 0;
-		return verify_clean_submodule(ce, action, o);
+		return verify_clean_submodule(ce, error_type, o);
 	}
 
 	/*
@@ -1010,9 +1018,9 @@ static int icase_exists(struct unpack_trees_options *o, struct cache_entry *dst,
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
 
@@ -1050,7 +1058,7 @@ static int verify_absent_1(struct cache_entry *ce, const char *action,
 			 * files that are in "foo/" we would lose
 			 * them.
 			 */
-			if (verify_clean_subdirectory(ce, action, o) < 0)
+			if (verify_clean_subdirectory(ce, error_type, o) < 0)
 				return -1;
 			return 0;
 		}
@@ -1067,22 +1075,28 @@ static int verify_absent_1(struct cache_entry *ce, const char *action,
 		}
 
 		return o->gently ? -1 :
-			error(ERRORMSG(o, ERROR_WOULD_LOSE_UNTRACKED), ce->name, action);
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
-	return verify_absent_1(ce, action, o, ERRORMSG(o, ERROR_WOULD_LOSE_UNTRACKED));
+	return verify_absent_1(ce, error_type, o);
 }
 
-static int verify_absent_sparse(struct cache_entry *ce, const char *action,
+static int verify_absent_sparse(struct cache_entry *ce,
+			 enum unpack_trees_error_types error_type,
 			 struct unpack_trees_options *o)
 {
-	return verify_absent_1(ce, action, o, ERRORMSG(o, ERROR_WOULD_LOSE_ORPHANED));
+	enum unpack_trees_error_types orphaned_error = error_type;
+	if (orphaned_error == ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN)
+		orphaned_error = ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN;
+
+	return verify_absent_1(ce, orphaned_error, o);
 }
 
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
@@ -1091,7 +1105,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 	int update = CE_UPDATE;
 
 	if (!old) {
-		if (verify_absent(merge, "overwritten", o))
+		if (verify_absent(merge, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
 			return -1;
 		invalidate_ce_path(merge, o);
 	} else if (!(old->ce_flags & CE_CONFLICTED)) {
@@ -1129,7 +1143,7 @@ static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 {
 	/* Did it exist in the index? */
 	if (!old) {
-		if (verify_absent(ce, "removed", o))
+		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
 			return -1;
 		return 0;
 	}
@@ -1278,7 +1292,7 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 			if (index)
 				return deleted_entry(index, index, o);
 			if (ce && !head_deleted) {
-				if (verify_absent(ce, "removed", o))
+				if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
 					return -1;
 			}
 			return 0;
diff --git a/unpack-trees.h b/unpack-trees.h
index 09e2252..8be6b3c 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -13,10 +13,12 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_OVERWRITE = 0,
 	ERROR_NOT_UPTODATE_FILE,
 	ERROR_NOT_UPTODATE_DIR,
-	ERROR_WOULD_LOSE_UNTRACKED,
+	ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN,
+	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
 	ERROR_SPARSE_NOT_UPTODATE_FILE,
-	ERROR_WOULD_LOSE_ORPHANED,
+	ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN,
+	ERROR_WOULD_LOSE_ORPHANED_REMOVED,
 	NB_UNPACK_TREES_ERROR_TYPES
 };
 
-- 
1.7.2.1.52.g95e25.dirty
