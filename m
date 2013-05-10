From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/8] rebase -i: return control to caller, for housekeeping
Date: Fri, 10 May 2013 19:56:43 +0530
Message-ID: <1368196005-5354-7-git-send-email-artagnon@gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:25:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoGQ-0007Mj-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756444Ab3EJOZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:25:32 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:39108 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab3EJOZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:25:23 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq12so2952566pab.40
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bpKH1SisYOC3N/EgdgS+jSTx3+Y15CAfs3R8nE7fHqI=;
        b=WB0hsAkNQyUOrzwPPu15PhAMVHCfmnTDMzeb9jueMI1LajrgJjlg8eMPr3X2h12Rul
         BvjqlwJDEKhwyx6Cils1oAXBWKZXLK9wjdjQqOdV1ku6vW74S1KjI53awCYU8wUlHRee
         YEHSTlddZEksl26/cPIMFkOlPWrEZYNr/pIV3COieuZa0/6UtETuI56S3udeeP8oAX95
         GPXotyrIfDCulASgXWPktxzBbxGAWFLhJAQFuQUKD4UphnxbBdDtSRyfS7aRk29zqiFz
         oxb3rAXY2QRDb9k5dLjbv4CkfGboNW3o50u0YRZ23hB8vz8BJ1BLdf0J08+qbeZPJxPo
         qYiQ==
X-Received: by 10.68.87.229 with SMTP id bb5mr17410498pbb.171.1368195922863;
        Fri, 10 May 2013 07:25:22 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id nt2sm2915928pbc.17.2013.05.10.07.25.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:25:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223843>

Return control to the caller git-rebase.sh to get these two tasks

    rm -fr "$dotest"
    git gc --auto

done by it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase--interactive.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3411139..f953d8d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -628,17 +628,16 @@ do_next () {
 		"$GIT_DIR"/hooks/post-rewrite rebase < "$rewritten_list"
 		true # we don't care if this hook failed
 	fi &&
-	rm -rf "$state_dir" &&
-	git gc --auto &&
 	warn "Successfully rebased and updated $head_name."
 
-	exit
+	return 1 # not failure; just to break the do_rest loop
 }
 
+# can only return 0, when the infinite loop breaks
 do_rest () {
 	while :
 	do
-		do_next
+		do_next || break
 	done
 }
 
@@ -805,11 +804,13 @@ first and then run 'git rebase --continue' again."
 
 	require_clean_work_tree "rebase"
 	do_rest
+	return 0
 	;;
 skip)
 	git rerere clear
 
 	do_rest
+	return 0
 	;;
 edit-todo)
 	git stripspace --strip-comments <"$todo" >"$todo".new
-- 
1.8.3.rc1.52.gc14258d
