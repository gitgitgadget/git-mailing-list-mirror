From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 07/12] cherry-pick: store rewritten commits
Date: Wed, 23 Apr 2014 21:44:46 -0500
Message-ID: <1398307491-21314-8-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:56:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9pn-0008CC-8d
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbaDXC4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:56:12 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:65265 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbaDXCzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:43 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so1959200obc.36
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IV57k1xenxBMJ05TzLjzoMwSWbY5lKDW2kt1qo1B6VQ=;
        b=rHeaYT+m/jtl4DSBqQLPW9eFObKCWXs1+ugTjyrfR1Afsj3j26KkSQE9rjKYsBK1ZU
         73toOs7q0oGeK8ZJqVB1qTwRJwPLep8ysY9PTtmaguDJFSEMKTkoAUrGTOdS7cP6c9hO
         imJ1OGBDsO6W0uTcppnGfICFw+JxaCbBk0zc1qfaQ1XLo61nC6AE6+4OLnUhADwlCxgS
         JmqCcFY8ZSZUl/QkKasv8IA9sJbo3Dvk4dfKb0cj3cEcvJDfz/F4Gj5emCDYAtmhaoNz
         L+ixwcReOgLtGbU+M63qlCRBmaRlfZKjOG0gxTWNyPY5ncdTOZaA/LVMkTFE350oNacf
         XrUw==
X-Received: by 10.182.105.1 with SMTP id gi1mr46197504obb.9.1398308143168;
        Wed, 23 Apr 2014 19:55:43 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j9sm5721222obh.23.2014.04.23.19.55.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246928>

Will be useful for the next commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 22 +++++++++++++++++++++-
 sequencer.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index a258627..426fddd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -14,11 +14,13 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "rewrite.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
+static struct rewritten rewritten;
 
 static int is_rfc2822_line(const char *buf, int len)
 {
@@ -651,6 +653,14 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
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
@@ -1021,8 +1031,11 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
-		if (res)
+		if (res) {
+			if (opts->action == REPLAY_PICK)
+				store_rewritten(&rewritten, git_path(SEQ_REWR_FILE));
 			return res;
+		}
 	}
 
 	/*
@@ -1051,6 +1064,8 @@ static int sequencer_continue(struct replay_opts *opts)
 		return continue_single_pick();
 	read_populate_opts(&opts);
 	read_populate_todo(&todo_list, opts);
+	if (opts->action == REPLAY_PICK)
+		load_rewritten(&rewritten, git_path(SEQ_REWR_FILE));
 
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
@@ -1061,6 +1076,11 @@ static int sequencer_continue(struct replay_opts *opts)
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
diff --git a/sequencer.h b/sequencer.h
index 74d592a..efec1b5 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -5,6 +5,7 @@
 #define SEQ_HEAD_FILE	"sequencer/head"
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
+#define SEQ_REWR_FILE	"sequencer/rewritten"
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
-- 
1.9.2+fc1.2.gfbaae8c
