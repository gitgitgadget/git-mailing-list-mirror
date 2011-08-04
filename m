From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/18] revert: Make pick_commits functionally act on a commit list
Date: Thu,  4 Aug 2011 16:09:10 +0530
Message-ID: <1312454356-3070-13-git-send-email-artagnon@gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:43:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QovOk-0007I5-0s
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab1HDKnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:43:24 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53033 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab1HDKnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:43:22 -0400
Received: by yxj19 with SMTP id 19so712048yxj.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VyWy4aVpLUAoBYo85YeQNevCZnh0ollpy4hOALwL0Xw=;
        b=HpoMn7HawDEO38J0LMCqQmXjcQ8LRVlDJRh8rOvgjMuNM0PaGt6NmhogkrlgTFblnK
         CksUvR/ZnL3zbOruYwEarGLxLMTt0JnPNlCdjBx7bhzriwCOYKTkAiV3MfbNFfLhZQNL
         zZenMicgPbn6IyKZr2clwC/nsyyKgUWI1tcd0=
Received: by 10.142.6.6 with SMTP id 6mr293199wff.126.1312454600945;
        Thu, 04 Aug 2011 03:43:20 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id m7sm2090440pbk.6.2011.08.04.03.43.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 03:43:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178728>

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
 builtin/revert.c |   43 ++++++++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 308c1ce..f088e1c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -727,11 +727,9 @@ static void save_opts(struct replay_opts *opts)
 	}
 }
 
-static int pick_commits(struct replay_opts *opts)
+static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char sha1[20];
 	struct commit_list *cur;
 	int res;
 
@@ -741,16 +739,6 @@ static int pick_commits(struct replay_opts *opts)
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
@@ -768,6 +756,31 @@ static int pick_commits(struct replay_opts *opts)
 	return 0;
 }
 
+static int pick_revisions(struct replay_opts *opts)
+{
+	struct commit_list *todo_list = NULL;
+	unsigned char sha1[20];
+
+	read_and_refresh_cache(opts);
+
+	/*
+	 * Decide what to do depending on the arguments; a fresh
+	 * cherry-pick should be handled differently from an existing
+	 * one that is being continued
+	 */
+	walk_revs_populate_todo(&todo_list, opts);
+	create_seq_dir();
+	if (get_sha1("HEAD", sha1)) {
+		if (opts->action == REVERT)
+			die(_("Can't revert as initial commit"));
+		die(_("Can't cherry-pick into empty head"));
+	}
+	save_head(sha1_to_hex(sha1));
+	save_opts(opts);
+
+	return pick_commits(todo_list, opts);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
@@ -778,7 +791,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	opts.action = REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
-	return pick_commits(&opts);
+	return pick_revisions(&opts);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
@@ -789,5 +802,5 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	opts.action = CHERRY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
-	return pick_commits(&opts);
+	return pick_revisions(&opts);
 }
-- 
1.7.6.351.gb35ac.dirty
