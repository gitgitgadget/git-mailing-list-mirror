From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 16/18] revert: Remove sequencer state when no commits are pending
Date: Tue, 19 Jul 2011 22:47:54 +0530
Message-ID: <1311095876-3098-17-git-send-email-artagnon@gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:20:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDxw-0003X7-Vh
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab1GSRUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:20:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48493 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1GSRUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:20:05 -0400
Received: by mail-pz0-f46.google.com with SMTP id 3so5220029pzk.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5l9HcIvmbb+xn4su0XBzVfeXMmyDIXUd9p5SNvF2MBk=;
        b=h/s85LhvyMkk2Fw3Q65YIuABvVs6dUkr0WLGUEvY0Yrhme+O1o4tiK/3Nz6udTGc3d
         U+GK2xiZ3hkVXAXUMpUSBjQGaAS6kNaNMQnfLvIgdbyXXkRQwk+3SMOEwokh3lxjTSxW
         aRmb14GzR/XmnYQKEu1vLUmjVx2ECjMZEIkLA=
Received: by 10.142.192.5 with SMTP id p5mr2424015wff.106.1311096004902;
        Tue, 19 Jul 2011 10:20:04 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.20.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:20:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177481>

When cherry-pick or revert is called on a list of commits, and a
conflict encountered somewhere in the middle, the data in
".git/sequencer" is required to continue the operation.  However, when
a conflict is encountered in the very last commit, the user will have
to "continue" after resolving the conflict and committing just so that
the sequencer state is removed.  This is how the current "rebase -i"
script works as well.

$ git cherry-pick foo..bar
... conflict encountered while picking "bar" ...
$ echo "resolved" >problematicfile
$ git add problematicfile
$ git commit
$ git cherry-pick --continue # This would be a noop

Change this so that the sequencer state is cleared when a conflict is
encountered in the last commit.  Incidentally, this patch makes sure
that some existing tests don't break when features like "--reset" and
"--continue" are implemented later in the series.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |   12 +++++++++++-
 t/t3510-cherry-pick-sequence.sh |   24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index bb82aa3..f23e9a3 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -887,8 +887,18 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
-		if (res)
+		if (res) {
+			if (!cur->next)
+				/*
+				 * An error was encountered while
+				 * picking the last commit; the
+				 * sequencer state is useless now --
+				 * the user simply needs to resolve
+				 * the conflict and commit
+				 */
+				remove_sequencer_state(0);
 			return res;
+		}
 	}
 
 	/*
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index aea4f6c..428b5bf 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -83,4 +83,28 @@ test_expect_success '--reset cleans up sequencer state' '
 	test_path_is_missing .git/sequencer
 '
 
+test_expect_success 'cherry-pick cleans up sequencer state when one commit is left' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..picked &&
+	test_path_is_missing .git/sequencer &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.4.rc1.7.g2cf08.dirty
