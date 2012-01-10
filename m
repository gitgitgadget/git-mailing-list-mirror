From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/8] revert: prepare to move replay_action to header
Date: Tue, 10 Jan 2012 21:43:52 +0530
Message-ID: <1326212039-13806-2-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 17:15:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkeMY-00059f-LV
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 17:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088Ab2AJQPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 11:15:42 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50928 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab2AJQPk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 11:15:40 -0500
Received: by mail-gx0-f174.google.com with SMTP id k6so301248ggd.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 08:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3nRQ+cutqk/1/2Cc9T1WOKPjFLDdrpIvl4mxB2iWDFI=;
        b=u2Mmk02EcTlEfZEgkUjMuGQGqEAp+jWx9kpmN61MN4vAVpdWH99k8RKcyxnFAIKbgU
         9X8A6z9AFCFPtApLfhNQmhGjNcbOPw12dcb6IUwRezR58F5J0oLi8WJf8bUIMJy9hiUw
         P45oNSJh7sv5tGbKh1ip8lzOWfShTMygCxKOM=
Received: by 10.50.182.130 with SMTP id ee2mr2880561igc.30.1326212140096;
        Tue, 10 Jan 2012 08:15:40 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id lu10sm129662851igc.0.2012.01.10.08.15.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 08:15:39 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188257>

Later in the series, we will build a generalized sequencer by
factoring code out of the revert builtin, and leaving it with just
argument parsing work.  This involves moving "replay_action" to
sequencer.h, so that both sequencer.c and builtin/revert.c can use it.
Unfortunately, "REVERT" and "CHERRY_PICK" are unsuitable variable
names, as their purpose is unclear in the global context; in
anticipation of the move, rename them to "REPLAY_REVERT" and
"REPLAY_PICK" respectively.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   40 ++++++++++++++++++++++------------------
 1 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0d8020c..2739405 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -39,7 +39,11 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-enum replay_action { REVERT, CHERRY_PICK };
+enum replay_action {
+	REPLAY_REVERT,
+	REPLAY_PICK
+};
+
 enum replay_subcommand {
 	REPLAY_NONE,
 	REPLAY_REMOVE_STATE,
@@ -74,14 +78,14 @@ struct replay_opts {
 
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
@@ -160,7 +164,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 	};
 
-	if (opts->action == CHERRY_PICK) {
+	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
@@ -374,7 +378,7 @@ static int error_dirty_index(struct replay_opts *opts)
 		return error_resolve_conflict(action_name(opts));
 
 	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == CHERRY_PICK)
+	if (opts->action == REPLAY_PICK)
 		error(_("Your local changes would be overwritten by cherry-pick."));
 	else
 		error(_("Your local changes would be overwritten by revert."));
@@ -553,7 +557,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->action == REVERT) {
+	if (opts->action == REPLAY_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -594,7 +598,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -618,13 +622,13 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
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
@@ -644,7 +648,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 static void prepare_revs(struct replay_opts *opts)
 {
-	if (opts->action != REVERT)
+	if (opts->action != REPLAY_REVERT)
 		opts->revs->reverse ^= 1;
 
 	if (prepare_revision_walk(opts->revs))
@@ -701,7 +705,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 {
 	struct commit_list *cur = NULL;
 	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REVERT ? "revert" : "pick";
+	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
 	const char *subject;
 	int subject_len;
 
@@ -722,10 +726,10 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
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
@@ -748,7 +752,7 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	 */
 	if (action != opts->action) {
 		const char *action_str;
-		action_str = action == REVERT ? "revert" : "cherry-pick";
+		action_str = action == REPLAY_REVERT ? "revert" : "cherry-pick";
 		error(_("Cannot %s during a %s"), action_str, action_name(opts));
 		return NULL;
 	}
@@ -1124,7 +1128,7 @@ static int pick_revisions(struct replay_opts *opts)
 	if (create_seq_dir() < 0)
 		return -1;
 	if (get_sha1("HEAD", sha1)) {
-		if (opts->action == REVERT)
+		if (opts->action == REPLAY_REVERT)
 			return error(_("Can't revert as initial commit"));
 		return error(_("Can't cherry-pick into empty head"));
 	}
@@ -1141,7 +1145,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
-	opts.action = REVERT;
+	opts.action = REPLAY_REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
@@ -1156,7 +1160,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.action = CHERRY_PICK;
+	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
-- 
1.7.8.2
