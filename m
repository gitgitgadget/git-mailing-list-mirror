From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 2/2] diff-no-index: exit(1) if 'diff --quiet <repo file> <external file>' finds changes
Date: Thu, 21 Jun 2012 14:09:51 -0400
Message-ID: <1340302191-23444-2-git-send-email-tim.henigan@gmail.com>
References: <1340302191-23444-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Thu Jun 21 20:10:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shlq1-0002wK-Fo
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 20:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760106Ab2FUSKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 14:10:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33466 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760093Ab2FUSKb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 14:10:31 -0400
Received: by yenl2 with SMTP id l2so758091yen.19
        for <git@vger.kernel.org>; Thu, 21 Jun 2012 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TEjIAwUhsV+AHQSMvv913eue3z/kgdaPdeegQh4iUkY=;
        b=EC6Wncp7KgqFhdU0OuOXhD4E2g7s3I02e4KgaftYNE9cckc+eKqBvOIoUNcBhVuJVB
         QGCUHXu1iV24wQa33Pm7UDmHoI2RaErMzHUfLpf0v9SaCtWh3k0Hp5Lz7AEHC7jDTGl2
         C5mO2ABdJFN7rIZfFdfr1F6YnakGb4Bn5nxQAGCAdSa0tvRJUFcjQ/V6OOUxJfKdQE/S
         E3slCFHQwGby3yAEKWsZDe6B26zJ64TIfuV1BPUsHVL52CoeknDsoOmU3Q8HaxwnxqPc
         1/GTCQG6vSgsXA7FzOg7LVx327u8MjkOrRCvcgdm+bgiR2rlJTfyL4GUeZuECEaBCpAm
         c0Fg==
Received: by 10.42.155.73 with SMTP id t9mr13887094icw.48.1340302230271;
        Thu, 21 Jun 2012 11:10:30 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id z3sm18516132igc.7.2012.06.21.11.10.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2012 11:10:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3.gf4ddae1
In-Reply-To: <1340302191-23444-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200413>

When running 'git diff --quiet <file1> <file2>', if file1 or file2
is outside the repository, it will exit(0) even if the files differ.
It should exit(1) when they differ.

This happens because 'diff_no_index' uses the 'found_changes' member
from 'diff_options' to determine if changes were made. This is the
wrong flag, since it is only set if xdiff is actually run and it
finds a change. The diff machinery will optimize out the xdiff call
when it is not necessary.

'diff_no_index' needs to check the 'HAS_CHANGES' flag instead, which
is done in the 'diff_result_code' function. This matches the code
paths used for regular index-aware diff.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Patch 1/2 is new to this series, but 3 earlier drafts of this patch
(2/2) were sent to the list for review.

Changes in this version:
  - Improved commit message based on suggestions from Jeff King.
  - Removed declaration after statement in diff-no-index.c.
  - Removed space after redirection operator in t4035.
  - Changed non-git paths in t4035 to match naming used in t7810.
  - Changed non-git paths to be relative rather than absolute.


 diff-no-index.c       |  2 +-
 t/t4035-diff-quiet.sh | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index e6b9952..63c31cc 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -256,5 +256,5 @@ void diff_no_index(struct rev_info *revs,
 	 * The return code for --no-index imitates diff(1):
 	 * 0 = no changes, 1 = changes, else error
 	 */
-	exit(revs->diffopt.found_changes);
+	exit(diff_result_code(&revs->diffopt, 0));
 }
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index cdb9202..231412d 100755
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
+		echo "1 1" >a &&
+		git add . &&
+		git commit -m 1
+	) &&
+	mkdir -p test-outside/non/git && (
+		cd test-outside/non/git &&
+		echo "1 1" >a &&
+		echo "1 1" >matching-file &&
+		echo "1 1 " >trailing-space &&
+		echo "1   1" >extra-space &&
+		echo "2" >never-match
+	)
 '
 
 test_expect_success 'git diff-tree HEAD^ HEAD' '
@@ -77,4 +92,60 @@ test_expect_success 'git diff-index --cached HEAD' '
 	}
 '
 
+test_expect_success 'git diff, one file outside repo' '
+	(
+		cd test-outside/repo &&
+		test_expect_code 0 git diff --quiet a ../non/git/matching-file &&
+		test_expect_code 1 git diff --quiet a ../non/git/extra-space
+	)
+'
+
+test_expect_success 'git diff, both files outside repo' '
+	(
+		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd test-outside/non/git &&
+		test_expect_code 0 git diff --quiet a matching-file &&
+		test_expect_code 1 git diff --quiet a extra-space
+	)
+'
+
+test_expect_success 'git diff --ignore-space-at-eol, one file outside repo' '
+	(
+		cd test-outside/repo &&
+		test_expect_code 0 git diff --quiet --ignore-space-at-eol a ../non/git/trailing-space &&
+		test_expect_code 1 git diff --quiet --ignore-space-at-eol a ../non/git/extra-space
+	)
+'
+
+test_expect_success 'git diff --ignore-space-at-eol, both files outside repo' '
+	(
+		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd test-outside/non/git &&
+		test_expect_code 0 git diff --quiet --ignore-space-at-eol a trailing-space &&
+		test_expect_code 1 git diff --quiet --ignore-space-at-eol a extra-space
+	)
+'
+
+test_expect_success 'git diff --ignore-all-space, one file outside repo' '
+	(
+		cd test-outside/repo &&
+		test_expect_code 0 git diff --quiet --ignore-all-space a ../non/git/trailing-space &&
+		test_expect_code 0 git diff --quiet --ignore-all-space a ../non/git/extra-space &&
+		test_expect_code 1 git diff --quiet --ignore-all-space a ../non/git/never-match
+	)
+'
+
+test_expect_success 'git diff --ignore-all-space, both files outside repo' '
+	(
+		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd test-outside/non/git &&
+		test_expect_code 0 git diff --quiet --ignore-all-space a trailing-space &&
+		test_expect_code 0 git diff --quiet --ignore-all-space a extra-space &&
+		test_expect_code 1 git diff --quiet --ignore-all-space a never-match
+	)
+'
+
 test_done
-- 
1.7.11.3.gf4ddae1
