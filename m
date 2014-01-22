From: Brad King <brad.king@kitware.com>
Subject: [PATCH] t3030-merge-recursive: Test known breakage with empty work tree
Date: Wed, 22 Jan 2014 15:11:59 -0500
Message-ID: <bee33fbfe83408a69085d58db302b3e72edf16a4.1390421446.git.brad.king@kitware.com>
Cc: gitster@pobox.com, newren@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 21:20:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W64HV-0007mH-Mw
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 21:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbaAVUUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 15:20:07 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:56057 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752408AbaAVUUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 15:20:06 -0500
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jan 2014 15:20:06 EST
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id A15BA9FBA1; Wed, 22 Jan 2014 15:11:59 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240853>

Add test cases that use 'merge-recursive' plumbing with a temporary
index and empty work tree.  Populate the index using 'read-tree' and
'update-index --ignore-missing --refresh' to prepare for merge without
actually checking all files out to disk.  Verify that each merge
produces its expected tree while displaying no error diagnostics.

This approach can be used to compute tree merges while checking out only
conflicting files to disk (which is useful for server-side scripts).
Prior to commit 5b448b85 (merge-recursive: When we detect we can skip an
update, actually skip it, 2011-08-11) this worked cleanly in all cases.
Since that commit, merge-recursive displays a diagnostic such as

 error: addinfo_cache failed for path 'e'

when "our" side has a rename (to 'e').  The diagnostic does not
influence the return code and the merge appears to succeed, but it
causes this test case to fail.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 t/t3030-merge-recursive.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 2f96100..b6d3ed0 100755
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
+	 GIT_WORK_TREE="$PWD/ours-has-rename-work" &&
+	 export GIT_WORK_TREE &&
+	 GIT_INDEX_FILE="$PWD/ours-has-rename-index" &&
+	 export GIT_INDEX_FILE &&
+	 mkdir "$GIT_WORK_TREE" &&
+	 git read-tree -i -m $c7 &&
+	 git update-index --ignore-missing --refresh &&
+	 git merge-recursive $c0 -- $c7 $c3 &&
+	 git ls-files -s >actual-files
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
+	 GIT_WORK_TREE="$PWD/theirs-has-rename-work" &&
+	 export GIT_WORK_TREE &&
+	 GIT_INDEX_FILE="$PWD/theirs-has-rename-index" &&
+	 export GIT_INDEX_FILE &&
+	 mkdir "$GIT_WORK_TREE" &&
+	 git read-tree -i -m $c3 &&
+	 git update-index --ignore-missing --refresh &&
+	 git merge-recursive $c0 -- $c3 $c7 &&
+	 git ls-files -s >actual-files
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
