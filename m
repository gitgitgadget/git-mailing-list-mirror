From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/6] completion: consolidate test_completion*() tests
Date: Sun, 11 Nov 2012 15:35:56 +0100
Message-ID: <1352644558-9410-5-git-send-email-felipe.contreras@gmail.com>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:36:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYeZ-00065I-9R
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab2KKOga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:36:30 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41620 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab2KKOg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:36:29 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2066470bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GPMug69o9DHQ7FRi001Rt/qewlC4d09WCYitxsRmNxo=;
        b=yMuU5RzdJONmXkNil4OW7j+eWdptSBqJZklk1dD34EHLCCLe6K8LbYNpcoglEva63W
         n87GUsjWDSM2HXi3LLbvTk/s3YxUvycVfIyUg8QggaR83eYWBd71ffmefyz8I8qYbhW8
         0cjpWSPhEQ0MCN111SIASq5TqbwkU0T18A2WaGXoGKQI15gVJaPEYBnWBhbEw4Ys4Qbg
         lwELpstZJ1A41mWWaJCcoWS37XsSEiGRAjmo0dEati0Mz2lFFHrCMyLPU1FT4Bf04n7/
         D/CPJgItlKpQGncTrv/66WGs3Kil5JZSJ6NTWQ8FDTW613frgt0k7zXDckFzrGuYyq1f
         ElIg==
Received: by 10.204.150.200 with SMTP id z8mr5857129bkv.139.1352644589252;
        Sun, 11 Nov 2012 06:36:29 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id k21sm1522544bkv.1.2012.11.11.06.36.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:36:28 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209386>

No need to have two versions; if a second argument is specified, use
that, otherwise use stdin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 204c92a..59cdbfd 100755
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
