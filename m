From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] sequencer: Remove sequencer state after final commit
Date: Wed, 10 Aug 2011 15:25:51 +0530
Message-ID: <1312970151-18906-6-git-send-email-artagnon@gmail.com>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 10 11:59:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qr5Zj-00021r-KX
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 11:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab1HJJ7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 05:59:24 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61802 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab1HJJ7W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 05:59:22 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1583833pzk.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ulg5HNty74NpgWvIjdC+jBPgzlXRQE+Jj9BOJ6vRdbM=;
        b=WnbP5egxyPPKO2mgqmjKkRmiRknfQEBAmLNPHD59Pu7f7XJzKNKdiL7BhuN2PNOTqn
         OqqRDwg8Uc1HpqjZEGjMek2/u+kT3QRB2Hf4suI8QV2VpZdD6SQ0N9NonnksGP4PqVC8
         10zBjAN2aFnJ04n4404J6haZc5yL7/sWVBpxo=
Received: by 10.142.152.23 with SMTP id z23mr7252605wfd.186.1312970362545;
        Wed, 10 Aug 2011 02:59:22 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id s7sm725394pbj.69.2011.08.10.02.59.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 02:59:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179061>

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
 builtin/commit.c                |    5 +++++
 builtin/revert.c                |   12 +-----------
 sequencer.c                     |   14 ++++++++++++++
 sequencer.h                     |    1 +
 t/t3510-cherry-pick-sequence.sh |    4 ++--
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e1af9b1..7ee4269 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -26,6 +26,7 @@
 #include "unpack-trees.h"
 #include "quote.h"
 #include "submodule.h"
+#include "sequencer.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -1521,6 +1522,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
 
+	/* Remove sequencer state if we just finished the last insn */
+	if (sequencer_count_todo() == 1)
+		remove_sequencer_state(1);
+
 	if (commit_index_files())
 		die (_("Repository has been updated, but unable to write\n"
 		     "new_index file. Check that disk is not full or quota is\n"
diff --git a/builtin/revert.c b/builtin/revert.c
index 491c10a..718ba86 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -581,18 +581,8 @@ static int pick_commits(struct replay_insn_list *todo_list,
 		sequencer_save_todo(cur);
 		opts->action = cur->action;
 		res = do_pick_commit(cur->operand, opts);
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
diff --git a/sequencer.c b/sequencer.c
index 2993846..0ad1da6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -326,3 +326,17 @@ void sequencer_save_opts(struct replay_opts *opts)
 							opts->xopts[i], "^$", 0);
 	}
 }
+
+int sequencer_count_todo(void)
+{
+	struct replay_insn_list *todo_list = NULL;
+	struct replay_insn_list *cur;
+	int insn_count = 0;
+
+	if (!file_exists(git_path(SEQ_TODO_FILE)))
+		return 0;
+	sequencer_read_todo(&todo_list);
+	for (cur = todo_list; cur; cur = cur->next)
+		insn_count += 1;
+	return insn_count;
+}
diff --git a/sequencer.h b/sequencer.h
index a5b951d..ca133e2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -68,5 +68,6 @@ int sequencer_create_dir(void);
 void sequencer_save_head(const char *head);
 void sequencer_save_todo(struct replay_insn_list *todo_list);
 void sequencer_save_opts(struct replay_opts *opts);
+int sequencer_count_todo(void);
 
 #endif
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index f85372c..832baa0 100755
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
