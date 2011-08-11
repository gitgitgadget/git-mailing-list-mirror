From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] revert: Don't remove the sequencer state on error
Date: Fri, 12 Aug 2011 00:21:40 +0530
Message-ID: <1313088705-32222-2-git-send-email-artagnon@gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 11 20:54:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QraP6-0002yw-BV
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 20:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab1HKSyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 14:54:46 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63951 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab1HKSyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 14:54:45 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so4115440pzk.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iSvlY0o5GMKajfk63keitz81reT0gBT+ipJw2cDpKu8=;
        b=aAahXIGQ5MenvOiPhuWcz50g9zRddFHxGCSkl8UApvITSzHjtF3cS7MuXIm+okz+0a
         EDT4Uvd2/5UEr8ddvWQzhqzVJjN5jQzXImxyONgjgVPMS5MchQcbVQonft2UNvB585BC
         Fzy+qnD387Ml7CY8LwALxzLjsgnpyGSIy+IlU=
Received: by 10.142.143.12 with SMTP id q12mr5591210wfd.380.1313088885204;
        Thu, 11 Aug 2011 11:54:45 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t7sm1117355wfl.2.2011.08.11.11.54.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 11:54:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179129>

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
