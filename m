From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 10/56] t6036: tests for criss-cross merges with various directory/file conflicts
Date: Thu, 11 Aug 2011 23:19:43 -0600
Message-ID: <1313126429-17368-11-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkB4-0004ab-9o
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab1HLFU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:20:57 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab1HLFUw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:52 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RzN/L8W5qdkqTNSK/LoyWURIBXBaVzBLKHW+Dc371KU=;
        b=VxwpB8wrdeoCi6f2gYjwvkLfBMo3nq3jmDZBO+gb6ZhSE+HnVYFINwJXb/1UCubEzp
         J1so/wjCM/mkmMgW3lqeQtcUbRGeABASf6G0S83d1rCGUcocdVs5zE5bZJB8g8c/KElB
         kLPeAoXqg/ZKjO2SIBCEkYVNvI9wvMusXdRIQ=
Received: by 10.231.200.147 with SMTP id ew19mr1069329ibb.79.1313126451980;
        Thu, 11 Aug 2011 22:20:51 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.50
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179168>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1: Lots of wording cleanups, made the tests more thorough.

 t/t6036-recursive-corner-cases.sh |  159 +++++++++++++++++++++++++++++++++++++
 1 files changed, 159 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 991c56d..acff84d 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -4,6 +4,12 @@ test_description='recursive merge corner cases involving criss-cross merges'
 
 . ./test-lib.sh
 
+get_clean_checkout () {
+	git reset --hard &&
+	git clean -fdqx &&
+	git checkout "$1"
+}
+
 #
 #  L1  L2
 #   o---o
@@ -397,4 +403,157 @@ test_expect_failure 'git detects conflict w/ criss-cross+contrived resolution' '
 	test $(git rev-parse :3:file) = $(git rev-parse E:file)
 '
 
+#
+# criss-cross + d/f conflict via add/add:
+#   Commit A: Neither file 'a' nor directory 'a/' exist.
+#   Commit B: Introduce 'a'
+#   Commit C: Introduce 'a/file'
+#   Commit D: Merge B & C, keeping 'a' and deleting 'a/'
+#
+# Two different later cases:
+#   Commit E1: Merge B & C, deleting 'a' but keeping 'a/file'
+#   Commit E2: Merge B & C, deleting 'a' but keeping a slightly modified 'a/file'
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E1 or E2
+#
+# Merging D & E1 requires we first create a virtual merge base X from
+# merging A & B in memory.  Now, if X could keep both 'a' and 'a/file' in
+# the index, then the merge of D & E1 could be resolved cleanly with both
+# 'a' and 'a/file' removed.  Since git does not currently allow creating
+# such a tree, the best we can do is have X contain both 'a~<unique>' and
+# 'a/file' resulting in the merge of D and E1 having a rename/delete
+# conflict for 'a'.  (Although this merge appears to be unsolvable with git
+# currently, git could do a lot better than it currently does with these
+# d/f conflicts, which is the purpose of this test.)
+#
+# Merge of D & E2 has similar issues for path 'a', but should always result
+# in a modify/delete conflict for path 'a/file'.
+#
+# We run each merge in both directions, to check for directional issues
+# with D/F conflict handling.
+#
+
+test_expect_success 'setup differently handled merges of directory/file conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	>ignore-me &&
+	git add ignore-me &&
+	test_tick &&
+	git commit -m A &&
+	git tag A &&
+
+	git branch B &&
+	git checkout -b C &&
+	mkdir a &&
+	echo 10 >a/file &&
+	git add a/file &&
+	test_tick &&
+	git commit -m C &&
+
+	git checkout B &&
+	echo 5 >a &&
+	git add a &&
+	test_tick &&
+	git commit -m B &&
+
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	git clean -f &&
+	rm -rf a/ &&
+	echo 5 >a &&
+	git add a &&
+	test_tick &&
+	git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	git clean -f &&
+	git rm --cached a &&
+	echo 10 >a/file &&
+	git add a/file &&
+	test_tick &&
+	git commit -m E1 &&
+	git tag E1 &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	git clean -f &&
+	git rm --cached a &&
+	printf "10\n11\n" >a/file &&
+	git add a/file &&
+	test_tick &&
+	git commit -m E2 &&
+	git tag E2
+'
+
+test_expect_failure 'merge of D & E1 fails but has appropriate contents' '
+	get_clean_checkout D^0 &&
+
+	test_must_fail git merge -s recursive E1^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+	test $(git rev-parse :2:a) = $(git rev-parse B:a)
+'
+
+test_expect_failure 'merge of E1 & D fails but has appropriate contents' '
+	get_clean_checkout E1^0 &&
+
+	test_must_fail git merge -s recursive D^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+	test $(git rev-parse :3:a) = $(git rev-parse B:a)
+'
+
+test_expect_success 'merge of D & E2 fails but has appropriate contents' '
+	get_clean_checkout D^0 &&
+
+	test_must_fail git merge -s recursive E2^0 &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :3:a/file) = $(git rev-parse E2:a/file) &&
+	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
+	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+
+	test -f a~HEAD
+'
+
+test_expect_failure 'merge of E2 & D fails but has appropriate contents' '
+	get_clean_checkout E2^0 &&
+
+	test_must_fail git merge -s recursive D^0 &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :2:a/file) = $(git rev-parse E2:a/file) &&
+	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file)
+	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+
+	test -f a~D^0
+'
+
 test_done
-- 
1.7.6.100.gac5c1
