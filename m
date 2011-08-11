From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/6] sequencer: Remove sequencer state after final commit
Date: Fri, 12 Aug 2011 00:21:45 +0530
Message-ID: <1313088705-32222-7-git-send-email-artagnon@gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 11 20:55:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QraPy-0003Vr-Sx
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 20:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab1HKSzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 14:55:13 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63951 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab1HKSzM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 14:55:12 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so4115440pzk.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 11:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gAWoXipBtcJE7aCibP48GNXbKSCHFjBQWjf2KItjGnM=;
        b=ib7t+6+/JIkt8m4YOolL54e8boNaQzOdNzlZ2IFW9x+TGwSS2DeASjfASo2uDuwKm5
         GONZQKoz9aTokATZYa/xs5U6OXC4oi6p9Rd5lALi9hoM1n8Tkb5oZtSONkIhCfDdePzS
         YFz3uiVpbP4QQe+YevxNoFfDTxajzMYTX67og=
Received: by 10.143.21.39 with SMTP id y39mr4026543wfi.300.1313088911920;
        Thu, 11 Aug 2011 11:55:11 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t7sm1117355wfl.2.2011.08.11.11.55.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 11:55:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179133>

Since d3f4628e (revert: Remove sequencer state when no commits are
pending, 2011-07-06), the sequencer removes the sequencer state before
the final commit is actually completed.  This design is inherently
flawed, as it will not allow the user to abort the sequencer operation
at that stage.  Instead, write and expose a new function to count the
number of commits left in the instruction sheet; use this in
builtin/commit.c to remove the sequencer state when a commit has
successfully completed and there is only one instruction left in the
sheet.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/commit.c                |    7 ++++++-
 sequencer.c                     |   26 +++++++++++++++-----------
 sequencer.h                     |    1 +
 t/t3510-cherry-pick-sequence.sh |    4 ++--
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e1af9b1..4a5af9a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -26,6 +26,7 @@
 #include "unpack-trees.h"
 #include "quote.h"
 #include "submodule.h"
+#include "sequencer.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -1521,7 +1522,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
 
-	if (commit_index_files())
+	/* Remove sequencer state if we just finished the last insn */
+	if (sequencer_count_todo() == 1)
+		remove_sequencer_state(1);
+
+       if (commit_index_files())
 		die (_("Repository has been updated, but unable to write\n"
 		     "new_index file. Check that disk is not full or quota is\n"
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
diff --git a/sequencer.c b/sequencer.c
index e72618c..783b4a9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -736,6 +736,20 @@ static void read_populate_todo(struct replay_insn_list **todo_list)
 		die(_("Unusable instruction sheet: %s"), todo_file);
 }
 
+int sequencer_count_todo(void)
+{
+	struct replay_insn_list *todo_list = NULL;
+	struct replay_insn_list *cur;
+	int insn_count = 0;
+
+	if (!file_exists(git_path(SEQ_TODO_FILE)))
+		return 0;
+	read_populate_todo(&todo_list);
+	for (cur = todo_list; cur; cur = cur->next)
+		insn_count += 1;
+	return insn_count;
+}
+
 static int populate_opts_cb(const char *key, const char *value, void *data)
 {
 	struct replay_opts *opts = data;
@@ -901,18 +915,8 @@ static int pick_commits(struct replay_insn_list *todo_list,
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur);
 		res = do_pick_commit(cur->operand, cur->action, opts);
-		if (res) {
-			if (!cur->next && res > 0)
-				/*
-				 * A conflict was encountered while
-				 * picking the last commit.  The
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
index ebf20cb..c64ba91 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -52,5 +52,6 @@ void remove_sequencer_state(int aggressive);
 
 void sequencer_parse_args(int argc, const char **argv, struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
+int sequencer_count_todo(void);
 
 #endif
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index bc7fb13..57e9e7c 100755
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
