From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 13/17] revert: Introduce a layer of indirection over pick_commits
Date: Mon, 11 Jul 2011 14:54:04 +0000
Message-ID: <1310396048-24925-14-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:54:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHsh-0005F4-RM
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757879Ab1GKOyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:38 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46637 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757838Ab1GKOyf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:35 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so2716724vxb.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gfJGfSa0Rdw6dsyubk4beKrtcmRzxkXqxqJyfGuykTA=;
        b=LaYfmoRlcC5xNExBBi7nrzISyWWq1KjTRbBesRLodH01Qja3BFEXlW5h/wyV/D5Kj1
         XlVTqvRl1prSSwt+0F5Hg4DQbQ2dJY5JGjgRrl/6hADxmbpBVa251tzflx9wF+D2QSYD
         /pJSNb34Ig1ktUpE2L/DOUxJxBHeNN+mee8nw=
Received: by 10.52.161.230 with SMTP id xv6mr5840879vdb.123.1310396073425;
        Mon, 11 Jul 2011 07:54:33 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176853>

Write a new function called process_subcommand to prepare a todo_list
to call pick_commits with; the job of pick_commits is simplified into
performing the tasks listed in todo_list.  This will be useful when
subcommands like "--reset" and "--continue" are introduced later in
the series.

Helped-by: Jonathan Nieder <jrnider@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index edf74fb..f9f5e3a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -976,10 +976,8 @@ static void save_opts(struct replay_opts *opts)
 	strbuf_release(&buf);
 }
 
-static int pick_commits(struct replay_opts *opts)
+static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
-	unsigned char sha1[20];
 	struct commit_list *cur;
 	int res;
 
@@ -989,13 +987,6 @@ static int pick_commits(struct replay_opts *opts)
 				opts->record_origin || opts->edit));
 	read_and_refresh_cache(me, opts);
 
-	walk_revs_populate_todo(&todo_list, opts);
-	create_seq_dir();
-	if (!get_sha1("HEAD", sha1))
-		save_head(sha1_to_hex(sha1));
-	save_opts(opts);
-	save_todo(todo_list, opts);
-
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
@@ -1011,6 +1002,23 @@ static int pick_commits(struct replay_opts *opts)
 	return 0;
 }
 
+static int process_subcommand(struct replay_opts *opts)
+{
+	struct commit_list *todo_list = NULL;
+	unsigned char sha1[20];
+
+	read_and_refresh_cache(me, opts);
+
+	walk_revs_populate_todo(&todo_list, opts);
+	create_seq_dir();
+	if (!get_sha1("HEAD", sha1))
+		save_head(sha1_to_hex(sha1));
+	save_opts(opts);
+	save_todo(todo_list, opts);
+
+	return pick_commits(todo_list, opts);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	int res;
@@ -1023,7 +1031,13 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
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
+	res = process_subcommand(&opts);
 	if (res < 0)
 		die(_("revert failed"));
 	return res;
@@ -1039,7 +1053,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "cherry-pick";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = process_subcommand(&opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
-- 
1.7.5.GIT
