From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] sequencer: handle single commit pick separately
Date: Sat,  5 Nov 2011 21:59:45 +0530
Message-ID: <1320510586-3940-5-git-send-email-artagnon@gmail.com>
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
	id 1RMjA9-0005OF-Jx
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 17:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab1KEQb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 12:31:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53689 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab1KEQb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 12:31:57 -0400
Received: by mail-iy0-f174.google.com with SMTP id e36so3884876iag.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9xpH57dzQ27QapLg+nnD/nQK+aAFm9pHDy/e25h+IZQ=;
        b=UyLu8dz8yfrck5n2y88KpiIhTmBETWU2Evzh++QNUbusi9mFGa90vtZye73UqtMc8y
         0Telbs19QatfI9Od5hRhM/L29ksFfPSwWwqWryD4wGdFD8v7yapZIK4q/rij7bvtNrwk
         +rSqClc7K1JLDbP3wyrh+mXTc6rGUMyN/f4u4=
Received: by 10.42.156.9 with SMTP id x9mr26019076icw.42.1320510717323;
        Sat, 05 Nov 2011 09:31:57 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id p10sm19248815pbd.15.2011.11.05.09.31.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 09:31:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184864>

Don't write a '.git/sequencer/todo', as CHERRY_PICK_HEAD already
contains this information.  However, '.git/sequencer/opts' and
'.git/sequencer/head' are required to support '--reset' and
'--continue' operations.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 517eb23..6762ceb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -746,6 +746,15 @@ static int pick_commits(struct replay_insn_list *todo_list,
 				opts->record_origin || opts->edit));
 	read_and_refresh_cache(opts);
 
+	/*
+	 * Backward compatibility hack: when only a single commit is
+	 * picked, don't save_todo(), because CHERRY_PICK_HEAD will
+	 * contain this information anyway.
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
