From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/6] completion: consolidate test_completion*() tests
Date: Sun, 18 Nov 2012 11:51:55 +0100
Message-ID: <1353235917-13059-5-git-send-email-felipe.contreras@gmail.com>
References: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:52:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2UY-00050R-SN
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586Ab2KRKwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:52:31 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38183 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab2KRKwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:52:30 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599489bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3UEZYiarxyCeluqEg6lbZIA8icT7LpMFyzLNh2A6MEQ=;
        b=r49LmTph+7WKZXav84Jk8mXmSUlXdPJF3BIjG7GP9932UmrqmbOvBJjmfqRZD1rz3G
         F1DJTWLJW7A973e1yTrN5yORB3GRjF2jmsFMWW7GM9t60uG8QkYJkn7UmLiCAG4Hq+lo
         Q6D4zJJcqFHYULhjgnN5UM6KQ8s2nE/+eAmTiVhXrwrhL8v5tW0bFzFK0X/UIquyfD5N
         P6g/H6nM4zeUojB52WPYMzb2n2BOEZs1vx2zQLK44SGMvBojs7bbiOhahyYkMtcETkNV
         Y/IjI0KN4eXYbFLfUAN54jIWieVaOXPuU/NaJsrYb4gTms+36hfR+kT/ajkM6JFgG54h
         idpg==
Received: by 10.204.151.21 with SMTP id a21mr3846139bkw.124.1353235950133;
        Sun, 18 Nov 2012 02:52:30 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id v14sm2894179bkv.10.2012.11.18.02.52.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:52:29 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210009>

No need to have two versions; if a second argument is specified, use
that, otherwise use stdin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6a250ad..90a9a91 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -60,19 +60,15 @@ run_completion ()
 # 2: expected completion
 test_completion ()
 {
-	test $# -gt 1 && echo "$2" > expected
+	if [ $# -gt 1 ]; then
+		echo "$2" > expected
+	else
+		sed -e 's/Z$//' > expected
+	fi &&
 	run_completion "$1" &&
 	test_cmp expected out
 }
 
-# Like test_completion, but reads expectation from stdin,
-# which is convenient when it is multiline.
-test_completion_long ()
-{
-	sed -e 's/Z$//' > expected &&
-	test_completion "$1"
-}
-
 newline=$'\n'
 
 test_expect_success '__gitcomp - trailing space - options' '
@@ -172,7 +168,7 @@ test_expect_success 'basic' '
 '
 
 test_expect_success 'double dash "git" itself' '
-	test_completion_long "git --" <<-\EOF
+	test_completion "git --" <<-\EOF
 	--paginate Z
 	--no-pager Z
 	--git-dir=
@@ -190,7 +186,7 @@ test_expect_success 'double dash "git" itself' '
 '
 
 test_expect_success 'double dash "git checkout"' '
-	test_completion_long "git checkout --" <<-\EOF
+	test_completion "git checkout --" <<-\EOF
 	--quiet Z
 	--ours Z
 	--theirs Z
@@ -206,7 +202,7 @@ test_expect_success 'double dash "git checkout"' '
 test_expect_success 'general options' '
 	test_completion "git --ver" "--version " &&
 	test_completion "git --hel" "--help " &&
-	test_completion_long "git --exe" <<-\EOF &&
+	test_completion "git --exe" <<-\EOF &&
 	--exec-path Z
 	--exec-path=
 	EOF
@@ -247,7 +243,7 @@ test_expect_success 'setup for ref completion' '
 '
 
 test_expect_success 'checkout completes ref names' '
-	test_completion_long "git checkout m" <<-\EOF
+	test_completion "git checkout m" <<-\EOF
 	master Z
 	mybranch Z
 	mytag Z
@@ -255,7 +251,7 @@ test_expect_success 'checkout completes ref names' '
 '
 
 test_expect_success 'show completes all refs' '
-	test_completion_long "git show m" <<-\EOF
+	test_completion "git show m" <<-\EOF
 	master Z
 	mybranch Z
 	mytag Z
@@ -263,7 +259,7 @@ test_expect_success 'show completes all refs' '
 '
 
 test_expect_success '<ref>: completes paths' '
-	test_completion_long "git show mytag:f" <<-\EOF
+	test_completion "git show mytag:f" <<-\EOF
 	file1 Z
 	file2 Z
 	EOF
@@ -273,7 +269,7 @@ test_expect_success 'complete tree filename with spaces' '
 	echo content >"name with spaces" &&
 	git add . &&
 	git commit -m spaces &&
-	test_completion_long "git show HEAD:nam" <<-\EOF
+	test_completion "git show HEAD:nam" <<-\EOF
 	name with spaces Z
 	EOF
 '
@@ -282,7 +278,7 @@ test_expect_failure 'complete tree filename with metacharacters' '
 	echo content >"name with \${meta}" &&
 	git add . &&
 	git commit -m meta &&
-	test_completion_long "git show HEAD:nam" <<-\EOF
+	test_completion "git show HEAD:nam" <<-\EOF
 	name with ${meta} Z
 	name with spaces Z
 	EOF
-- 
1.8.0
