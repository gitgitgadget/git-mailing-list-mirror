From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 07/18] revert: put option information in an option struct
Date: Thu, 25 Nov 2010 22:20:38 +0100
Message-ID: <20101125212050.5188.8316.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrGt-0006kW-3X
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249Ab0KZFyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:54:51 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47534 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860Ab0KZFyv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:54:51 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6350AA61F5;
	Fri, 26 Nov 2010 06:54:43 +0100 (CET)
X-git-sha1: 474f797943a39d793a65ef3cdc483aec2c1927db 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162191>

This is needed because we want to reuse the parse_args() function
so that we can parse options saved in a TODO file.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |  148 +++++++++++++++++++++++++++++-------------------------
 1 files changed, 79 insertions(+), 69 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e3dea19..443b529 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -36,58 +36,68 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
-static enum { REVERT, CHERRY_PICK } action;
-static int commit_argc;
-static const char **commit_argv;
-static int allow_rerere_auto;
-
 static const char *me;
-static const char *strategy;
+
+struct args_info {
+	enum { REVERT, CHERRY_PICK } action;
+	int edit;
+	int no_replay;
+	int no_commit;
+	int mainline;
+	int signoff;
+	int allow_ff;
+	int allow_rerere_auto;
+	const char *strategy;
+	const char **commit_argv;
+	int commit_argc;
+	const char * const * usage_str;
+};
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 static char *get_encoding(const char *message, const unsigned char *sha1);
 
-static const char * const *revert_or_cherry_pick_usage(void)
+static const char * const *revert_or_cherry_pick_usage(struct args_info *info)
 {
-	return action == REVERT ? revert_usage : cherry_pick_usage;
+	return info->action == REVERT ? revert_usage : cherry_pick_usage;
 }
 
-static void parse_args(int argc, const char **argv)
+static void parse_args(int argc, const char **argv, struct args_info *info)
 {
-	const char * const * usage_str = revert_or_cherry_pick_usage();
 	int noop;
 	struct option options[] = {
-		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
-		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
+		OPT_BOOLEAN('n', "no-commit", &info->no_commit,
+			    "don't automatically commit"),
+		OPT_BOOLEAN('e', "edit", &info->edit, "edit the commit message"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
-		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
-		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
-		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
-		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy"),
+		OPT_BOOLEAN('s', "signoff", &info->signoff, "add Signed-off-by:"),
+		OPT_INTEGER('m', "mainline", &info->mainline, "parent number"),
+		OPT_RERERE_AUTOUPDATE(&info->allow_rerere_auto),
+		OPT_STRING(0, "strategy", &info->strategy, "strategy",
+			   "merge strategy"),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
 	};
 
-	if (action == CHERRY_PICK) {
+	if (info->action == CHERRY_PICK) {
 		struct option cp_extra[] = {
-			OPT_BOOLEAN('x', NULL, &no_replay, "append commit name"),
-			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
+			OPT_BOOLEAN('x', NULL, &info->no_replay, "append commit name"),
+			OPT_BOOLEAN(0, "ff", &info->allow_ff, "allow fast-forward"),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
 			die("program error");
 	}
 
-	commit_argc = parse_options(argc, argv, NULL, options, usage_str,
-				    PARSE_OPT_KEEP_ARGV0 |
-				    PARSE_OPT_KEEP_UNKNOWN);
-	if (commit_argc < 2)
-		usage_with_options(usage_str, options);
+	info->usage_str = revert_or_cherry_pick_usage(info);
+	info->commit_argc = parse_options(argc, argv, NULL, options, info->usage_str,
+					  PARSE_OPT_KEEP_ARGV0 |
+					  PARSE_OPT_KEEP_UNKNOWN);
+	info->commit_argv = argv;
 
-	commit_argv = argv;
+	if (info->commit_argc < 2)
+		usage_with_options(info->usage_str, options);
 }
 
 struct commit_message {
@@ -238,7 +248,7 @@ static void advise(const char *advice, ...)
 	va_end(params);
 }
 
-static void print_advice(const unsigned char *sha1)
+static void print_advice(struct args_info *info, const unsigned char *sha1)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
@@ -250,7 +260,7 @@ static void print_advice(const unsigned char *sha1)
 	advise("after resolving the conflicts, mark the corrected paths");
 	advise("with 'git add <paths>' or 'git rm <paths>'");
 
-	if (action == CHERRY_PICK)
+	if (info->action == CHERRY_PICK)
 		advise("and commit the result with 'git commit -c %s'",
 		       find_unique_abbrev(sha1, DEFAULT_ABBREV));
 }
@@ -370,7 +380,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  * If we are revert, or if our cherry-pick results in a hand merge,
  * we had better say that the current user is responsible for that.
  */
-static int run_git_commit(const char *defmsg)
+static int run_git_commit(const char *defmsg, struct args_info *info)
 {
 	/* 6 is max possible length of our args array including NULL */
 	const char *args[6];
@@ -378,9 +388,9 @@ static int run_git_commit(const char *defmsg)
 
 	args[i++] = "commit";
 	args[i++] = "-n";
-	if (signoff)
+	if (info->signoff)
 		args[i++] = "-s";
-	if (!edit) {
+	if (!info->edit) {
 		args[i++] = "-F";
 		args[i++] = defmsg;
 	}
@@ -389,7 +399,7 @@ static int run_git_commit(const char *defmsg)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(struct commit *commit)
+static int do_pick_commit(struct args_info *info, struct commit *commit)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -399,7 +409,7 @@ static int do_pick_commit(struct commit *commit)
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, write_res;
 
-	if (no_commit) {
+	if (info->no_commit) {
 		/*
 		 * We do not intend to commit immediately.  We just want to
 		 * merge the differences in, so let's compute the tree
@@ -417,7 +427,7 @@ static int do_pick_commit(struct commit *commit)
 	discard_cache();
 
 	if (!commit->parents) {
-		if (action == REVERT)
+		if (info->action == REVERT)
 			return error("Cannot revert a root commit");
 		parent = NULL;
 	}
@@ -426,24 +436,24 @@ static int do_pick_commit(struct commit *commit)
 		int cnt;
 		struct commit_list *p;
 
-		if (!mainline)
+		if (!info->mainline)
 			return error("Commit %s is a merge but no -m option "
 				     "was given.", sha1_to_hex(commit->object.sha1));
 		for (cnt = 1, p = commit->parents;
-		     cnt != mainline && p;
+		     cnt != info->mainline && p;
 		     cnt++)
 			p = p->next;
-		if (cnt != mainline || !p)
+		if (cnt != info->mainline || !p)
 			return error("Commit %s does not have parent %d",
-				     sha1_to_hex(commit->object.sha1), mainline);
+				     sha1_to_hex(commit->object.sha1), info->mainline);
 		parent = p->item;
-	} else if (0 < mainline)
+	} else if (0 < info->mainline)
 		return error("Mainline was specified but commit %s is not a merge.",
 			     sha1_to_hex(commit->object.sha1));
 	else
 		parent = commit->parents->item;
 
-	if (allow_ff && parent && !hashcmp(parent->object.sha1, head))
+	if (info->allow_ff && parent && !hashcmp(parent->object.sha1, head))
 		return fast_forward_to(commit->object.sha1, head);
 
 	if (parent && parse_commit(parent) < 0)
@@ -463,7 +473,7 @@ static int do_pick_commit(struct commit *commit)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (action == REVERT) {
+	if (info->action == REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -485,14 +495,15 @@ static int do_pick_commit(struct commit *commit)
 		next_label = msg.label;
 		set_author_ident_env(msg.message, commit->object.sha1);
 		add_message_to_msg(&msgbuf, msg.message, commit->object.sha1);
-		if (no_replay) {
+		if (info->no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
 	}
 
-	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
+	if (!info->strategy || !strcmp(info->strategy, "recursive") ||
+	    info->action == REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf);
 		write_res = write_message(&msgbuf, defmsg);
@@ -508,7 +519,7 @@ static int do_pick_commit(struct commit *commit)
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res = try_merge_command(strategy, common,
+		res = try_merge_command(info->strategy, common,
 					sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
@@ -516,14 +527,14 @@ static int do_pick_commit(struct commit *commit)
 
 	if (res) {
 		error("could not %s %s... %s",
-		      action == REVERT ? "revert" : "apply",
+		      info->action == REVERT ? "revert" : "apply",
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
 		      msg.subject);
-		print_advice(commit->object.sha1);
-		rerere(allow_rerere_auto);
+		print_advice(info, commit->object.sha1);
+		rerere(info->allow_rerere_auto);
 	} else {
-		if (!no_commit)
-			res = run_git_commit(defmsg);
+		if (!info->no_commit)
+			res = run_git_commit(defmsg, info);
 	}
 
 	free_message(&msg);
@@ -532,18 +543,18 @@ static int do_pick_commit(struct commit *commit)
 	return res;
 }
 
-static void prepare_revs(struct rev_info *revs)
+static void prepare_revs(struct rev_info *revs, struct args_info *info)
 {
 	int argc;
 
 	init_revisions(revs, NULL);
 	revs->no_walk = 1;
-	if (action != REVERT)
+	if (info->action != REVERT)
 		revs->reverse = 1;
 
-	argc = setup_revisions(commit_argc, commit_argv, revs, NULL);
+	argc = setup_revisions(info->commit_argc, info->commit_argv, revs, NULL);
 	if (argc > 1)
-		usage(*revert_or_cherry_pick_usage());
+		usage(*revert_or_cherry_pick_usage(info));
 
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
@@ -567,33 +578,36 @@ static void read_and_refresh_cache(const char *me)
 	rollback_lock_file(&index_lock);
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv)
+static int revert_or_cherry_pick(int argc, const char **argv, int revert, int edit)
 {
+	struct args_info infos;
 	struct rev_info revs;
 	struct commit *commit;
 
+	memset(&infos, 0, sizeof(infos));
 	git_config(git_default_config, NULL);
-	me = action == REVERT ? "revert" : "cherry-pick";
+	infos.action = revert ? REVERT : CHERRY_PICK;
+	me = revert ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
-	parse_args(argc, argv);
+	parse_args(argc, argv, &infos);
 
-	if (allow_ff) {
-		if (signoff)
+	if (infos.allow_ff) {
+		if (infos.signoff)
 			die("cherry-pick --ff cannot be used with --signoff");
-		if (no_commit)
+		if (infos.no_commit)
 			die("cherry-pick --ff cannot be used with --no-commit");
-		if (no_replay)
+		if (infos.no_replay)
 			die("cherry-pick --ff cannot be used with -x");
-		if (edit)
+		if (infos.edit)
 			die("cherry-pick --ff cannot be used with --edit");
 	}
 
 	read_and_refresh_cache(me);
 
-	prepare_revs(&revs);
+	prepare_revs(&revs, &infos);
 
 	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit(commit);
+		int res = do_pick_commit(&infos, commit);
 		if (res)
 			return res;
 	}
@@ -603,14 +617,10 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
-	if (isatty(0))
-		edit = 1;
-	action = REVERT;
-	return revert_or_cherry_pick(argc, argv);
+	return revert_or_cherry_pick(argc, argv, 1, isatty(0));
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
-	action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv);
+	return revert_or_cherry_pick(argc, argv, 0, 0);
 }
-- 
1.7.3.2.504.g59d466
