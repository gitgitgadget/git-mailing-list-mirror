From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD as refs
Date: Tue,  7 Jul 2015 20:55:57 -0400
Message-ID: <1436316963-25520-2-git-send-email-dturner@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 08 02:56:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCdfD-0007Ba-5T
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 02:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbbGHA4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 20:56:33 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33245 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757450AbbGHA4S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 20:56:18 -0400
Received: by qkhu186 with SMTP id u186so153054070qkh.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 17:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rz5OXqR9Ru3D3R6lP3IBL36RsZW5Ls3SENSj2D6uSaU=;
        b=Sqp2jRRMkeC1Ecba5bmnX/aLW+k6TIPSKVQCMB7WiXqOEemQgd9Fc5TtRFVEuJzvKB
         hWgnGOoAYV7dpw+bqBika740Zf+p99jznxCkvEP+l/HeAmfgKSJwyLLlj09mo9om0ake
         3ZluP8SuC4skANlNyObUyrO4IhTGhuIswJ+Xq+4mmbOQ2e1Ml+0ou01UduzwLtoEao90
         wBTfTuA6gUQKu3T6qLjL3/W8dQbpZzbeUUkyGKTGeXbOGuw2VWTlh7NrXTMh1LraU9J3
         nrRfW7JA03p+z3L8ju+LM/Sx1eKdJOtyAyBp2sdpHQjLdN/eRxQxNpNixXkcc3Grb/y3
         I7Og==
X-Gm-Message-State: ALoCoQnkEQtvKrwoWA9rzT8RTf8GOTEU2Ot9/Hb/FpXyY6DbRqIW49NnWRcpseJhBEp+sC9LRBKV
X-Received: by 10.140.30.100 with SMTP id c91mr11557050qgc.81.1436316978244;
        Tue, 07 Jul 2015 17:56:18 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z135sm278447qhd.29.2015.07.07.17.56.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 17:56:17 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273624>

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
 sequencer.c                      | 31 ++++++++++---------------------
 t/t7509-commit.sh                |  4 ++--
 wt-status.c                      |  6 ++----
 8 files changed, 23 insertions(+), 36 deletions(-)

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
diff --git a/sequencer.c b/sequencer.c
index f8421a8..90396ba 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -158,21 +158,10 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 	unuse_commit_buffer(commit, msg->message);
 }
 
-static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
+static void write_cherry_pick_head(struct commit *commit, const char *ref)
 {
-	const char *filename;
-	int fd;
-	struct strbuf buf = STRBUF_INIT;
-
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
-
-	filename = git_path("%s", pseudoref);
-	fd = open(filename, O_WRONLY | O_CREAT, 0666);
-	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"), filename);
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
-		die_errno(_("Could not write to '%s'"), filename);
-	strbuf_release(&buf);
+	update_ref(NULL, ref, commit->object.sha1, NULL, REF_NODEREF,
+		   UPDATE_REFS_DIE_ON_ERR);
 }
 
 static void print_advice(int show_hint, struct replay_opts *opts)
@@ -186,7 +175,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-		unlink(git_path("CHERRY_PICK_HEAD"));
+		delete_ref("CHERRY_PICK_HEAD", NULL, REF_NODEREF);
 		return;
 	}
 
@@ -878,8 +867,8 @@ static int rollback_single_pick(void)
 {
 	unsigned char head_sha1[20];
 
-	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
-	    !file_exists(git_path("REVERT_HEAD")))
+	if (!ref_exists("CHERRY_PICK_HEAD") &&
+	    !ref_exists("REVERT_HEAD"))
 		return error(_("no cherry-pick or revert in progress"));
 	if (read_ref_full("HEAD", 0, head_sha1, NULL))
 		return error(_("cannot resolve HEAD"));
@@ -1014,8 +1003,8 @@ static int continue_single_pick(void)
 {
 	const char *argv[] = { "commit", NULL };
 
-	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
-	    !file_exists(git_path("REVERT_HEAD")))
+	if (!ref_exists("CHERRY_PICK_HEAD") &&
+	    !ref_exists("REVERT_HEAD"))
 		return error(_("no cherry-pick or revert in progress"));
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
@@ -1030,8 +1019,8 @@ static int sequencer_continue(struct replay_opts *opts)
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
2.0.5.499.g01f6352.dirty-twtrsrc
