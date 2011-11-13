From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/7] sequencer: handle cherry-pick conflict in last commit
Date: Sun, 13 Nov 2011 16:16:18 +0530
Message-ID: <1321181181-23923-5-git-send-email-artagnon@gmail.com>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:48:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXbq-0000Ss-O3
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab1KMKsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 05:48:19 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50926 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab1KMKsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 05:48:16 -0500
Received: by mail-pz0-f42.google.com with SMTP id 36so9315254pzk.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5afQL0ZD45DaCGcVnyMM8jMolw0QzfEAel9SV2Rl2RY=;
        b=lNGm5ExpV64R09oQxTTcymOebJY/YHg6dXwUrBuzwf9mugnWCWUab8zu8bKUevvDQs
         v/DIQowdFkaDb/Pnmj+XitZ08a/1EGEEdeALAUpQ1imuQmfEdTE9bfaHUm27SKTQz2eg
         p2zADuyM+92rqk2eu+jilFddX+chPHy25Caws=
Received: by 10.68.72.168 with SMTP id e8mr40167360pbv.127.1321181296563;
        Sun, 13 Nov 2011 02:48:16 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id g8sm28723464pbe.11.2011.11.13.02.48.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 02:48:15 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185332>

The previous two commits in the series implement special handling for
the single-commit cherry-pick case.  Although we can technically
revert the changes made by d3f4628e (revert: Remove sequencer state
when no commits are pending, 2011-06-06) without breaking any existing
tests now, there is one pending corner case: when a cherry-pick is
invoked on a commit range, and a conflict that occurs in the last
commit is concluded with a 'git commit'.  Without d3f4628e, we'd have
the following unpleasant case:

  $ git cherry-pick foo..bar
  ... .git/sequencer is created ...
  ... .git/CHERRY_PICK_HEAD is created ...
  ... conflict in bar ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git commit
  ... .git/CHERRY_PICK_HEAD is removed ...
  $ git cherry-pick moo
  error: An existing cherry-pick or revert is in progress
  $ git cherry-pick --continue
  ... .git/sequencer is removed ...
  # We're in pristine shape now

While prematurely removing the entire sequencer state is an overkill,
we can revise our plan: prematurely remove only '.git/sequencer/todo'
in the 'REPLAY_PICK' case, because this is the exact case where the
information in '.git/sequencer/todo' can be inferred from
'.git/CHERRY_PICK_HEAD'.  This will be compatible with our future plan
to implement '--continue' and '--reset' consistently.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c                     |    8 +++-----
 t/t3510-cherry-pick-sequence.sh |    4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b35fcc7..23fd3fe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -753,15 +753,13 @@ static int pick_commits(struct replay_insn_list *todo_list,
 		save_todo(cur);
 		res = do_pick_commit(cur->operand, cur->action, opts);
 		if (res) {
-			if (!cur->next)
+			if (!cur->next && opts->action == REPLAY_PICK)
 				/*
 				 * An error was encountered while
 				 * picking the last commit; the
-				 * sequencer state is useless now --
-				 * the user simply needs to resolve
-				 * the conflict and commit
+				 * sequencer todo is useless now.
 				 */
-				remove_sequencer_state(0);
+				unlink(git_path(SEQ_TODO_FILE));
 			return res;
 		}
 	}
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 4b12244..09b9e65 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -85,10 +85,10 @@ test_expect_success '--reset cleans up sequencer state' '
 	test_path_is_missing .git/sequencer
 '
 
-test_expect_success 'cherry-pick cleans up sequencer state when one commit is left' '
+test_expect_success 'cherry-pick cleans up sequencer todo when one commit is left' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..picked &&
-	test_path_is_missing .git/sequencer &&
+	test_path_is_missing .git/sequencer/todo &&
 	echo "resolved" >foo &&
 	git add foo &&
 	git commit &&
-- 
1.7.6.351.gb35ac.dirty
