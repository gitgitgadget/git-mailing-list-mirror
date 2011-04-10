From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/11] revert: Introduce a struct to parse command-line options into
Date: Sun, 10 Apr 2011 20:41:49 +0530
Message-ID: <1302448317-32387-4-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:13:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wKJ-0008AC-Mt
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab1DJPNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:13:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49368 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab1DJPNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:13:17 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so4855877iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=CHCfU4VUAfB2A2ZFPBZtxJvlYfGrl8aUDg+i/jcjYmA=;
        b=ZUgNO7atJ3DeU3pGTa+B7n7xd51vHcaUl11g0+V3liz9y187rbjhsnctzDmGye6mhi
         3faqMFGej2EQNTOpPurU3BKq7PwAH5oszpMnGf3cWm1suNQTN4OZUn1qbPRJ6fg4S+Xm
         43QKwFOQ+FK/yYUUA9S6Mn2q5sinJ62j2vv58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r8uvSSjodSqQrrj1fXxF7VwSpBOAT055Mk4hxeoS0O95SW10P74CkFTBIBXwmDbmxZ
         Y2P5cOA0S2Ui2H1jApT+ZYDxUjOZoY21xCggUzWdHRmcPoQZTQ33mqBxgZ47LBLkSF0W
         IswSUKFoPZRk82l03NpYU2OHbM7xOoRpLZkVY=
Received: by 10.43.54.200 with SMTP id vv8mr6097383icb.378.1302448396864;
        Sun, 10 Apr 2011 08:13:16 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.13.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:13:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171257>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |  132 +++++++++++++++++++++++++++++------------------------
 1 files changed, 72 insertions(+), 60 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index fdbacad..2b33220 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -35,17 +35,27 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
-static enum { REVERT, CHERRY_PICK } action;
-static int commit_argc;
-static const char **commit_argv;
-static int allow_rerere_auto;
 
+static struct {
+	enum { REVERT, CHERRY_PICK } action;
 
-/* Merge strategy. */
-static const char *strategy;
-static const char **xopts;
-static size_t xopts_nr, xopts_alloc;
+	/* Boolean options */
+	int edit;
+	int no_replay;
+	int no_commit;
+	int signoff;
+	int allow_ff;
+	int allow_rerere_auto;
+
+	int mainline;
+	int commit_argc;
+	const char **commit_argv;
+
+	/* Merge strategy */
+	const char *strategy;
+	const char **xopts;
+	size_t xopts_nr, xopts_alloc;
+} cmd_opts;
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -53,7 +63,7 @@ static char *get_encoding(struct commit *commit, const char *message);
 
 static const char * const *revert_or_cherry_pick_usage(void)
 {
-	return action == REVERT ? revert_usage : cherry_pick_usage;
+	return cmd_opts.action == REVERT ? revert_usage : cherry_pick_usage;
 }
 
 static int option_parse_x(const struct option *opt,
@@ -62,8 +72,8 @@ static int option_parse_x(const struct option *opt,
 	if (unset)
 		return 0;
 
-	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
-	xopts[xopts_nr++] = xstrdup(arg);
+	ALLOC_GROW(cmd_opts.xopts, cmd_opts.xopts_nr + 1, cmd_opts.xopts_alloc);
+	cmd_opts.xopts[cmd_opts.xopts_nr++] = xstrdup(arg);
 	return 0;
 }
 
@@ -72,37 +82,37 @@ static void parse_args(int argc, const char **argv)
 	const char * const * usage_str = revert_or_cherry_pick_usage();
 	int noop;
 	struct option options[] = {
-		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
-		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
+		OPT_BOOLEAN('n', "no-commit", &cmd_opts.no_commit, "don't automatically commit"),
+		OPT_BOOLEAN('e', "edit", &cmd_opts.edit, "edit the commit message"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
-		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
-		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
-		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
-		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy"),
-		OPT_CALLBACK('X', "strategy-option", &xopts, "option",
+		OPT_BOOLEAN('s', "signoff", &cmd_opts.signoff, "add Signed-off-by:"),
+		OPT_INTEGER('m', "mainline", &cmd_opts.mainline, "parent number"),
+		OPT_RERERE_AUTOUPDATE(&cmd_opts.allow_rerere_auto),
+		OPT_STRING(0, "strategy", &cmd_opts.strategy, "strategy", "merge strategy"),
+		OPT_CALLBACK('X', "strategy-option", &cmd_opts.xopts, "option",
 			"option for merge strategy", option_parse_x),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
 	};
 
-	if (action == CHERRY_PICK) {
+	if (cmd_opts.action == CHERRY_PICK) {
 		struct option cp_extra[] = {
-			OPT_BOOLEAN('x', NULL, &no_replay, "append commit name"),
-			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
+			OPT_BOOLEAN('x', NULL, &cmd_opts.no_replay, "append commit name"),
+			OPT_BOOLEAN(0, "ff", &cmd_opts.allow_ff, "allow fast-forward"),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
 			die(_("program error"));
 	}
 
-	commit_argc = parse_options(argc, argv, NULL, options, usage_str,
+	cmd_opts.commit_argc = parse_options(argc, argv, NULL, options, usage_str,
 				    PARSE_OPT_KEEP_ARGV0 |
 				    PARSE_OPT_KEEP_UNKNOWN);
-	if (commit_argc < 2)
+	if (cmd_opts.commit_argc < 2)
 		usage_with_options(usage_str, options);
 
-	commit_argv = argv;
+	cmd_opts.commit_argv = argv;
 }
 
 struct commit_message {
@@ -268,17 +278,17 @@ static struct tree *empty_tree(void)
 static int error_dirty_index()
 {
 	if (read_cache_unmerged()) {
-		die_resolve_conflict(action == REVERT ? "revert" : "cherry-pick");
+		die_resolve_conflict(cmd_opts.action == REVERT ? "revert" : "cherry-pick");
 	} else {
 		if (advice_commit_before_merge) {
-			if (action == REVERT)
+			if (cmd_opts.action == REVERT)
 				return error(_("Your local changes would be overwritten by revert.\n"
 					  "Please, commit your changes or stash them to proceed."));
 			else
 				return error(_("Your local changes would be overwritten by cherry-pick.\n"
 					  "Please, commit your changes or stash them to proceed."));
 		} else {
-			if (action == REVERT)
+			if (cmd_opts.action == REVERT)
 				return error(_("Your local changes would be overwritten by revert.\n"));
 			else
 				return error(_("Your local changes would be overwritten by cherry-pick.\n"));
@@ -320,7 +330,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	next_tree = next ? next->tree : empty_tree();
 	base_tree = base ? base->tree : empty_tree();
 
-	for (xopt = xopts; xopt != xopts + xopts_nr; xopt++)
+	for (xopt = cmd_opts.xopts; xopt != cmd_opts.xopts + cmd_opts.xopts_nr; xopt++)
 		parse_merge_opt(&o, *xopt);
 
 	clean = merge_trees(&o,
@@ -331,7 +341,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     commit_locked_index(&index_lock)))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		return error(_("%s: Unable to write new index file"), me);
+		return error(_("%s: Unable to write new index file"),
+			cmd_opts.action == REVERT ? "revert" : "cherry-pick");
 	rollback_lock_file(&index_lock);
 
 	if (!clean) {
@@ -368,9 +379,9 @@ static int run_git_commit(const char *defmsg)
 
 	args[i++] = "commit";
 	args[i++] = "-n";
-	if (signoff)
+	if (cmd_opts.signoff)
 		args[i++] = "-s";
-	if (!edit) {
+	if (!cmd_opts.edit) {
 		args[i++] = "-F";
 		args[i++] = defmsg;
 	}
@@ -389,7 +400,7 @@ static int do_pick_commit(struct commit *commit)
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res;
 
-	if (no_commit) {
+	if (cmd_opts.no_commit) {
 		/*
 		 * We do not intend to commit immediately.  We just want to
 		 * merge the differences in, so let's compute the tree
@@ -407,7 +418,7 @@ static int do_pick_commit(struct commit *commit)
 	discard_cache();
 
 	if (!commit->parents) {
-		if (action == REVERT)
+		if (cmd_opts.action == REVERT)
 			return error(_("Cannot revert a root commit"));
 		parent = NULL;
 	}
@@ -416,32 +427,32 @@ static int do_pick_commit(struct commit *commit)
 		int cnt;
 		struct commit_list *p;
 
-		if (!mainline)
+		if (!cmd_opts.mainline)
 			return error(_("Commit %s is a merge but no -m option was given."),
 				sha1_to_hex(commit->object.sha1));
 
 		for (cnt = 1, p = commit->parents;
-		     cnt != mainline && p;
+		     cnt != cmd_opts.mainline && p;
 		     cnt++)
 			p = p->next;
-		if (cnt != mainline || !p)
+		if (cnt != cmd_opts.mainline || !p)
 			return error(_("Commit %s does not have parent %d"),
-			    sha1_to_hex(commit->object.sha1), mainline);
+			    sha1_to_hex(commit->object.sha1), cmd_opts.mainline);
 		parent = p->item;
-	} else if (mainline > 0)
+	} else if (cmd_opts.mainline > 0)
 		return error(_("Mainline was specified but commit %s is not a merge."),
 		    sha1_to_hex(commit->object.sha1));
 	else
 		parent = commit->parents->item;
 
-	if (allow_ff && parent && !hashcmp(parent->object.sha1, head))
+	if (cmd_opts.allow_ff && parent && !hashcmp(parent->object.sha1, head))
 		return fast_forward_to(commit->object.sha1, head);
 
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
 		return error(_("%s: cannot parse parent commit %s"),
-			action == REVERT ? "revert" : "cherry-pick",
+			cmd_opts.action == REVERT ? "revert" : "cherry-pick",
 			sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit, commit->buffer, &msg) != 0)
@@ -457,7 +468,7 @@ static int do_pick_commit(struct commit *commit)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (action == REVERT) {
+	if (cmd_opts.action == REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -478,16 +489,16 @@ static int do_pick_commit(struct commit *commit)
 		next = commit;
 		next_label = msg.label;
 		add_message_to_msg(commit, &msgbuf, msg.message);
-		if (no_replay) {
+		if (cmd_opts.no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
-		if (!no_commit)
+		if (!cmd_opts.no_commit)
 			write_cherry_pick_head(commit);
 	}
 
-	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
+	if (!cmd_opts.strategy || !strcmp(cmd_opts.strategy, "recursive") || cmd_opts.action == REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf);
 		write_message(&msgbuf, defmsg);
@@ -499,22 +510,23 @@ static int do_pick_commit(struct commit *commit)
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res = try_merge_command(strategy, xopts_nr, xopts, common,
+		res = try_merge_command(cmd_opts.strategy, cmd_opts.xopts_nr,
+					cmd_opts.xopts, common,
 					sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
 
 	if (res) {
-		error(action == REVERT
+		error(cmd_opts.action == REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
 		      msg.subject);
 		print_advice();
-		rerere(allow_rerere_auto);
+		rerere(cmd_opts.allow_rerere_auto);
 	} else {
-		if (!no_commit)
+		if (!cmd_opts.no_commit)
 			res = run_git_commit(defmsg);
 	}
 
@@ -530,10 +542,10 @@ static int prepare_revs(struct rev_info *revs)
 
 	init_revisions(revs, NULL);
 	revs->no_walk = 1;
-	if (action != REVERT)
+	if (cmd_opts.action != REVERT)
 		revs->reverse = 1;
 
-	argc = setup_revisions(commit_argc, commit_argv, revs, NULL);
+	argc = setup_revisions(cmd_opts.commit_argc, cmd_opts.commit_argv, revs, NULL);
 	if (argc > 1) {
 		fprintf(stderr, "usage: %s", _(*revert_or_cherry_pick_usage()));
 		return 129;
@@ -574,18 +586,18 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	int res;
 
 	git_config(git_default_config, NULL);
-	me = (action == REVERT ? "revert" : "cherry-pick");
+	me = (cmd_opts.action == REVERT ? "revert" : "cherry-pick");
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
 
-	if (allow_ff) {
-		if (signoff)
+	if (cmd_opts.allow_ff) {
+		if (cmd_opts.signoff)
 			die(_("cherry-pick --ff cannot be used with --signoff"));
-		if (no_commit)
+		if (cmd_opts.no_commit)
 			die(_("cherry-pick --ff cannot be used with --no-commit"));
-		if (no_replay)
+		if (cmd_opts.no_replay)
 			die(_("cherry-pick --ff cannot be used with -x"));
-		if (edit)
+		if (cmd_opts.edit)
 			die(_("cherry-pick --ff cannot be used with --edit"));
 	}
 
@@ -603,13 +615,13 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	if (isatty(0))
-		edit = 1;
-	action = REVERT;
+		cmd_opts.edit = 1;
+	cmd_opts.action = REVERT;
 	return revert_or_cherry_pick(argc, argv);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
-	action = CHERRY_PICK;
+	cmd_opts.action = CHERRY_PICK;
 	return revert_or_cherry_pick(argc, argv);
 }
-- 
1.7.4.rc1.7.g2cf08.dirty
