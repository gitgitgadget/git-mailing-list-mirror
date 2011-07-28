From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 16/18] revert: Don't implictly stomp pending sequencer operation
Date: Thu, 28 Jul 2011 22:22:29 +0530
Message-ID: <1311871951-3497-17-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:57:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTtK-00049i-Bj
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab1G1Q4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:56:48 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53753 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab1G1Q4q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:56:46 -0400
Received: by yia27 with SMTP id 27so1953150yia.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WT32Piev/99H0O+8SLZXC0f9l87STzlJQEaBU+PqiTs=;
        b=BLb1qfHIba5F09fK8ee+VfKMUNcy+ziActNsNeSLdXkrM2tqHV4KzWP4MnXPQwwsC6
         hwxgPdSkNVj+0XpbX1gKvSk7AVVs3gjvaPdixtyIVAjrtIvTA04FIAm6DDoOkkfPSfTG
         agSWYH7zRCkSvHE9yIs8NsKZA/hlZTkJDxPkE=
Received: by 10.42.133.195 with SMTP id i3mr145098ict.449.1311872205829;
        Thu, 28 Jul 2011 09:56:45 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.56.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:56:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178094>

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
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c                |   30 +++++++++++++++++++++++++-----
 t/t3510-cherry-pick-sequence.sh |   10 ++++++++++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 80a2ef7..e173c71 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -66,6 +66,15 @@ struct replay_opts {
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
+static void fatal(const char *advice, ...)
+{
+	va_list params;
+
+	va_start(params, advice);
+	vreportf("fatal: ", advice, params);
+	va_end(params);
+}
+
 static const char *action_name(const struct replay_opts *opts)
 {
 	return opts->action == REVERT ? "revert" : "cherry-pick";
@@ -673,13 +682,15 @@ static void walk_revs_populate_todo(struct commit_list **todo_list,
 		next = commit_list_append(commit, next);
 }
 
-static void create_seq_dir(void)
+static int create_seq_dir(void)
 {
 	const char *seq_dir = git_path(SEQ_DIR);
 
-	if (!(file_exists(seq_dir) && is_directory(seq_dir))
-		&& mkdir(seq_dir, 0777) < 0)
+	if (file_exists(seq_dir))
+		return error(_("%s already exists."), seq_dir);
+	else if (mkdir(seq_dir, 0777) < 0)
 		die_errno(_("Could not create sequencer directory '%s'."), seq_dir);
+	return 0;
 }
 
 static void save_head(const char *head)
@@ -798,9 +809,18 @@ static int pick_revisions(struct replay_opts *opts)
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
+			fatal(_("A cherry-pick or revert is in progress."));
+			advise(_("Use --reset to forget about it"));
+			exit(128);
+		}
 		if (get_sha1("HEAD", sha1)) {
 			if (opts->action == REVERT)
 				die(_("Can't revert as initial commit"));
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 528f270..342cab3 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -110,4 +110,14 @@ test_expect_success 'cherry-pick cleans up sequencer state when one commit is le
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick does not implicitly stomp an existing operation' '
+	git cherry-pick --reset &&
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	test-chmtime -v +0 .git/sequencer >expect &&
+	test_must_fail git cherry-pick unrelatedpick &&
+	test-chmtime -v +0 .git/sequencer >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.4.rc1.7.g2cf08.dirty
