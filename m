From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Sun, 14 Aug 2011 14:03:09 +0530
Message-ID: <1313310789-10216-8-git-send-email-artagnon@gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 10:37:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWC2-0000ii-Ob
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab1HNIhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 04:37:09 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:49094 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab1HNIhH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 04:37:07 -0400
Received: by pzk37 with SMTP id 37so1546273pzk.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4xpafTPed1nivoDIR7pD6Hj/ejKHwvC8Mq9cP2r/ej0=;
        b=YlFSOVua88Ge4LislNsYbruVcJvvVgzyAf7aHKVDm03FOeA3pHeKTBa7pUXPXskcz+
         tpJR2XODSWrZAiW2Qd236771lBfzfcsKVdGeWaUfEqJno/Dc52PVhhYBAS41/DXhwvq9
         p6oK8XHtS0LX4rlCxhcCeEtTMs19P3xhLmnS4=
Received: by 10.142.150.38 with SMTP id x38mr1206191wfd.128.1313311027378;
        Sun, 14 Aug 2011 01:37:07 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id 14sm2642752wfl.5.2011.08.14.01.36.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 01:37:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179311>

Since d3f4628e (revert: Remove sequencer state when no commits are
pending, 2011-07-06), the sequencer removes the sequencer state before
the final commit is actually completed.  This design is inherently
flawed, as it will not allow the user to abort the sequencer operation
at that stage.  Instead, make 'git commit' notify the sequencer after
every successful commit; the sequencer then removes the state if no
more instructions are pending.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/commit.c                   |    8 ++++++++
 sequencer.c                        |   23 ++++++++++++-----------
 sequencer.h                        |    1 +
 t/t3032-merge-recursive-options.sh |    2 ++
 t/t3510-cherry-pick-sequence.sh    |    4 ++--
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e1af9b1..1699371 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -26,6 +26,7 @@
 #include "unpack-trees.h"
 #include "quote.h"
 #include "submodule.h"
+#include "sequencer.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -1521,6 +1522,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
 
+	/*
+	 * Notify the sequencer that we're committing.  The routine
+	 * removes the sequencer state if our commit just completed
+	 * the last instruction.
+	 */
+	sequencer_notify_commit();
+
 	if (commit_index_files())
 		die (_("Repository has been updated, but unable to write\n"
 		     "new_index file. Check that disk is not full or quota is\n"
diff --git a/sequencer.c b/sequencer.c
index 95bce89..caae932 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -580,6 +580,17 @@ static void read_populate_todo(struct replay_insn_list **todo_list)
 		die(_("Unusable instruction sheet: %s"), todo_file);
 }
 
+void sequencer_notify_commit(void)
+{
+	struct replay_insn_list *todo_list = NULL;
+
+	if (!file_exists(git_path(SEQ_TODO_FILE)))
+		return;
+	read_populate_todo(&todo_list);
+	if (!todo_list->next)
+		remove_sequencer_state(1);
+}
+
 static int populate_opts_cb(const char *key, const char *value, void *data)
 {
 	struct replay_opts *opts = data;
@@ -743,18 +754,8 @@ static int pick_commits(struct replay_insn_list *todo_list,
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur);
 		res = do_pick_commit(cur->operand, cur->action, opts);
-		if (res) {
-			if (!cur->next)
-				/*
-				 * An error was encountered while
-				 * picking the last commit; the
-				 * sequencer state is useless now --
-				 * the user simply needs to resolve
-				 * the conflict and commit
-				 */
-				remove_sequencer_state(0);
+		if (res)
 			return res;
-		}
 	}
 
 	/*
diff --git a/sequencer.h b/sequencer.h
index 5e56cd4..3b89d42 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -51,5 +51,6 @@ void remove_sequencer_state(int aggressive);
 
 void sequencer_parse_args(int argc, const char **argv, struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
+void sequencer_notify_commit(void);
 
 #endif
diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 2b17311..1da99b7 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -114,8 +114,10 @@ test_expect_success 'naive cherry-pick fails' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick --no-commit remote &&
 	git read-tree --reset -u HEAD &&
+	git cherry-pick --reset &&
 	test_must_fail git cherry-pick remote &&
 	test_must_fail git update-index --refresh &&
+	git cherry-pick --reset &&
 	grep "<<<<<<" text.txt
 '
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index c284c96..abd13fe 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -82,13 +82,13 @@ test_expect_success '--reset cleans up sequencer state' '
 	test_path_is_missing .git/sequencer
 '
 
-test_expect_success 'cherry-pick cleans up sequencer state when one commit is left' '
+test_expect_success 'final commit cleans up sequencer state' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..picked &&
-	test_path_is_missing .git/sequencer &&
 	echo "resolved" >foo &&
 	git add foo &&
 	git commit &&
+	test_path_is_missing .git/sequencer &&
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
-- 
1.7.6.351.gb35ac.dirty
