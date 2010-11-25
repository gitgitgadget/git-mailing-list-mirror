From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 18/18] revert: implement --continue processing
Date: Thu, 25 Nov 2010 22:20:49 +0100
Message-ID: <20101125212050.5188.26439.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:56:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIi-0007NM-O7
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab0KZFzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:55:52 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48142 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860Ab0KZFzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:55:51 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DF143A6209;
	Fri, 26 Nov 2010 06:55:43 +0100 (CET)
X-git-sha1: 59d4663a9d44ba9a16ab47e7de9a296b5fcad484 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162197>

This patch adds the pick_continue() and the process_insn() functions
to process all the instructions from a todo file.
The TODO and DONE files are removed at the end if there was no
error.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c                    |   54 ++++++++++++++++++----
 t/t3508-cherry-pick-many-commits.sh |   85 +++++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 12 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b51f7ab..46445b0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -923,7 +923,8 @@ static int ff_incompatible(int val, const char *opt)
 static int save_todo_and_done(int res, struct args_info *infos,
 			      struct commit *commit,
 			      struct commit_list *todo_list,
-			      struct commit_list **done_list)
+			      struct commit_list **done_list,
+			      struct parsed_insn *insn)
 {
 	if (res) {
 		if (!file_exists(SEQ_PATH) && mkdir(SEQ_PATH, 0777))
@@ -931,14 +932,15 @@ static int save_todo_and_done(int res, struct args_info *infos,
 				  SEQ_PATH);
 		if (commit)
 			commit_list_insert(commit, &todo_list);
-		create_todo_file(TODO_FILE, 0, todo_list, NULL, "", infos);
+		create_todo_file(TODO_FILE, 0, todo_list, insn, "", infos);
 		*done_list = reverse_commit_list(*done_list);
-		create_todo_file(DONE_FILE, 0, *done_list, NULL, "", infos);
+		create_todo_file(DONE_FILE, 1, *done_list, NULL, "", infos);
 	}
 	return res;
 }
 
-static int pick_commits(struct args_info *infos, struct commit_list **done_list)
+static int pick_commits(struct args_info *infos, struct commit_list **done_list,
+			struct parsed_insn *insn)
 {
 	struct rev_info revs;
 	struct commit *commit;
@@ -949,17 +951,51 @@ static int pick_commits(struct args_info *infos, struct commit_list **done_list)
 	     (res = ff_incompatible(infos->no_commit, "--no_commit")) ||
 	     (res = ff_incompatible(infos->no_replay, "-x")) ||
 	     (res = ff_incompatible(infos->edit, "--edit"))))
-		return save_todo_and_done(res, infos, NULL, NULL, done_list);
+	  return save_todo_and_done(res, infos, NULL, NULL, done_list, insn);
 
 	if ((res = read_and_refresh_cache(infos->me)) ||
 	    (res = prepare_revs(&revs, infos)))
-		return save_todo_and_done(res, infos, NULL, NULL, done_list);
+		return save_todo_and_done(res, infos, NULL, NULL, done_list, insn);
 
 	while ((commit = get_revision(&revs)) &&
 	       !(res = do_pick_commit(infos, commit)))
 		commit_list_insert(commit, done_list);
 
-	return save_todo_and_done(res, infos, commit, revs.commits, done_list);
+	return save_todo_and_done(res, infos, commit, revs.commits, done_list, insn);
+}
+
+static int process_insn(struct parsed_insn *cur, struct commit_list **done_list)
+{
+	struct args_info infos;
+	memset(&infos, 0, sizeof(infos));
+	parse_args(cur->argc, cur->argv, &infos);
+
+	if (infos.continuing)
+		return error("option --continue is not allowed in todo file");
+
+	return pick_commits(&infos, done_list, cur);
+}
+
+static int pick_continue(struct commit_list **done_list)
+{
+	struct parsed_file content;
+	struct parsed_insn *cur;
+
+	if (!file_exists(TODO_FILE))
+		die("No %s file found, so nothing to continue", TODO_FILE);
+
+	parse_file(TODO_FILE, &content);
+
+	for (cur = content.first; cur; cur = cur->next) {
+		int res = process_insn(cur, done_list);
+		if (res)
+			return res;
+	}
+
+	unlink(TODO_FILE);
+	unlink(DONE_FILE);
+
+	return 0;
 }
 
 static int revert_or_cherry_pick(int argc, const char **argv, int revert, int edit)
@@ -974,9 +1010,9 @@ static int revert_or_cherry_pick(int argc, const char **argv, int revert, int ed
 	parse_args(argc, argv, &infos);
 
 	if (infos.continuing)
-		res = 0;
+		res = pick_continue(&done_list);
 	else
-		res = pick_commits(&infos, &done_list);
+		res = pick_commits(&infos, &done_list, NULL);
 
 	free_commit_list(done_list);
 
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 9213d59..bbc6588 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -164,18 +164,97 @@ test_expect_success 'create some files to test --continue' '
 	pick  $(git rev-parse --short fourth) # fourth
 	EOF
 
-	cat <<-EOF >expected_done
+	cat <<-EOF >expected_done &&
 	pick  $(git rev-parse --short second) # second
 	EOF
+
+	cat <<-EOF >new_todo
+	pick  $(git rev-parse --short third) # third
+	pick  $(git rev-parse --short fourth) # fourth
+	EOF
+'
+
+test_expect_success 'cherry-pick --continue works' '
+	git checkout -f master &&
+	git reset --hard first &&
+	test_tick &&
+	test_must_fail git cherry-pick fourth~2 fourth &&
+	test_cmp expected_todo "$TODO_FILE" &&
+	test_cmp expected_done "$DONE_FILE" &&
+	git reset --merge HEAD &&
+	cp new_todo "$TODO_FILE" &&
+	git cherry-pick --continue &&
+	git diff --quiet other &&
+	git diff --quiet HEAD other &&
+	check_head_differs_from fourth &&
+	! test -e "$TODO_FILE" &&
+	! test -e "$DONE_FILE"
+'
+
+test_expect_success 'create more files to test --continue' '
+	cat <<-EOF >expected_todo_2 &&
+	pick  $(git rev-parse --short second) # second
+	EOF
+
+	cat <<-EOF >expected_done_2 &&
+	pick  $(git rev-parse --short second) # second
+	pick  $(git rev-parse --short third) # third
+	EOF
+
+	cat <<-EOF >new_todo_2
+	pick  $(git rev-parse --short third) # third
+	pick  $(git rev-parse --short second) # second
+	EOF
+'
+
+test_expect_success 'TODO and DONE files are ok when --continue fails (1)' '
+	git checkout -f master &&
+	git reset --hard first &&
+	test_tick &&
+	test_must_fail git cherry-pick fourth~2 fourth &&
+	test_cmp expected_todo "$TODO_FILE" &&
+	test_cmp expected_done "$DONE_FILE" &&
+	git reset --merge HEAD &&
+	cp new_todo_2 "$TODO_FILE" &&
+	test_must_fail git cherry-pick --continue &&
+	test_cmp expected_todo_2 "$TODO_FILE" &&
+	test_cmp expected_done_2 "$DONE_FILE" &&
+	rm "$TODO_FILE" &&
+	rm "$DONE_FILE"
+'
+
+test_expect_success 'create again more files to test --continue' '
+	cat <<-EOF >expected_todo_3 &&
+	pick  $(git rev-parse --short second) # second
+	pick  $(git rev-parse --short fourth) # fourth
+	EOF
+
+	cat <<-EOF >expected_done_3 &&
+	pick  $(git rev-parse --short second) # second
+	pick  $(git rev-parse --short third) # third
+	EOF
+
+	cat <<-EOF >new_todo_3
+	pick  $(git rev-parse --short third) # third
+	pick  $(git rev-parse --short second) # second
+	pick  $(git rev-parse --short fourth) # fourth
+	EOF
 '
 
-test_expect_success 'failed cherry-pick produces todo and done files' '
+test_expect_success 'TODO and DONE files are ok when --continue fails (2)' '
 	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
 	test_must_fail git cherry-pick fourth~2 fourth &&
 	test_cmp expected_todo "$TODO_FILE" &&
-	test_cmp expected_done "$DONE_FILE"
+	test_cmp expected_done "$DONE_FILE" &&
+	git reset --merge HEAD &&
+	cp new_todo_3 "$TODO_FILE" &&
+	test_must_fail git cherry-pick --continue &&
+	test_cmp expected_todo_3 "$TODO_FILE" &&
+	test_cmp expected_done_3 "$DONE_FILE" &&
+	rm "$TODO_FILE" &&
+	rm "$DONE_FILE"
 '
 
 test_done
-- 
1.7.3.2.504.g59d466
