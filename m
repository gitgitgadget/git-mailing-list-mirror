From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 15/17] revert: Remove sequencer state when no commits are pending
Date: Mon, 11 Jul 2011 14:54:06 +0000
Message-ID: <1310396048-24925-16-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:55:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHtF-0005dD-An
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757887Ab1GKOyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:47 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46637 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757874Ab1GKOyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:38 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so2716724vxb.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NedJk1Qa1cKn8d/4K4XNykUDzIc1EcXEeam230A0tpI=;
        b=Vn5HYXwKctvJGjNhoryGsUxAfrQFWgag3+9DWLYr15nwuxLJF4zwIlDbJ7QBSTGf1a
         TnbucZNDzB+2nKlTSXy1psPfXF/vuXt8+Ms3azRolzXpzm5VVIjUiYGGyKP6p8YYldY1
         xgzhPpAbf6RupCo7h1wHny6SCWKscsNRBEFqA=
Received: by 10.52.155.135 with SMTP id vw7mr627279vdb.238.1310396077528;
        Mon, 11 Jul 2011 07:54:37 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176858>

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
 t/t3510-cherry-pick-sequence.sh |   25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f9f5e3a..3936516 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -990,8 +990,18 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
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
+				remove_sequencer_state();
 			return res;
+		}
 	}
 
 	/*
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 100cbb1..0a8b093 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -63,4 +63,29 @@ test_expect_success 'cherry-pick cleans up sequencer state upon success' '
 	test_path_is_missing .git/sequencer
 '
 
+test_expect_success 'cherry-pick cleans up sequencer state when one commit is left' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	test_path_is_missing .git/sequencer &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/[0-9a-f]\{40\}/OBJID/g"
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
1.7.5.GIT
