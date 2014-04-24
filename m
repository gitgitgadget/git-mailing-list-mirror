From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 10/12] builtin: rewrite: add copy_rewrite_notes()
Date: Wed, 23 Apr 2014 21:44:49 -0500
Message-ID: <1398307491-21314-11-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:56:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9pT-0007sX-OI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbaDXCz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:55:56 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:33154 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbaDXCzx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:53 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so1983637oag.20
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rP/qCNA6GQgT+akz6frh/k7CBAFGuKSqV7N7QGTJKdg=;
        b=ocd1ACKVCxRxMXYyk3G6QC74NARv5DcEsiGgSm/UUqymgog44NBgjxGDab0mm5Iz+s
         xLqlNRBKWn+vkFjYRkbXIOYNMMbQcd1QrQUPgS9t9KOrzZGeMj01ynAjLVBD04E8aZo8
         URU5hq1AZ9dAjL6gzTnuHAnVpHxgzIyeBidq3PNC5bruRKXS/ROSmz4xsmkzyk+G/bc9
         zse0U/HZEAwP44KQwnhQHprDKbZAvmMxWY2qnzzA6gr/JgD4VzU0xS8Kp/etA5HELFDh
         okCfavZLM2cIai4u+Yeir76TVdTLIcKf8ZyG77gKOQ0G+M1BUqi0lPGBZTfbQxQBzkF7
         xUTg==
X-Received: by 10.182.66.202 with SMTP id h10mr41521431obt.38.1398308153610;
        Wed, 23 Apr 2014 19:55:53 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm11862434oen.3.2014.04.23.19.55.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246923>

And use it on commit.c.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/commit.c |  8 +-------
 rewrite.c        | 18 ++++++++++++++++++
 rewrite.h        |  1 +
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index ea42f22..b5287d6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1661,16 +1661,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	rerere(0);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
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
index 56617ce..59b8be7 100644
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
1.9.2+fc1.2.gfbaae8c
