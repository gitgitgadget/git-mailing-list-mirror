From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 09/28] builtin: rewrite: add copy_rewrite_notes()
Date: Fri, 30 Aug 2013 00:56:03 -0500
Message-ID: <1377842182-18724-10-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmy-0007xJ-0d
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab3H3GC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:02:26 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:53042 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab3H3GBX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:23 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so1470984obc.13
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0bueePfjm64k5Rx7uCL9BShRtt5ZJOyqEUfqDby36Dg=;
        b=rnLb+3NA8jLf2ZO1IWCfWbTSRXPB5nJddX+dM1lh5e9xgBgN3QrLs6iyOmlR1Ou9SS
         4NMVF/Q/B53qQu34wyW9gZLyNqd52ssokO7hfboezJ+LgMMvvsMqYjEpGMJMft/IDDDp
         CVfV6/PRYyKldHlHBVq1QXMZFiMLY2lDnrZ7qGIYJ+iXzvdXF7Fgq0EaZus65iMxJanF
         HRo50s7mRrXflwM8FfuKFV9jWhhA5lmICX2MTC4oxwil/JVsIxHA16xmge5QpXpcmeY/
         MgWCSHNxTMCQdivZ/zv2+WcyVr0YqVzdjl2Thw3LbhTqhpk4HaK1mo3j3sh8Qkz/fMOV
         eDgQ==
X-Received: by 10.182.131.166 with SMTP id on6mr5474198obb.60.1377842483164;
        Thu, 29 Aug 2013 23:01:23 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z2sm35709955obi.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233423>

And use it on commit.c.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/commit.c |  8 +-------
 rewrite.c        | 18 ++++++++++++++++++
 rewrite.h        |  1 +
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7bfe9d0..cc589d5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1621,16 +1621,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
-		struct notes_rewrite_cfg *cfg;
 		struct rewritten rewrite;
 		memset(&rewrite, 0, sizeof(rewrite));
-		cfg = init_copy_notes_for_rewrite("amend");
-		if (cfg) {
-			/* we are amending, so current_head is not NULL */
-			copy_note_for_rewrite(cfg, current_head->object.sha1, sha1);
-			finish_copy_notes_for_rewrite(cfg, "Notes added by 'git commit --amend'");
-		}
 		add_rewritten(&rewrite, current_head->object.sha1, sha1);
+		copy_rewrite_notes(&rewrite, "amend", "Notes added by 'git commit --amend'");
 		run_rewrite_hook(&rewrite, "amend");
 	}
 	if (!quiet)
diff --git a/rewrite.c b/rewrite.c
index c8efaa8..4dddcd9 100644
--- a/rewrite.c
+++ b/rewrite.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "rewrite.h"
 #include "run-command.h"
+#include "notes-utils.h"
 
 void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to)
 {
@@ -101,3 +102,20 @@ int run_rewrite_hook(struct rewritten *list, const char *name)
 	close(proc.in);
 	return finish_command(&proc);
 }
+
+void copy_rewrite_notes(struct rewritten *list, const char *name, const char *msg)
+{
+	struct notes_rewrite_cfg *cfg;
+	int i;
+
+	cfg = init_copy_notes_for_rewrite(name);
+	if (!cfg)
+		return;
+
+	for (i = 0; i < list->nr; i++) {
+		struct rewritten_item *item = &list->items[i];
+		copy_note_for_rewrite(cfg, item->from, item->to);
+	}
+
+	finish_copy_notes_for_rewrite(cfg, msg);
+}
diff --git a/rewrite.h b/rewrite.h
index fd00e66..fdc7055 100644
--- a/rewrite.h
+++ b/rewrite.h
@@ -15,5 +15,6 @@ void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *t
 int store_rewritten(struct rewritten *list, const char *file);
 void load_rewritten(struct rewritten *list, const char *file);
 int run_rewrite_hook(struct rewritten *list, const char *name);
+void copy_rewrite_notes(struct rewritten *list, const char *name, const char *msg);
 
 #endif
-- 
1.8.4-fc
