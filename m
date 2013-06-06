From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 6/9] cherry-pick: add support to copy notes
Date: Thu,  6 Jun 2013 03:59:01 -0500
Message-ID: <1370509144-31974-7-git-send-email-felipe.contreras@gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 11:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkW4R-0006Dn-1m
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 11:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432Ab3FFJBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 05:01:16 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:49501 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab3FFJBO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 05:01:14 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so4309153obb.32
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SywRdoKCks+QONhW7lFMemZE91N/J+Ecic8Y1zxfU1I=;
        b=rwVQgElEyHutHyTOmBi6mADkiQB34KQ6buk05KW6kp0FW94Bo2ZTK+IulQiMNsn0QC
         UVADjfUARZnBaF2SuV0MfMKLI/eTL80b97wiqLwVnVrHUxU/qneYofXtoIOuPMW5+dGQ
         /cu1GRdPBayOht+KZZF1KDk89B05jZSxcXspnRob/eThTfabRA+ACKSQBItvGNKrBNNY
         wt8duFUwTI3FKk6mH4Xl8RkjErxhskD9dujXoFxq0t38vKXKyttmTmIrInhiR4STYxSs
         m944k8uk2rOTo33rULvdex9Junw9IadKyd2UQ63KmJ7p5n2hxD9fzjpR7ys1Psh5yjRy
         tbFw==
X-Received: by 10.60.161.68 with SMTP id xq4mr17904001oeb.8.1370509273592;
        Thu, 06 Jun 2013 02:01:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z5sm57303012obw.4.2013.06.06.02.01.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 02:01:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226492>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 74480d7..6d13e63 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -14,6 +14,7 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "builtin.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -158,6 +159,32 @@ static void run_rewrite_hook(const char *name)
 	finish_command(&proc);
 }
 
+static void copy_notes(const char *name)
+{
+	struct notes_rewrite_cfg *cfg;
+	int i;
+
+	cfg = init_copy_notes_for_rewrite(name);
+	if (!cfg)
+		return;
+
+	for (i = 0; i < rewritten.nr; i++) {
+		struct rewritten_list_item *item = &rewritten.items[i];
+		copy_note_for_rewrite(cfg, item->from, item->to);
+	}
+
+	finish_copy_notes_for_rewrite(cfg);
+}
+
+static void finish(struct replay_opts *opts)
+{
+	if (opts->action != REPLAY_PICK)
+		return;
+
+	run_rewrite_hook("cherry-pick");
+	copy_notes("cherry-pick");
+}
+
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -1131,8 +1158,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		}
 	}
 
-	if (opts->action == REPLAY_PICK)
-		run_rewrite_hook("cherry-pick");
+	finish(opts);
 
 	/*
 	 * Sequence of picks finished successfully; cleanup by
@@ -1188,8 +1214,7 @@ static int single_pick(struct commit *cmit, struct replay_opts *opts)
 	ret = do_pick_commit(cmit, opts);
 	if (ret)
 		return ret;
-	if (opts->action == REPLAY_PICK)
-		run_rewrite_hook("cherry-pick");
+	finish(opts);
 	return 0;
 }
 
-- 
1.8.3.698.g079b096
