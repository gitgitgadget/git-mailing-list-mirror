From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 12/18] revert: write TODO and DONE files in case of failure
Date: Thu, 25 Nov 2010 22:20:43 +0100
Message-ID: <20101125212050.5188.74945.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:56:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIf-0007NM-KP
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab0KZFzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:55:19 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47810 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab0KZFzS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:55:18 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E7157A61DE;
	Fri, 26 Nov 2010 06:55:10 +0100 (CET)
X-git-sha1: 1d54a42723301397ad51ca736f47994090100ac6 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162194>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c                    |   42 ++++++++++++++++++++++++++++++-----
 t/t3508-cherry-pick-many-commits.sh |   22 ++++++++++++++++++
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 7429be2..27e9d6f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -14,6 +14,7 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
+#include "dir.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -55,6 +56,11 @@ struct args_info {
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
+#define SEQ_DIR		"sequencer"
+#define SEQ_PATH	git_path(SEQ_DIR)
+#define TODO_FILE	git_path(SEQ_DIR "/git-cherry-pick-todo")
+#define DONE_FILE	git_path(SEQ_DIR "/git-cherry-pick-done")
+
 static char *get_encoding(const char *message, const unsigned char *sha1);
 
 static const char * const *revert_or_cherry_pick_usage(struct args_info *info)
@@ -651,7 +657,25 @@ static int ff_incompatible(int val, const char *opt)
 	return val ? error("cherry-pick --ff cannot be used with %s", opt) : 0;
 }
 
-static int pick_commits(struct args_info *infos)
+static int save_todo_and_done(int res, struct args_info *infos,
+			      struct commit *commit,
+			      struct commit_list *todo_list,
+			      struct commit_list **done_list)
+{
+	if (res) {
+		if (!file_exists(SEQ_PATH) && mkdir(SEQ_PATH, 0777))
+			die_errno("Could not create sequencer directory '%s'",
+				  SEQ_PATH);
+		if (commit)
+			commit_list_insert(commit, &todo_list);
+		create_todo_file(TODO_FILE, 0, todo_list, "", infos);
+		*done_list = reverse_commit_list(*done_list);
+		create_todo_file(DONE_FILE, 0, *done_list, "", infos);
+	}
+	return res;
+}
+
+static int pick_commits(struct args_info *infos, struct commit_list **done_list)
 {
 	struct rev_info revs;
 	struct commit *commit;
@@ -662,22 +686,24 @@ static int pick_commits(struct args_info *infos)
 	     (res = ff_incompatible(infos->no_commit, "--no_commit")) ||
 	     (res = ff_incompatible(infos->no_replay, "-x")) ||
 	     (res = ff_incompatible(infos->edit, "--edit"))))
-			return res;
+		return save_todo_and_done(res, infos, NULL, NULL, done_list);
 
 	if ((res = read_and_refresh_cache(me)) ||
 	    (res = prepare_revs(&revs, infos)))
-		return res;
+		return save_todo_and_done(res, infos, NULL, NULL, done_list);
 
 	while ((commit = get_revision(&revs)) &&
 	       !(res = do_pick_commit(infos, commit)))
-		; /* do nothing */
+		commit_list_insert(commit, done_list);
 
-	return res;
+	return save_todo_and_done(res, infos, commit, revs.commits, done_list);
 }
 
 static int revert_or_cherry_pick(int argc, const char **argv, int revert, int edit)
 {
 	struct args_info infos;
+	struct commit_list *done_list = NULL;
+	int res;
 
 	git_config(git_default_config, NULL);
 	me = revert ? "revert" : "cherry-pick";
@@ -686,7 +712,11 @@ static int revert_or_cherry_pick(int argc, const char **argv, int revert, int ed
 	infos.action = revert ? REVERT : CHERRY_PICK;
 	parse_args(argc, argv, &infos);
 
-	return pick_commits(&infos);
+	res = pick_commits(&infos, &done_list);
+
+	free_commit_list(done_list);
+
+	return res;
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 8e09fd0..9213d59 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -156,4 +156,26 @@ test_expect_success 'cherry-pick --stdin works' '
 	check_head_differs_from fourth
 '
 
+test_expect_success 'create some files to test --continue' '
+	TODO_FILE="$(git rev-parse --git-dir)/sequencer/git-cherry-pick-todo" &&
+	DONE_FILE="$(git rev-parse --git-dir)/sequencer/git-cherry-pick-done" &&
+
+	cat <<-EOF >expected_todo &&
+	pick  $(git rev-parse --short fourth) # fourth
+	EOF
+
+	cat <<-EOF >expected_done
+	pick  $(git rev-parse --short second) # second
+	EOF
+'
+
+test_expect_success 'failed cherry-pick produces todo and done files' '
+	git checkout -f master &&
+	git reset --hard first &&
+	test_tick &&
+	test_must_fail git cherry-pick fourth~2 fourth &&
+	test_cmp expected_todo "$TODO_FILE" &&
+	test_cmp expected_done "$DONE_FILE"
+'
+
 test_done
-- 
1.7.3.2.504.g59d466
