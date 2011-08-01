From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 18/18] revert: Propagate errors upwards from do_pick_commit
Date: Mon,  1 Aug 2011 23:37:05 +0530
Message-ID: <1312222025-28453-19-git-send-email-artagnon@gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:13:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwzS-0004hD-Up
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423Ab1HASNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:13:18 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33004 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab1HASNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:13:16 -0400
Received: by mail-yw0-f46.google.com with SMTP id 13so874233ywn.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=B5JnD5e/3I4Vv1sGafZyGFPlpdnpx5MxDtvTCKB/fso=;
        b=M3UxSVsE/xkdyd2J0LrQasHVrcEpVHQaFii/NX48UXEFuygBWj4vqasag4rsmrUaHe
         lsL1jkZX+S3sxgXfEno6AtXhiE6f38t7Ow+RnRFyTYye2oz9c1vSYmCdzpnhEhghq9dB
         LjwSfDtbPEKNU9GBqqLotoZgSpvUuo3NX5xNg=
Received: by 10.68.5.98 with SMTP id r2mr7900060pbr.98.1312222395589;
        Mon, 01 Aug 2011 11:13:15 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d3sm5789958pbh.37.2011.08.01.11.13.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:13:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178391>

Currently, revert_or_cherry_pick can fail in two ways.  If it
encounters a conflict, it returns a positive number indicating the
intended exit status for the git wrapper to pass on; for all other
errors, it calls die().  The latter behavior is inconsiderate towards
callers, as it denies them the opportunity to recover from errors and
do other things.

After this patch, revert_or_cherry_pick will still return a positive
return value to indicate an exit status for conflicts as before, while
for some other errors, it will print an error message and return -1
instead of die()-ing.  The cmd_revert and cmd_cherry_pick are adjusted
to handle the fatal errors by die()-ing themselves.

While the full benefits of this patch will only be seen once all the
"die" calls are replaced with calls to "error", its immediate impact
is to change some "fatal:" messages to say "error:" and to add a new
"fatal: cherry-pick failed" message at the end when the operation
fails.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c |   86 +++++++++++++++++++++++++-----------------------------
 1 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 35ee089..7bb7313 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -66,15 +66,6 @@ struct replay_opts {
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-static void fatal(const char *advice, ...)
-{
-	va_list params;
-
-	va_start(params, advice);
-	vreportf("fatal: ", advice, params);
-	va_end(params);
-}
-
 static const char *action_name(const struct replay_opts *opts)
 {
 	return opts->action == REVERT ? "revert" : "cherry-pick";
@@ -363,25 +354,20 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
-static NORETURN void die_dirty_index(struct replay_opts *opts)
+static int error_dirty_index(struct replay_opts *opts)
 {
-	if (read_cache_unmerged()) {
-		die_resolve_conflict(action_name(opts));
-	} else {
-		if (advice_commit_before_merge) {
-			if (opts->action == REVERT)
-				die(_("Your local changes would be overwritten by revert.\n"
-					  "Please, commit your changes or stash them to proceed."));
-			else
-				die(_("Your local changes would be overwritten by cherry-pick.\n"
-					  "Please, commit your changes or stash them to proceed."));
-		} else {
-			if (opts->action == REVERT)
-				die(_("Your local changes would be overwritten by revert.\n"));
-			else
-				die(_("Your local changes would be overwritten by cherry-pick.\n"));
-		}
-	}
+	if (read_cache_unmerged())
+		return error_resolve_conflict(action_name(opts));
+
+	/* Different translation strings for cherry-pick and revert */
+	if (opts->action == CHERRY_PICK)
+		error(_("Your local changes would be overwritten by cherry-pick."));
+	else
+		error(_("Your local changes would be overwritten by revert."));
+
+	if (advice_commit_before_merge)
+		advise(_("Commit your changes or stash them to proceed."));
+	return -1;
 }
 
 static int fast_forward_to(const unsigned char *to, const unsigned char *from)
@@ -499,9 +485,9 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 			die (_("Your index file is unmerged."));
 	} else {
 		if (get_sha1("HEAD", head))
-			die (_("You do not have a valid HEAD"));
+			return error(_("You do not have a valid HEAD"));
 		if (index_differs_from("HEAD", 0))
-			die_dirty_index(opts);
+			return error_dirty_index(opts);
 	}
 	discard_cache();
 
@@ -514,20 +500,20 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		struct commit_list *p;
 
 		if (!opts->mainline)
-			die(_("Commit %s is a merge but no -m option was given."),
-			    sha1_to_hex(commit->object.sha1));
+			return error(_("Commit %s is a merge but no -m option was given."),
+				sha1_to_hex(commit->object.sha1));
 
 		for (cnt = 1, p = commit->parents;
 		     cnt != opts->mainline && p;
 		     cnt++)
 			p = p->next;
 		if (cnt != opts->mainline || !p)
-			die(_("Commit %s does not have parent %d"),
-			    sha1_to_hex(commit->object.sha1), opts->mainline);
+			return error(_("Commit %s does not have parent %d"),
+				sha1_to_hex(commit->object.sha1), opts->mainline);
 		parent = p->item;
 	} else if (0 < opts->mainline)
-		die(_("Mainline was specified but commit %s is not a merge."),
-		    sha1_to_hex(commit->object.sha1));
+		return error(_("Mainline was specified but commit %s is not a merge."),
+			sha1_to_hex(commit->object.sha1));
 	else
 		parent = commit->parents->item;
 
@@ -537,12 +523,12 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
-		die(_("%s: cannot parse parent commit %s"),
-		    action_name(opts), sha1_to_hex(parent->object.sha1));
+		return error(_("%s: cannot parse parent commit %s"),
+			action_name(opts), sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit, &msg) != 0)
-		die(_("Cannot get commit message for %s"),
-				sha1_to_hex(commit->object.sha1));
+		return error(_("Cannot get commit message for %s"),
+			sha1_to_hex(commit->object.sha1));
 
 	/*
 	 * "commit" is an existing commit.  We would want to apply
@@ -995,27 +981,28 @@ static int pick_revisions(struct replay_opts *opts)
 
 		walk_revs_populate_todo(&todo_list, opts);
 		if (create_seq_dir() < 0) {
-			fatal(_("A cherry-pick or revert is in progress."));
+			error(_("A cherry-pick or revert is in progress."));
 			advise(_("Use --continue to continue the operation"));
 			advise(_("or --reset to forget about it"));
-			exit(128);
+			return -1;
 		}
 		if (get_sha1("HEAD", sha1)) {
 			if (opts->action == REVERT)
-				die(_("Can't revert as initial commit"));
-			die(_("Can't cherry-pick into empty head"));
+				return error(_("Can't revert as initial commit"));
+			return error(_("Can't cherry-pick into empty head"));
 		}
 		save_head(sha1_to_hex(sha1));
 		save_opts(opts);
 	}
 	return pick_commits(todo_list, opts);
 error:
-	die(_("No %s in progress"), action_name(opts));
+	return error(_("No %s in progress"), action_name(opts));
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
+	int res;
 
 	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
@@ -1023,16 +1010,23 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	opts.action = REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
-	return pick_revisions(&opts);
+	res = pick_revisions(&opts);
+	if (res < 0)
+		die(_("revert failed"));
+	return res;
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
+	int res;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.action = CHERRY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
-	return pick_revisions(&opts);
+	res = pick_revisions(&opts);
+	if (res < 0)
+		die(_("cherry-pick failed"));
+	return res;
 }
-- 
1.7.4.rc1.7.g2cf08.dirty
