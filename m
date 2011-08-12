From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 07/56] t6042: Add failing testcases for rename/rename/add-{source,dest} conflicts
Date: Thu, 11 Aug 2011 23:19:40 -0600
Message-ID: <1313126429-17368-8-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkDB-0005ix-59
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202Ab1HLFUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:20:55 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab1HLFUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:46 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iBR7Ipa4TGGB00H+hmkSlouuqTtgqj6UwRc3iUPIDDQ=;
        b=hMQm4ixTrxx2ZYiFC6m6znWODVqrDES78cJrr7TlEIo9H+Wi+14yL1yQJRVJOkIvF/
         zj3SuLM9DEL4OZ8wo9muIwzScBP9cudqzcLicYnlScU/q3V3LlIkzBFQ9seef36Uy3y/
         pDj9kGytALCsSVKf1pRs9Sfk9b7afIuyOEypM=
Received: by 10.231.115.36 with SMTP id g36mr1169430ibq.3.1313126446106;
        Thu, 11 Aug 2011 22:20:46 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.44
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179214>

Add testcases that cover three failures with current git merge, all
involving renaming one file on both sides of history:

Case 1:
If a single file is renamed to two different filenames on different sides
of history, there should be a conflict.  Adding a new file on one of those
sides of history whose name happens to match the rename source should not
cause the merge to suddenly succeed.

Case 2:
If a single file is renamed on both sides of history but renamed
identically, there should not be a conflict.  This works fine.  However,
if one of those sides also added a new file that happened to match the
rename source, then that file should be left alone.  Currently, the
rename/rename conflict handling causes that new file to become untracked.

Case 3:
If a single file is renamed to two different filenames on different sides
of history, there should be a conflict.  This works currently.  However,
if those renames also involve rename/add conflicts (i.e. there are new
files on one side of history that match the destination of the rename of
the other side of history), then the resulting conflict should be recorded
in the index, showing that there were multiple files with a given filename.
Currently, git silently discards one of file versions.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Changes since v1: moved this patch (and its content) prior to the
  patch it used to follow (as suggested by Junio), since it has a
  simpler rename/rename(1to2) case in it.

 t/t6042-merge-rename-corner-cases.sh |  125 ++++++++++++++++++++++++++++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 371fb39..427fe1c 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -441,4 +441,129 @@ test_expect_success 'merge has correct working tree contents' '
 	test $(git hash-object c) = $(git rev-parse A:a)
 '
 
+# Testcase setup for rename/rename(1to2)/add-source conflict:
+#   Commit A: new file: a
+#   Commit B: rename a->b
+#   Commit C: rename a->c, add completely different a
+#
+# Merging of B & C should NOT be clean; there's a rename/rename conflict
+
+test_expect_success 'setup rename/rename(1to2)/add-source conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	echo something completely different >a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse 3:a) = $(git rev-parse C:a) &&
+	test $(git rev-parse 1:a) = $(git rev-parse A:a) &&
+	test $(git rev-parse 2:b) = $(git rev-parse B:b) &&
+	test $(git rev-parse 3:c) = $(git rev-parse C:c) &&
+
+	test -f a &&
+	test -f b &&
+	test -f c
+'
+
+test_expect_success 'setup rename/rename(1to2)/add-source resolvable conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	>a &&
+	git add a &&
+	test_tick &&
+	git commit -m base &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	test_tick &&
+	git commit -m one &&
+
+	git checkout -b C A &&
+	git mv a b &&
+	echo important-info >a &&
+	git add a &&
+	test_tick &&
+	git commit -m two
+'
+
+test_expect_failure 'rename/rename/add-source still tracks new a file' '
+	git checkout C^0 &&
+	git merge -s recursive B^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse HEAD:a) = $(git rev-parse C:a) &&
+	test $(git rev-parse HEAD:b) = $(git rev-parse A:a)
+'
+
+test_expect_success 'setup rename/rename(1to2)/add-dest conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	echo stuff >a &&
+	git add a &&
+	test_tick &&
+	git commit -m base &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	echo precious-data >c &&
+	git add c &&
+	test_tick &&
+	git commit -m one &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	echo important-info >b &&
+	git add b &&
+	test_tick &&
+	git commit -m two
+'
+
+test_expect_failure 'rename/rename/add-dest merge still knows about conflicting file versions' '
+	git checkout C^0 &&
+	test_must_fail git merge -s recursive B^0 &&
+
+	test 5 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u b | wc -l) &&
+	test 2 -eq $(git ls-files -u c | wc -l) &&
+
+	test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
+	test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
+	test $(git rev-parse :3:b) = $(git rev-parse B:b) &&
+	test $(git rev-parse :2:c) = $(git rev-parse C:c) &&
+	test $(git rev-parse :3:c) = $(git rev-parse B:c)
+'
+
 test_done
-- 
1.7.6.100.gac5c1
