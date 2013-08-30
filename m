From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 06/28] cherry-pick: store rewritten commits
Date: Fri, 30 Aug 2013 00:56:00 -0500
Message-ID: <1377842182-18724-7-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHlr-0007Bo-6S
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529Ab3H3GBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:18 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:38542 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab3H3GBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:15 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so1824554oah.9
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0RMMy/xAgXIE80KY7VnbIYHqF4c4uI6MB1gygoStkF4=;
        b=d2SMJQZ20tpz64gIz8DSb+/LekbjJpq/nbR96dxHjGwq/Gi4fdzRnIyBHNIt7Qs2YP
         TgkwNV5A3YVSHLowJz4C66EQix8nM+GlFQTvmlZzYwM9MX4LeLTVelknfCVCrMAaGM4R
         mCIXsPKg1Z1895pFLJHY5VU+UzTRihsG4m8kMlrss3mmfKEkKYX4qb2kubmYAyUIIsiS
         iYyniaI9H3pnjgk4GffxCWIKEuBKXupQs9FAtjx8cOXLpU7/wha4tt2xrE7FoQd4VNxh
         J+FKEXwSIrwwwJEP2wRtzjt2RPAU/8YSI1EbewQt9QCcU/6MZ6EC2gZJju2S0ZsaJyyd
         em6A==
X-Received: by 10.182.29.198 with SMTP id m6mr5498082obh.105.1377842475518;
        Thu, 29 Aug 2013 23:01:15 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm36904267oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233400>

Will be useful for the next commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 22 +++++++++++++++++++++-
 sequencer.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d0e65de..468fa54 100644
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
@@ -650,6 +652,14 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
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
@@ -1012,8 +1022,11 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
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
@@ -1042,6 +1055,8 @@ static int sequencer_continue(struct replay_opts *opts)
 		return continue_single_pick();
 	read_populate_opts(&opts);
 	read_populate_todo(&todo_list, opts);
+	if (opts->action == REPLAY_PICK)
+		load_rewritten(&rewritten, git_path(SEQ_REWR_FILE));
 
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
@@ -1052,6 +1067,11 @@ static int sequencer_continue(struct replay_opts *opts)
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
1.8.4-fc
