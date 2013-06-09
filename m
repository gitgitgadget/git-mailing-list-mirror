From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 19/45] builtin: add copy_rewrite_notes()
Date: Sun,  9 Jun 2013 11:40:31 -0500
Message-ID: <1370796057-25312-20-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uliid-0006mJ-3c
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab3FIQnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:47 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:63869 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab3FIQnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:45 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so8713297obb.25
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Rp63kf9MeRL0alrNgZaRxcCpac6ST8pGWQ62g8ALv4s=;
        b=scmsCNN1g/1fG7G0TUAP8R331HVZ6hy8I5YUZEGR9RcX7npSjEBMAgkS7qOLRr4cgt
         cniFwFQT7d3BP6IWDfdJ5sJX5gp1c+jlUKnGqeY/qUUBxy62F56NwAfD/Wswg/F2YevE
         Axu0/0gVCKeARnXmviuZ8XbKog9Yv5izifN2IIlvYVI8SVB/P/evyTLMOIEICcYbvZQA
         B1gGFTCj37S2YyGNol9mn/FMF9mx0pVGDyJlG+/So4hqm8WXVPrFUKkysW3Y9AHK8g3u
         mxDzYj9EPM90PYYfwV2ScbrtY2gLSGhIhDv4oAu1V2BmpFyVpPtfRvpa561Io68wglvs
         9UTQ==
X-Received: by 10.60.46.9 with SMTP id r9mr5384828oem.50.1370796224815;
        Sun, 09 Jun 2013 09:43:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm14863459oby.12.2013.06.09.09.43.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226987>

And use it on commit.c.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/commit.c  |  8 +-------
 builtin/rewrite.c | 17 +++++++++++++++++
 builtin/rewrite.h |  1 +
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 56dab4f..4f35794 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1557,16 +1557,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
-			finish_copy_notes_for_rewrite(cfg);
-		}
 		add_rewritten(&rewrite, current_head->object.sha1, sha1);
+		copy_rewrite_notes(&rewrite, "amend");
 		run_rewrite_hook(&rewrite, "amend");
 	}
 	if (!quiet)
diff --git a/builtin/rewrite.c b/builtin/rewrite.c
index 15fcd1a..02e0ea9 100644
--- a/builtin/rewrite.c
+++ b/builtin/rewrite.c
@@ -104,3 +104,20 @@ int run_rewrite_hook(struct rewritten *list, const char *name)
 	close(proc.in);
 	return finish_command(&proc);
 }
+
+void copy_rewrite_notes(struct rewritten *list, const char *name)
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
+	finish_copy_notes_for_rewrite(cfg);
+}
diff --git a/builtin/rewrite.h b/builtin/rewrite.h
index fd00e66..38b2caf 100644
--- a/builtin/rewrite.h
+++ b/builtin/rewrite.h
@@ -15,5 +15,6 @@ void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *t
 int store_rewritten(struct rewritten *list, const char *file);
 void load_rewritten(struct rewritten *list, const char *file);
 int run_rewrite_hook(struct rewritten *list, const char *name);
+void copy_rewrite_notes(struct rewritten *list, const char *name);
 
 #endif
-- 
1.8.3.698.g079b096
