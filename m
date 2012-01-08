From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] revert: decouple sequencer actions from builtin commands
Date: Sun,  8 Jan 2012 17:57:29 +0530
Message-ID: <1326025653-11922-3-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 13:29:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjrsf-0008M1-AS
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 13:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab2AHM3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 07:29:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab2AHM3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 07:29:16 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5271273iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 04:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Pd54fJ6L1WrJ5JSxjACnWE7lvIL+WP5nCGJXxV80uEw=;
        b=vP/QRJH5z77tsxdpni1Glqjr9Y8ddUWprk/Z1HZ++3y13tRxn2ofwL+IX4l7uEeXnP
         QTroeZgiG8jxkzSa+zc/fm2whedKOs8RqIkOTHSOC332kYn+Km/sNKrA/apeJ28G5ORp
         dJkYHzuAhBbaEH/+Xc+oIlpIMwbVpRdtzKD2E=
Received: by 10.42.168.135 with SMTP id w7mr12267020icy.9.1326025756212;
        Sun, 08 Jan 2012 04:29:16 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id r5sm106707878igl.3.2012.01.08.04.29.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 04:29:15 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188111>

Currently, 'git cherry-pick' fills up the '.git/sequencer/todo'
instruction sheet with "pick" actions, while 'git revert' fills it up
with "revert" actions.  Inspired by the way 'rebase -i' works, we
would like to permit mixing arbitrary actions in the same instruction
sheet.  To do this, we first have to decouple the notion of an action
in the instruction sheet from builtin commands.  So, while a future
instruction sheet would look like:

  pick next~4
  action3 b74fea
  revert rr/moo^2~34

the actions "pick", "action3" and "revert" need not necessarily
correspond to the specific builtins.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   62 +++++++++++++++++++++++++++++------------------------
 sequencer.h      |    5 ++++
 2 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index c804045..3ac6da0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -40,7 +40,7 @@ static const char * const cherry_pick_usage[] = {
 };
 
 struct replay_opts {
-	enum replay_action action;
+	enum replay_command command;
 	enum replay_subcommand subcommand;
 
 	/* Boolean options */
@@ -64,16 +64,21 @@ struct replay_opts {
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-static const char *action_name(const struct replay_opts *opts)
+static const char *command_name(struct replay_opts *opts)
+{
+	return opts->command == REPLAY_CMD_REVERT ? "revert" : "cherry-pick";
+}
+
+static const char *action_name(enum replay_action action)
 {
-	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
+	return action == REPLAY_REVERT ? "revert" : "pick";
 }
 
 static char *get_encoding(const char *message);
 
 static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 {
-	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
+	return opts->command == REPLAY_CMD_REVERT ? revert_usage : cherry_pick_usage;
 }
 
 static int option_parse_x(const struct option *opt,
@@ -130,7 +135,7 @@ static void verify_opt_mutually_compatible(const char *me, ...)
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
-	const char *me = action_name(opts);
+	const char *me = command_name(opts);
 	int remove_state = 0;
 	int contin = 0;
 	int rollback = 0;
@@ -152,7 +157,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 	};
 
-	if (opts->action == REPLAY_PICK) {
+	if (opts->command == REPLAY_CMD_CHERRY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
@@ -363,10 +368,10 @@ static struct tree *empty_tree(void)
 static int error_dirty_index(struct replay_opts *opts)
 {
 	if (read_cache_unmerged())
-		return error_resolve_conflict(action_name(opts));
+		return error_resolve_conflict(command_name(opts));
 
 	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == REPLAY_PICK)
+	if (opts->command == REPLAY_CMD_CHERRY_PICK)
 		error(_("Your local changes would be overwritten by cherry-pick."));
 	else
 		error(_("Your local changes would be overwritten by revert."));
@@ -422,7 +427,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     commit_locked_index(&index_lock)))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		die(_("%s: Unable to write new index file"), action_name(opts));
+		die(_("%s: Unable to write new index file"), command_name(opts));
 	rollback_lock_file(&index_lock);
 
 	if (!clean) {
@@ -530,7 +535,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
 		return error(_("%s: cannot parse parent commit %s"),
-			action_name(opts), sha1_to_hex(parent->object.sha1));
+			command_name(opts), sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
@@ -545,7 +550,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->action == REPLAY_REVERT) {
+	if (opts->command == REPLAY_CMD_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -586,7 +591,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->command == REPLAY_CMD_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -610,13 +615,13 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
+	if (opts->command == REPLAY_CMD_CHERRY_PICK && !opts->no_commit && (res == 0 || res == 1))
 		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
-	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
+	if (opts->command == REPLAY_CMD_REVERT && ((opts->no_commit && res == 0) || res == 1))
 		write_cherry_pick_head(commit, "REVERT_HEAD");
 
 	if (res) {
-		error(opts->action == REPLAY_REVERT
+		error(opts->command == REPLAY_CMD_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
@@ -636,7 +641,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 static void prepare_revs(struct replay_opts *opts)
 {
-	if (opts->action != REPLAY_REVERT)
+	if (opts->command != REPLAY_CMD_REVERT)
 		opts->revs->reverse ^= 1;
 
 	if (prepare_revision_walk(opts->revs))
@@ -651,12 +656,13 @@ static void read_and_refresh_cache(struct replay_opts *opts)
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
-		die(_("git %s: failed to read the index"), action_name(opts));
+		die(_("git %s: failed to read the index"), command_name(opts));
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed) {
 		if (write_index(&the_index, index_fd) ||
 		    commit_locked_index(&index_lock))
-			die(_("git %s: failed to refresh the index"), action_name(opts));
+			die(_("git %s: failed to refresh the index"),
+				command_name(opts));
 	}
 	rollback_lock_file(&index_lock);
 }
@@ -693,7 +699,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 {
 	struct commit_list *cur = NULL;
 	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
+	const char *action_str = opts->command == REPLAY_CMD_REVERT ? "revert" : "pick";
 	const char *subject;
 	int subject_len;
 
@@ -738,10 +744,10 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	 * Verify that the action matches up with the one in
 	 * opts; we don't support arbitrary instructions
 	 */
-	if (action != opts->action) {
-		const char *action_str;
-		action_str = action == REPLAY_REVERT ? "revert" : "cherry-pick";
-		error(_("Cannot %s during a %s"), action_str, action_name(opts));
+	if ((action == REPLAY_PICK && opts->command == REPLAY_CMD_REVERT) ||
+		(action == REPLAY_REVERT && opts->command == REPLAY_CMD_CHERRY_PICK)) {
+		error(_("Cannot %s during a %s"), action_name(action),
+			command_name(opts));
 		return NULL;
 	}
 
@@ -1003,7 +1009,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	struct commit_list *cur;
 	int res;
 
-	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
+	setenv(GIT_REFLOG_ACTION, command_name(opts), 0);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit));
@@ -1058,7 +1064,7 @@ static int sequencer_continue(struct replay_opts *opts)
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
-	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
+	setenv(GIT_REFLOG_ACTION, command_name(opts), 0);
 	return do_pick_commit(cmit, opts);
 }
 
@@ -1116,7 +1122,7 @@ static int pick_revisions(struct replay_opts *opts)
 	if (create_seq_dir() < 0)
 		return -1;
 	if (get_sha1("HEAD", sha1)) {
-		if (opts->action == REPLAY_REVERT)
+		if (opts->command == REPLAY_CMD_REVERT)
 			return error(_("Can't revert as initial commit"));
 		return error(_("Can't cherry-pick into empty head"));
 	}
@@ -1133,7 +1139,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
-	opts.action = REPLAY_REVERT;
+	opts.command = REPLAY_CMD_REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
@@ -1148,7 +1154,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.action = REPLAY_PICK;
+	opts.command = REPLAY_CMD_CHERRY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
diff --git a/sequencer.h b/sequencer.h
index 1d9fcec..07e0639 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -11,6 +11,11 @@ enum replay_action {
 	REPLAY_PICK
 };
 
+enum replay_command {
+	REPLAY_CMD_REVERT,
+	REPLAY_CMD_CHERRY_PICK
+};
+
 enum replay_subcommand {
 	REPLAY_NONE,
 	REPLAY_REMOVE_STATE,
-- 
1.7.8.2
