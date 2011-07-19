From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 17/18] revert: Don't implictly stomp pending sequencer operation
Date: Tue, 19 Jul 2011 22:47:55 +0530
Message-ID: <1311095876-3098-18-git-send-email-artagnon@gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDy1-0003ZF-5P
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab1GSRUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:20:12 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36451 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1GSRUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:20:10 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so4030753pvg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sM2uIroGUoZhxImIykxr9gzGwGFRaw3BYwD1URmH6+U=;
        b=nCh4yAMhUOneEmUrO2EupbDHn3jy04GjB1ohN/l9ZD2VAvB3hRyeBi1sQBzhIPKZMJ
         Kys4lzKFxLp3DkI3Pd91LqtPFvjrD6tdW1jpWJNTgM1gp3HC5QT60vgiHbxw9Pbrt3Hd
         HfVbOqmpqJymw05ggc9erpViRPd28xnonPDvs=
Received: by 10.143.62.10 with SMTP id p10mr3770755wfk.191.1311096009926;
        Tue, 19 Jul 2011 10:20:09 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.20.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:20:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177482>

Protect the user from forgetting about a pending sequencer operation
by immediately erroring out when an existing cherry-pick or revert
operation is in progress like:

$ git cherry-pick foo
... conflict ...
$ git cherry-pick moo
error: .git/sequencer already exists
hint: A cherry-pick or revert is in progress
hint: Use --reset to forget about it
fatal: cherry-pick failed

A naive version of this would break the following established ways of
working:

$ git cherry-pick foo
... conflict ...
$ git reset --hard  # I actually meant "moo" when I said "foo"
$ git cherry-pick moo

$ git cherry-pick foo
... conflict ...
$ git commit # commit the resolution
$ git cherry-pick moo # New operation

However, the previous patches "reset: Make reset remove the sequencer
state" and "revert: Remove sequencer state when no commits are
pending" make sure that this does not happen.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |   21 +++++++++++++++++----
 t/t3510-cherry-pick-sequence.sh |   10 ++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f23e9a3..82a919a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -796,12 +796,15 @@ static void walk_revs_populate_todo(struct commit_list **todo_list,
 		next = commit_list_append(commit, next);
 }
 
-static void create_seq_dir(void)
+static int create_seq_dir(void)
 {
 	const char *seq_dir = git_path(SEQ_DIR);
 
-	if (!file_exists(seq_dir) && mkdir(seq_dir, 0777) < 0)
+	if (file_exists(seq_dir))
+		return error(_("%s already exists."), seq_dir);
+	else if (mkdir(seq_dir, 0777) < 0)
 		die_errno(_("Could not create sequencer directory '%s'."), seq_dir);
+	return 0;
 }
 
 static void save_head(const char *head)
@@ -912,6 +915,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 static int pick_revisions(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
+	const char *me = action_name(opts);
 	unsigned char sha1[20];
 
 	read_and_refresh_cache(opts);
@@ -920,9 +924,18 @@ static int pick_revisions(struct replay_opts *opts)
 		remove_sequencer_state(1);
 		return 0;
 	} else {
-		/* Start a new cherry-pick/ revert sequence */
+		/*
+		 * Start a new cherry-pick/ revert sequence; but
+		 * first, make sure that an existing one isn't in
+		 * progress
+		 */
+
 		walk_revs_populate_todo(&todo_list, opts);
-		create_seq_dir();
+		if (create_seq_dir() < 0) {
+			advise(_("A cherry-pick or revert is in progress."));
+			advise(_("Use --reset to forget about it"));
+			return -1;
+		}
 		if (get_sha1("HEAD", sha1)) {
 			if (opts->action == REVERT)
 				return error(_("Can't revert as initial commit"));
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 428b5bf..44277f5 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -107,4 +107,14 @@ test_expect_success 'cherry-pick cleans up sequencer state when one commit is le
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick does not implicitly stomp an existing operation' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	test-chmtime -v +0 .git/sequencer >expect &&
+	test_must_fail git cherry-pick unrelatedpick &&
+	test-chmtime -v +0 .git/sequencer >actual &&
+	test_cmp expect actual &&
+	git cherry-pick --reset
+'
+
 test_done
-- 
1.7.4.rc1.7.g2cf08.dirty
