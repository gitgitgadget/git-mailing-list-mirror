From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 17/18] revert: Don't implictly stomp pending sequencer operation
Date: Wed, 27 Jul 2011 08:49:14 +0530
Message-ID: <1311736755-24205-18-git-send-email-artagnon@gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlujO-0006PP-7j
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab1G0DXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:23:36 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35904 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab1G0DXf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:23:35 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1938359pzk.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yIEAWDFwpxS1K7SQzqYpxX9yd9ihRF1P/vWHdFEcfAA=;
        b=xtbTm1yPwOvKTFDKgYO1LzVrI0DcM4GAWWHcz8SSW1VAGjeTb4TC3bLInE/7RsLzDk
         /AoVuWLNx8qi5rIJgOOsMP44OSKfE2JxwoVpJZ/ANyyxtwpwl/Q6P6E4QApT6lpFR83h
         Q5dh5HpdstjVC4yZgtevP3JVSEHQ1He8RgVRY=
Received: by 10.68.17.40 with SMTP id l8mr11419618pbd.80.1311737015475;
        Tue, 26 Jul 2011 20:23:35 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id p7sm1210706pbn.65.2011.07.26.20.23.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:23:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177921>

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
index 09d479b..11973e6 100644
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
