From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 18/45] builtin: move run_rewrite_hook() to rewrite.c
Date: Sun,  9 Jun 2013 11:40:30 -0500
Message-ID: <1370796057-25312-19-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:45:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlikG-00080v-Ca
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab3FIQp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:45:26 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:40844 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3FIQnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:42 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so9021413obc.13
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Cbyg50Ao4Xo166pxMQ9Jpk9i5fjmSmR4f6AvoX9ba3k=;
        b=QFboy+IMh8uObf/M2NINmpDNapIyiTgdE4KLNr3LwKwHxqo6B/XweSU6nioXJDh1wI
         9vx+CXeRsBlYD0co5+10PiH4TRH4rKh2OQ3+pbTih5I2f85qoPJZC6d81K+aGom8JZil
         dX6Mv2mgg9t0n9iLOeqcQRoCZ3HNpuecV8YKf2koPtHUA3J9YuyVpN0f7eHV1+RRSuTG
         1b/pEJVgvyJvkjBZGv2kSYBCRb3lW/N4j7anT0FH2AW3Epe9EtS4C4yfkrRHd+eT1woB
         0QRKsHvzIaS0ynveiG4b9F+NYPnCKrTtgi8V0BAaSZ0G+vGgkwUu/vqfFpfGp9/NlCc/
         Ibgg==
X-Received: by 10.60.121.106 with SMTP id lj10mr5355852oeb.128.1370796221846;
        Sun, 09 Jun 2013 09:43:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kz3sm14917874obb.6.2013.06.09.09.43.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227016>

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
