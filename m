From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/7] rebase -i: return control to the caller, for housekeeping
Date: Tue, 23 Apr 2013 19:32:02 +0530
Message-ID: <1366725724-1016-6-git-send-email-artagnon@gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:00:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUdm9-0001CS-FH
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab3DWOAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:00:49 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:41082 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab3DWOAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:00:47 -0400
Received: by mail-da0-f41.google.com with SMTP id p8so356889dan.28
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Q8S2BZrl+qg+Uaw3jHy3BHZwtJKqiLg/EM3jUutAvDQ=;
        b=eE79QyDjiS7hZqgaR+5u7/4p60Tl48xjtZhIknbC/Jl3oh+PZ1NoYK7Xk9DszGWx1u
         rdKWRXvnVw7BjpqwUaULUSQgM2TKYuqfvzqRjhhY7zya6fkRMjk+PSWyE3D1sPQ4EHs4
         oZvPbQiJ8fvP2vf6XWrYTvCchoL5i3odts4vj3SWY92A8wQme9s0/TWARuj99zfUxnPz
         mtET/Hofn7agXQM2dvP2CFuxqiImsbQf9oRbw1bRGcJAn0ykeFOVL2Jz4751vsXWwWuB
         ySQ5GeC7mksEv04YKTRVqyfx1OSAc9LTLNxuWNvyLBk37fzTyXsa8x3wXQ/T4BwZSl1p
         VbVg==
X-Received: by 10.68.105.33 with SMTP id gj1mr41479265pbb.13.1366725647300;
        Tue, 23 Apr 2013 07:00:47 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id vk7sm29634120pbc.41.2013.04.23.07.00.45
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 07:00:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.578.ga933817
In-Reply-To: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222161>

On a successful interactive rebase, git-rebase--interactive.sh
currently cleans up and exits on its own.  Instead of doing these
two things ourselves:

    rm -fr "$dotest"
    git gc --auto

let us return control to the caller (git-rebase.sh), to do the
needful.  The advantage of doing this is that the caller can implement
a generic cleanup routine (and possibly other things) independent of
specific rebases.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase--interactive.sh | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cc3a9a7..9514e31 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -597,7 +597,7 @@ do_next () {
 		fi
 		;;
 	esac
-	test -s "$todo" && return
+	test -s "$todo" && return 1
 
 	comment_for_reflog finish &&
 	newhead=$(git rev-parse HEAD) &&
@@ -623,17 +623,15 @@ do_next () {
 		"$GIT_DIR"/hooks/post-rewrite rebase < "$rewritten_list"
 		true # we don't care if this hook failed
 	fi &&
-	rm -rf "$state_dir" &&
-	git gc --auto &&
 	warn "Successfully rebased and updated $head_name."
 
-	exit
+	return 0
 }
 
 do_rest () {
 	while :
 	do
-		do_next
+		do_next && break
 	done
 }
 
@@ -799,12 +797,12 @@ first and then run 'git rebase --continue' again."
 	record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
 
 	require_clean_work_tree "rebase"
-	do_rest
+	do_rest && return 0
 	;;
 skip)
 	git rerere clear
 
-	do_rest
+	do_rest && return 0
 	;;
 edit-todo)
 	git stripspace --strip-comments <"$todo" >"$todo".new
-- 
1.8.2.1.578.ga933817
