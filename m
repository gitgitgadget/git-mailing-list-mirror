From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 4/4] git-stash: remove untracked/ignored directories when stashed
Date: Fri, 26 Aug 2011 19:59:27 -0500
Message-ID: <1314406767-17832-4-git-send-email-drafnel@gmail.com>
References: <1314406767-17832-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, hilco.wijbenga@gmail.com, david@porkrind.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 27 03:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx7Gx-0007C6-4e
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 03:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab1H0BBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 21:01:11 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52986 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab1H0BBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 21:01:09 -0400
Received: by gxk21 with SMTP id 21so3328245gxk.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 18:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Z3K2VT9ATXzv3KxSWiqOXhqCbEn7YE+yQBvMo0luVzo=;
        b=ArYZcaZRXUHx8XmGopj0UtyjyIDdunZ4RUua26cnIuMbjltU/kcIWkecWR3cH4tIKg
         KZrugcgg5j9L0iSSBiltNAcUTGiBKI7uY/fSGhZfNkzkYkvswFa8RSu3iDs8q/trp2BY
         uXlvMDVyQUm/tZIdWxBYFLZk69FfdcXv6xJdo=
Received: by 10.236.80.66 with SMTP id j42mr10738705yhe.98.1314406868794;
        Fri, 26 Aug 2011 18:01:08 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id j45sm2756593yhe.36.2011.08.26.18.01.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Aug 2011 18:01:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1314406767-17832-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180214>

The two new stash options --include-untracked and --all do not remove the
untracked and/or ignored files that are stashed if those files reside in
a subdirectory. e.g. the following sequence fails:

   mkdir untracked &&
   echo hello >untracked/file.txt &&
   git stash --include-untracked &&
   test ! -f untracked/file.txt

Within the git-stash script, git-clean is used to remove the
untracked/ignored files, but since the -d option was not supplied, it does
not remove directories.

So, add -d to the git-clean arguments, and update the tests to test this
functionality.

Reported-by: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git-stash.sh                       |    2 +-
 t/t3905-stash-include-untracked.sh |   26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9d65250..c766692 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -240,7 +240,7 @@ save_stash () {
 		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
 		if test -n "$untracked"
 		then
-			git clean --force --quiet $CLEAN_X_OPTION
+			git clean --force --quiet -d $CLEAN_X_OPTION
 		fi
 
 		if test "$keep_index" = "t" && test -n $i_tree
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index ca1a46c..ef44fb2 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -17,6 +17,8 @@ test_expect_success 'stash save --include-untracked some dirty working directory
 	echo 3 > file &&
 	test_tick &&
 	echo 1 > file2 &&
+	mkdir untracked &&
+	echo untracked >untracked/untracked &&
 	git stash --include-untracked &&
 	git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD
@@ -40,14 +42,23 @@ index 0000000..d00491f
 +++ b/file2
 @@ -0,0 +1 @@
 +1
+diff --git a/untracked/untracked b/untracked/untracked
+new file mode 100644
+index 0000000..5a72eb2
+--- /dev/null
++++ b/untracked/untracked
+@@ -0,0 +1 @@
++untracked
 EOF
 cat > expect.lstree <<EOF
 file2
+untracked
 EOF
 
 test_expect_success 'stash save --include-untracked stashed the untracked files' '
 	test "!" -f file2 &&
-	git diff HEAD..stash^3 -- file2 >actual &&
+	test ! -e untracked &&
+	git diff HEAD stash^3 -- file2 untracked >actual &&
 	test_cmp expect.diff actual &&
 	git ls-tree --name-only stash^3: >actual &&
 	test_cmp expect.lstree actual
@@ -67,15 +78,18 @@ cat > expect <<EOF
 ?? actual
 ?? expect
 ?? file2
+?? untracked/
 EOF
 
 test_expect_success 'stash pop after save --include-untracked leaves files untracked again' '
 	git stash pop &&
 	git status --porcelain >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test "1" = "`cat file2`" &&
+	test untracked = "`cat untracked/untracked`"
 '
 
-git clean --force --quiet
+git clean --force --quiet -d
 
 test_expect_success 'stash save -u dirty index' '
 	echo 4 > file3 &&
@@ -125,12 +139,16 @@ test_expect_success 'stash save --include-untracked removed files got stashed' '
 cat > .gitignore <<EOF
 .gitignore
 ignored
+ignored.d/
 EOF
 
 test_expect_success 'stash save --include-untracked respects .gitignore' '
 	echo ignored > ignored &&
+	mkdir ignored.d &&
+	echo ignored >ignored.d/untracked &&
 	git stash -u &&
 	test -s ignored &&
+	test -s ignored.d/untracked &&
 	test -s .gitignore
 '
 
@@ -143,12 +161,14 @@ test_expect_success 'stash save -u can stash with only untracked files different
 test_expect_success 'stash save --all does not respect .gitignore' '
 	git stash -a &&
 	test "!" -f ignored &&
+	test "!" -e ignored.d &&
 	test "!" -f .gitignore
 '
 
 test_expect_success 'stash save --all is stash poppable' '
 	git stash pop &&
 	test -s ignored &&
+	test -s ignored.d/untracked &&
 	test -s .gitignore
 '
 
-- 
1.7.6
