From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 16/36] cherry-pick: store rewritten commits
Date: Sun,  9 Jun 2013 14:24:30 -0500
Message-ID: <1370805890-3453-17-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHJ-0003fR-RQ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab3FIT1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:33 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36122 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab3FIT1a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:30 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so9103794obc.17
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/Pd0FOPUUQ7fiIELjdGDoVpOFx1XiRU1Qu9qPcq9qTI=;
        b=OIgDSBqgTKViDnE0nR6tZt+RnrtiWDMcACdHoy8U9Cv4DIE3Q/KF/CixjJPKhT+hsQ
         u+6FCyyewlclhHQpVV+WPPAzp6ZqX0ZzJlDVcQuYYdQs7f4EnWq8WFVTfq1465O4xp15
         VZu1jFPisCrZ/9fpUYIsxBOEuVfxl4L0+uKDjuXF9BA0QdYWtWPYpDEc8eARcZs0S2R3
         hiMEsAV2S7cnLBe/k2HhFvZQP+Mf0ZFcmhqdc709d8vHC0H52aiDV6NYG21bu0J4h8YK
         bh2ZCuzJQ2u4m/nrO+219H/pxyNIMawSDPWIV3q4WJN3EeRhHg6QE8OWWDEK+S2iyHxQ
         kDlA==
X-Received: by 10.60.174.83 with SMTP id bq19mr5458922oec.80.1370806050154;
        Sun, 09 Jun 2013 12:27:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm16268525oez.4.2013.06.09.12.27.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227125>

Will be useful for the next commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/sequencer.c | 23 ++++++++++++++++++++++-
 builtin/sequencer.h |  1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index 2b1b30a..24034f2 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -15,9 +15,12 @@
 #include "refs.h"
 #include "argv-array.h"
 #include "log-tree.h"
+#include "rewrite.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
+static struct rewritten rewritten;
+
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -555,6 +558,14 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	if (!opts->no_commit)
 		res = run_git_commit(defmsg, opts, allow);
 
+	if (!res && opts->action == REPLAY_PICK) {
+		unsigned char to[20];
+
+		if (read_ref("HEAD", to))
+			goto leave;
+
+		add_rewritten(&rewritten, commit->object.sha1, to);
+	}
 leave:
 	free_message(&msg);
 	free(defmsg);
@@ -917,9 +928,12 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
-		if (res)
+		if (res) {
+			if (opts->action == REPLAY_PICK)
+				store_rewritten(&rewritten, git_path(SEQ_REWR_FILE));
 			return res;
 		}
+	}
 
 	/*
 	 * Sequence of picks finished successfully; cleanup by
@@ -947,6 +961,8 @@ static int sequencer_continue(struct replay_opts *opts)
 		return continue_single_pick();
 	read_populate_opts(&opts);
 	read_populate_todo(&todo_list, opts);
+	if (opts->action == REPLAY_PICK)
+		load_rewritten(&rewritten, git_path(SEQ_REWR_FILE));
 
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
@@ -957,6 +973,11 @@ static int sequencer_continue(struct replay_opts *opts)
 	}
 	if (index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
+	if (opts->action == REPLAY_PICK) {
+		unsigned char to[20];
+		if (!read_ref("HEAD", to))
+			add_rewritten(&rewritten, todo_list->item->object.sha1, to);
+	}
 	todo_list = todo_list->next;
 	return pick_commits(todo_list, opts);
 }
diff --git a/builtin/sequencer.h b/builtin/sequencer.h
index e69495a..63ba274 100644
--- a/builtin/sequencer.h
+++ b/builtin/sequencer.h
@@ -5,6 +5,7 @@
 #define SEQ_HEAD_FILE	"sequencer/head"
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
+#define SEQ_REWR_FILE	"sequencer/rewritten"
 
 enum replay_action {
 	REPLAY_REVERT,
-- 
1.8.3.698.g079b096
