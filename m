From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/7] sequencer: teach parser about CHERRY_PICK_HEAD
Date: Sun, 13 Nov 2011 16:16:21 +0530
Message-ID: <1321181181-23923-8-git-send-email-artagnon@gmail.com>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:48:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXc1-0000WR-KP
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab1KMKsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 05:48:30 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50926 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab1KMKs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 05:48:29 -0500
Received: by mail-pz0-f42.google.com with SMTP id 36so9315254pzk.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UCTJv1qg7s6kNvofYsS4Kk+389kXDEPsL6IAlfDI8Wo=;
        b=CuKsbRttI5ExibfZ07ZF0Xw1zp4pb9XEJep0KuZhU9ZQoby/7fVo9CGpkqvKC9MT1p
         dHA2hOV5gnPtBgFSimDgBl94oyaiKmnpflROjWTUHJC52GU3Bd9Dp8xMuNs41Nc/j8GH
         nMc1JoBZKEur+EPsXbO7zlXUjp2QcDvG8Asa4=
Received: by 10.68.0.129 with SMTP id 1mr39797329pbe.94.1321181308870;
        Sun, 13 Nov 2011 02:48:28 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id g8sm28723464pbe.11.2011.11.13.02.48.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 02:48:28 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185337>

The final step in unifying the sequencer interface involves making
sure that a single-commit pick can be concluded with a '--continue'.

  $ git cherry-pick foo
  ... conflict ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git sequencer --continue

To do this, we have to update our parser that normally reads
'.git/sequencer/todo' to read '.git/CHERRY_PICK_HEAD' as a special
case before proceeding as usual.  Add a new test in
't3510-sequencer.sh' to make sure that this works.  Although we have
added a similar test for revert in the same patch for symmetry, the
test doesn't depend on this patch to work.  A single-commit revert
operation does not create a '.git/CHERRY_PICK_HEAD' at all: it uses
the information in '.git/sequencer' as usual.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c          |   32 ++++++++++++++++++++++++++++----
 t/t3510-sequencer.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7b10b7b..84df926 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -569,12 +569,32 @@ static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
 	return 0;
 }
 
-static void read_populate_todo(struct replay_insn_list **todo_list)
+static void read_populate_todo(struct replay_insn_list **todo_list, int cph_flag)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
 	int fd, res;
 
+	if (cph_flag) {
+		struct replay_insn_list item = {0, NULL, NULL};
+		const char *name = "CHERRY_PICK_HEAD";
+		const char *CHERRY_PICK_HEAD = git_path(name);
+
+		fd = open(CHERRY_PICK_HEAD, O_RDONLY);
+		if (fd < 0)
+			die_errno(_("Could not open %s."), CHERRY_PICK_HEAD);
+
+		item.action = REPLAY_PICK;
+		item.operand = lookup_commit_reference_by_name(name);
+
+		if (!item.operand)
+			die(_("could not lookup commit %s"), name);
+		replay_insn_list_append(item.action, item.operand, todo_list);
+		close(fd);
+		strbuf_release(&buf);
+		return;
+	}
+
 	fd = open(todo_file, O_RDONLY);
 	if (fd < 0)
 		die_errno(_("Could not open %s."), todo_file);
@@ -792,10 +812,14 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		remove_sequencer_state(1);
 		return 0;
 	} else if (opts->subcommand == REPLAY_CONTINUE) {
-		if (!file_exists(git_path(SEQ_TODO_FILE)))
-			goto error;
+		if (!file_exists(git_path(SEQ_TODO_FILE))) {
+			if (!file_exists(git_path("CHERRY_PICK_HEAD")))
+				goto error;
+			read_populate_todo(&todo_list, 1);
+		}
+		else
+			read_populate_todo(&todo_list, 0);
 		read_populate_opts(&opts);
-		read_populate_todo(&todo_list);
 
 		if (!index_differs_from("HEAD", 0))
 			todo_list = todo_list->next;
diff --git a/t/t3510-sequencer.sh b/t/t3510-sequencer.sh
index 65f2724..f7c3a37 100755
--- a/t/t3510-sequencer.sh
+++ b/t/t3510-sequencer.sh
@@ -45,6 +45,50 @@ test_expect_success '--continue complains when there are unresolved conflicts' '
 	test_must_fail git sequencer --continue
 '
 
+test_expect_success '--continue continues single-commit cherry-pick' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git sequencer --continue &&
+	test_path_is_missing .git/sequencer &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--continue continues single-commit revert' '
+	pristine_detach initial &&
+	test_must_fail git revert anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git sequencer --continue &&
+	test_path_is_missing .git/sequencer &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success '--continue continues after conflicts are resolved' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
-- 
1.7.6.351.gb35ac.dirty
