From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/8] port the filtering part of branch.c to use ref-filter APIs
Date: Sun, 13 Sep 2015 12:53:47 +0530
Message-ID: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 09:23:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb1dj-0002fB-IF
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 09:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbbIMHXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 03:23:49 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34289 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbbIMHXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 03:23:48 -0400
Received: by padhy16 with SMTP id hy16so113322288pad.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Rk/B883DlWxQVzqf/0tGka3GdiR72Oao1rrv4zJP+Uw=;
        b=0BalERV8BiW7fL4BOuJ4T+XE9XYZN1LhmvqrXvKl4YGrKzx5fMFSaN6WELCVkfZe+I
         R3JQGwnJqSHbjkjo2iRE7EBG+2y42uGx4/iIphZQbZ+uAK9sODFRg9ZBnGQwdlUpsKis
         QjjBkRv11UQRwij96DBa0geJJzXuCYX/Mxl7ANp1Urs8nvsuUG5dZzqRbIFzrTWelTs/
         QRyZj6pFBzk7lQgPYY4mx5T0qeJDrmUaaXahYb5f2Xnq3d0ZntjaMI5YThg6WXAU7f+V
         IANOic5Dxb1ZvWBdWoronMVCD6dtcF9kSc/zpNdQ4U2ehE+hEghFeiNruIfd+5SnUOKF
         JK1g==
X-Received: by 10.68.111.3 with SMTP id ie3mr19594580pbb.63.1442129027750;
        Sun, 13 Sep 2015 00:23:47 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id g5sm7688014pat.21.2015.09.13.00.23.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Sep 2015 00:23:47 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277761>

This makes branch.c use the ref-filter APIs for filtering of
refs for 'git branch -l'. This is part of the series of unification
of code of 'git branch -l, git tag -l and git for-each-ref'.

The previous version can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/276377

The changes in this version are:
[7/8]: Change the tests check for stdout and stderr. (check interdiff)

Karthik Nayak (8):
  branch: refactor width computation
  branch: bump get_head_description() to the top
  branch: roll show_detached HEAD into regular ref_list
  branch: move 'current' check down to the presentation layer
  branch: drop non-commit error reporting
  branch.c: use 'ref-filter' data structures
  branch.c: use 'ref-filter' APIs
  branch: add '--points-at' option

 Documentation/git-branch.txt |  13 +-
 builtin/branch.c             | 506 +++++++++++++------------------------------
 ref-filter.c                 |   4 +-
 ref-filter.h                 |   8 +-
 t/t1430-bad-ref-name.sh      |  31 ++-
 t/t3203-branch-output.sh     |  20 ++
 6 files changed, 216 insertions(+), 366 deletions(-)

interdiff:

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index db3627e..070cf06 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -38,18 +38,20 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
 	test_must_fail git fast-import <input
 '
 
-test_expect_success 'git branch shows badly named ref' '
+test_expect_success 'git branch shows badly named ref as warning' '
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-	git branch 2>output &&
-	grep -e "broken\.\.\.ref" output
+	git branch >output 2>error &&
+	grep -e "broken\.\.\.ref" error &&
+	! grep -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'branch -d can delete badly named ref' '
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch -d broken...ref &&
-	git branch >output &&
+	git branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
@@ -57,7 +59,8 @@ test_expect_success 'branch -D can delete badly named ref' '
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch -D broken...ref &&
-	ngit branch >output &&
+	git branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
@@ -85,7 +88,8 @@ test_expect_success 'branch -D cannot delete absolute path' '
 test_expect_success 'git branch cannot create a badly named ref' '
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	test_must_fail git branch broken...ref &&
-	git branch >output &&
+	git branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
@@ -95,7 +99,8 @@ test_expect_success 'branch -m cannot rename to a bad ref name' '
 	git branch goodref &&
 	test_must_fail git branch -m goodref broken...ref &&
 	test_cmp_rev master goodref &&
-	git branch >output &&
+	git branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
@@ -104,14 +109,16 @@ test_expect_failure 'branch -m can rename from a bad ref name' '
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch -m broken...ref renamed &&
 	test_cmp_rev master renamed &&
-	git branch >output &&
+	git branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'push cannot create a badly named ref' '
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	test_must_fail git push "file://$(pwd)" HEAD:refs/heads/broken...ref &&
-	git branch >output &&
+	git branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
@@ -131,7 +138,8 @@ test_expect_failure 'push --mirror can delete badly named ref' '
 		cp .git/refs/heads/master .git/refs/heads/broken...ref
 	) &&
 	git -C src push --mirror "file://$top/dest" &&
-	git -C dest branch >output &&
+	git -C dest branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error
 	! grep -e "broken\.\.\.ref" output
 '
 
@@ -159,7 +167,8 @@ test_expect_success 'update-ref -d can delete broken name' '
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git update-ref -d refs/heads/broken...ref &&
-	git branch >output &&
+	git branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '

-- 
2.5.1
