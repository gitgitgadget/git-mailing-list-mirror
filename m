From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/14] revert: Introduce a layer of indirection over pick_commits
Date: Wed,  6 Jul 2011 07:54:25 +0000
Message-ID: <1309938868-2028-12-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:54:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMwh-0005vT-RM
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab1GFHyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:54:51 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48564 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab1GFHyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:49 -0400
Received: by mail-qy0-f174.google.com with SMTP id 29so1924487qyk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iShwQ89/64dmSdSZtzm2CyXI5ijo2EDT62xfnmgfi6s=;
        b=OfnVMJ2fEAl5UaIr9KgF0agD6zpVxL3r5uEwlX6wl3RPYPhbJSjSbmAwBAcA+5FcJR
         eDdxOkeeTuJ5jOd7Y56gHmeBo0fVuoR7sxJ4Ck2Yc67lwkxk72W8kWDrFoUJ61Mn3r6+
         113SILNYfYViuMCvGgAbiKPWYKfcGOUbyKdh0=
Received: by 10.229.61.102 with SMTP id s38mr6054278qch.198.1309938888626;
        Wed, 06 Jul 2011 00:54:48 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176655>

Write a new function called process_continuation to prepare a
todo_list to call pick_commits with; the job of pick_commits is
simplified into performing the tasks listed in todo_list.  This will
be useful when continuation functionality like "--continue" is
introduced later in the series.

Helped-by: Jonathan Nieder <jrnider@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   36 +++++++++++++++++++++++++-----------
 1 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 7d76f92..8cdcdb6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -677,10 +677,8 @@ static int cleanup_sequencer_data(void)
 	return 0;
 }
 
-static int pick_commits(struct replay_opts *opts)
+static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
-	unsigned char sha1[20];
 	struct commit_list *cur;
 	int res;
 
@@ -690,12 +688,6 @@ static int pick_commits(struct replay_opts *opts)
 				opts->record_origin || opts->edit));
 	read_and_refresh_cache(me, opts);
 
-	walk_revs_populate_todo(&todo_list, opts);
-	create_seq_dir();
-	if (!get_sha1("HEAD", sha1))
-		save_head(sha1_to_hex(sha1));
-	save_todo(todo_list, opts);
-
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
@@ -710,6 +702,22 @@ static int pick_commits(struct replay_opts *opts)
 	return cleanup_sequencer_data();
 }
 
+static int process_continuation(struct replay_opts *opts)
+{
+	struct commit_list *todo_list = NULL;
+	unsigned char sha1[20];
+
+	read_and_refresh_cache(me, opts);
+
+	walk_revs_populate_todo(&todo_list, opts);
+	create_seq_dir();
+	if (!get_sha1("HEAD", sha1))
+		persist_head(sha1_to_hex(sha1));
+	persist_todo(todo_list, opts);
+
+	return pick_commits(todo_list, opts);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	int res;
@@ -722,7 +730,13 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "revert";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+
+	/*
+	 * Decide what to do depending on the arguments; a fresh
+	 * cherry-pick should be handled differently from an existing
+	 * one that is being continued
+	 */
+	res = process_continuation(&opts);
 	if (res < 0)
 		die(_("%s failed"), me);
 	return res;
@@ -738,7 +752,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "cherry-pick";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = process_continuation(&opts);
 	if (res < 0)
 		die(_("%s failed"), me);
 	return res;
-- 
1.7.5.GIT
