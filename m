From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/18] revert: Save command-line options for continuing operation
Date: Thu, 28 Jul 2011 22:22:24 +0530
Message-ID: <1311871951-3497-12-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:56:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTtH-00049i-8v
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868Ab1G1Q40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:56:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34882 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab1G1Q4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:56:24 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so3015481iyb.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NOIPrT8V9Kv4fdibSP313x240sOeQrswtlemMm1h7+U=;
        b=KJ3ZmWIjdXizqiJOwRg0RJth9xtft9U0IeRQZgrwypw6LI8k2c72HZuyFBXSaAGFcu
         3JE2TubCybXAXL+2MyWEG0OSJhfjwcvDOBfGj1oJA6QX60dil4R0+gN0XeaPT6an8NVI
         IF2yXyTx2MwD69QCZsKbdn3grSIWnq3oJTZ6g=
Received: by 10.42.117.73 with SMTP id s9mr129700icq.455.1311872184617;
        Thu, 28 Jul 2011 09:56:24 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.56.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:56:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178089>

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

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c                |   35 +++++++++++++++++++++++++++++++++++
 t/t3510-cherry-pick-sequence.sh |   30 ++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b04cf39..f561f33 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -64,6 +64,7 @@ struct replay_opts {
 #define SEQ_DIR         "sequencer"
 #define SEQ_HEAD_FILE   "sequencer/head"
 #define SEQ_TODO_FILE   "sequencer/todo"
+#define SEQ_OPTS_FILE   "sequencer/opts"
 
 static const char *action_name(const struct replay_opts *opts)
 {
@@ -695,6 +696,39 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	strbuf_release(&buf);
 }
 
+static void save_opts(struct replay_opts *opts)
+{
+	const char *opts_file = git_path(SEQ_OPTS_FILE);
+	struct strbuf buf = STRBUF_INIT;
+	int i;
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
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%d", opts->mainline);
+		git_config_set_in_file(opts_file, "options.mainline", buf.buf);
+	}
+	if (opts->strategy)
+		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
+	if (opts->xopts) {
+		for (i = 0; i < opts->xopts_nr; i++)
+			git_config_set_multivar_in_file(opts_file,
+							"options.strategy-option",
+							opts->xopts[i], "^$", 0);
+	}
+
+	strbuf_release(&buf);
+}
+
 static int pick_commits(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
@@ -717,6 +751,7 @@ static int pick_commits(struct replay_opts *opts)
 		die(_("Can't cherry-pick into empty head"));
 	}
 	save_head(sha1_to_hex(sha1));
+	save_opts(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 890e59c..f3fab7d 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -32,10 +32,36 @@ test_expect_success setup '
 
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
