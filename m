From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/7] am: don't do housekeeping when rebasing
Date: Tue, 23 Apr 2013 19:32:01 +0530
Message-ID: <1366725724-1016-5-git-send-email-artagnon@gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:00:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUdm8-0001CS-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab3DWOAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:00:46 -0400
Received: from mail-da0-f45.google.com ([209.85.210.45]:49647 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab3DWOAp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:00:45 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so353184dad.18
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=IaHDlU/OVDeafM7vVBYi/StYeuzeAbQkmNCK/kF/TuE=;
        b=sZzQVz/kFKFgB8QtF/LvFZlgekcHIeagK5j0A23ivJPiK4rB6shcomJNHgOZFwUP7F
         GWpvxyrdH8YKU8rT82sFsXnTXeRSGhqaRaqgLQO2ylPOOVvDBhuPW0ud4ODK/Sx4Cjl6
         OnKYjtGMfMMTVAXTr6EA0jRf5c2umQwkUpqm67fYl3S5sYR03BkI9zXfJRFSaoqqOnAO
         Bsp2vQrC1+06YkI3zb/KoACpHT0a9TBgS798+wmaBoIYuJGhMOdVGEdMeE3STfsB/Vz1
         M+BE5SV6Uk15Ukm47NtTkVyN/YprZ62hiO+E800PwhHPJZWzvYbO93BrW5GzeqetgV6D
         Z4WQ==
X-Received: by 10.68.88.129 with SMTP id bg1mr40829256pbb.10.1366725645112;
        Tue, 23 Apr 2013 07:00:45 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id vk7sm29634120pbc.41.2013.04.23.07.00.43
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 07:00:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.578.ga933817
In-Reply-To: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222160>

Perform these two tasks:

    git gc --auto
    rm -fr "$dotest"

only when not called with --rebasing (from git-rebase--am.sh).
Otherwise, return control to the caller so that it can do the needful.
The advantage of doing this is that the caller can implement a generic
cleanup routine (that possibly does other things) independent of
specific rebases.

Patch the ultimate caller, git-rebase.sh, to perform these two steps
for the moment.  Later patches will add functionality.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh         | 9 +++++++--
 git-rebase--am.sh | 8 ++++----
 git-rebase.sh     | 7 +++++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index f4ef8fc..47c1021 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -904,5 +904,10 @@ if test -s "$dotest"/rewritten; then
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
index f84854f..8230094 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -7,12 +7,12 @@ case "$action" in
 continue)
 	git am --resolved --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
-	exit
+	return $?
 	;;
 skip)
 	git am --skip --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
-	exit
+	return $?
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
diff --git a/git-rebase.sh b/git-rebase.sh
index b2f1c76..8412d81 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -150,6 +150,13 @@ run_specific_rebase () {
 		autosquash=
 	fi
 	. git-rebase--$type
+	ret=$?
+	if test $ret = 0
+	then
+		git gc --auto &&
+		rm -rf "$state_dir"
+	fi
+	exit $ret
 }
 
 run_pre_rebase_hook () {
-- 
1.8.2.1.578.ga933817
