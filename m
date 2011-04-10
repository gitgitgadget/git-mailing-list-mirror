From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/11] revert: Lose global variables "commit" and "me"
Date: Sun, 10 Apr 2011 20:41:48 +0530
Message-ID: <1302448317-32387-3-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:14:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wLg-0000Xa-9E
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090Ab1DJPOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:14:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59899 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab1DJPOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:14:43 -0400
Received: by iwn34 with SMTP id 34so4865116iwn.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=KgwRn38A3X+1qsF5BUvfkGULPFFs5tq9AQ8e63LiDt8=;
        b=rtQoUKkf4LNB6nW1x5oGWA98Xa0rGS4AFsqhUUsOIW82eDXAV7T5HqVmHvFNiUPAYy
         Rag0762WfutPNJEM+F/YX6pQE+UIQCUCJAEeJRAAf1BRX0/IMgTiiNaidvznAxUeUXr8
         w9AhsXVz75Lq2vyFAKPCAB1M1KvmbjdgAFV2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fm/K8oULRlzkLCzNjvJrHzAY/VJvtWH9Y4vDT1rL3UwehD8JOON2QNXmTfiO6lGcX+
         fm7elWJZtAHMm/q1TnkzT+gYmtbJWW4RXXBfQKB7N/LiPXZpc3vPLiYUH/wEzfPF8/mF
         a0ADP+NMydiDNLphA64NX3E3csPV3orEbFx9k=
Received: by 10.42.75.65 with SMTP id z1mr2850668icj.132.1302448390479;
        Sun, 10 Apr 2011 08:13:10 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.13.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:13:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171266>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   44 +++++++++++++++++++++++++-------------------
 1 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 017b1af..fdbacad 100644
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
@@ -115,7 +113,8 @@ struct commit_message {
 	const char *message;
 };
 
-static int get_message(const char *raw_message, struct commit_message *out)
+static int get_message(struct commit *commit, const char *raw_message,
+		struct commit_message *out)
 {
 	const char *encoding;
 	const char *abbrev, *subject;
@@ -124,7 +123,7 @@ static int get_message(const char *raw_message, struct commit_message *out)
 
 	if (!raw_message)
 		return -1;
-	encoding = get_encoding(raw_message);
+	encoding = get_encoding(commit, raw_message);
 	if (!encoding)
 		encoding = "UTF-8";
 	if (!git_commit_encoding)
@@ -162,7 +161,7 @@ static void free_message(struct commit_message *msg)
 	free(msg->reencoded_message);
 }
 
-static char *get_encoding(const char *message)
+static char *get_encoding(struct commit *commit, const char *message)
 {
 	const char *p = message, *eol;
 
@@ -184,7 +183,8 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
+static void add_message_to_msg(struct commit *commit, struct strbuf *msgbuf,
+			const char *message)
 {
 	const char *p = message;
 	while (*p && (*p != '\n' || p[1] != '\n'))
@@ -197,7 +197,7 @@ static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
 	strbuf_addstr(msgbuf, p);
 }
 
-static void write_cherry_pick_head(void)
+static void write_cherry_pick_head(struct commit *commit)
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
@@ -265,10 +265,10 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
-static int error_dirty_index(const char *me)
+static int error_dirty_index()
 {
 	if (read_cache_unmerged()) {
-		die_resolve_conflict(me);
+		die_resolve_conflict(action == REVERT ? "revert" : "cherry-pick");
 	} else {
 		if (advice_commit_before_merge) {
 			if (action == REVERT)
@@ -379,7 +379,7 @@ static int run_git_commit(const char *defmsg)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(void)
+static int do_pick_commit(struct commit *commit)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -402,7 +402,7 @@ static int do_pick_commit(void)
 		if (get_sha1("HEAD", head))
 			return error(_("You do not have a valid HEAD"));
 		if (index_differs_from("HEAD", 0))
-			return error_dirty_index(me);
+			return error_dirty_index();
 	}
 	discard_cache();
 
@@ -441,9 +441,10 @@ static int do_pick_commit(void)
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
 
@@ -476,14 +477,14 @@ static int do_pick_commit(void)
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
-			write_cherry_pick_head();
+			write_cherry_pick_head(commit);
 	}
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
@@ -546,10 +547,13 @@ static int prepare_revs(struct rev_info *revs)
 	return 0;
 }
 
-static int read_and_refresh_cache(const char *me)
+static int read_and_refresh_cache(void)
 {
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
+	const char *me;
+
+	me = (cmd_opts.action == REVERT ? "revert" : "cherry-pick");
 	if (read_index_preload(&the_index, NULL) < 0)
 		return error(_("%s: failed to read the index"), me);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
@@ -565,10 +569,12 @@ static int read_and_refresh_cache(const char *me)
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
 
@@ -583,7 +589,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die(_("cherry-pick --ff cannot be used with --edit"));
 	}
 
-	if ((res = read_and_refresh_cache(me)) ||
+	if ((res = read_and_refresh_cache()) ||
 		(res = prepare_revs(&revs)))
 		return res;
 
-- 
1.7.4.rc1.7.g2cf08.dirty
