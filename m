From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 7/7] t7403: Submodule git mv, git rm testsuite
Date: Wed, 16 Jul 2008 21:11:40 +0200
Message-ID: <20080716191139.19772.16159.stgit@localhost>
References: <20080716190753.19772.93357.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 21:13:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCQm-0001D4-6R
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552AbYGPTLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757430AbYGPTLq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:11:46 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:64302 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757174AbYGPTLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:11:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 154482ACC76
	for <git@vger.kernel.org>; Wed, 16 Jul 2008 21:11:40 +0200 (CEST)
In-Reply-To: <20080716190753.19772.93357.stgit@localhost>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88724>

The testsuite for newly added submodule support in git mv, git rm.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 t/t7403-submodule-mvrm.sh |  242 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 242 insertions(+), 0 deletions(-)
 create mode 100755 t/t7403-submodule-mvrm.sh

diff --git a/t/t7403-submodule-mvrm.sh b/t/t7403-submodule-mvrm.sh
new file mode 100755
index 0000000..9b50d6a
--- /dev/null
+++ b/t/t7403-submodule-mvrm.sh
@@ -0,0 +1,242 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Johannes Schindelin
+#
+
+test_description='Test submodules support in git mv and git rm'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	(mkdir sub-repo &&
+	 cd sub-repo &&
+	 git init &&
+	 echo file > file &&
+	 git add file &&
+	 git commit -m "sub initial") &&
+	(cp -r sub-repo sub2-repo &&
+	 cd sub2-repo &&
+	 echo file2 > file &&
+	 git add file &&
+	 git commit -m "sub commit2") &&
+	git submodule add "$(pwd)/sub-repo" sub &&
+	git submodule add "$(pwd)/sub2-repo" sub2 &&
+	git commit -m initial &&
+	test "$(git config -f .gitmodules submodule.sub.path)" = "sub" &&
+	test "$(git config -f .gitmodules submodule.sub2.path)" = "sub2"
+
+'
+
+test_expect_success 'git mv of a submodule' '
+
+	git mv sub sub.moved &&
+	! test -d sub &&
+	test -d sub.moved/.git &&
+	! git ls-files --error-unmatch sub &&
+	test "$(git ls-files --stage --error-unmatch sub.moved | cut -d " " -f 1)" = 160000 &&
+	test "$(git config -f .gitmodules submodule.sub.path)" = "sub.moved" &&
+	! git config -f .gitmodules submodule.sub.moved.path
+
+'
+
+test_expect_success 'git submodule add vs. git mv' '
+
+	! git submodule add "$(pwd)/sub2-repo" sub.moved &&
+	git submodule add "$(pwd)/sub2-repo" sub &&
+	test -d sub/.git &&
+	test "$(git config -f .gitmodules submodule.sub.url)" = "$(pwd)/sub-repo" &&
+	test "$(git config -f .gitmodules submodule.sub.path)" = "sub.moved" &&
+	test "$(git config -f .gitmodules submodule.sub~.path)" = "sub"
+
+'
+
+test_expect_success 'git mv onto existing file' '
+
+	echo file > file &&
+	git add file &&
+	! git mv sub.moved file &&
+	test -d sub.moved &&
+	! test -d file/.git &&
+	test "$(git ls-files --stage --error-unmatch file | cut -d " " -f 1)" = 100644 &&
+	test "$(git ls-files --stage --error-unmatch sub.moved | cut -d " " -f 1)" = 160000 &&
+	test "$(git config -f .gitmodules submodule.sub.path)" = "sub.moved"
+
+'
+
+test_expect_success 'git mv onto existing directory' '
+
+	mkdir -p dir &&
+	echo file > dir/file &&
+	git add dir/file &&
+	git mv sub.moved dir &&
+	! test -d sub.moved &&
+	test -d dir/sub.moved/.git &&
+	! git ls-files --error-unmatch sub.moved &&
+	test "$(git ls-files --stage --error-unmatch dir/sub.moved | cut -d " " -f 1)" = 160000 &&
+	test "$(git config -f .gitmodules submodule.sub.path)" = "dir/sub.moved" &&
+	git mv dir/sub.moved . &&
+	test "$(git config -f .gitmodules submodule.sub.path)" = "sub.moved"
+
+'
+
+test_expect_success 'git mv onto existing submodule' '
+
+	! git mv sub.moved sub2 &&
+	test -d sub.moved/.git &&
+	! test -d sub2/sub.moved &&
+	test "$(git ls-files --stage --error-unmatch sub2 | cut -d " " -f 1)" = 160000 &&
+	test "$(git ls-files --stage --error-unmatch sub.moved | cut -d " " -f 1)" = 160000 &&
+	test "$(git config -f .gitmodules submodule.sub.path)" = "sub.moved"
+
+'
+
+test_expect_success 'git mv of multiple submodules' '
+
+	mkdir -p dir &&
+	git mv sub.moved sub dir &&
+	! test -d sub.moved &&
+	! test -d sub &&
+	test -d dir/sub.moved/.git &&
+	test -d dir/sub/.git &&
+	! git ls-files --error-unmatch sub.moved sub &&
+	test "$(git ls-files --stage --error-unmatch dir/sub.moved dir/sub | cut -d " " -f 1 | uniq)" = 160000 &&
+	! git config -f .gitmodules submodule.dir.path &&
+	test "$(git config -f .gitmodules submodule.sub.path)" = "dir/sub.moved" &&
+	test "$(git config -f .gitmodules submodule.sub~.path)" = "dir/sub"
+
+'
+
+test_expect_success 'git mv of multiple submodules back from a subdir' '
+
+	(cd dir && git mv sub.moved sub .. && cd ..) &&
+	test -d sub.moved &&
+	test -d sub &&
+	! test -d dir/sub.moved/.git &&
+	! test -d dir/sub/.git &&
+	! git ls-files --error-unmatch dir/sub.moved dir/sub &&
+	test "$(git ls-files --stage --error-unmatch sub.moved sub | cut -d " " -f 1 | uniq)" = 160000 &&
+	test "$(git config -f .gitmodules submodule.sub.path)" = "sub.moved" &&
+	test "$(git config -f .gitmodules submodule.sub~.path)" = "sub"
+
+'
+
+test_expect_success 'git mv of non-checked-out submodules' '
+
+	git clone . clone &&
+	(cd clone &&
+	test -d sub &&
+	test -d sub2 &&
+	! test -d sub/.git &&
+	! test -d sub2/.git &&
+	git ls-files --stage --error-unmatch sub sub2 > ls-files.out &&
+	mkdir -p dir &&
+	git mv sub sub2 dir &&
+	! test -d sub &&
+	! test -d sub2 &&
+	test -d dir/sub &&
+	test -d dir/sub2 &&
+	! git ls-files --error-unmatch sub sub2 &&
+	test "$(git ls-files --stage --error-unmatch dir/sub dir/sub2 | cut -d " " -f 1 | uniq)" = 160000 &&
+	git ls-files --stage --error-unmatch dir/sub dir/sub2 | sed "s#dir/##g" | diff - ls-files.out &&
+	test "$(git config -f .gitmodules submodule.sub.path)" = "dir/sub" &&
+	test "$(git config -f .gitmodules submodule.sub2.path)" = "dir/sub2" &&
+	(cd dir && git mv sub2 .. && cd ..) &&
+	test -d sub2 &&
+	! test -d dir/sub2 &&
+	! git ls-files --error-unmatch dir/sub2 &&
+	test "$(git ls-files --stage --error-unmatch sub2 | cut -d " " -f 1)" = 160000 &&
+	test "$(git config -f .gitmodules submodule.sub2.path)" = "sub2")
+
+'
+
+test_expect_success 'checkpointing state with git commit' '
+
+	git commit -m"checkpoint" -a &&
+	(cd clone && git commit -m"clone checkpoint" -a)
+
+'
+
+test_expect_success 'git rm of a regular submodule' '
+
+	git rm sub2 &&
+	test -d sub2/.git &&
+	! git ls-files --error-unmatch sub2 &&
+	! git config -f .gitmodules submodule.sub2.path &&
+	! git config -f .gitmodules submodule.sub2.url
+
+'
+
+test_expect_success 'git rm of a submodule with name different from path' '
+
+	git rm sub.moved &&
+	test -d sub.moved/.git &&
+	! git ls-files --error-unmatch sub.moved &&
+	! git config -f .gitmodules submodule.sub.path &&
+	! git config -f .gitmodules submodule.sub.url
+
+'
+
+test_expect_success 'git rm of a modified submodule' '
+
+	git mv sub dir/sub && # more fun with richer path
+	(cd dir/sub &&
+	 echo mod > file &&
+	 git commit -m "sub mod" file) &&
+	git add dir/sub &&
+	! git rm dir/sub &&
+	test -d dir/sub/.git &&
+	test "$(git ls-files --stage --error-unmatch dir/sub | cut -d " " -f 1)" = "160000" &&
+	git config -f .gitmodules submodule.sub~.path &&
+	git config -f .gitmodules submodule.sub~.url &&
+	git rm -f dir/sub &&
+	test -d dir/sub/.git &&
+	! git ls-files --error-unmatch dir/sub &&
+	! git config -f .gitmodules submodule.sub~.path &&
+	! git config -f .gitmodules submodule.sub~.url
+
+'
+
+test_expect_success 'git rm of a submodule from within a subdirectory' '
+
+	git submodule add "$(pwd)/sub-repo" sub-torm &&
+	mkdir -p dir &&
+	# -f since we did not commit the submodule
+	(cd dir && git rm -f ../sub-torm && cd ..) &&
+	test -d sub-torm/.git &&
+	! git ls-files --error-unmatch sub-torm &&
+	! git config -f .gitmodules submodule.sub-torm.path &&
+	! git config -f .gitmodules submodule.sub-torm.url
+
+'
+
+test_expect_success 'git rm of a non-checked-out submodule' '
+
+	(cd clone &&
+	test -d dir/sub &&
+	! test -d dir/sub/.git &&
+	git rm dir/sub &&
+	! test -d dir/sub &&
+	! git ls-files --error-unmatch dir/sub &&
+	! git config -f .gitmodules submodule.sub.path &&
+	! git config -f .gitmodules submodule.sub.url)
+
+'
+
+test_expect_success 'git rm of a non-checked-out submodule w/ different working tree' '
+
+	(cd clone &&
+	rmdir sub2 &&
+	echo cunning > sub2 &&
+	! git rm sub2 &&
+	test -f sub2 &&
+	test "$(git ls-files --stage --error-unmatch sub2 | cut -d " " -f 1)" = "160000" &&
+	git rm -f sub2 &&
+	! test -e sub2 &&
+	! git ls-files --error-unmatch sub2 &&
+	! git config -f .gitmodules submodule.sub2.path &&
+	! git config -f .gitmodules submodule.sub2.url)
+
+'
+
+test_done
