From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/8] revert: Make "commit" and "me" local variables
Date: Wed, 11 May 2011 13:30:16 +0530
Message-ID: <1305100822-20470-3-git-send-email-artagnon@gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 19:31:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKDFu-0007HY-II
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 19:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab1EKRbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 13:31:09 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:38645 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab1EKRbI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 13:31:08 -0400
X-IronPort-AV: E=Sophos;i="4.64,351,1301875200"; 
   d="scan'208";a="77413330"
Received: from smtp-in-9003.sea19.amazon.com ([10.186.104.20])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 May 2011 08:05:34 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-9003.sea19.amazon.com (8.13.8/8.13.8) with ESMTP id p4B85VA2013466;
	Wed, 11 May 2011 08:05:32 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 91EB5754833; Wed, 11 May 2011 13:30:22 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173417>

Currently, "commit" and "me" are global static variables. Since we
want to develop the functionality to either pick/ revert individual
commits atomically later in the series, make them local variables.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 The variable "me" is nowhere as fundamental as "commit" -- it's
 simply a string derived from a more fundamental "action".  Yet, the
 commit message seems to indicate that both "me" and "commit" are
 equally important -- how should it be reworded?

 builtin/revert.c |   42 +++++++++++++++++++++++++-----------------
 1 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index fefb18b..e5c3c6c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -37,12 +37,10 @@ static const char * const cherry_pick_usage[] = {
 
 static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
-static struct commit *commit;
 static int commit_argc;
 static const char **commit_argv;
 static int allow_rerere_auto;
 
-static const char *me;
 
 /* Merge strategy. */
 static const char *strategy;
@@ -51,7 +49,7 @@ static size_t xopts_nr, xopts_alloc;
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-static char *get_encoding(const char *message);
+static char *get_encoding(struct commit *commit, const char *message);
 
 static const char * const *revert_or_cherry_pick_usage(void)
 {
@@ -116,7 +114,8 @@ struct commit_message {
 	const char *message;
 };
 
-static int get_message(const char *raw_message, struct commit_message *out)
+static int get_message(struct commit *commit, const char *raw_message,
+		struct commit_message *out)
 {
 	const char *encoding;
 	const char *abbrev, *subject;
@@ -125,7 +124,7 @@ static int get_message(const char *raw_message, struct commit_message *out)
 
 	if (!raw_message)
 		return -1;
-	encoding = get_encoding(raw_message);
+	encoding = get_encoding(commit, raw_message);
 	if (!encoding)
 		encoding = "UTF-8";
 	if (!git_commit_encoding)
@@ -163,7 +162,7 @@ static void free_message(struct commit_message *msg)
 	free(msg->reencoded_message);
 }
 
-static char *get_encoding(const char *message)
+static char *get_encoding(struct commit *commit, const char *message)
 {
 	const char *p = message, *eol;
 
@@ -187,7 +186,8 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
+static void add_message_to_msg(struct commit *commit, struct strbuf *msgbuf,
+			const char *message)
 {
 	const char *p = message;
 	while (*p && (*p != '\n' || p[1] != '\n'))
@@ -200,7 +200,7 @@ static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
 	strbuf_addstr(msgbuf, p);
 }
 
-static int write_cherry_pick_head(void)
+static int write_cherry_pick_head(struct commit *commit)
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
@@ -319,6 +319,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	int clean, index_fd;
 	const char **xopt;
 	static struct lock_file index_lock;
+	const char *me = (action == REVERT ? "revert" : "cherry-pick");
 
 	index_fd = hold_locked_index(&index_lock, 1);
 
@@ -394,7 +395,7 @@ static int run_git_commit(const char *defmsg)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(void)
+static int do_pick_commit(struct commit *commit)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -402,6 +403,7 @@ static int do_pick_commit(void)
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
+	const char *me = (action == REVERT ? "revert" : "cherry-pick");
 	int res;
 
 	if (no_commit) {
@@ -458,9 +460,10 @@ static int do_pick_commit(void)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
 		return error(_("%s: cannot parse parent commit %s"),
-		    me, sha1_to_hex(parent->object.sha1));
+			action == REVERT ? "revert" : "cherry-pick",
+			sha1_to_hex(parent->object.sha1));
 
-	if (get_message(commit->buffer, &msg) != 0)
+	if (get_message(commit, commit->buffer, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
 				sha1_to_hex(commit->object.sha1));
 
@@ -493,14 +496,14 @@ static int do_pick_commit(void)
 		base_label = msg.parent_label;
 		next = commit;
 		next_label = msg.label;
-		add_message_to_msg(&msgbuf, msg.message);
+		add_message_to_msg(commit, &msgbuf, msg.message);
 		if (no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
 		if (!no_commit)
-			if ((res = write_cherry_pick_head())) {
+			if ((res = write_cherry_pick_head(commit))) {
 				free_message(&msg);
 				free(defmsg);
 				return res;
@@ -562,10 +565,13 @@ static int prepare_revs(struct rev_info *revs)
 	return 0;
 }
 
-static int read_and_refresh_cache(const char *me)
+static int read_and_refresh_cache(void)
 {
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
+	const char *me;
+
+	me = (action == REVERT ? "revert" : "cherry-pick");
 	if (read_index_preload(&the_index, NULL) < 0)
 		return error(_("%s: failed to read the index"), me);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
@@ -583,10 +589,12 @@ static int read_and_refresh_cache(const char *me)
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	struct rev_info revs;
+	struct commit *commit;
+	const char *me;
 	int res;
 
 	git_config(git_default_config, NULL);
-	me = action == REVERT ? "revert" : "cherry-pick";
+	me = (action == REVERT ? "revert" : "cherry-pick");
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
 
@@ -601,12 +609,12 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die(_("cherry-pick --ff cannot be used with --edit"));
 	}
 
-	if ((res = read_and_refresh_cache(me)) ||
+	if ((res = read_and_refresh_cache()) ||
 		(res = prepare_revs(&revs)))
 		return res;
 
 	while ((commit = get_revision(&revs)) &&
-		!(res = do_pick_commit()))
+		!(res = do_pick_commit(commit)))
 		;
 
 	return res;
-- 
1.7.5.GIT
