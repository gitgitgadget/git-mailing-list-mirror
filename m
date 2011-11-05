From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] sequencer: revert d3f4628e
Date: Sat,  5 Nov 2011 21:59:46 +0530
Message-ID: <1320510586-3940-6-git-send-email-artagnon@gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 05 17:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMjAA-0005OF-57
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 17:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab1KEQcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 12:32:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49229 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab1KEQcE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 12:32:04 -0400
Received: by gyc15 with SMTP id 15so2531906gyc.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4gIKmkTaDJovZeQetzm/sbF0zZH1DPxwGQRwIPcqCEA=;
        b=xKSf9nHnqaLK7+SEzsXrVFw3HFrAqSw69JPhYBQLTpGS9uTuMSqpDp3z2BDIxbME8W
         YHqehgLA8Dh1o4206xi4+FwiH+uE7UoaPU+NFgkKvZv+grpdHyKoJ2OpQVCrm3wj6T54
         xr9FHzDoQ/3a+GA+78igrabqNq97/2yQ4nzdg=
Received: by 10.50.203.70 with SMTP id ko6mr23217536igc.19.1320510721499;
        Sat, 05 Nov 2011 09:32:01 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id p10sm19248815pbd.15.2011.11.05.09.31.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 09:32:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184863>

Revert d3f4628e (revert: Remove sequencer state when no commits are
pending, 2011-06-06), because this is not the right approach.  Instead
of increasing coupling between the sequencer and 'git commit', a
unified '--continue' that invokes 'git commit' on behalf of the
end-user is preferred.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c                     |   12 +-----------
 t/t3510-cherry-pick-sequence.sh |   24 ------------------------
 2 files changed, 1 insertions(+), 35 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6762ceb..7caa550 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -758,18 +758,8 @@ static int pick_commits(struct replay_insn_list *todo_list,
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur);
 		res = do_pick_commit(cur->operand, cur->action, opts);
-		if (res) {
-			if (!cur->next)
-				/*
-				 * An error was encountered while
-				 * picking the last commit; the
-				 * sequencer state is useless now --
-				 * the user simply needs to resolve
-				 * the conflict and commit
-				 */
-				remove_sequencer_state(0);
+		if (res)
 			return res;
-		}
 	}
 
 	/*
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 4b12244..b30f13a 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -85,30 +85,6 @@ test_expect_success '--reset cleans up sequencer state' '
 	test_path_is_missing .git/sequencer
 '
 
-test_expect_success 'cherry-pick cleans up sequencer state when one commit is left' '
-	pristine_detach initial &&
-	test_must_fail git cherry-pick base..picked &&
-	test_path_is_missing .git/sequencer &&
-	echo "resolved" >foo &&
-	git add foo &&
-	git commit &&
-	{
-		git rev-list HEAD |
-		git diff-tree --root --stdin |
-		sed "s/$_x40/OBJID/g"
-	} >actual &&
-	cat >expect <<-\EOF &&
-	OBJID
-	:100644 100644 OBJID OBJID M	foo
-	OBJID
-	:100644 100644 OBJID OBJID M	unrelated
-	OBJID
-	:000000 100644 OBJID OBJID A	foo
-	:000000 100644 OBJID OBJID A	unrelated
-	EOF
-	test_cmp expect actual
-'
-
 test_expect_success 'cherry-pick does not implicitly stomp an existing operation' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
-- 
1.7.6.351.gb35ac.dirty
