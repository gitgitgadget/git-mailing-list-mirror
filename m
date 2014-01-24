From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 1/3] t3030-merge-recursive: Test known breakage with empty work tree
Date: Fri, 24 Jan 2014 15:10:47 -0500
Message-ID: <bc20dc0a791ac6441fa564ed5df469e43376ab87.1390592626.git.brad.king@kitware.com>
References: <cover.1390574980.git.brad.king@kitware.com> <cover.1390592626.git.brad.king@kitware.com>
Cc: gitster@pobox.com, newren@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 21:10:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6n5A-0007A7-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbaAXUK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:10:26 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:59746 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752290AbaAXUKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 15:10:21 -0500
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id DFCC99FBA5; Fri, 24 Jan 2014 15:10:49 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <cover.1390592626.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241031>

Sometimes when working with a large repository it can be useful to try
out a merge and only check out conflicting files to disk (for example as
a speed optimization on a server).  Until v1.7.7-rc1~28^2~20
(merge-recursive: When we detect we can skip an update, actually skip
it, 2011-08-11), it was possible to do so with the following idiom:

	# Prepare a temporary index and empty work tree.
	GIT_INDEX_FILE="$PWD/tmp-$$-index" &&
	export GIT_INDEX_FILE &&
	GIT_WORK_TREE="$PWD/tmp-$$-work" &&
	export GIT_WORK_TREE &&
	mkdir "$GIT_WORK_TREE" &&

	# Convince the index that our side is on disk.
	git read-tree -i -m $ours &&
	git update-index --ignore-missing --refresh &&

	# Merge their side into our side.
	bases=$(git merge-base --all $ours $theirs) &&
	git merge-recursive $bases -- $ours $theirs &&
	tree=$(git write-tree)

Nowadays, that still works and the exit status is the same, but
merge-recursive produces a diagnostic if "our" side renamed a file:

	error: addinfo_cache failed for path 'dst'

Add a test to document this regression.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 t/t3030-merge-recursive.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 2f96100..3db3bf6 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -257,6 +257,7 @@ test_expect_success 'setup 8' '
 	git add e &&
 	test_tick &&
 	git commit -m "rename a->e" &&
+	c7=$(git rev-parse --verify HEAD) &&
 	git checkout rename-ln &&
 	git mv a e &&
 	test_ln_s_add e a &&
@@ -517,6 +518,52 @@ test_expect_success 'reset and bind merge' '
 
 '
 
+test_expect_failure 'merge-recursive w/ empty work tree - ours has rename' '
+	(
+		GIT_WORK_TREE="$PWD/ours-has-rename-work" &&
+		export GIT_WORK_TREE &&
+		GIT_INDEX_FILE="$PWD/ours-has-rename-index" &&
+		export GIT_INDEX_FILE &&
+		mkdir "$GIT_WORK_TREE" &&
+		git read-tree -i -m $c7 &&
+		git update-index --ignore-missing --refresh &&
+		git merge-recursive $c0 -- $c7 $c3 &&
+		git ls-files -s >actual-files
+	) 2>actual-err &&
+	>expected-err &&
+	cat >expected-files <<-EOF &&
+	100644 $o3 0	b/c
+	100644 $o0 0	c
+	100644 $o0 0	d/e
+	100644 $o0 0	e
+	EOF
+	test_cmp expected-files actual-files &&
+	test_cmp expected-err actual-err
+'
+
+test_expect_success 'merge-recursive w/ empty work tree - theirs has rename' '
+	(
+		GIT_WORK_TREE="$PWD/theirs-has-rename-work" &&
+		export GIT_WORK_TREE &&
+		GIT_INDEX_FILE="$PWD/theirs-has-rename-index" &&
+		export GIT_INDEX_FILE &&
+		mkdir "$GIT_WORK_TREE" &&
+		git read-tree -i -m $c3 &&
+		git update-index --ignore-missing --refresh &&
+		git merge-recursive $c0 -- $c3 $c7 &&
+		git ls-files -s >actual-files
+	) 2>actual-err &&
+	>expected-err &&
+	cat >expected-files <<-EOF &&
+	100644 $o3 0	b/c
+	100644 $o0 0	c
+	100644 $o0 0	d/e
+	100644 $o0 0	e
+	EOF
+	test_cmp expected-files actual-files &&
+	test_cmp expected-err actual-err
+'
+
 test_expect_success 'merge removes empty directories' '
 
 	git reset --hard master &&
-- 
1.8.5.2
