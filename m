From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 2/6] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD as refs
Date: Thu, 25 Jun 2015 16:45:06 -0400
Message-ID: <1435265110-6414-2-git-send-email-dturner@twopensource.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jun 25 22:45:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8E1c-0005xV-KS
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbbFYUpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:45:30 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37309 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbbFYUp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:45:26 -0400
Received: by igblr2 with SMTP id lr2so552521igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 13:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XIpomeW3VnfDs/riqJ5gEmtZMFpRnig42y5UUMbECho=;
        b=MWfnJtmA8/dGPUq9ncX7I7Z9CPD1E0VmF7V9ZqRkb2aUzU1fg7uClbE9Gp7nhLuj80
         yxK41GENi0EsqnWneDQTrRuC23c3gG7il37T0L478XsKUWSGLRq95NRz+lQ29TI2nMdl
         EAwMpIG7JRpUqcyqVh8hTUm6Z8him79vOTfkGqX2gebiLYqcu//U5j769blrRoqWVPSo
         KUKUZgmvmWHcCF5Ux/9efFlAz+6EPtBckWnhkLFPICdg2yHWOi0RW4ZUoCWND9Eg789N
         4HFp5OgEDmlp3NFNjttZ8OmdOF1lpb4HDHuYXmWMdM6c50VHD1Q0vzZqBlXoLRVMaG5Z
         Xiaw==
X-Gm-Message-State: ALoCoQlKbW+9jhx/G+pg9UsOBVKf5Bikyi9N2ObmeoOvlXHdu2gO8wYPZlFDIGXVq+6ryHSPgGdZ
X-Received: by 10.107.138.201 with SMTP id c70mr62646435ioj.24.1435265125451;
        Thu, 25 Jun 2015 13:45:25 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id fv2sm4042683igb.22.2015.06.25.13.45.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 13:45:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272727>

Instead of directly writing to and reading from files in
$GIT_DIR, use ref API to interact with CHERRY_PICK_HEAD
and REVERT_HEAD.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 branch.c                         |  4 ++--
 builtin/commit.c                 |  6 +++---
 builtin/merge.c                  |  2 +-
 contrib/completion/git-prompt.sh |  4 ++--
 git-gui/lib/commit.tcl           |  2 +-
 refs.c                           | 32 +++++++++++++++++++-------------
 sequencer.c                      | 37 +++++++++++++++++++------------------
 t/t7509-commit.sh                |  4 ++--
 wt-status.c                      |  6 ++----
 9 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/branch.c b/branch.c
index b002435..ec598aa 100644
--- a/branch.c
+++ b/branch.c
@@ -302,8 +302,8 @@ void create_branch(const char *head,
 
 void remove_branch_state(void)
 {
-	unlink(git_path("CHERRY_PICK_HEAD"));
-	unlink(git_path("REVERT_HEAD"));
+	delete_ref("CHERRY_PICK_HEAD", NULL, REF_NODEREF);
+	delete_ref("REVERT_HEAD", NULL, REF_NODEREF);
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_RR"));
 	unlink(git_path("MERGE_MSG"));
diff --git a/builtin/commit.c b/builtin/commit.c
index b5b1158..53c7e90 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -168,7 +168,7 @@ static void determine_whence(struct wt_status *s)
 {
 	if (file_exists(git_path("MERGE_HEAD")))
 		whence = FROM_MERGE;
-	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
+	else if (ref_exists("CHERRY_PICK_HEAD")) {
 		whence = FROM_CHERRY_PICK;
 		if (file_exists(git_path(SEQ_DIR)))
 			sequencer_in_use = 1;
@@ -1777,8 +1777,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 	ref_transaction_free(transaction);
 
-	unlink(git_path("CHERRY_PICK_HEAD"));
-	unlink(git_path("REVERT_HEAD"));
+	delete_ref("CHERRY_PICK_HEAD", NULL, REF_NODEREF);
+	delete_ref("REVERT_HEAD", NULL, REF_NODEREF);
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("MERGE_MODE"));
diff --git a/builtin/merge.c b/builtin/merge.c
index 46aacd6..3e2ae2f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1206,7 +1206,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
-	if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
+	if (ref_exists("CHERRY_PICK_HEAD")) {
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 			    "Please, commit your changes before you merge."));
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 366f0bc..e2c5583 100644
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
index b34a54a..de7b5ef 100644
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
@@ -3118,6 +3118,14 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
+static int should_autocreate_reflog(const char *refname)
+{
+	return starts_with(refname, "refs/heads/") ||
+		starts_with(refname, "refs/remotes/") ||
+		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "HEAD");
+}
+
 /* This function will fill in *err and return -1 on failure */
 int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
 {
@@ -3128,11 +3136,7 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	logfile = sb_logfile->buf;
 	/* make sure the rest of the function can't change "logfile" */
 	sb_logfile = NULL;
-	if (log_all_ref_updates &&
-	    (starts_with(refname, "refs/heads/") ||
-	     starts_with(refname, "refs/remotes/") ||
-	     starts_with(refname, "refs/notes/") ||
-	     !strcmp(refname, "HEAD"))) {
+	if (log_all_ref_updates && should_autocreate_reflog(refname)) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			strbuf_addf(err, "unable to create directory for %s. "
 				    "%s", logfile, strerror(errno));
@@ -3291,12 +3295,14 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
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
+	if ((should_autocreate_reflog(lock->ref_name) ||
+	     reflog_exists(lock->ref_name)) &&
+	    (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0 ||
+	     (strcmp(lock->ref_name, lock->orig_ref_name) &&
+	      log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0))) {
 		strbuf_addf(err, "Cannot update the ref '%s'.",
 			    lock->ref_name);
 		unlock_ref(lock);
@@ -4063,7 +4069,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->flags & REF_NEEDS_COMMIT) {
 			if (commit_ref_update(update->lock,
-					      update->new_sha1, update->msg, err)) {
+					      update->new_sha1, update->msg, err, 0)) {
 				/* freed by commit_ref_update(): */
 				update->lock = NULL;
 				ret = TRANSACTION_GENERIC_ERROR;
diff --git a/sequencer.c b/sequencer.c
index f8421a8..de904aa 100644
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
+				   NULL, REF_NODEREF, NULL,
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
@@ -1014,8 +1015,8 @@ static int continue_single_pick(void)
 {
 	const char *argv[] = { "commit", NULL };
 
-	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
-	    !file_exists(git_path("REVERT_HEAD")))
+	if (!ref_exists("CHERRY_PICK_HEAD") &&
+	    !ref_exists("REVERT_HEAD"))
 		return error(_("no cherry-pick or revert in progress"));
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
@@ -1030,8 +1031,8 @@ static int sequencer_continue(struct replay_opts *opts)
 	read_populate_todo(&todo_list, opts);
 
 	/* Verify that the conflict has been resolved */
-	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
-	    file_exists(git_path("REVERT_HEAD"))) {
+	if (ref_exists("CHERRY_PICK_HEAD") ||
+	    ref_exists("REVERT_HEAD")) {
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
