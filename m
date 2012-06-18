From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file> <external file>' finds changes
Date: Mon, 18 Jun 2012 15:28:24 -0400
Message-ID: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Mon Jun 18 21:29:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sghe1-0006xW-SF
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 21:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab2FRT3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 15:29:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49774 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab2FRT3p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 15:29:45 -0400
Received: by yhmm54 with SMTP id m54so4155162yhm.19
        for <git@vger.kernel.org>; Mon, 18 Jun 2012 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=H5hX/h+/PBHiyNaYM4bkGhio09D5eWBzxSy8DywxR+A=;
        b=mxeoTLUHFspg5mHqN+78lKYHbxnW8VY3yOXsEc4lFkF6hiANvAyNlH5RLqSdGfYBUn
         uHghEZk7e/iv++XvAVRgniKNWkeK1V3zi1FG8H6NHjejfCVpIUTkL+znd7oFkGgkcVHm
         GnHOVCGWCtxml6npJsA4WXe9gAGxYf577sNB2q+B3IbxXkWq9aXNKcGKqyIdQXqYPmJQ
         wYPDxW1KFzki8mzgxhU2zLFUAXkd//ZQmbEA7YYst4h69NEJuB7iTam1YzSVykyPsec1
         2w0TtUApe/AllkIdy8NRTAqkAokyQ1yy0cjrHIhAai1SPRmLlHtndyAuYZoc60rh88GN
         3X4g==
Received: by 10.42.20.201 with SMTP id h9mr6014962icb.36.1340047784423;
        Mon, 18 Jun 2012 12:29:44 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id ga6sm9904103igc.2.2012.06.18.12.29.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2012 12:29:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc3.6.g5532165
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200160>

When running 'git diff --quiet <file1> <file2>', if file1 or file2
is outside the repository, it will exit(0) even if the files differ.
It should exit(1) when they differ.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---


v3 improves the test coverage to include variations of 'diff --quiet'
where one or both of the files are outside the repository. Tests for
'--ignore-space-at-eol' and '--ignore-all-space' are included as well.


 diff-no-index.c       |  3 +-
 t/t4035-diff-quiet.sh | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index f0b0010..b935d2a 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -273,5 +273,6 @@ void diff_no_index(struct rev_info *revs,
 	 * The return code for --no-index imitates diff(1):
 	 * 0 = no changes, 1 = changes, else error
 	 */
-	exit(revs->diffopt.found_changes);
+	int result = diff_result_code(&revs->diffopt, 0);
+	exit(result);
 }
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index cdb9202..33d8980 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -10,7 +10,22 @@ test_expect_success 'setup' '
 	git commit -m first &&
 	echo 2 >b &&
 	git add . &&
-	git commit -a -m second
+	git commit -a -m second &&
+	mkdir -p test-outside/repo && (
+		cd test-outside/repo &&
+		git init &&
+		echo "1 1" > a &&
+		git add . &&
+		git commit -m 1
+	) &&
+	mkdir -p test-outside/no-repo && (
+		cd test-outside/no-repo &&
+		echo "1 1" >a &&
+		echo "1 1" >matching-file &&
+		echo "1 1 " >trailing-space &&
+		echo "1   1" >extra-space &&
+		echo "2" >never-match
+	)
 '
 
 test_expect_success 'git diff-tree HEAD^ HEAD' '
@@ -77,4 +92,66 @@ test_expect_success 'git diff-index --cached HEAD' '
 	}
 '
 
+test_expect_success 'git diff, one file outside repo' '
+	(
+		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd test-outside/repo &&
+		test_expect_code 0 git diff --quiet a "$TRASH_DIRECTORY/test-outside/no-repo/matching-file" &&
+		test_expect_code 1 git diff --quiet a "$TRASH_DIRECTORY/test-outside/no-repo/extra-space"
+	)
+'
+
+test_expect_success 'git diff, both files outside repo' '
+	(
+		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd test-outside/no-repo &&
+		test_expect_code 0 git diff --quiet a matching-file &&
+		test_expect_code 1 git diff --quiet a extra-space
+	)
+'
+
+test_expect_success 'git diff --ignore-space-at-eol, one file outside repo' '
+	(
+		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd test-outside/repo &&
+		test_expect_code 0 git diff --quiet --ignore-space-at-eol a "$TRASH_DIRECTORY/test-outside/no-repo/trailing-space" &&
+		test_expect_code 1 git diff --quiet --ignore-space-at-eol a "$TRASH_DIRECTORY/test-outside/no-repo/extra-space"
+	)
+'
+
+test_expect_success 'git diff --ignore-space-at-eol, both files outside repo' '
+	(
+		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd test-outside/no-repo &&
+		test_expect_code 0 git diff --quiet --ignore-space-at-eol a trailing-space &&
+		test_expect_code 1 git diff --quiet --ignore-space-at-eol a extra-space
+	)
+'
+
+test_expect_success 'git diff --ignore-all-space, one file outside repo' '
+	(
+		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd test-outside/repo &&
+		test_expect_code 0 git diff --quiet --ignore-all-space a "$TRASH_DIRECTORY/test-outside/no-repo/trailing-space" &&
+		test_expect_code 0 git diff --quiet --ignore-all-space a "$TRASH_DIRECTORY/test-outside/no-repo/extra-space" &&
+		test_expect_code 1 git diff --quiet --ignore-all-space a "$TRASH_DIRECTORY/test-outside/no-repo/never-match"
+	)
+'
+
+test_expect_success 'git diff --ignore-all-space, both files outside repo' '
+	(
+		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd test-outside/no-repo &&
+		test_expect_code 0 git diff --quiet --ignore-all-space a trailing-space &&
+		test_expect_code 0 git diff --quiet --ignore-all-space a extra-space &&
+		test_expect_code 1 git diff --quiet --ignore-all-space a never-match
+	)
+'
+
 test_done
-- 
1.7.11.rc3.6.g5532165
