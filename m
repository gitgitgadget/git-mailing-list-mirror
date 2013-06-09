From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 17/45] cherry-pick: don't store skipped commit
Date: Sun,  9 Jun 2013 11:40:29 -0500
Message-ID: <1370796057-25312-18-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uliic-0006mJ-HW
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab3FIQnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:43 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:41505 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3FIQnj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:39 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so9025773obb.15
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E4a606BbeR9V++cwxtV8/Qn1yZJ0U7l2QzTZIIy4Nd0=;
        b=e1lUpxhuR6psHyIU2RckBrdOpGJ+0LEMnjeHcrTTa+0ygLONjRGF0Fukh5o128lkc2
         F0SxZDBWkhKkW/zXOPYjnT0hMR6qWdHMncIQGuTH562bFg+9ttL4a/y/rnRVpcyLr1xZ
         O81dlmfgP9zzxfVZopwkpcZfxJ54ud4brDIL2z452sHAXLjkWCVeNcslxSJ7ZcA40Cht
         Fdd6CqNDbzoR5TvGMq8K9/ffMZ/GbOOD/aTTpoTh7YzjFS3mCzhUAfGIsv7Xuzg4U2OI
         E5RqpVIGJu0oWePw7BjJv6tiNUgOpKXtoXC/HDByatHB9RURS/zRhnMnZYfXrqUeAlx6
         vQeQ==
X-Received: by 10.182.128.106 with SMTP id nn10mr5345949obb.72.1370796219023;
        Sun, 09 Jun 2013 09:43:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id dz4sm14844861obb.14.2013.06.09.09.43.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226986>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/sequencer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index 24034f2..d40fda9 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -953,7 +953,7 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
-static int sequencer_continue(struct replay_opts *opts)
+static int sequencer_continue(struct replay_opts *opts, int skip)
 {
 	struct commit_list *todo_list = NULL;
 
@@ -973,7 +973,7 @@ static int sequencer_continue(struct replay_opts *opts)
 	}
 	if (index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
-	if (opts->action == REPLAY_PICK) {
+	if (opts->action == REPLAY_PICK && !skip) {
 		unsigned char to[20];
 		if (!read_ref("HEAD", to))
 			add_rewritten(&rewritten, todo_list->item->object.sha1, to);
@@ -1001,7 +1001,7 @@ static int sequencer_skip(struct replay_opts *opts)
 	if (ret)
 		return ret;
 
-	return sequencer_continue(opts);
+	return sequencer_continue(opts, 1);
 }
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
@@ -1033,7 +1033,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_ROLLBACK)
 		return sequencer_rollback(opts);
 	if (opts->subcommand == REPLAY_CONTINUE)
-		return sequencer_continue(opts);
+		return sequencer_continue(opts, 0);
 	if (opts->subcommand == REPLAY_SKIP)
 		return sequencer_skip(opts);
 
-- 
1.8.3.698.g079b096
