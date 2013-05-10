From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/8] am: return control to caller, for housekeeping
Date: Fri, 10 May 2013 19:56:42 +0530
Message-ID: <1368196005-5354-6-git-send-email-artagnon@gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:25:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoGM-0007Fp-8V
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404Ab3EJOZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:25:24 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:65222 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237Ab3EJOZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:25:21 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so2971008pab.31
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nQbp5sq9dkwj0/BzHtAi6PW3Hc/dacqDx+zqGQlQsHM=;
        b=BwPodkas6f2sA0AEPpDHj8sTYbHIVO6HyrYdgq8tVRkwPX9F63FMntdSo1cZ/drlaN
         Od1Hfda4uYyCCsZT98K2lUI63F4Rv0k12dON6kxoBF+setsrhHS29j9oe4EScFv6z6BL
         KVEl6bRyBjh3BDuJsefYiTQkDfhHUFaVinXpGLhhK+AE0yOeiOmZ8xBaLNnBu5S15Aob
         KVTYZ3uvWqVUx/H9UfmRhDArWQEFamYnYm1zxb1e0pQ976uwmsl6JBvNDWupCQbwXrGN
         jDVIW/5TQG1Tf1Szhf4q4FHYgYVT4442ImV/xZg2Jg+5U0GarapbruITcEwV20OtzV4X
         fYwQ==
X-Received: by 10.66.248.163 with SMTP id yn3mr18043901pac.39.1368195920595;
        Fri, 10 May 2013 07:25:20 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id nt2sm2915928pbc.17.2013.05.10.07.25.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:25:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223842>

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
1.8.3.rc1.52.gc14258d
