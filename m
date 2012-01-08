From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] revert: move replay_action, replay_subcommand to header
Date: Sun,  8 Jan 2012 17:57:28 +0530
Message-ID: <1326025653-11922-2-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 13:29:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjrsK-0008F4-VT
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 13:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab2AHM3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 07:29:14 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab2AHM3M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 07:29:12 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5271273iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 04:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=drGTsrtPpP68fC3L4wC/o2nS5My0eJDNJDjzfJXHNi4=;
        b=V6G5R8VeYaR8Dfta3o9y8NncbjtxrvhE06CLLfVK1jfbj7tLvNCraDOhQmcyroyMOG
         iJphmsurHCm3VFGKwxHcji73w+RK2s1JwBbxo01Atfg0zcc5CkguY5cPweLA7LLg4Mn2
         kxAyWpw8UAiuQxRXwWzlDdnkOiA4Cq0LKAre0=
Received: by 10.50.188.132 with SMTP id ga4mr6574281igc.4.1326025751770;
        Sun, 08 Jan 2012 04:29:11 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id r5sm106707878igl.3.2012.01.08.04.29.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 04:29:10 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188107>

Our plan to build a sequencer involves leaving the revert builtin with
just argument parsing work.  Since the enums replay_action and
replay_subcommand have nothing to do with this argument parsing, move
them to sequencer.h in advance.

"REVERT" and "CHERRY_PICK" are unsuitable variable names for exposing
publicly, as their purpose is unclear in the global context: rename
them to "REPLAY_REVERT" and "REPLAY_PICK" respectively.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   42 +++++++++++++++++-------------------------
 sequencer.h      |   12 ++++++++++++
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0d8020c..c804045 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -39,14 +39,6 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-enum replay_action { REVERT, CHERRY_PICK };
-enum replay_subcommand {
-	REPLAY_NONE,
-	REPLAY_REMOVE_STATE,
-	REPLAY_CONTINUE,
-	REPLAY_ROLLBACK
-};
-
 struct replay_opts {
 	enum replay_action action;
 	enum replay_subcommand subcommand;
@@ -74,14 +66,14 @@ struct replay_opts {
 
 static const char *action_name(const struct replay_opts *opts)
 {
-	return opts->action == REVERT ? "revert" : "cherry-pick";
+	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
 }
 
 static char *get_encoding(const char *message);
 
 static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 {
-	return opts->action == REVERT ? revert_usage : cherry_pick_usage;
+	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
 }
 
 static int option_parse_x(const struct option *opt,
@@ -160,7 +152,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 	};
 
-	if (opts->action == CHERRY_PICK) {
+	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
@@ -374,7 +366,7 @@ static int error_dirty_index(struct replay_opts *opts)
 		return error_resolve_conflict(action_name(opts));
 
 	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == CHERRY_PICK)
+	if (opts->action == REPLAY_PICK)
 		error(_("Your local changes would be overwritten by cherry-pick."));
 	else
 		error(_("Your local changes would be overwritten by revert."));
@@ -553,7 +545,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->action == REVERT) {
+	if (opts->action == REPLAY_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -594,7 +586,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -618,13 +610,13 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (opts->action == CHERRY_PICK && !opts->no_commit && (res == 0 || res == 1))
+	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
 		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
-	if (opts->action == REVERT && ((opts->no_commit && res == 0) || res == 1))
+	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
 		write_cherry_pick_head(commit, "REVERT_HEAD");
 
 	if (res) {
-		error(opts->action == REVERT
+		error(opts->action == REPLAY_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
@@ -644,7 +636,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 static void prepare_revs(struct replay_opts *opts)
 {
-	if (opts->action != REVERT)
+	if (opts->action != REPLAY_REVERT)
 		opts->revs->reverse ^= 1;
 
 	if (prepare_revision_walk(opts->revs))
@@ -701,7 +693,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 {
 	struct commit_list *cur = NULL;
 	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REVERT ? "revert" : "pick";
+	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
 	const char *subject;
 	int subject_len;
 
@@ -722,10 +714,10 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	int saved, status, padding;
 
 	if (!prefixcmp(bol, "pick")) {
-		action = CHERRY_PICK;
+		action = REPLAY_PICK;
 		bol += strlen("pick");
 	} else if (!prefixcmp(bol, "revert")) {
-		action = REVERT;
+		action = REPLAY_REVERT;
 		bol += strlen("revert");
 	} else
 		return NULL;
@@ -748,7 +740,7 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	 */
 	if (action != opts->action) {
 		const char *action_str;
-		action_str = action == REVERT ? "revert" : "cherry-pick";
+		action_str = action == REPLAY_REVERT ? "revert" : "cherry-pick";
 		error(_("Cannot %s during a %s"), action_str, action_name(opts));
 		return NULL;
 	}
@@ -1124,7 +1116,7 @@ static int pick_revisions(struct replay_opts *opts)
 	if (create_seq_dir() < 0)
 		return -1;
 	if (get_sha1("HEAD", sha1)) {
-		if (opts->action == REVERT)
+		if (opts->action == REPLAY_REVERT)
 			return error(_("Can't revert as initial commit"));
 		return error(_("Can't cherry-pick into empty head"));
 	}
@@ -1141,7 +1133,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
-	opts.action = REVERT;
+	opts.action = REPLAY_REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
@@ -1156,7 +1148,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.action = CHERRY_PICK;
+	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
diff --git a/sequencer.h b/sequencer.h
index 2d4528f..1d9fcec 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -6,6 +6,18 @@
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
 
+enum replay_action {
+	REPLAY_REVERT,
+	REPLAY_PICK
+};
+
+enum replay_subcommand {
+	REPLAY_NONE,
+	REPLAY_REMOVE_STATE,
+	REPLAY_CONTINUE,
+	REPLAY_ROLLBACK
+};
+
 /* Removes SEQ_DIR. */
 extern void remove_sequencer_state(void);
 
-- 
1.7.8.2
