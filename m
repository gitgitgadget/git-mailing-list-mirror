From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 18/36] builtin: move run_rewrite_hook() to rewrite.c
Date: Sun,  9 Jun 2013 14:24:32 -0500
Message-ID: <1370805890-3453-19-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHK-0003fR-U4
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab3FIT1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:38 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:49459 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab3FIT1g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:36 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so8958914obc.27
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Cbyg50Ao4Xo166pxMQ9Jpk9i5fjmSmR4f6AvoX9ba3k=;
        b=YZRNtPPmAMPoR5fHvnbEYlyzQeD4/Q0yGdBYY0NjkJWi+GMYG8sgG/Ejo2g3+A4pYr
         X5jEcWIo85JtlzF+zqqLYJXS1HQM3KmptDhNSLCSAG3OfLt/ab8dlnjtCGjcjPPtqqrD
         WA45STTkZnbQifimwRZNeEcj0fbUGJavlqTWoetE1ozgvNVsY+FIjywzDCfOt7GVKFsX
         rE2aAj2igJ/jU35ae8r6anNAhn9rriLhD56g2S/xAvtWU5zDepkhVxt87gDx7qjPxEG1
         Nzsfruv45Jq3c02NLGNzIzNyDqaWvhRTZGLF3MZyKIQKP0aW3sLpVlxGW/jY0/+AtIjW
         HGvg==
X-Received: by 10.182.87.170 with SMTP id az10mr5674248obb.10.1370806055517;
        Sun, 09 Jun 2013 12:27:35 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm16289064oel.2.2013.06.09.12.27.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227126>

And use struct rewrite.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/commit.c  | 38 +++++---------------------------------
 builtin/rewrite.c | 32 ++++++++++++++++++++++++++++++++
 builtin/rewrite.h |  1 +
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1621dfc..56dab4f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -29,6 +29,7 @@
 #include "gpg-interface.h"
 #include "column.h"
 #include "sequencer.h"
+#include "rewrite.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [options] [--] <pathspec>..."),
@@ -1323,38 +1324,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
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
@@ -1589,13 +1558,16 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		struct notes_rewrite_cfg *cfg;
+		struct rewritten rewrite;
+		memset(&rewrite, 0, sizeof(rewrite));
 		cfg = init_copy_notes_for_rewrite("amend");
 		if (cfg) {
 			/* we are amending, so current_head is not NULL */
 			copy_note_for_rewrite(cfg, current_head->object.sha1, sha1);
 			finish_copy_notes_for_rewrite(cfg);
 		}
-		run_rewrite_hook(current_head->object.sha1, sha1);
+		add_rewritten(&rewrite, current_head->object.sha1, sha1);
+		run_rewrite_hook(&rewrite, "amend");
 	}
 	if (!quiet)
 		print_summary(prefix, sha1, !current_head);
diff --git a/builtin/rewrite.c b/builtin/rewrite.c
index 2519352..15fcd1a 100644
--- a/builtin/rewrite.c
+++ b/builtin/rewrite.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "rewrite.h"
+#include "run-command.h"
 
 void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to)
 {
@@ -72,3 +73,34 @@ void load_rewritten(struct rewritten *list, const char *file)
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
diff --git a/builtin/rewrite.h b/builtin/rewrite.h
index 09e7222..fd00e66 100644
--- a/builtin/rewrite.h
+++ b/builtin/rewrite.h
@@ -14,5 +14,6 @@ struct rewritten {
 void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to);
 int store_rewritten(struct rewritten *list, const char *file);
 void load_rewritten(struct rewritten *list, const char *file);
+int run_rewrite_hook(struct rewritten *list, const char *name);
 
 #endif
-- 
1.8.3.698.g079b096
