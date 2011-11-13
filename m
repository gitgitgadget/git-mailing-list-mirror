From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/7] sequencer: handle single-commit pick as special case
Date: Sun, 13 Nov 2011 16:16:17 +0530
Message-ID: <1321181181-23923-4-git-send-email-artagnon@gmail.com>
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
	id 1RPXbq-0000Ss-7z
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab1KMKsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 05:48:16 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50926 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab1KMKsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 05:48:13 -0500
Received: by mail-pz0-f42.google.com with SMTP id 36so9315254pzk.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qZf8I7+HfQJhj3MS2t2nAu7P5Vaj6Q7iw9tUySU2CUY=;
        b=uE4AVBdVU4gUEG+nvPy1k2zMAvjgtaysrDp3PO7/aFM32BnhMeq5P0mHx+s3z16HZ8
         Q/DGccDxxpbf3xeHQCy6w3LzMzmkUJAj1sZf+RWuRY0x4PDk5r73ku3IUUn2JnHn/21f
         FBPQSLEFJU6s4fYR8gvGwDC15/9z6FwwjFcVY=
Received: by 10.68.39.98 with SMTP id o2mr40805720pbk.119.1321181292665;
        Sun, 13 Nov 2011 02:48:12 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id g8sm28723464pbe.11.2011.11.13.02.48.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 02:48:11 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185333>

Prior to v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than one
commit, 2010-06-02), 'git cherry-pick' could only pick one commit at a
time, and it used '.git/CHERRY_PICK_HEAD' to pass on information to a
subsequent invocation in case of a conflict.  While
'.git/CHERRY_PICK_HEAD' can only keep information about one commit,
the sequencer uses '.git/sequencer' to persist information in the
general case.

A problem arises because a single-commit cherry-pick operation can be
completed successfully using 'git commit'.  This removes
'.git/CHERRY_PICK_HEAD' without informing the sequencer, leaving
behind a stale sequencer state as a result.  We have worked around
this problem already by prematurely removing the sequencer state in
d3f4628e (revert: Remove sequencer state when no commits are pending,
2011-06-06).  However, this gets in the way of our future plan to
eliminate a glaring workflow inconsistency:

  $ git cherry-pick foo
  ... .git/sequencer is created ....
  ... .git/CHERRY_PICK_HEAD is created ...
  ... conflict ...
  .... .git/sequencer is prematurely removed ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git commit
  ... .git/CHERRY_PICK_HEAD is removed ...
  $ git cherry-pick --continue
  error: No cherry-pick in progress

  $ git cherry-pick foo..bar
  ... .git/sequencer is created ....
  ... CHERRY_PICK_HEAD is created ...
  ... conflict in bar~1 ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git commit
  ... CHERRY_PICK_HEAD is removed ...
  $ git cherry-pick --continue # Success!

To eliminate this inconsistency, we have decided to make '--continue'
continue any general sequencer operation bypassing 'git commit'
completely (although preserving the existing workflow for backward
compatibility).  For '--continue' and '--reset' to work uniformly,
they must use the information in:

1. '.git/sequencer/head', '.git/sequencer/opts', '.git/sequencer/todo'
   in the general case.
2. '.git/sequencer/head', '.git/sequencer/opts', '.git/CHERRY_PICK_HEAD'
   in case of a single-commit cherry-pick.

As a start, handle cherry-picking a single commit as a special case by
not creating '.git/sequencer/todo' in the first place.  This will
eliminate the need for prematurely removing it in d3f4628e.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8b2518c..b35fcc7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -741,6 +741,14 @@ static int pick_commits(struct replay_insn_list *todo_list,
 				opts->record_origin || opts->edit));
 	read_and_refresh_cache(opts);
 
+	/*
+	 * Backward compatibility hack: handle single-commit pick as a
+	 * special case.
+	 */
+	if (opts->subcommand == REPLAY_NONE &&
+		todo_list->next == NULL && todo_list->action == REPLAY_PICK)
+		return do_pick_commit(todo_list->operand, REPLAY_PICK, opts);
+
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur);
 		res = do_pick_commit(cur->operand, cur->action, opts);
-- 
1.7.6.351.gb35ac.dirty
