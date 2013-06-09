From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 20/45] cherry-pick: copy notes and run hooks
Date: Sun,  9 Jun 2013 11:40:32 -0500
Message-ID: <1370796057-25312-21-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uliim-0006ud-JN
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab3FIQnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:50 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:53587 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab3FIQns (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:48 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8852605obc.20
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qWVpbYa+ZuouTaTPWEEOVrMiOISdMDnKZh7a32bIrIc=;
        b=HMj/5ecp1UCgpnaufOsZsSeAuHp3uc7txoX64Zj4lYwNlDsrXfzlHJeaz1xmE6NUT+
         Yal1wFcQ6AOOXXAA33ghmlJPWke/MFWELri4RYz51xviOVPTPs3bdkBsNnB2EBrHXyLT
         tlMIuZ35uwbKvIpulHxGzXV8hQkBP62yUpjj99zUT9F5iJvldW3SYaMSowi5EHSf8oty
         3C+Lrk2ck5WqSC5ucgfSz1x2gpX8fB0e8V/LEPgdFfjFULYHEbatZioqsI9fEa/ZEpiI
         +4sRi88OnbMwS1F0g3gSM/DN0YbkGOZbjLJswRiWtiQBY/MYdqlmq9w1wsgKarsctaeb
         YPgA==
X-Received: by 10.182.66.170 with SMTP id g10mr5362215obt.64.1370796227684;
        Sun, 09 Jun 2013 09:43:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id dz4sm14846124obb.14.2013.06.09.09.43.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226989>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/rewrite.c   |  1 +
 builtin/sequencer.c | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/rewrite.c b/builtin/rewrite.c
index 02e0ea9..acbad44 100644
--- a/builtin/rewrite.c
+++ b/builtin/rewrite.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "rewrite.h"
 #include "run-command.h"
+#include "builtin.h"
 
 void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to)
 {
diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index d40fda9..fe96f1f 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -21,6 +21,15 @@
 
 static struct rewritten rewritten;
 
+static void finish(struct replay_opts *opts)
+{
+	if (opts->action != REPLAY_PICK)
+		return;
+
+	run_rewrite_hook(&rewritten, "cherry-pick");
+	copy_rewrite_notes(&rewritten, "cherry-pick");
+}
+
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -935,6 +944,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		}
 	}
 
+	finish(opts);
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -1006,8 +1017,13 @@ static int sequencer_skip(struct replay_opts *opts)
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
+	int ret;
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(cmit, opts);
+	ret = do_pick_commit(cmit, opts);
+	if (ret)
+		return ret;
+	finish(opts);
+	return 0;
 }
 
 int sequencer_pick_revisions(struct replay_opts *opts)
-- 
1.8.3.698.g079b096
