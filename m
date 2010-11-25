From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 14/18] revert: move global variable "me" into "struct
	args_info"
Date: Thu, 25 Nov 2010 22:20:45 +0100
Message-ID: <20101125212050.5188.49554.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:56:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIg-0007NM-Kq
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab0KZFzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:55:32 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47907 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab0KZFz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:55:29 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E77B1A61F3;
	Fri, 26 Nov 2010 06:55:21 +0100 (CET)
X-git-sha1: 267ad8202fbcd63dbdb69f7b9d32b666962b4056 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162199>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 12a2409..7513a00 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -39,8 +39,6 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static const char *me;
-
 struct args_info {
 	enum { REVERT, CHERRY_PICK } action;
 	int edit;
@@ -51,6 +49,7 @@ struct args_info {
 	int allow_ff;
 	int allow_rerere_auto;
 	int continuing;
+	const char *me;
 	const char *strategy;
 	const char **commit_argv;
 	int commit_argc;
@@ -91,6 +90,9 @@ static void parse_args(int argc, const char **argv, struct args_info *info)
 		OPT_END(),
 	};
 
+	info->me = info->action == REVERT ? "revert" : "cherry-pick";
+	setenv(GIT_REFLOG_ACTION, info->me, 0);
+
 	if (info->action == CHERRY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &info->no_replay, "append commit name"),
@@ -403,7 +405,8 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from)
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
 			      const char *base_label, const char *next_label,
-			      unsigned char *head, struct strbuf *msgbuf)
+			      unsigned char *head, const char *me,
+			      struct strbuf *msgbuf)
 {
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
@@ -507,7 +510,7 @@ static int do_pick_commit(struct args_info *info, struct commit *commit)
 		if (get_sha1("HEAD", head))
 			return error("You do not have a valid HEAD");
 		if (index_differs_from("HEAD", 0))
-			return error_dirty_index(me);
+			return error_dirty_index(info->me);
 	}
 	discard_cache();
 
@@ -543,7 +546,7 @@ static int do_pick_commit(struct args_info *info, struct commit *commit)
 
 	if (parent && parse_commit(parent) < 0)
 		return error("%s: cannot parse parent commit %s",
-			     me, sha1_to_hex(parent->object.sha1));
+			     info->me, sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit->buffer, commit->object.sha1, &msg) != 0)
 		return error("Cannot get commit message for %s",
@@ -590,7 +593,7 @@ static int do_pick_commit(struct args_info *info, struct commit *commit)
 	if (!info->strategy || !strcmp(info->strategy, "recursive") ||
 	    info->action == REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
-					 head, &msgbuf);
+					 head, info->me, &msgbuf);
 		write_res = write_message(&msgbuf, defmsg);
 		if (write_res)
 			return write_res;
@@ -704,7 +707,7 @@ static int pick_commits(struct args_info *infos, struct commit_list **done_list)
 	     (res = ff_incompatible(infos->edit, "--edit"))))
 		return save_todo_and_done(res, infos, NULL, NULL, done_list);
 
-	if ((res = read_and_refresh_cache(me)) ||
+	if ((res = read_and_refresh_cache(infos->me)) ||
 	    (res = prepare_revs(&revs, infos)))
 		return save_todo_and_done(res, infos, NULL, NULL, done_list);
 
@@ -722,8 +725,6 @@ static int revert_or_cherry_pick(int argc, const char **argv, int revert, int ed
 	int res;
 
 	git_config(git_default_config, NULL);
-	me = revert ? "revert" : "cherry-pick";
-	setenv(GIT_REFLOG_ACTION, me, 0);
 	memset(&infos, 0, sizeof(infos));
 	infos.action = revert ? REVERT : CHERRY_PICK;
 	parse_args(argc, argv, &infos);
-- 
1.7.3.2.504.g59d466
