From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 8/8] rebase: use 'cherrypick' mode instead of 'am'
Date: Tue, 28 May 2013 23:16:40 -0500
Message-ID: <1369801000-3705-9-git-send-email-felipe.contreras@gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 06:18:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXqc-0002So-5b
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935003Ab3E2ESr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 00:18:47 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36395 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933908Ab3E2ESp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 00:18:45 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so765516obc.40
        for <git@vger.kernel.org>; Tue, 28 May 2013 21:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pk9GlZ6vEKR999zeiRbt2TO16nQrN3g92HwFB5I0bCQ=;
        b=AZEZDeRDLSkOebvMdntNUW2uhlmpz/0eH4bclX7MyzNpJvFz78T2lwse+YqKueWj9S
         rO7V5st49WkCNVPQpq9qa+Z5NuCWVV17JWiEBqN2srS3yWUk5HivYQ0CLagzCCIXN1PU
         Xts5hCBSn7h3f6bKzZ869RGGTUfvX8hxVIsVsKsoD21IjBlTWF+9tJleSlDSdXI8J2Hf
         kSHiFQFYdl8kE+YoXt7p3gYHFGdclSw+baTjFEsyQEIhVeXYTO58AdzZyyGLj7Ug1Iri
         La23t3eE21xZupFoV4vOwCwLoFW1FJgTTzneX6keq0HBoidTc3/t/Dj6KuMUdNYl8Kwg
         +QUw==
X-Received: by 10.60.155.177 with SMTP id vx17mr596834oeb.9.1369801124765;
        Tue, 28 May 2013 21:18:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm38309297obb.14.2013.05.28.21.18.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 21:18:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225730>

Unless any specific 'git am' options are used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh       | 2 ++
 git-rebase--am.sh                      | 1 +
 git-rebase.sh                          | 9 ++++-----
 t/t3407-rebase-abort.sh                | 2 +-
 t/t5520-pull.sh                        | 2 +-
 t/t9106-git-svn-commit-diff-clobber.sh | 2 +-
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..f001463 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -271,6 +271,8 @@ __git_ps1 ()
 			total=$(cat "$g/rebase-merge/end")
 			if [ -f "$g/rebase-merge/interactive" ]; then
 				r="|REBASE-i"
+			elif [ -f "$g/rebase-merge/cherrypick" ]; then
+				r="|REBASE"
 			else
 				r="|REBASE-m"
 			fi
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index ee1b1b9..7a978fd 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -51,6 +51,7 @@ then
 	exit $?
 fi
 
+test -n "$GIT_QUIET" && git_am_opt="$git_am_opt -q"
 git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
 ret=$?
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 9b5d78b..16cc91b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -251,7 +251,6 @@ do
 		;;
 	-q)
 		GIT_QUIET=t
-		git_am_opt="$git_am_opt -q"
 		verbose=
 		diffstat=
 		;;
@@ -383,13 +382,13 @@ elif test -n "$do_merge"
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
1.8.3.rc3.312.g47657de
