From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 12/56] t6036: criss-cross + rename/rename(1to2)/add-source + modify/modify
Date: Thu, 11 Aug 2011 23:19:45 -0600
Message-ID: <1313126429-17368-13-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBN-0004nj-Pk
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab1HLFVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:02 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab1HLFU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:56 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2LfzrG5RAKdCqttni7QTd4TUdvSQfUkP9TaeDHBdgtA=;
        b=mUwuYi5PL9H70/9fvHHQGcgpZvFjDgbz890snYwSw1TwYSmG048BxSNM5lxlSB6uWk
         TMErPE1xuNHiBry0b6Ne9EEHmp4PtI0vbJFcd7gWpP6NCApVU7eyP8g8Uvnc3cdIYSvr
         oDeXn62nFIzbKYBo3rQnmf8w7u4zMuJOumCFU=
Received: by 10.42.28.193 with SMTP id o1mr538946icc.103.1313126456216;
        Thu, 11 Aug 2011 22:20:56 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.54
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179172>

This is another challenging testcase trying to exercise the virtual merge
base creation in the rename/rename(1to2) code.  A testcase is added that
we should be able to merge cleanly, but which requires a virtual merge
base to be created that is aware of rename/rename(1to2)/add-source
conflicts and can handle those.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1: More thorough testing of results, improvement on
  wording in description of testcase.

 t/t6036-recursive-corner-cases.sh |   77 +++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 38cace6..526a2ea 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -644,4 +644,81 @@ test_expect_failure 'handle rename/rename(1to2)/modify followed by what looks li
 	test $(git rev-parse HEAD:newname) = $(git rev-parse E:newname)
 '
 
+#
+# criss-cross with rename/rename(1to2)/add-source + resolvable modify/modify:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: new file: a
+#   Commit B: rename a->b
+#   Commit C: rename a->c, add different a
+#   Commit D: merge B&C, keeping b&c and (new) a modified at beginning
+#   Commit E: merge B&C, keeping b&c and (new) a modified at end
+#
+# Merging commits D & E should result in no conflict; doing so correctly
+# requires getting the virtual merge base (from merging B&C) right, handling
+# renaming carefully (both in the virtual merge base and later), and getting
+# content merge handled.
+
+test_expect_success 'setup criss-cross + rename/rename/add + modify/modify' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "lots\nof\nwords\nand\ncontent\n" >a &&
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
+	printf "2\n3\n4\n5\n6\n7\n" >a &&
+	git add a &&
+	git commit -m C &&
+
+	git checkout B^0 &&
+	git merge --no-commit -s ours C^0 &&
+	git checkout C -- a c &&
+	mv a old_a &&
+	echo 1 >a &&
+	cat old_a >>a &&
+	rm old_a &&
+	git add -u &&
+	git commit -m "Merge commit C^0 into HEAD" &&
+	git tag D &&
+
+	git checkout C^0 &&
+	git merge --no-commit -s ours B^0 &&
+	git checkout B -- b &&
+	echo 8 >>a &&
+	git add -u &&
+	git commit -m "Merge commit B^0 into HEAD" &&
+	git tag E
+'
+
+test_expect_failure 'detect rename/rename/add-source for virtual merge-base' '
+	git checkout D^0 &&
+
+	git merge -s recursive E^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
+	test $(git rev-parse HEAD:c) = $(git rev-parse A:a) &&
+	test "$(cat a)" = "$(printf "1\n2\n3\n4\n5\n6\n7\n8\n")"
+'
+
 test_done
-- 
1.7.6.100.gac5c1
