From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH v2] revert: Implement --abort processing
Date: Sat, 11 Jun 2011 12:06:26 +0530
Message-ID: <1307774186-14207-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 08:36:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVHoP-0004rh-Ep
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 08:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab1FKGgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2011 02:36:36 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:56153 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab1FKGgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 02:36:35 -0400
Received: by pxi2 with SMTP id 2so2077456pxi.10
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 23:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Mtvo5ya/DUPlC6jQ9PXlvgfjose9PIfwvy0JmHvtYvU=;
        b=Z1L++feueBf7GPTHvMoyZlT/X1tMUSh+ocPL5gqwr0YB/tuOi4WJsDU+udL5IB10D4
         qCdbcE+R6VUtTALYuxnuyp38p+jEFF1d/hS6tGfH2/LRRksGCUnpWgnxXtVJGxp96YmF
         a7H3GIpIFjRp1giF/QRsjIsHBW7at+8/1Z/T0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rj0jJq2WR7wC0Wthuwab/UyH6nD32ktFLc5wfq0nN4QnAUDyu+JlIbAf5AIu7JdONq
         cEDRAWUykaqIEmrGkRaSKHuLHhti23jSyfCOcIWyHydL2bIK/uzbhcKhgm6qiocSN5Tt
         K9rz0Au0Si3a/0fn0v/XTWqqYTBrDF6qdUx7Y=
Received: by 10.142.195.12 with SMTP id s12mr475480wff.307.1307774194488;
        Fri, 10 Jun 2011 23:36:34 -0700 (PDT)
Received: from localhost.localdomain ([122.174.121.147])
        by mx.google.com with ESMTPS id x1sm2925142pbb.50.2011.06.10.23.36.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 23:36:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175638>

To abort, simply reset the HEAD to the location specified by the
HEAD_FILE written earlier, without touching the worktree or index.  It
is upto the user to execute "rerere clear", "reset --hard", and "reset
--merge" as approprite.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I've persisted the TODO early, and made it complain when an existing
 cherry-pick/ revert is in progress.  Further, as Junio suggested,
 I've made no attempt to touch the index or the worktree during the
 --abort operation: I simply update HEAD and leave the user to do the
 rest.  Should we print some hints about this?

 However, by making it complain everytime a cherry-pick/ revert is in
 progress, I've essentially broken the entire testsuite -- everytime a
 test or even a script (see git-rebase.sh) calls cherry-pick or
 revert, I must call '--abort' to clean up afterwards.  Fixing this
 will require me to touch many seemingly unrelated files.

 Also, note that I'm depending on the "libify reset" patch I posted a
 few minutes ago to print_new_head_line exactly the way reset does.

 In other news, I've started writing '--continue' and '--skip'
 operations, but the limiting factor is the instruction sheet's
 format: I'm still wondering if there's any way to avoid being
 verbose/ ugly and flexible (by allowing command-line options for each
 instruction) at the same time.  Will post RFC patches asking more
 directed questions soon.

 Thanks.

 builtin/revert.c                |   85 +++++++++++++++++++++++++++++++++++---
 t/t3510-cherry-pick-sequence.sh |   16 +++++++
 2 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e1a05a3..efcc01f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -14,6 +14,7 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "dir.h"
+#include "reset.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -208,8 +209,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				NULL);
 
 	/* Remove these when the options are actually implemented */
-	if (opts->abort_oper)
-		die("--abort is not implemented yet");
 	if (opts->skip_oper)
 		die("--skip is not implemented yet");
 	if (opts->continue_oper)
@@ -719,6 +718,7 @@ static int pick_commits(struct replay_opts *opts)
 	struct commit *commit;
 	unsigned char sha1[20];
 	const char *head;
+	int res;
 
 	setenv(GIT_REFLOG_ACTION, me, 0);
 
@@ -730,11 +730,30 @@ static int pick_commits(struct replay_opts *opts)
 	persist_head(head);
 	prepare_revs(&revs, opts);
 
+	/* Prepare todo_list and persist it early before picking */
+	struct commit_list *todo_list = NULL;
+	struct commit_list *cur = NULL;
+	struct commit_list *new_item = NULL;
+
+	/* Insert into todo_list in the same order */
 	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit(commit, opts);
+		new_item = xmalloc(sizeof(struct commit_list));
+		new_item->item = commit;
+		if (cur)
+			cur->next = new_item;
+		else
+			todo_list = new_item;
+		cur = new_item;
+	}
+	cur->next = NULL;
+
+	persist_todo(todo_list, opts);
+
+	for (cur = todo_list; cur; cur = cur->next) {
+		res = do_pick_commit(cur->item, opts);
 		if (res) {
-			commit_list_insert(commit, &revs.commits);
-			persist_todo(revs.commits, opts);
+			commit_list_insert(cur->item, &todo_list);
+			persist_todo(todo_list, opts);
 			return res;
 		}
 	}
@@ -743,6 +762,58 @@ static int pick_commits(struct replay_opts *opts)
 	return cleanup_sequencer_dir();
 }
 
+static int process_continuation(struct replay_opts *opts)
+{
+	unsigned char sha1[20];
+	struct commit *commit;
+	char head_hex[40];
+	char msg[1024];
+	int fd;
+
+	if (opts->abort_oper) {
+		/* First, read the HEAD_FILE */
+		if (!file_exists(HEAD_FILE))
+			goto error;
+		fd = open(HEAD_FILE, O_RDONLY, 0666);
+		if (fd < 0)
+			return error(_("Could not open '%s' for reading: %s"),
+				HEAD_FILE, strerror(errno));
+		if (read_in_full(fd, head_hex, 40) < 40 || get_sha1_hex(head_hex, sha1) < 0) {
+			close(fd);
+			return error(_("Corrupt '%s': %s"), HEAD_FILE, strerror(errno));
+		}
+		close(fd);
+
+		/* Update the HEAD ref */
+		if (snprintf(msg, sizeof(msg), "%s: updating HEAD", me) >= sizeof(msg))
+			warning(_("Reflog action message too long: %.*s..."), 50, msg);
+		if (update_ref(msg, "HEAD", sha1, NULL, 0, MSG_ON_ERR))
+			return -1;
+		commit = lookup_commit_reference(sha1);
+		print_new_head_line(commit);
+
+		return cleanup_sequencer_dir();
+	}
+	else if (opts->skip_oper) {
+		if (!file_exists(TODO_FILE))
+			goto error;
+	}
+	else if (opts->continue_oper) {
+		if (!file_exists(TODO_FILE))
+			goto error;
+	}
+	else if (file_exists(HEAD_FILE)) {
+		error(_("A %s is already in progress"), me);
+		advise(_("Use %s --continue to continue the operation"), me);
+		advise(_("or %s --abort to start afresh"), me);
+		return -1;
+	}
+
+	return pick_commits(opts);
+error:
+	return error(_("No %s in progress"), me);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	int res;
@@ -755,7 +826,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "revert";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = process_continuation(&opts);
 	if (res > 0)
 		/* Exit status from conflict */
 		return res;
@@ -775,7 +846,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "cherry-pick";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = process_continuation(&opts);
 	if (res > 0)
 		return res;
 	if (res < 0)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index a2e1888..c6ace35 100644
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -36,4 +36,20 @@ test_expect_success 'cherry-pick cleans up sequencer directory upon success' '
 	test_must_fail test -d .git/sequencer
 '
 
+test_expect_success '--abort complains when no cherry-pick is in progress' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --abort >actual 2>&1 &&
+	echo "error: No cherry-pick in progress" >expect &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success '--abort restores HEAD after failed cherry-pick' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	git cherry-pick --abort &&
+	newhead=$(git rev-parse HEAD) &&
+	test "$head" = "$newhead"
+'
+
 test_done
-- 
1.7.4.1
