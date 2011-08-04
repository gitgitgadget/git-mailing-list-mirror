From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 16/18] revert: Don't implicitly stomp pending sequencer operation
Date: Thu,  4 Aug 2011 16:09:14 +0530
Message-ID: <1312454356-3070-17-git-send-email-artagnon@gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:43:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QovP0-0007PF-9c
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab1HDKnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:43:42 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63604 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab1HDKnl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:43:41 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1836868pzk.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vDVEshVC/zZb9QPPUVn22DsiZxCzQT0RIxKkzGeu498=;
        b=r3IbuNogKm3BjO0l6hfgCQPaGNIgoGpuG9hC2g2CJ6VT0JBw4MPnfdo4wiDV4BI95x
         uxQNKpdtmKA6QGjjXO1yp82MhGPPxhdrxPkkn4ADNik3VK5V0q/TrMFhbLvQK5MMzBjG
         eMzcd3SJ42IMDWfzbslwIITk8MBYjlDS+Veds=
Received: by 10.142.61.7 with SMTP id j7mr685198wfa.266.1312454621411;
        Thu, 04 Aug 2011 03:43:41 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id m7sm2090440pbk.6.2011.08.04.03.43.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 03:43:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178732>

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
 t/t3510-cherry-pick-sequence.sh |    9 +++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 000806c..19b6739 100644
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
@@ -801,9 +812,18 @@ static int pick_revisions(struct replay_opts *opts)
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
index a414086..566a15e 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -106,4 +106,13 @@ test_expect_success 'cherry-pick cleans up sequencer state when one commit is le
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick does not implicitly stomp an existing operation' '
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
1.7.6.351.gb35ac.dirty
