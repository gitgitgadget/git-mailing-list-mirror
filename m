From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 15/18] revert: Remove sequencer state when no commits are pending
Date: Thu, 28 Jul 2011 22:22:28 +0530
Message-ID: <1311871951-3497-16-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:57:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTtJ-00049i-Pe
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab1G1Q4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:56:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34882 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab1G1Q4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:56:41 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so3015481iyb.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=63kyq/G+B7cCR3qj5gGdYyWrT7hhd3CPo7a0Rq3Yt00=;
        b=O240azT0sKWFiEfRt03yd8jB+n8OvAyIUbz01uZ4EoU1RorIZw+NYvKGZeWQi8rem0
         tQFTJemCXHX1z667wo/CR7t/mfNKNIKardkUQbeJdrZLn8X9IIk+eML0RLu5R3vmOAk9
         dYQ8lz30pqs4wMDoZcI/M9iHheiZxHYLbE/zM=
Received: by 10.42.132.199 with SMTP id e7mr158125ict.492.1311872201653;
        Thu, 28 Jul 2011 09:56:41 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.56.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:56:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178095>

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
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c                |   12 +++++++++++-
 t/t3510-cherry-pick-sequence.sh |   25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 70b9f65..80a2ef7 100644
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
index 49df209..528f270 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -85,4 +85,29 @@ test_expect_success '--reset cleans up sequencer state' '
 	test_path_is_missing .git/sequencer
 '
 
+test_expect_success 'cherry-pick cleans up sequencer state when one commit is left' '
+	git cherry-pick --reset &&
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
