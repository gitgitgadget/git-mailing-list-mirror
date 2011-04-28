From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] add tests for merge-index / merge-one-file
Date: Thu, 28 Apr 2011 18:39:49 -0400
Message-ID: <20110428223949.GA16027@sigill.intra.peff.net>
References: <20110428223822.GA16004@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aman Gupta <themastermind1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 00:39:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFZsK-0008N6-TG
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 00:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687Ab1D1Wjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 18:39:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49421
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756604Ab1D1Wjv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 18:39:51 -0400
Received: (qmail 6725 invoked by uid 107); 28 Apr 2011 22:41:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Apr 2011 18:41:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2011 18:39:49 -0400
Content-Disposition: inline
In-Reply-To: <20110428223822.GA16004@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172413>

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
work properly in the face of GIT_WORK_TREE.

Signed-off-by: Jeff King <peff@peff.net>
---
We could also exercise the more exotic "both sides added" code paths of
merge-one-file. But anybody who cares about that these days is almost
certainly using "read-tree --aggressive" anyway.

 t/t6060-merge-index.sh |   70 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100755 t/t6060-merge-index.sh

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
new file mode 100755
index 0000000..8f8ec77
--- /dev/null
+++ b/t/t6060-merge-index.sh
@@ -0,0 +1,70 @@
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
+test_expect_failure 'merge-one-file respects GIT_WORK_TREE' '
+	git clone . bare.git &&
+	(cd bare.git &&
+	 mkdir work &&
+	 GIT_WORK_TREE=$PWD/work &&
+	 export GIT_WORK_TREE &&
+	 GIT_INDEX_FILE=$PWD/merge.index &&
+	 export GIT_INDEX_FILE &&
+	 git read-tree -i -m base ten two &&
+	 git merge-index git-merge-one-file -a &&
+	 git cat-file blob :file >work/file-index
+	) &&
+	test_cmp expect-merged bare.git/work/file &&
+	test_cmp expect-merged bare.git/work/file-index
+'
+
+test_done
-- 
1.7.5.rc3.17.g5e09b
