From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 13/18] revert: Make pick_commits functionally act on a commit list
Date: Wed, 27 Jul 2011 08:49:10 +0530
Message-ID: <1311736755-24205-14-git-send-email-artagnon@gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:23:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QluiY-00068x-MX
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab1G0DXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:23:21 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35904 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab1G0DXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:23:20 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1938359pzk.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3rYW8Cr7kZxdLYDTSc0iJbcDOOqlvtZz5A9aMqzrRVI=;
        b=meQYy3VsyTcp7b5KYD+3XKjvbYa6qHQFF9hrZ46CcqELVUOpra6Z9PohcwWVqaQKpf
         2mZb/N21VOkrMgN7UwgOWBjaKE0LqTOk89njfFBLABKOWfAFVAct0UVjcS8DD5m19a3G
         mB3oV6xZ25wGdboX16DF55S5jC8XPNi7m5FeU=
Received: by 10.68.36.225 with SMTP id t1mr11058256pbj.8.1311736999900;
        Tue, 26 Jul 2011 20:23:19 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id p7sm1210706pbn.65.2011.07.26.20.23.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:23:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177918>

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

Helped-by: Jonathan Nieder <jrnider@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   46 ++++++++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b02d3d2..46b1371 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -851,11 +851,9 @@ static void save_opts(struct replay_opts *opts)
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
 
@@ -865,17 +863,6 @@ static int pick_commits(struct replay_opts *opts)
 				opts->record_origin || opts->edit));
 	read_and_refresh_cache(opts);
 
-	walk_revs_populate_todo(&todo_list, opts);
-	create_seq_dir();
-	if (get_sha1("HEAD", sha1)) {
-		if (opts->action == REVERT)
-			return error(_("Can't revert as initial commit"));
-		return error(_("Can't cherry-pick into empty head"));
-	} else
-		save_head(sha1_to_hex(sha1));
-	save_opts(opts);
-	save_todo(todo_list, opts);
-
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
@@ -892,6 +879,27 @@ static int pick_commits(struct replay_opts *opts)
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
+			return error(_("Can't revert as initial commit"));
+		return error(_("Can't cherry-pick into empty head"));
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
 	int res;
@@ -903,7 +911,13 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	opts.action = REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+
+	/*
+	 * Decide what to do depending on the arguments; a fresh
+	 * cherry-pick should be handled differently from an existing
+	 * one that is being continued
+	 */
+	res = pick_revisions(&opts);
 	if (res < 0)
 		die(_("revert failed"));
 	return res;
@@ -918,7 +932,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	opts.action = CHERRY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = pick_revisions(&opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
-- 
1.7.4.rc1.7.g2cf08.dirty
