From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/7] rebase -i: return control to caller, for housekeeping
Date: Sun, 12 May 2013 17:26:39 +0530
Message-ID: <1368359801-28121-6-git-send-email-artagnon@gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 12 13:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbUt6-00023w-Eq
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 13:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab3ELL4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 07:56:21 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:46225 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab3ELL4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 07:56:19 -0400
Received: by mail-da0-f41.google.com with SMTP id y19so3092338dan.0
        for <git@vger.kernel.org>; Sun, 12 May 2013 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=TonY7c663pvqdbYbGnwErkJDjj27js0/4eWr/c0RcAQ=;
        b=sBx4kPbG29n+DBW32Ie3BpLsQGtfA6dS2CMdAGzlBbd0IdherKybuMSIzCeF9SRWSC
         HIvDGbLJUr/YX2s2+AZ319tNJHM2nFAor8aE00WOJdaGvc2HlqlMtpxPHPDhlvQRtJMO
         3cv87wsxQ+3oR8g0DPZ7a1HhpS+PvNgzPlTjrTKmiBVfzP11pThTWgYGlrjEzqbUgnVn
         YcRnLjbOpcImqIt0ZaamlWRIXdaCXTz2hnvh7rjKkq8ztG46n4RSH/lOJ3B5SRw6LwZx
         uHkoAPl7V4Ac/bLXwo733H/BKqy+5lbsBxU8ErIq4spBlYHc3a5wV4qiAPAIi8lbVfiS
         OTLA==
X-Received: by 10.68.196.100 with SMTP id il4mr24831417pbc.170.1368359778683;
        Sun, 12 May 2013 04:56:18 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.41])
        by mx.google.com with ESMTPSA id iy2sm9911078pbb.31.2013.05.12.04.56.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 May 2013 04:56:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.51.gd7a04de
In-Reply-To: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224039>

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
1.8.3.rc1.51.gd7a04de
