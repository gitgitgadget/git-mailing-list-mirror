From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 13/18] revert: Make pick_commits functionally act on a commit list
Date: Tue, 19 Jul 2011 22:47:51 +0530
Message-ID: <1311095876-3098-14-git-send-email-artagnon@gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDxc-0003LZ-6H
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab1GSRTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:19:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48493 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1GSRTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:19:48 -0400
Received: by mail-pz0-f46.google.com with SMTP id 3so5220029pzk.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=I02vr+3g5S5FZ+2CFaY1u4R3mP+XZ+LpnHBChatniLc=;
        b=tovO5Z2Ni9LLc6Teotzs2+gDisRnuh6C6EeQQeiC+ikAnPMp4jQGR0SNn15vTZWEf0
         oa9of1cxOQe8wuPKmYWb5Wvfa9AOYybSyGXyFXR9EGyVK8Tv2azJGtiJH2uNHfmMBN8V
         QhMxV4UWSYZkWMQ2nn4gdH0uxwaM7oPojZFG0=
Received: by 10.142.117.20 with SMTP id p20mr3756805wfc.386.1311095987955;
        Tue, 19 Jul 2011 10:19:47 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.19.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:19:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177478>

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
index a8ac5a1..b648448 100644
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
