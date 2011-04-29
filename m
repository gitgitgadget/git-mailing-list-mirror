From: Jeff King <peff@peff.net>
Subject: [PATCHv2 1/2] add tests for merge-index / merge-one-file
Date: Fri, 29 Apr 2011 18:23:54 -0400
Message-ID: <20110429222354.GA3347@sigill.intra.peff.net>
References: <20110429185228.GA27268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Aman Gupta <themastermind1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:24:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFw6W-0003ND-Ax
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab1D2WX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:23:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48441
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485Ab1D2WX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:23:57 -0400
Received: (qmail 16820 invoked by uid 107); 29 Apr 2011 22:25:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Apr 2011 18:25:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 18:23:54 -0400
Content-Disposition: inline
In-Reply-To: <20110429185228.GA27268@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172497>

There were no tests for either, except a brief use in
t1200-tutorial.

These tools are not used much these days, as most people
use the merge-recursive strategy, which handles everything
internally. However, they are used by the "octopus" and
"resolve" strategies, as well as any custom strategies
or merge scripts people have built around them.

For example, together with read-tree, they are the simplest
way to do a basic content-level merge without checking out
the entire repository contents beforehand.

This script adds a basic test of the tools to perform one
content-level merge. It also shows a failure of the tools to
work properly in the face of GIT_WORK_TREE or core.worktree.

Signed-off-by: Jeff King <peff@peff.net>
---
Two new tests in this version:

  - make sure we properly fail when there is no work tree; we do
    already, although it is not entirely graceful. But mainly I wanted
    to make sure I didn't regress on that behavior with the fix in 2/2.

  - check both GIT_WORK_TREE and core.worktree; the latter was still
    broken in the original series

 t/t6060-merge-index.sh |  100 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100755 t/t6060-merge-index.sh

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
new file mode 100755
index 0000000..895f079
--- /dev/null
+++ b/t/t6060-merge-index.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='basic git merge-index / git-merge-one-file tests'
+. ./test-lib.sh
+
+test_expect_success 'setup diverging branches' '
+	for i in 1 2 3 4 5 6 7 8 9 10; do
+		echo $i
+	done >file &&
+	git add file &&
+	git commit -m base &&
+	git tag base &&
+	sed s/2/two/ <file >tmp &&
+	mv tmp file &&
+	git commit -a -m two &&
+	git tag two &&
+	git checkout -b other HEAD^ &&
+	sed s/10/ten/ <file >tmp &&
+	mv tmp file &&
+	git commit -a -m ten &&
+	git tag ten
+'
+
+cat >expect-merged <<'EOF'
+1
+two
+3
+4
+5
+6
+7
+8
+9
+ten
+EOF
+
+test_expect_success 'read-tree does not resolve content merge' '
+	git read-tree -i -m base ten two &&
+	echo file >expect &&
+	git diff-files --name-only --diff-filter=U >unmerged &&
+	test_cmp expect unmerged
+'
+
+test_expect_success 'git merge-index git-merge-one-file resolves' '
+	git merge-index git-merge-one-file -a &&
+	git diff-files --name-only --diff-filter=U >unmerged &&
+	>expect &&
+	test_cmp expect unmerged &&
+	test_cmp expect-merged file &&
+	git cat-file blob :file >file-index &&
+	test_cmp expect-merged file-index
+'
+
+test_expect_success 'setup bare merge' '
+	git clone --bare . bare.git &&
+	(cd bare.git &&
+	 GIT_INDEX_FILE=$PWD/merge.index &&
+	 export GIT_INDEX_FILE &&
+	 git read-tree -i -m base ten two
+	)
+'
+
+test_expect_success 'merge-one-file fails without a work tree' '
+	(cd bare.git &&
+	 GIT_INDEX_FILE=$PWD/merge.index &&
+	 export GIT_INDEX_FILE &&
+	 test_must_fail git merge-index git-merge-one-file -a
+	)
+'
+
+test_expect_failure 'merge-one-file respects GIT_WORK_TREE' '
+	(cd bare.git &&
+	 mkdir work &&
+	 GIT_WORK_TREE=$PWD/work &&
+	 export GIT_WORK_TREE &&
+	 GIT_INDEX_FILE=$PWD/merge.index &&
+	 export GIT_INDEX_FILE &&
+	 git merge-index git-merge-one-file -a &&
+	 git cat-file blob :file >work/file-index
+	) &&
+	test_cmp expect-merged bare.git/work/file &&
+	test_cmp expect-merged bare.git/work/file-index
+'
+
+test_expect_failure 'merge-one-file respects core.worktree' '
+	mkdir subdir &&
+	git clone . subdir/child &&
+	(cd subdir &&
+	 GIT_DIR=$PWD/child/.git &&
+	 export GIT_DIR &&
+	 git config core.worktree "$PWD/child" &&
+	 git read-tree -i -m base ten two &&
+	 git merge-index git-merge-one-file -a &&
+	 git cat-file blob :file >file-index
+	) &&
+	test_cmp expect-merged subdir/child/file &&
+	test_cmp expect-merged subdir/file-index
+'
+
+test_done
-- 
1.7.4.3.28.g10631
