From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/18] revert: Make pick_commits functionally act on a commit list
Date: Thu, 28 Jul 2011 22:22:25 +0530
Message-ID: <1311871951-3497-13-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:56:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTtI-00049i-Jk
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab1G1Q4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:56:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34882 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864Ab1G1Q43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:56:29 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so3015481iyb.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KPopYTdLXUhGYUSAYMjJPqfHPPkGBeWfyVMQTHwWr/0=;
        b=iQPGOu9brSRaAgdUD+0bvoKnc9ltQ5UAyQ4OXyCtW1A+w9/Ns0R4P4tOwgG+KQgM2+
         KWqTKupQNLNZM7i3+d77aZELcCpIYHMjcGtndGZgUCLRcDu5r+7xf93/hsqsByc3WcYY
         MSbXNJOefZMSjQgksUcd+qGxr9GbTnrUfydKc=
Received: by 10.42.135.129 with SMTP id p1mr191510ict.37.1311872188922;
        Thu, 28 Jul 2011 09:56:28 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.56.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:56:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178092>

Apart from its central objective of calling into the picking
mechanism, pick_commits creates a sequencer directory, prepares a todo
list, and even acts upon the "--reset" subcommand.  This makes for a
bad API since the central worry of callers is to figure out whether or
not any conflicts were encountered during the cherry picking.  The
current API is like:

  if (pick_commits(opts) < 0)
     print "Something failed, we're not sure what"

So, change pick_commits so that it's only responsible for picking
commits in a loop and reporting any errors, leaving the rest to a new
function called pick_revisions.  Consequently, the API of pick_commits
becomes much clearer:

  act_on_subcommand(opts->subcommand);
  todo_list = prepare_todo_list();
  if (pick_commits(todo_list, opts) < 0)
     print "Error encountered while picking commits"

Now, callers can easily call-in to the cherry-picking machinery by
constructing an arbitrary todo list along with some options.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c |   45 ++++++++++++++++++++++++++++++---------------
 1 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f561f33..14259db 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -729,11 +729,9 @@ static void save_opts(struct replay_opts *opts)
 	strbuf_release(&buf);
 }
 
-static int pick_commits(struct replay_opts *opts)
+static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char sha1[20];
 	struct commit_list *cur;
 	int res;
 
@@ -743,16 +741,6 @@ static int pick_commits(struct replay_opts *opts)
 				opts->record_origin || opts->edit));
 	read_and_refresh_cache(opts);
 
-	walk_revs_populate_todo(&todo_list, opts);
-	create_seq_dir();
-	if (get_sha1("HEAD", sha1)) {
-		if (opts->action == REVERT)
-			die(_("Can't revert as initial commit"));
-		die(_("Can't cherry-pick into empty head"));
-	}
-	save_head(sha1_to_hex(sha1));
-	save_opts(opts);
-
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
@@ -770,6 +758,27 @@ static int pick_commits(struct replay_opts *opts)
 	return 0;
 }
 
+static int pick_revisions(struct replay_opts *opts)
+{
+	struct commit_list *todo_list = NULL;
+	unsigned char sha1[20];
+
+	read_and_refresh_cache(opts);
+
+	walk_revs_populate_todo(&todo_list, opts);
+	create_seq_dir();
+	if (get_sha1("HEAD", sha1)) {
+		if (opts->action == REVERT)
+			die(_("Can't revert as initial commit"));
+		die(_("Can't cherry-pick into empty head"));
+	} else
+		save_head(sha1_to_hex(sha1));
+	save_opts(opts);
+	save_todo(todo_list, opts);
+
+	return pick_commits(todo_list, opts);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
@@ -780,7 +789,13 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	opts.action = REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
-	return pick_commits(&opts);
+
+	/*
+	 * Decide what to do depending on the arguments; a fresh
+	 * cherry-pick should be handled differently from an existing
+	 * one that is being continued
+	 */
+	return pick_revisions(&opts);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
@@ -791,5 +806,5 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	opts.action = CHERRY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
-	return pick_commits(&opts);
+	return pick_revisions(&opts);
 }
-- 
1.7.4.rc1.7.g2cf08.dirty
