From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 32/45] rebase: use 'cherrypick' mode instead of 'am'
Date: Sun,  9 Jun 2013 11:40:44 -0500
Message-ID: <1370796057-25312-33-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:45:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulik7-0007uc-Hk
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab3FIQpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:45:17 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:64863 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab3FIQoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:22 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8852967obc.20
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Un7Atk2KZ2G1nx+PWkllZHuE0MgVqDV3BbaXapFyqYw=;
        b=so14UY0IofV+w7GiFvTeJPpeJdMmCmTPllVAp+8M/EhaXoQRYxZ6U4vzWt7GgUX7wH
         qUAZBjsrm8M0ySjG/btAV6xqS9jakejcpvCvzbWKF0Z9WqNwdCRVxfMjrHVtzxhDeXZe
         Aw3lYZQ7hojx7pcEAbd3Wvi8hBZPgi0YS+ucDHGkUrIn6T1qhmlXfzN/bJyAKoempjb0
         sGB0cHWoo+scmQG08AsIuIvTGMscQPSD7dqAzsCpdbVhp7X2Ysv9dpWxwe2xBZxTeHI5
         FRgoHAC1AFdKtfQFjnotI8nPytUX2ksWAQYfZV+XAqHJsDjXdCBpEagndgzy613yyTrm
         2mcg==
X-Received: by 10.182.129.4 with SMTP id ns4mr5358277obb.22.1370796261593;
        Sun, 09 Jun 2013 09:44:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm14969107obl.1.2013.06.09.09.44.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227015>

Unless any specific 'git am' options are used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh       | 2 ++
 git-rebase.sh                          | 8 ++++----
 t/t3407-rebase-abort.sh                | 2 +-
 t/t3420-rebase-autostash.sh            | 2 +-
 t/t5520-pull.sh                        | 2 +-
 t/t9106-git-svn-commit-diff-clobber.sh | 2 +-
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 86a4f3f..3a14665 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -352,6 +352,8 @@ __git_ps1 ()
 			total=$(cat "$g/rebase-merge/end")
 			if [ -f "$g/rebase-merge/interactive" ]; then
 				r="|REBASE-i"
+			elif [ -f "$g/rebase-merge/cherrypick" ]; then
+				r="|REBASE"
 			else
 				r="|REBASE-m"
 			fi
diff --git a/git-rebase.sh b/git-rebase.sh
index 6be247d..f2efff9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -416,13 +416,13 @@ elif test -n "$do_merge"
 then
 	type=merge
 	state_dir="$merge_dir"
-elif test -n "$keep_empty"
+elif test -n "$git_am_opt"
 then
-	type=cherrypick
-	state_dir="$merge_dir"
-else
 	type=am
 	state_dir="$apply_dir"
+else
+	type=cherrypick
+	state_dir="$merge_dir"
 fi
 
 if test -z "$rebase_root"
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index a6a6c40..2699b08 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -96,7 +96,7 @@ testrebase() {
 	'
 }
 
-testrebase "" .git/rebase-apply
+testrebase "" .git/rebase-merge
 testrebase " --merge" .git/rebase-merge
 
 test_done
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 479cbb2..a5e69f3 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -141,7 +141,7 @@ testrebase() {
 	'
 }
 
-testrebase "" .git/rebase-apply
+testrebase "" .git/rebase-merge
 testrebase " --merge" .git/rebase-merge
 testrebase " --interactive" .git/rebase-merge
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 6af6c63..ec2373b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -244,7 +244,7 @@ test_expect_success 'setup for avoiding reapplying old patches' '
 test_expect_success 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
 	 test_must_fail git pull --rebase &&
-	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+	 test 1 = $(cat .git/sequencer/todo | wc -l)
 	)
 '
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index f6d7ac7..b9cec33 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -92,7 +92,7 @@ test_expect_success 'multiple dcommit from git svn will not clobber svn' "
 
 
 test_expect_success 'check that rebase really failed' '
-	test -d .git/rebase-apply
+	test -d .git/rebase-merge
 '
 
 test_expect_success 'resolve, continue the rebase and dcommit' "
-- 
1.8.3.698.g079b096
