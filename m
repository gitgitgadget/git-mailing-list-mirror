From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/18] revert: Save command-line options for continuing operation
Date: Thu,  4 Aug 2011 16:09:09 +0530
Message-ID: <1312454356-3070-12-git-send-email-artagnon@gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:43:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QovOa-0007Db-Pj
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1HDKnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:43:18 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60792 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1HDKnR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:43:17 -0400
Received: by gyh3 with SMTP id 3so957821gyh.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8bEhsJXb6xinzd8tlCc/d1TTQ8CI/fYIq1poZLBBUZM=;
        b=AL9QA7+3hKuoXqWf/u7ToSIFl5QXuU24KrZxh+vav9Jd5IaGdsv1a8ooDKo4vOIAvz
         1yJPlrfSWalGs4+PDwNNUTUJgrO10z4EvBm0L0RXWWtgk4XG5ojeaHvgygPeBw9qyuCJ
         GeerUxNdkVoH2h8p7y5zSrpFj5Yr7SHt+lcx0=
Received: by 10.142.148.16 with SMTP id v16mr633028wfd.238.1312454595805;
        Thu, 04 Aug 2011 03:43:15 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id m7sm2090440pbk.6.2011.08.04.03.43.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 03:43:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178726>

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
 t/t3510-cherry-pick-sequence.sh |   29 +++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 54df8a2..308c1ce 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -64,6 +64,7 @@ struct replay_opts {
 #define SEQ_DIR         "sequencer"
 #define SEQ_HEAD_FILE   "sequencer/head"
 #define SEQ_TODO_FILE   "sequencer/todo"
+#define SEQ_OPTS_FILE   "sequencer/opts"
 
 static const char *action_name(const struct replay_opts *opts)
 {
@@ -695,6 +696,37 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
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
@@ -717,6 +749,7 @@ static int pick_commits(struct replay_opts *opts)
 		die(_("Can't cherry-pick into empty head"));
 	}
 	save_head(sha1_to_hex(sha1));
+	save_opts(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index a2c70ad..8ee0001 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -33,10 +33,35 @@ test_expect_success setup '
 
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
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
+	test_path_is_dir .git/sequencer &&
+	test_path_is_file .git/sequencer/head &&
+	test_path_is_file .git/sequencer/todo &&
+	test_path_is_file .git/sequencer/opts &&
+	echo "true" >expect &&
+	git config --file=.git/sequencer/opts --get-all options.signoff >actual &&
+	test_cmp expect actual &&
+	echo "1" >expect &&
+	git config --file=.git/sequencer/opts --get-all options.mainline >actual &&
+	test_cmp expect actual &&
+	echo "recursive" >expect &&
+	git config --file=.git/sequencer/opts --get-all options.strategy >actual &&
+	test_cmp expect actual &&
+	cat >expect <<-\EOF &&
+	patience
+	ours
+	EOF
+	git config --file=.git/sequencer/opts --get-all options.strategy-option >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'cherry-pick cleans up sequencer state upon success' '
-- 
1.7.6.351.gb35ac.dirty
