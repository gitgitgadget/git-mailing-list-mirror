From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/7] am: return control to caller, for housekeeping
Date: Sun, 12 May 2013 17:26:38 +0530
Message-ID: <1368359801-28121-5-git-send-email-artagnon@gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 12 13:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbUt5-00023w-Fz
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 13:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab3ELL4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 07:56:19 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:50831 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab3ELL4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 07:56:17 -0400
Received: by mail-da0-f52.google.com with SMTP id o9so1813465dan.11
        for <git@vger.kernel.org>; Sun, 12 May 2013 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=rtiife9AAC6yScwZ3i4G/nRFlV4Fzg2MSEjeJaP4cko=;
        b=vEVz3+R13bvBZONMkyo+amMB3BVx6rkhu/fr7T4Ly8XbYuuk55TftGMPwiQXMwyLB5
         faMy3yIswz9bUqGyc18l7+e7u1Id17gKMfOLcuE8KYmnQe6sp8aMgZcIVdWl9OyKQbKE
         WxJet2seguCofTgOqtYPPACDfSa/a/qlCaB/9wxIGTcE2RR844C+TEhzjjWE+TqdRkpb
         ocmr750KxMvo9Nfo3QU6QfjSjzJ3JgKmo5SbHrZqgj3AmdDSOj7VdxELPUuPVhFbxEZp
         gtq6seXCtPWozkb/alA2mb/+dQHmunHRJEaZLsuBtkdH+6QUmhhIYOXtDjgLs/n8F2aT
         DBfg==
X-Received: by 10.68.231.65 with SMTP id te1mr24717290pbc.98.1368359776516;
        Sun, 12 May 2013 04:56:16 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.41])
        by mx.google.com with ESMTPSA id iy2sm9911078pbb.31.2013.05.12.04.56.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 May 2013 04:56:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.51.gd7a04de
In-Reply-To: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224037>

We only need to do these two tasks

    git gc --auto
    rm -fr "$dotest"

ourselves if the script was invoked as a standalone program; when
invoked with --rebasing (from git-rebase--am.sh), cascade control back
to the ultimate caller git-rebase.sh to do this for us.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh         | 9 +++++++--
 git-rebase--am.sh | 8 ++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ccb854a..1cf3d1d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -906,5 +906,10 @@ if test -s "$dotest"/rewritten; then
     fi
 fi
 
-rm -fr "$dotest"
-git gc --auto
+# If am was called with --rebasing (from git-rebase--am), it's up to
+# the caller to take care of housekeeping.
+if ! test -f "$dotest/rebasing"
+then
+	rm -fr "$dotest"
+	git gc --auto
+fi
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index f84854f..34e3102 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -7,12 +7,12 @@ case "$action" in
 continue)
 	git am --resolved --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
-	exit
+	return
 	;;
 skip)
 	git am --skip --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
-	exit
+	return
 	;;
 esac
 
@@ -56,7 +56,7 @@ else
 
 		As a result, git cannot rebase them.
 		EOF
-		exit $?
+		return $?
 	fi
 
 	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
@@ -68,7 +68,7 @@ fi
 if test 0 != $ret
 then
 	test -d "$state_dir" && write_basic_state
-	exit $ret
+	return $ret
 fi
 
 move_to_original_branch
-- 
1.8.3.rc1.51.gd7a04de
