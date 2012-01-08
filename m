From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] revert: don't let revert continue a cherry-pick
Date: Sun,  8 Jan 2012 17:57:30 +0530
Message-ID: <1326025653-11922-4-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 13:29:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjrsg-0008M1-0x
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 13:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab2AHM3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 07:29:24 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab2AHM3U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 07:29:20 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5271273iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 04:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8aKACoM/snuc3Ge9zMlBxI2qc6Rw0YYRVp5P6vcgiW4=;
        b=dExIBrvcG1fiekgkmbbWdOjiL19hz+jl2F56kyIbWRSF1qT9Ddo1O+WoVhDHCqc63p
         0SHqDTkSvRK3X3cdMMlr2vo7JkjVotR2dSmLOUZH9iqyesQAAFUqhJQdv8FBeMN/Ei94
         ErTnxoUkSvTZko/IsWROQjuZLnSZ9oXAyg9DU=
Received: by 10.42.29.6 with SMTP id p6mr11794418icc.44.1326025760252;
        Sun, 08 Jan 2012 04:29:20 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id r5sm106707878igl.3.2012.01.08.04.29.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 04:29:19 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188108>

When we allow mixing "revert" and "pick" instructions in the same
sheet in the next patch, the following workflow would be perfectly
valid:

  $ git cherry-pick base..latercommit
  [conflict occurs]
  $ edit problematicfile
  $ git add problematicfile
  $ git revert --continue
  [finishes successfully]

This is confusing to the operator, because the sequencer is an
implementation detail hidden behind the 'git cherry-pick' and 'git
revert' builtins.  So, disallow this workflow by keeping track of the
builtin command executed (either "revert" or "cherry-pick") in
'.git/sequencer/cmd'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |   57 +++++++++++++++++++++++++++++++++++++++
 sequencer.h                     |    1 +
 t/t3510-cherry-pick-sequence.sh |   11 +++++++
 3 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 3ac6da0..52fa115 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -871,6 +871,50 @@ static int create_seq_dir(void)
 	return 0;
 }
 
+static enum replay_command read_cmd(void)
+{
+	const char *cmd_file = git_path(SEQ_CMD_FILE);
+	struct strbuf buf = STRBUF_INIT;
+	enum replay_command res;
+	int fd;
+
+	fd = open(cmd_file, O_RDONLY);
+	if (fd < 0)
+		die_errno(_("Could not open %s"), cmd_file);
+	if (strbuf_read(&buf, fd, 0) < 0) {
+		close(fd);
+		strbuf_release(&buf);
+		die(_("Could not read %s."), cmd_file);
+	}
+	close(fd);
+
+	if (!strcmp(buf.buf, "revert\n"))
+		res = REPLAY_CMD_REVERT;
+	else if (!strcmp(buf.buf, "cherry-pick\n"))
+		res = REPLAY_CMD_CHERRY_PICK;
+	else {
+		strbuf_release(&buf);
+		die(_("Malformed command file: %s"), cmd_file);
+	}
+	strbuf_release(&buf);
+	return res;
+}
+
+static void save_cmd(struct replay_opts *opts)
+{
+	const char *cmd_file = git_path(SEQ_CMD_FILE);
+	static struct lock_file cmd_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&cmd_lock, cmd_file, LOCK_DIE_ON_ERROR);
+	strbuf_addf(&buf, "%s\n", command_name(opts));
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		die_errno(_("Could not write to %s"), cmd_file);
+	if (commit_lock_file(&cmd_lock) < 0)
+		die(_("Error wrapping up %s."), cmd_file);
+}
+
 static void save_head(const char *head)
 {
 	const char *head_file = git_path(SEQ_HEAD_FILE);
@@ -1043,9 +1087,21 @@ static int continue_single_pick(void)
 static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
+	enum replay_command cmd;
 
 	if (!file_exists(git_path(SEQ_TODO_FILE)))
 		return continue_single_pick();
+
+	/*
+	 * Disallow continuing a cherry-pick with 'git revert
+	 * --continue' and viceversa
+	 */
+	cmd = read_cmd();
+	if (cmd != opts->command)
+		return error(_("cannot %s: a %s is in progress."),
+			command_name(opts),
+			cmd == REPLAY_CMD_REVERT ? "revert" : "cherry-pick");
+
 	read_populate_opts(&opts);
 	read_populate_todo(&todo_list, opts);
 
@@ -1126,6 +1182,7 @@ static int pick_revisions(struct replay_opts *opts)
 			return error(_("Can't revert as initial commit"));
 		return error(_("Can't cherry-pick into empty head"));
 	}
+	save_cmd(opts);
 	save_head(sha1_to_hex(sha1));
 	save_opts(opts);
 	return pick_commits(todo_list, opts);
diff --git a/sequencer.h b/sequencer.h
index 07e0639..00ab685 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -2,6 +2,7 @@
 #define SEQUENCER_H
 
 #define SEQ_DIR		"sequencer"
+#define SEQ_CMD_FILE	"sequencer/cmd"
 #define SEQ_HEAD_FILE	"sequencer/head"
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 97f3710..73298cf 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -48,6 +48,7 @@ test_expect_success 'cherry-pick persists data on failure' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick -s base..anotherpick &&
 	test_path_is_dir .git/sequencer &&
+	test_path_is_file .git/sequencer/cmd &&
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
 	test_path_is_file .git/sequencer/opts
@@ -69,6 +70,7 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	pristine_detach initial &&
 	test_expect_code 128 git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours initial..anotherpick &&
 	test_path_is_dir .git/sequencer &&
+	test_path_is_file .git/sequencer/cmd &&
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
 	test_path_is_file .git/sequencer/opts &&
@@ -517,4 +519,13 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 	test_line_count = 4 commits
 '
 
+test_expect_success 'revert --continue refuses to follow cherry-pick' '
+       pristine_detach initial &&
+       test_expect_code 1 git cherry-pick base..anotherpick &&
+       echo "c" >foo &&
+       git add foo &&
+       git commit &&
+       test_expect_code 128 git revert --continue
+'
+
 test_done
-- 
1.7.8.2
