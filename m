From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/18] revert: Save command-line options for continuing operation
Date: Mon,  1 Aug 2011 23:36:58 +0530
Message-ID: <1312222025-28453-12-git-send-email-artagnon@gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:12:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwyS-0004FI-3D
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab1HASMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:12:16 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62360 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab1HASMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:12:14 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so11912645pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PCC+iOMPDjCmzdCVmf9tBl1PzSl/AMFJse4SCEvPAro=;
        b=Gh8ipdOx4Ufr+aEpW7ZeYqoPZ5gS+VrxFooEbzJobL7h9Cfdj6TuZXsg9EmrQ7JJHM
         YOTumTwLEuV4GFyZO1y/TRx/zULPWIC8CfO/EDYY8Y0Op3/P+kaPsn4Z4lGL/AZ4foSF
         of5mAw0oDIx5CmkJHVWOnAWcDHQ6NJiEKvhws=
Received: by 10.68.23.194 with SMTP id o2mr2636807pbf.172.1312222333896;
        Mon, 01 Aug 2011 11:12:13 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d3sm5789958pbh.37.2011.08.01.11.12.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:12:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178383>

In the same spirit as ".git/sequencer/head" and ".git/sequencer/todo",
introduce ".git/sequencer/opts" to persist the replay_opts structure
for continuing after a conflict resolution.  Use the gitconfig format
for this file so that it looks like:

  [options]
	  signoff = true
	  record-origin = true
	  mainline = 1
	  strategy = recursive
	  strategy-option = patience
	  strategy-option = ours

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c                |   33 +++++++++++++++++++++++++++++++++
 t/t3510-cherry-pick-sequence.sh |   30 ++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1d5a242..7aa0aaf 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -64,6 +64,7 @@ struct replay_opts {
 #define SEQ_DIR         "sequencer"
 #define SEQ_HEAD_FILE   "sequencer/head"
 #define SEQ_TODO_FILE   "sequencer/todo"
+#define SEQ_OPTS_FILE   "sequencer/opts"
 
 static const char *action_name(const struct replay_opts *opts)
 {
@@ -697,6 +698,37 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	strbuf_release(&buf);
 }
 
+static void save_opts(struct replay_opts *opts)
+{
+	const char *opts_file = git_path(SEQ_OPTS_FILE);
+
+	if (opts->no_commit)
+		git_config_set_in_file(opts_file, "options.no-commit", "true");
+	if (opts->edit)
+		git_config_set_in_file(opts_file, "options.edit", "true");
+	if (opts->signoff)
+		git_config_set_in_file(opts_file, "options.signoff", "true");
+	if (opts->record_origin)
+		git_config_set_in_file(opts_file, "options.record-origin", "true");
+	if (opts->allow_ff)
+		git_config_set_in_file(opts_file, "options.allow-ff", "true");
+	if (opts->mainline) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "%d", opts->mainline);
+		git_config_set_in_file(opts_file, "options.mainline", buf.buf);
+		strbuf_release(&buf);
+	}
+	if (opts->strategy)
+		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
+	if (opts->xopts) {
+		int i;
+		for (i = 0; i < opts->xopts_nr; i++)
+			git_config_set_multivar_in_file(opts_file,
+							"options.strategy-option",
+							opts->xopts[i], "^$", 0);
+	}
+}
+
 static int pick_commits(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
@@ -719,6 +751,7 @@ static int pick_commits(struct replay_opts *opts)
 		die(_("Can't cherry-pick into empty head"));
 	}
 	save_head(sha1_to_hex(sha1));
+	save_opts(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index a2c70ad..6038419 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -33,10 +33,36 @@ test_expect_success setup '
 
 test_expect_success 'cherry-pick persists data on failure' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_must_fail git cherry-pick -s base..anotherpick &&
 	test_path_is_dir .git/sequencer &&
 	test_path_is_file .git/sequencer/head &&
-	test_path_is_file .git/sequencer/todo
+	test_path_is_file .git/sequencer/todo &&
+	test_path_is_file .git/sequencer/opts
+'
+
+test_expect_success 'cherry-pick persists opts correctly' '
+	rm -rf .git/sequencer &&
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
+	test_path_is_dir .git/sequencer &&
+	test_path_is_file .git/sequencer/head &&
+	test_path_is_file .git/sequencer/todo &&
+	test_path_is_file .git/sequencer/opts &&
+	echo "true" >expect
+	git config --file=.git/sequencer/opts --get-all options.signoff >actual &&
+	test_cmp expect actual &&
+	echo "1" >expect
+	git config --file=.git/sequencer/opts --get-all options.mainline >actual &&
+	test_cmp expect actual &&
+	echo "recursive" >expect
+	git config --file=.git/sequencer/opts --get-all options.strategy >actual &&
+	test_cmp expect actual &&
+	cat >expect <<-\EOF
+	patience
+	ours
+	EOF
+	git config --file=.git/sequencer/opts --get-all options.strategy-option >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'cherry-pick cleans up sequencer state upon success' '
-- 
1.7.4.rc1.7.g2cf08.dirty
