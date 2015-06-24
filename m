From: David Turner <dturner@twopensource.com>
Subject: [PATCH 2/6] cherry-pick: Use refs infrastructure for CHERRY_PICK_HEAD
Date: Wed, 24 Jun 2015 15:16:24 -0400
Message-ID: <1435173388-8346-3-git-send-email-dturner@twopensource.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jun 24 21:17:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qAS-0000GJ-IZ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbbFXTRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:17:01 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34554 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbbFXTQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:16:57 -0400
Received: by igboe5 with SMTP id oe5so122077390igb.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4WtJDE7JVX0DbN1fdXhPyvnBsodeNXtKB0bKVxivz8A=;
        b=QHJXQH5WDCppAc46uaqUUxEU9n2zo3cf/pfS1ZU/wgjBlUxUylmNORtJ6k3RYTpWLB
         W1t/nJXLzRsshtESHW0VdmgXWsw+Ds9vtRLaEYR++THV9lWBbz5LVENT7AMEwg3I4xCT
         Q4+UjdL0jX4X2zV28TdHyb29UrZF+XKpPr9bVbnybBq4jBY4nXEJjaMkI96N9EdreMCr
         KoL1/45/nv58CrFXNb9a8Jrdnzh0ExIKDDJjJSZ9iV8ksOTLagrhvCZ1RiFZiP6GUV/F
         zOCs7ZTGP1ByaTnNuJ0KxBpoNP0m/YjpLyyEJs7is2CoWJwtzMNYxbRrLfgDS+EGBKD8
         oDcw==
X-Gm-Message-State: ALoCoQlk7TOxHljYAqp2uN3qjFD7rombB9dvCsnOH+HiXdaAjMK/ximaKQtFtnCyrFcSqoQIb7/i
X-Received: by 10.107.168.150 with SMTP id e22mr50737874ioj.9.1435173416771;
        Wed, 24 Jun 2015 12:16:56 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id p8sm1644609iga.13.2015.06.24.12.16.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:16:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272582>

Also use refs infrastructure for REVERT_HEAD.  These refs
need to go through the refs backend, since some code
assumes that they can be read as refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 branch.c                         |  4 ++--
 builtin/commit.c                 |  7 ++++---
 builtin/merge.c                  |  3 ++-
 contrib/completion/git-prompt.sh |  9 +++++----
 git-gui/lib/commit.tcl           |  2 +-
 refs.c                           | 17 +++++++++--------
 refs.h                           |  5 +++++
 sequencer.c                      | 39 +++++++++++++++++++++------------------
 t/t7509-commit.sh                |  4 ++--
 wt-status.c                      |  6 ++----
 10 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/branch.c b/branch.c
index b002435..8371a16 100644
--- a/branch.c
+++ b/branch.c
@@ -302,8 +302,8 @@ void create_branch(const char *head,
 
 void remove_branch_state(void)
 {
-	unlink(git_path("CHERRY_PICK_HEAD"));
-	unlink(git_path("REVERT_HEAD"));
+	delete_ref("CHERRY_PICK_HEAD", NULL, REF_NODEREF | REF_NO_REFLOG);
+	delete_ref("REVERT_HEAD", NULL, REF_NODEREF | REF_NO_REFLOG);
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_RR"));
 	unlink(git_path("MERGE_MSG"));
diff --git a/builtin/commit.c b/builtin/commit.c
index b5b1158..0f0b184 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -166,9 +166,10 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 
 static void determine_whence(struct wt_status *s)
 {
+	unsigned char unused[20];
 	if (file_exists(git_path("MERGE_HEAD")))
 		whence = FROM_MERGE;
-	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
+	else if (!read_ref("CHERRY_PICK_HEAD", unused)) {
 		whence = FROM_CHERRY_PICK;
 		if (file_exists(git_path(SEQ_DIR)))
 			sequencer_in_use = 1;
@@ -1777,8 +1778,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 	ref_transaction_free(transaction);
 
-	unlink(git_path("CHERRY_PICK_HEAD"));
-	unlink(git_path("REVERT_HEAD"));
+	delete_ref("CHERRY_PICK_HEAD", NULL, REF_NODEREF | REF_NO_REFLOG);
+	delete_ref("REVERT_HEAD", NULL, REF_NODEREF | REF_NO_REFLOG);
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("MERGE_MODE"));
diff --git a/builtin/merge.c b/builtin/merge.c
index 46aacd6..a4abf93 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1144,6 +1144,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	unsigned char result_tree[20];
 	unsigned char stash[20];
 	unsigned char head_sha1[20];
+	unsigned char unused[20];
 	struct commit *head_commit;
 	struct strbuf buf = STRBUF_INIT;
 	int flag, i, ret = 0, head_subsumed;
@@ -1206,7 +1207,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
-	if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
+	if (!read_ref("CHERRY_PICK_HEAD", unused)) {
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 			    "Please, commit your changes before you merge."));
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 366f0bc..5e27a34 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -415,9 +415,9 @@ __git_ps1 ()
 			fi
 		elif [ -f "$g/MERGE_HEAD" ]; then
 			r="|MERGING"
-		elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
+		elif git rev-parse --quiet --verify "CHERRY_PICK_HEAD" >/dev/null; then
 			r="|CHERRY-PICKING"
-		elif [ -f "$g/REVERT_HEAD" ]; then
+		elif git rev-parse --quiet --verify "REVERT_HEAD" >/dev/null; then
 			r="|REVERTING"
 		elif [ -f "$g/BISECT_LOG" ]; then
 			r="|BISECTING"
@@ -429,8 +429,9 @@ __git_ps1 ()
 			# symlink symbolic ref
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
 		else
-			local head=""
-			if ! __git_eread "$g/HEAD" head; then
+			local head
+			head="ref: $(git symbolic-ref HEAD 2>/dev/null)" || head=$(git rev-parse HEAD)
+			if [ -z "$head" ]; then
 				return $exit
 			fi
 			# is it a symbolic ref?
diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 864b687..2b08b13 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -409,7 +409,7 @@ A rescan will be automatically started now.
 	catch {file delete [gitdir MERGE_MSG]}
 	catch {file delete [gitdir SQUASH_MSG]}
 	catch {file delete [gitdir GITGUI_MSG]}
-	catch {file delete [gitdir CHERRY_PICK_HEAD]}
+	catch {git update-ref -d --no-deref CHERRY_PICK_HEAD}
 
 	# -- Let rerere do its thing.
 	#
diff --git a/refs.c b/refs.c
index b34a54a..c1a563f 100644
--- a/refs.c
+++ b/refs.c
@@ -2979,7 +2979,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf* err);
 static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
-			     struct strbuf *err);
+			     struct strbuf *err, int flags);
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
@@ -3041,7 +3041,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	hashcpy(lock->old_oid.hash, orig_sha1);
 
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, logmsg, &err)) {
+	    commit_ref_update(lock, orig_sha1, logmsg, &err, 0)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
@@ -3060,7 +3060,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, NULL, &err)) {
+	    commit_ref_update(lock, orig_sha1, NULL, &err, 0)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
@@ -3291,12 +3291,13 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
  */
 static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
-			     struct strbuf *err)
+			     struct strbuf *err, int flags)
 {
 	clear_loose_ref_cache(&ref_cache);
-	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0 ||
-	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0)) {
+	if (!(flags & REF_NO_REFLOG) &&
+	    (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0 ||
+	     (strcmp(lock->ref_name, lock->orig_ref_name) &&
+	      log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0))) {
 		strbuf_addf(err, "Cannot update the ref '%s'.",
 			    lock->ref_name);
 		unlock_ref(lock);
@@ -4063,7 +4064,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->flags & REF_NEEDS_COMMIT) {
 			if (commit_ref_update(update->lock,
-					      update->new_sha1, update->msg, err)) {
+					      update->new_sha1, update->msg, err, 0)) {
 				/* freed by commit_ref_update(): */
 				update->lock = NULL;
 				ret = TRANSACTION_GENERIC_ERROR;
diff --git a/refs.h b/refs.h
index debdefc..eee99f6 100644
--- a/refs.h
+++ b/refs.h
@@ -153,6 +153,11 @@ struct ref_transaction;
 #define REF_BAD_NAME 0x08
 
 /*
+ * Used as a flag in ref_update::flags when the reflog should not be updated
+ */
+#define REF_NO_REFLOG	0x40
+
+/*
  * The signature for the callback function for the for_each_*()
  * functions below.  The memory pointed to by the refname and sha1
  * arguments is only guaranteed to be valid for the duration of a
diff --git a/sequencer.c b/sequencer.c
index f8421a8..f66e2be 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -160,19 +160,20 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 
 static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
 {
-	const char *filename;
-	int fd;
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	void *transaction;
 
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
+	transaction = ref_transaction_begin(&err);
+	if (!transaction)
+		die(_("Could not create transaction: %s"), err.buf);
 
-	filename = git_path("%s", pseudoref);
-	fd = open(filename, O_WRONLY | O_CREAT, 0666);
-	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"), filename);
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
-		die_errno(_("Could not write to '%s'"), filename);
-	strbuf_release(&buf);
+	if (ref_transaction_update(transaction, pseudoref, commit->object.sha1,
+				   NULL, REF_NODEREF | REF_NO_REFLOG, NULL,
+				   &err))
+		die(_("Could not write ref %s: %s"), pseudoref, err.buf);
+
+	if (ref_transaction_commit(transaction, &err))
+		die(_("Could not commit ref write %s: %s"), pseudoref, err.buf);
 }
 
 static void print_advice(int show_hint, struct replay_opts *opts)
@@ -186,7 +187,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-		unlink(git_path("CHERRY_PICK_HEAD"));
+		delete_ref("CHERRY_PICK_HEAD", NULL, REF_NODEREF);
 		return;
 	}
 
@@ -878,8 +879,8 @@ static int rollback_single_pick(void)
 {
 	unsigned char head_sha1[20];
 
-	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
-	    !file_exists(git_path("REVERT_HEAD")))
+	if (read_ref("CHERRY_PICK_HEAD", head_sha1) &&
+	    read_ref("REVERT_HEAD", head_sha1))
 		return error(_("no cherry-pick or revert in progress"));
 	if (read_ref_full("HEAD", 0, head_sha1, NULL))
 		return error(_("cannot resolve HEAD"));
@@ -1013,9 +1014,10 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 static int continue_single_pick(void)
 {
 	const char *argv[] = { "commit", NULL };
+	unsigned char unused[20];
 
-	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
-	    !file_exists(git_path("REVERT_HEAD")))
+	if (read_ref("CHERRY_PICK_HEAD", unused) &&
+	    read_ref("REVERT_HEAD", unused))
 		return error(_("no cherry-pick or revert in progress"));
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
@@ -1023,6 +1025,7 @@ static int continue_single_pick(void)
 static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
+	unsigned char unused[20];
 
 	if (!file_exists(git_path(SEQ_TODO_FILE)))
 		return continue_single_pick();
@@ -1030,8 +1033,8 @@ static int sequencer_continue(struct replay_opts *opts)
 	read_populate_todo(&todo_list, opts);
 
 	/* Verify that the conflict has been resolved */
-	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
-	    file_exists(git_path("REVERT_HEAD"))) {
+	if (!read_ref("CHERRY_PICK_HEAD", unused) ||
+	    !read_ref("REVERT_HEAD", unused)) {
 		int ret = continue_single_pick();
 		if (ret)
 			return ret;
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index 9ac7940..f7fd62c 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -163,7 +163,7 @@ test_expect_success 'commit respects CHERRY_PICK_HEAD and MERGE_MSG' '
 	test_tick &&
 	git commit -am "cherry-pick 1" --author="Cherry <cherry@pick.er>" &&
 	git tag cherry-pick-head &&
-	git rev-parse cherry-pick-head >.git/CHERRY_PICK_HEAD &&
+	git update-ref CHERRY_PICK_HEAD $(git rev-parse cherry-pick-head) &&
 	echo "This is a MERGE_MSG" >.git/MERGE_MSG &&
 	echo "cherry-pick 1b" >>foo &&
 	test_tick &&
@@ -178,7 +178,7 @@ test_expect_success 'commit respects CHERRY_PICK_HEAD and MERGE_MSG' '
 '
 
 test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
-	git rev-parse cherry-pick-head >.git/CHERRY_PICK_HEAD &&
+	git update-ref CHERRY_PICK_HEAD $(git rev-parse cherry-pick-head) &&
 	echo "cherry-pick 2" >>foo &&
 	test_tick &&
 	git commit -am "cherry-pick 2" --reset-author &&
diff --git a/wt-status.c b/wt-status.c
index 9c686e6..661c1fb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1336,8 +1336,7 @@ void wt_status_get_state(struct wt_status_state *state,
 			state->rebase_in_progress = 1;
 		state->branch = read_and_strip_branch("rebase-merge/head-name");
 		state->onto = read_and_strip_branch("rebase-merge/onto");
-	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st) &&
-			!get_sha1("CHERRY_PICK_HEAD", sha1)) {
+	} else if (!read_ref("CHERRY_PICK_HEAD", sha1)) {
 		state->cherry_pick_in_progress = 1;
 		hashcpy(state->cherry_pick_head_sha1, sha1);
 	}
@@ -1345,8 +1344,7 @@ void wt_status_get_state(struct wt_status_state *state,
 		state->bisect_in_progress = 1;
 		state->branch = read_and_strip_branch("BISECT_START");
 	}
-	if (!stat(git_path("REVERT_HEAD"), &st) &&
-	    !get_sha1("REVERT_HEAD", sha1)) {
+	if (!read_ref("REVERT_HEAD", sha1)) {
 		state->revert_in_progress = 1;
 		hashcpy(state->revert_head_sha1, sha1);
 	}
-- 
2.0.4.314.gdbf7a51-twtrsrc
