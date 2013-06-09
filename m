From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 32/36] rebase: use 'cherrypick' mode instead of 'am'
Date: Sun,  9 Jun 2013 14:24:46 -0500
Message-ID: <1370805890-3453-33-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllI2-00048m-Ok
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab3FIT2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:20 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:52678 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab3FIT2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:28:16 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so5130192oag.9
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Un7Atk2KZ2G1nx+PWkllZHuE0MgVqDV3BbaXapFyqYw=;
        b=IcjH9otpPU6U4RObER2iJp8VoX61OY032irhRjtEG5+TgtoerJRZl/XsLHxTTvLplx
         mToYfQ6yEr8rw0cT6/ZwBrrzfK7OMl30EFOaXqN0FRcYVBY6Ardn0G+dMNMid1hxG3r6
         0CwkxR2V8aZeuYRG99ppS+a1CGKMgQfYdz+18P3TUtaKdsx5MhsLSvGiWP5xcHEvULSC
         7/c5hQnLZqF1cvw2VJZfEvF8AsJOIP6yJUuPUQYEbaagoiSlp0nDDHa1mFZ2Ny5UE8+X
         vDbFZCdSjOF1iUUFy3+QacNnjRZuGbiiMrKFO4kE68fD/Z0saE7bZbo5N5/GZx90PvYx
         ARjQ==
X-Received: by 10.60.54.194 with SMTP id l2mr5532198oep.52.1370806095792;
        Sun, 09 Jun 2013 12:28:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm16293059oel.2.2013.06.09.12.28.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:28:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227140>

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
