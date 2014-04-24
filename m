From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 08/12] cherry-pick: don't store skipped commit
Date: Wed, 23 Apr 2014 21:44:47 -0500
Message-ID: <1398307491-21314-9-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:55:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9pO-0007kP-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbaDXCzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:55:50 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47137 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbaDXCzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:48 -0400
Received: by mail-oa0-f46.google.com with SMTP id m1so1982448oag.5
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sx6hSPCq1G+jLzXsSGObV8hwsZYC65aZXUITVMOo8hY=;
        b=mvfjYKzBq2vrNehnw1cV3Q6CUzo0w263kGRNdCFQHVCbbL71k1ePov3i5vvfwRBuR5
         t5XLLDGDs4DyYUEJVnQn+wVcDMdBmUEge69oxJro6bQJ6LrCcTx/2uYneCSlHKuwGkhj
         CIAyvwb6vCJbrt9TnWAqA42ObCQZvqdJlcEr6uGRFMEKs7X0bKWoLXS1VfYBKe191iaX
         M37HBpxUKhk/iPsb2pfzTlleHhnpSOziq25ZqydB22B6meho07ZOGr9Lsyr6+XUyPTPI
         5KjVgcdn+57zW2GdIA3gSm7Q+cXrLY3Zs7aueNzwgUASCfBoD6x/cKt53Z9BRlhz84ku
         TmEA==
X-Received: by 10.182.55.3 with SMTP id n3mr10780316obp.55.1398308146191;
        Wed, 23 Apr 2014 19:55:46 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b6sm11829589oez.8.2014.04.23.19.55.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:45 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246921>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 426fddd..fc0dd04 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1056,7 +1056,7 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
-static int sequencer_continue(struct replay_opts *opts)
+static int sequencer_continue(struct replay_opts *opts, int skip)
 {
 	struct commit_list *todo_list = NULL;
 
@@ -1076,7 +1076,7 @@ static int sequencer_continue(struct replay_opts *opts)
 	}
 	if (index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
-	if (opts->action == REPLAY_PICK) {
+	if (opts->action == REPLAY_PICK && !skip) {
 		unsigned char to[20];
 		if (!read_ref("HEAD", to))
 			add_rewritten(&rewritten, todo_list->item->object.sha1, to);
@@ -1104,7 +1104,7 @@ static int sequencer_skip(struct replay_opts *opts)
 	if (ret)
 		return ret;
 
-	return sequencer_continue(opts);
+	return sequencer_continue(opts, 1);
 }
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
@@ -1136,7 +1136,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_ROLLBACK)
 		return sequencer_rollback(opts);
 	if (opts->subcommand == REPLAY_CONTINUE)
-		return sequencer_continue(opts);
+		return sequencer_continue(opts, 0);
 	if (opts->subcommand == REPLAY_SKIP)
 		return sequencer_skip(opts);
 
-- 
1.9.2+fc1.2.gfbaae8c
