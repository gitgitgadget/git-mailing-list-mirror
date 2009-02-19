From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] add basic branch display tests
Date: Wed, 18 Feb 2009 22:34:44 -0500
Message-ID: <20090219033444.GA18970@coredump.intra.peff.net>
References: <20090219033329.GA13666@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 04:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZzhw-0001Ge-AV
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 04:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbZBSDes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 22:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753078AbZBSDer
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 22:34:47 -0500
Received: from peff.net ([208.65.91.99]:48560 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbZBSDeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 22:34:46 -0500
Received: (qmail 19017 invoked by uid 107); 19 Feb 2009 03:35:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 22:35:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 22:34:44 -0500
Content-Disposition: inline
In-Reply-To: <20090219033329.GA13666@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110614>

We were not testing the output of "git branch" anywhere.
Not only does this not protect us against regressions in the
output, but we are not exercising code paths which may have
bugs (such as the one fixed by 45e2b61).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3203-branch-output.sh |   81 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100755 t/t3203-branch-output.sh

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
new file mode 100755
index 0000000..809d1c4
--- /dev/null
+++ b/t/t3203-branch-output.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='git branch display tests'
+. ./test-lib.sh
+
+test_expect_success 'make commits' '
+	echo content >file &&
+	git add file &&
+	git commit -m one &&
+	echo content >>file &&
+	git commit -a -m two
+'
+
+test_expect_success 'make branches' '
+	git branch branch-one
+	git branch branch-two HEAD^
+'
+
+test_expect_success 'make remote branches' '
+	git update-ref refs/remotes/origin/branch-one branch-one
+	git update-ref refs/remotes/origin/branch-two branch-two
+	git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/branch-one
+'
+
+cat >expect <<'EOF'
+  branch-one
+  branch-two
+* master
+EOF
+test_expect_success 'git branch shows local branches' '
+	git branch >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+  origin/HEAD -> origin/branch-one
+  origin/branch-one
+  origin/branch-two
+EOF
+test_expect_success 'git branch -r shows remote branches' '
+	git branch -r >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+  branch-one
+  branch-two
+* master
+  remotes/origin/HEAD -> origin/branch-one
+  remotes/origin/branch-one
+  remotes/origin/branch-two
+EOF
+test_expect_success 'git branch -a shows local and remote branches' '
+	git branch -a >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+two
+one
+two
+EOF
+test_expect_success 'git branch -v shows branch summaries' '
+	git branch -v >tmp &&
+	awk "{print \$NF}" <tmp >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+* (no branch)
+  branch-one
+  branch-two
+  master
+EOF
+test_expect_success 'git branch shows detached HEAD properly' '
+	git checkout HEAD^0 &&
+	git branch >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.6.2.rc1.210.g1210c
