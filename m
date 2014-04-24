From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 09/12] builtin: move run_rewrite_hook() to rewrite.c
Date: Wed, 23 Apr 2014 21:44:48 -0500
Message-ID: <1398307491-21314-10-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:56:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9pU-0007sX-I1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbaDXCz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:55:58 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:38619 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbaDXCzt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:49 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so2001532oag.34
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RVheqi4QXNSC1r0y+TkIx64iqRMAaBfiWQD8Vm/AVrE=;
        b=0j9jUiuiVYxbDOolTltavHuP6Xu2CaXFwe1XkT/45+FnzwHvQskTDiLwr/H/rN9Zcy
         a59Xx2ymPtZC5ML5Gdr9NQcJr9eHkIg0TmyVUwwQc2GFdU6Fsv7m5xxgT/Dl6JuQ5aIy
         5WNFzUkFMT1IkpyE4m4BKw94Qr+v2nthERmHI1BkpkXPEkk0o4X2r+W41AaNGnvXT/FK
         0bAY71+ts1utraVHzpzajqwOFxxlKnpr3J/ndzr0de1A2gtzVLzObhkUCO26RQYrws+W
         TAhRk9R8WWLMtUWq2fK+S0iQXhMuUlr/+ALA8toR9wUT0Qe1d+vLSZ8Jb1Mn6lpKcB5m
         QVLA==
X-Received: by 10.60.55.97 with SMTP id r1mr46172814oep.5.1398308149480;
        Wed, 23 Apr 2014 19:55:49 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qp6sm5734157obb.14.2014.04.23.19.55.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246924>

And use struct rewrite.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/commit.c | 38 +++++---------------------------------
 rewrite.c        | 32 ++++++++++++++++++++++++++++++++
 rewrite.h        |  1 +
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7d711ea..ea42f22 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -31,6 +31,7 @@
 #include "sequencer.h"
 #include "notes-utils.h"
 #include "mailmap.h"
+#include "rewrite.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [options] [--] <pathspec>..."),
@@ -1411,38 +1412,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
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
 int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
 {
 	const char *hook_env[3] =  { NULL };
@@ -1693,13 +1662,16 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
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
index 436d54a..56617ce 100644
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
1.9.2+fc1.2.gfbaae8c
