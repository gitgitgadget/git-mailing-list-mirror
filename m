Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE70C433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E216610CE
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhKMDh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 22:37:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54570 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235668AbhKMDhW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 22:37:22 -0500
Received: from localhost ([38.30.8.235])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AD3YA2Q004993
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 22:34:12 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v6 4/8] worktree: simplify find_shared_symref() memory ownership model
Date:   Fri, 12 Nov 2021 19:33:54 -0800
Message-Id: <20211113033358.2179376-5-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211113033358.2179376-1-andersk@mit.edu>
References: <20211113033358.2179376-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Storing the worktrees list in a static variable meant that
find_shared_symref() had to rebuild the list on each call (which is
inefficient when the call site is in a loop), and also that each call
invalidated the pointer returned by the previous call (which is
confusing).

Instead, make it the caller’s responsibility to pass in the worktrees
list and manage its lifetime.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 branch.c               | 14 ++++++----
 builtin/branch.c       |  7 ++++-
 builtin/notes.c        |  6 +++-
 builtin/receive-pack.c | 63 +++++++++++++++++++++++++++---------------
 worktree.c             |  8 ++----
 worktree.h             |  5 ++--
 6 files changed, 65 insertions(+), 38 deletions(-)

diff --git a/branch.c b/branch.c
index 147827cf46..c7b9ba0e10 100644
--- a/branch.c
+++ b/branch.c
@@ -357,14 +357,16 @@ void remove_branch_state(struct repository *r, int verbose)
 
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
 {
+	struct worktree **worktrees = get_worktrees();
 	const struct worktree *wt;
 
-	wt = find_shared_symref("HEAD", branch);
-	if (!wt || (ignore_current_worktree && wt->is_current))
-		return;
-	skip_prefix(branch, "refs/heads/", &branch);
-	die(_("'%s' is already checked out at '%s'"),
-	    branch, wt->path);
+	wt = find_shared_symref(worktrees, "HEAD", branch);
+	if (wt && (!ignore_current_worktree || !wt->is_current)) {
+		skip_prefix(branch, "refs/heads/", &branch);
+		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
+	}
+
+	free_worktrees(worktrees);
 }
 
 int replace_each_worktree_head_symref(const char *oldref, const char *newref,
diff --git a/builtin/branch.c b/builtin/branch.c
index 03c7b7253a..25785dc939 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -193,6 +193,7 @@ static void delete_branch_config(const char *branchname)
 static int delete_branches(int argc, const char **argv, int force, int kinds,
 			   int quiet)
 {
+	struct worktree **worktrees;
 	struct commit *head_rev = NULL;
 	struct object_id oid;
 	char *name = NULL;
@@ -229,6 +230,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		if (!head_rev)
 			die(_("Couldn't look up commit object for HEAD"));
 	}
+
+	worktrees = get_worktrees();
+
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
 		int flags = 0;
@@ -239,7 +243,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 		if (kinds == FILTER_REFS_BRANCHES) {
 			const struct worktree *wt =
-				find_shared_symref("HEAD", name);
+				find_shared_symref(worktrees, "HEAD", name);
 			if (wt) {
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
@@ -300,6 +304,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 	free(name);
 	strbuf_release(&bname);
+	free_worktrees(worktrees);
 
 	return ret;
 }
diff --git a/builtin/notes.c b/builtin/notes.c
index 71c59583a1..7f60408dbb 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -861,15 +861,19 @@ static int merge(int argc, const char **argv, const char *prefix)
 		update_ref(msg.buf, default_notes_ref(), &result_oid, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	else { /* Merge has unresolved conflicts */
+		struct worktree **worktrees;
 		const struct worktree *wt;
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
 		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", &result_oid, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
-		wt = find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
+		worktrees = get_worktrees();
+		wt = find_shared_symref(worktrees, "NOTES_MERGE_REF",
+					default_notes_ref());
 		if (wt)
 			die(_("a notes merge into %s is already in-progress at %s"),
 			    default_notes_ref(), wt->path);
+		free_worktrees(worktrees);
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
 			die(_("failed to store link to current notes ref (%s)"),
 			    default_notes_ref());
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a82b60f387..5d7c4832c1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1481,12 +1481,17 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	struct object_id *old_oid = &cmd->old_oid;
 	struct object_id *new_oid = &cmd->new_oid;
 	int do_update_worktree = 0;
-	const struct worktree *worktree = is_bare_repository() ? NULL : find_shared_symref("HEAD", name);
+	struct worktree **worktrees = get_worktrees();
+	const struct worktree *worktree =
+		is_bare_repository() ?
+			NULL :
+			find_shared_symref(worktrees, "HEAD", name);
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
-		return "funny refname";
+		ret = "funny refname";
+		goto out;
 	}
 
 	strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
@@ -1505,7 +1510,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			rp_error("refusing to update checked out branch: %s", name);
 			if (deny_current_branch == DENY_UNCONFIGURED)
 				refuse_unconfigured_deny();
-			return "branch is currently checked out";
+			ret = "branch is currently checked out";
+			goto out;
 		case DENY_UPDATE_INSTEAD:
 			/* pass -- let other checks intervene first */
 			do_update_worktree = 1;
@@ -1516,13 +1522,15 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	if (!is_null_oid(new_oid) && !has_object_file(new_oid)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", oid_to_hex(new_oid));
-		return "bad pack";
+		ret = "bad pack";
+		goto out;
 	}
 
 	if (!is_null_oid(old_oid) && is_null_oid(new_oid)) {
 		if (deny_deletes && starts_with(name, "refs/heads/")) {
 			rp_error("denying ref deletion for %s", name);
-			return "deletion prohibited";
+			ret = "deletion prohibited";
+			goto out;
 		}
 
 		if (worktree || (head_name && !strcmp(namespaced_name, head_name))) {
@@ -1538,9 +1546,11 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				if (deny_delete_current == DENY_UNCONFIGURED)
 					refuse_unconfigured_deny_delete_current();
 				rp_error("refusing to delete the current branch: %s", name);
-				return "deletion of the current branch prohibited";
+				ret = "deletion of the current branch prohibited";
+				goto out;
 			default:
-				return "Invalid denyDeleteCurrent setting";
+				ret = "Invalid denyDeleteCurrent setting";
+				goto out;
 			}
 		}
 	}
@@ -1558,25 +1568,30 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		    old_object->type != OBJ_COMMIT ||
 		    new_object->type != OBJ_COMMIT) {
 			error("bad sha1 objects for %s", name);
-			return "bad ref";
+			ret = "bad ref";
+			goto out;
 		}
 		old_commit = (struct commit *)old_object;
 		new_commit = (struct commit *)new_object;
 		if (!in_merge_bases(old_commit, new_commit)) {
 			rp_error("denying non-fast-forward %s"
 				 " (you should pull first)", name);
-			return "non-fast-forward";
+			ret = "non-fast-forward";
+			goto out;
 		}
 	}
 	if (run_update_hook(cmd)) {
 		rp_error("hook declined to update %s", name);
-		return "hook declined";
+		ret = "hook declined";
+		goto out;
 	}
 
 	if (do_update_worktree) {
-		ret = update_worktree(new_oid->hash, find_shared_symref("HEAD", name));
+		ret = update_worktree(new_oid->hash,
+				      find_shared_symref(worktrees, "HEAD",
+							 name));
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	if (is_null_oid(new_oid)) {
@@ -1595,17 +1610,19 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 					   old_oid,
 					   0, "push", &err)) {
 			rp_error("%s", err.buf);
-			strbuf_release(&err);
-			return "failed to delete";
+			ret = "failed to delete";
+		} else {
+			ret = NULL; /* good */
 		}
 		strbuf_release(&err);
-		return NULL; /* good */
 	}
 	else {
 		struct strbuf err = STRBUF_INIT;
 		if (shallow_update && si->shallow_ref[cmd->index] &&
-		    update_shallow_ref(cmd, si))
-			return "shallow error";
+		    update_shallow_ref(cmd, si)) {
+			ret = "shallow error";
+			goto out;
+		}
 
 		if (ref_transaction_update(transaction,
 					   namespaced_name,
@@ -1613,14 +1630,16 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 					   0, "push",
 					   &err)) {
 			rp_error("%s", err.buf);
-			strbuf_release(&err);
-
-			return "failed to update ref";
+			ret = "failed to update ref";
+		} else {
+			ret = NULL; /* good */
 		}
 		strbuf_release(&err);
-
-		return NULL; /* good */
 	}
+
+out:
+	free_worktrees(worktrees);
+	return ret;
 }
 
 static void run_update_post_hook(struct command *commands)
diff --git a/worktree.c b/worktree.c
index 092a4f92ad..cf13d63845 100644
--- a/worktree.c
+++ b/worktree.c
@@ -402,17 +402,13 @@ int is_worktree_being_bisected(const struct worktree *wt,
  * bisect). New commands that do similar things should update this
  * function as well.
  */
-const struct worktree *find_shared_symref(const char *symref,
+const struct worktree *find_shared_symref(struct worktree **worktrees,
+					  const char *symref,
 					  const char *target)
 {
 	const struct worktree *existing = NULL;
-	static struct worktree **worktrees;
 	int i = 0;
 
-	if (worktrees)
-		free_worktrees(worktrees);
-	worktrees = get_worktrees();
-
 	for (i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
 		const char *symref_target;
diff --git a/worktree.h b/worktree.h
index 8b7c408132..9e06fcbdf3 100644
--- a/worktree.h
+++ b/worktree.h
@@ -143,9 +143,10 @@ void free_worktrees(struct worktree **);
 /*
  * Check if a per-worktree symref points to a ref in the main worktree
  * or any linked worktree, and return the worktree that holds the ref,
- * or NULL otherwise. The result may be destroyed by the next call.
+ * or NULL otherwise.
  */
-const struct worktree *find_shared_symref(const char *symref,
+const struct worktree *find_shared_symref(struct worktree **worktrees,
+					  const char *symref,
 					  const char *target);
 
 /*
-- 
2.33.1

