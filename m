From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 07/28] cherry-pick: don't store skipped commit
Date: Fri, 30 Aug 2013 00:56:01 -0500
Message-ID: <1377842182-18724-8-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHm1-0007Jh-Gu
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab3H3GBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:21 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:35513 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab3H3GBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:18 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so1786096oag.8
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3svDrtUUCXPMrQ2ZYG6FhRpK6CAVZnXwTuJ/nyn75ls=;
        b=HdzjGnZhKrtfSr/LhYhUrnXMRQP73SErk/D4PdfUJ0coYL035LGw9Qx0jP3b8sqGWG
         n0uwe2bF+dKyz83hYX8HYdRQ0qM6ghqdyOMF+Uhpb40nZk7c8QxA5UNtlTuEn6ES9Enk
         hyZgitZ5I3lK1SrNb22EapeIO6+a1gQTCzFXqI+63YgUFZXngwP6J+5soY9uu+fdz6hS
         ISyhDj/d9qB1Pcu71m60ptZsRul1dyU88k25k1CcUXkkYcVH0K/kMVOYN5fJeTetZDm5
         HsTGH8rspdvWC95LU8qz5isuKhCOU4EzrHPdhfmYM5z85tp4biz5N6UR2ZdZEdP+NpfL
         kLtQ==
X-Received: by 10.182.106.4 with SMTP id gq4mr5631477obb.4.1377842478075;
        Thu, 29 Aug 2013 23:01:18 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id uz16sm35712706obc.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233402>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 468fa54..56d791f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1047,7 +1047,7 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
-static int sequencer_continue(struct replay_opts *opts)
+static int sequencer_continue(struct replay_opts *opts, int skip)
 {
 	struct commit_list *todo_list = NULL;
 
@@ -1067,7 +1067,7 @@ static int sequencer_continue(struct replay_opts *opts)
 	}
 	if (index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
-	if (opts->action == REPLAY_PICK) {
+	if (opts->action == REPLAY_PICK && !skip) {
 		unsigned char to[20];
 		if (!read_ref("HEAD", to))
 			add_rewritten(&rewritten, todo_list->item->object.sha1, to);
@@ -1095,7 +1095,7 @@ static int sequencer_skip(struct replay_opts *opts)
 	if (ret)
 		return ret;
 
-	return sequencer_continue(opts);
+	return sequencer_continue(opts, 1);
 }
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
@@ -1127,7 +1127,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_ROLLBACK)
 		return sequencer_rollback(opts);
 	if (opts->subcommand == REPLAY_CONTINUE)
-		return sequencer_continue(opts);
+		return sequencer_continue(opts, 0);
 	if (opts->subcommand == REPLAY_SKIP)
 		return sequencer_skip(opts);
 
-- 
1.8.4-fc
