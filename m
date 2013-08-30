From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 08/28] builtin: move run_rewrite_hook() to rewrite.c
Date: Fri, 30 Aug 2013 00:56:02 -0500
Message-ID: <1377842182-18724-9-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHm2-0007Jh-1R
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab3H3GBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:24 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:37853 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466Ab3H3GBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:21 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so1493458obb.29
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S8zFzVyPGayH9EZupIOo+9dKcb0PVxFHD95dZmJ+Htc=;
        b=kpzOn5Yz+hVBewJLw4bAP5X5TPmq6kYdtiNffefjDgvRj6a8w1CuWl1xF9BCzGZWxy
         xFEozpo2BG3NrLmkYNhg/lMzPixPt350JCgICXLONkhwRR5M6BzG8kLUlo9xIxor3n3E
         ekZ6MwhyenT8xvMbvdlwxI1njj07oLy+douizm7elOtxqEuctWRva0rtfqqgCp0NcFor
         QfO8UqhgRGjF9hiQczyMW+O8kWLgkxD4Y5uG1+UdFkj6jOLaXSXofW0tP8CD+BQHt3PI
         hwtk1SpTxqvGjMQPFvHsSxu0O1NF3xw3f37mkXhJe4qFnqDMmusQauMxzJMGR2TxsKJW
         9Eyg==
X-Received: by 10.60.52.81 with SMTP id r17mr5654000oeo.3.1377842480616;
        Thu, 29 Aug 2013 23:01:20 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm32420840obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233404>

And use struct rewrite.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/commit.c | 38 +++++---------------------------------
 rewrite.c        | 32 ++++++++++++++++++++++++++++++++
 rewrite.h        |  1 +
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 10acc53..7bfe9d0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -30,6 +30,7 @@
 #include "column.h"
 #include "sequencer.h"
 #include "notes-utils.h"
+#include "rewrite.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [options] [--] <pathspec>..."),
@@ -1386,38 +1387,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	return git_status_config(k, v, s);
 }
 
-static int run_rewrite_hook(const unsigned char *oldsha1,
-			    const unsigned char *newsha1)
-{
-	/* oldsha1 SP newsha1 LF NUL */
-	static char buf[2*40 + 3];
-	struct child_process proc;
-	const char *argv[3];
-	int code;
-	size_t n;
-
-	argv[0] = find_hook("post-rewrite");
-	if (!argv[0])
-		return 0;
-
-	argv[1] = "amend";
-	argv[2] = NULL;
-
-	memset(&proc, 0, sizeof(proc));
-	proc.argv = argv;
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-
-	code = start_command(&proc);
-	if (code)
-		return code;
-	n = snprintf(buf, sizeof(buf), "%s %s\n",
-		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
-	write_in_full(proc.in, buf, n);
-	close(proc.in);
-	return finish_command(&proc);
-}
-
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	static struct wt_status s;
@@ -1653,13 +1622,16 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		struct notes_rewrite_cfg *cfg;
+		struct rewritten rewrite;
+		memset(&rewrite, 0, sizeof(rewrite));
 		cfg = init_copy_notes_for_rewrite("amend");
 		if (cfg) {
 			/* we are amending, so current_head is not NULL */
 			copy_note_for_rewrite(cfg, current_head->object.sha1, sha1);
 			finish_copy_notes_for_rewrite(cfg, "Notes added by 'git commit --amend'");
 		}
-		run_rewrite_hook(current_head->object.sha1, sha1);
+		add_rewritten(&rewrite, current_head->object.sha1, sha1);
+		run_rewrite_hook(&rewrite, "amend");
 	}
 	if (!quiet)
 		print_summary(prefix, sha1, !current_head);
diff --git a/rewrite.c b/rewrite.c
index 2793688..c8efaa8 100644
--- a/rewrite.c
+++ b/rewrite.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "rewrite.h"
+#include "run-command.h"
 
 void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to)
 {
@@ -69,3 +70,34 @@ void load_rewritten(struct rewritten *list, const char *file)
 	}
 	strbuf_release(&buf);
 }
+
+int run_rewrite_hook(struct rewritten *list, const char *name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process proc;
+	const char *argv[3];
+	int code, i;
+
+	argv[0] = find_hook("post-rewrite");
+	if (!argv[0])
+		return 0;
+
+	argv[1] = name;
+	argv[2] = NULL;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv = argv;
+	proc.in = -1;
+	proc.stdout_to_stderr = 1;
+
+	code = start_command(&proc);
+	if (code)
+		return code;
+	for (i = 0; i < list->nr; i++) {
+		struct rewritten_item *item = &list->items[i];
+		strbuf_addf(&buf, "%s %s\n", sha1_to_hex(item->from), sha1_to_hex(item->to));
+	}
+	write_in_full(proc.in, buf.buf, buf.len);
+	close(proc.in);
+	return finish_command(&proc);
+}
diff --git a/rewrite.h b/rewrite.h
index 09e7222..fd00e66 100644
--- a/rewrite.h
+++ b/rewrite.h
@@ -14,5 +14,6 @@ struct rewritten {
 void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to);
 int store_rewritten(struct rewritten *list, const char *file);
 void load_rewritten(struct rewritten *list, const char *file);
+int run_rewrite_hook(struct rewritten *list, const char *name);
 
 #endif
-- 
1.8.4-fc
