From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] revert: Don't remove the sequencer state on error
Date: Wed, 10 Aug 2011 15:25:47 +0530
Message-ID: <1312970151-18906-2-git-send-email-artagnon@gmail.com>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 10 11:59:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qr5Z2-0001jE-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 11:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab1HJJ66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 05:58:58 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61802 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab1HJJ65 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 05:58:57 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1583833pzk.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iSvlY0o5GMKajfk63keitz81reT0gBT+ipJw2cDpKu8=;
        b=BKbREPaPHeWwkpAF0eVjy91Zah+AIynjNX/NCst0+wa7hvK0cG0HQlgT8Y5j48jkN8
         MzYwizXDsmTAI/RI2KJqMnFUoR0j3LLRTrrQ1sVXw2uHPlsNVQNYOsZRLCNCjABQlpRb
         x9ElzhEVwpUHK1GCvpvrx4kDf7E8TnJN7PRjA=
Received: by 10.142.152.23 with SMTP id z23mr7252406wfd.186.1312970337518;
        Wed, 10 Aug 2011 02:58:57 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id s7sm725394pbj.69.2011.08.10.02.58.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 02:58:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179058>

The cherry-pick/ revert machinery now removes the sequencer state when
do_pick_commit returns a non-zero, and when only one instruction is
left in the todo_list.  Since do_pick_commit has a way to distinguish
errors from conflicts using the signed-ness of the return value,
utilize this to ensure that the sequencer state is only removed when
there's a conflict and there is only one instruction left in the
todo_list.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8b452e8..a548a14 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -929,10 +929,10 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
 		if (res) {
-			if (!cur->next)
+			if (!cur->next && res > 0)
 				/*
-				 * An error was encountered while
-				 * picking the last commit; the
+				 * A conflict was encountered while
+				 * picking the last commit.  The
 				 * sequencer state is useless now --
 				 * the user simply needs to resolve
 				 * the conflict and commit
-- 
1.7.6.351.gb35ac.dirty
