From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 15/18] revert: Remove sequencer state when no commits are pending
Date: Mon,  1 Aug 2011 23:37:02 +0530
Message-ID: <1312222025-28453-16-git-send-email-artagnon@gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:12:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwz0-0004U5-28
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305Ab1HASMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:12:50 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62360 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab1HASMt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:12:49 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so11912645pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ajhpa72hepFwm1hU5kq2JFno5Og2eqhG882KTkWGStQ=;
        b=CgJT07qIOtsdo9ed1N4wYYAQ6ajEq/q1pJfyDQ7g+q99RSKdrIJR6WtJoiWUGDnyg0
         /iZM4nJ40BmfYdlhOFauktFJOG+xDMkmzH7/37LUnj2E/w3AwZ2Auviekjvl5yuSJ2sr
         wYGr1ho2pCmP1juY+a86TyA34ca1sS8A8wGkc=
Received: by 10.68.27.168 with SMTP id u8mr8647054pbg.447.1312222369094;
        Mon, 01 Aug 2011 11:12:49 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d3sm5789958pbh.37.2011.08.01.11.12.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:12:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178387>

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
  $ git cherry-pick --continue # This would be a no-op

Change this so that the sequencer state is cleared when a conflict is
encountered in the last commit.  Incidentally, this patch makes sure
that some existing tests don't break when features like "--reset" and
"--continue" are implemented later in the series.

A better way to implement this feature is to get the last "git commit"
to remove the sequencer state.  However, that requires tighter
coupling between "git commit" and the sequencer, a goal that can be
pursued once the sequencer is made more general.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c                |   12 +++++++++++-
 t/t3510-cherry-pick-sequence.sh |   24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2ddd7e7..ce57301 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -765,8 +765,18 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
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
index a3427a5..0b68397 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -82,4 +82,28 @@ test_expect_success '--reset cleans up sequencer state' '
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
