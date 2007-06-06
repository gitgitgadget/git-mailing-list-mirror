From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 7/7 (amend)] test GIT_WORK_TREE
Date: Wed, 6 Jun 2007 09:14:25 +0200
Message-ID: <20070606071425.GB32642@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx> <20070603144925.GG20061@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 09:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvpiz-0004MP-So
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 09:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXFFHO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 03:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbXFFHO2
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 03:14:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:50653 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750886AbXFFHO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 03:14:28 -0400
Received: (qmail invoked by alias); 06 Jun 2007 07:14:26 -0000
Received: from pD9EBB5B0.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.176]
  by mail.gmx.net (mp034) with SMTP; 06 Jun 2007 09:14:26 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+RH2cuWWqR5xkDlzeYxEYYeKIU+Dnu0oGOIMXyP4
	m0xsQac/FI4bSa
Content-Disposition: inline
In-Reply-To: <20070603144925.GG20061@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49252>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Remove test for fallback work tree with GIT_DIR, this is now in
t1500-rev-parse.sh.
---
 t/t1501-worktree.sh |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100755 t/t1501-worktree.sh

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
new file mode 100755
index 0000000..aadeeab
--- /dev/null
+++ b/t/t1501-worktree.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='test separate work tree'
+. ./test-lib.sh
+
+test_rev_parse() {
+	name=$1
+	shift
+
+	test_expect_success "$name: is-bare-repository" \
+	"test '$1' = \"\$(git rev-parse --is-bare-repository)\""
+	shift
+	[ $# -eq 0 ] && return
+
+	test_expect_success "$name: is-inside-git-dir" \
+	"test '$1' = \"\$(git rev-parse --is-inside-git-dir)\""
+	shift
+	[ $# -eq 0 ] && return
+
+	test_expect_success "$name: is-inside-work-tree" \
+	"test '$1' = \"\$(git rev-parse --is-inside-work-tree)\""
+	shift
+	[ $# -eq 0 ] && return
+
+	test_expect_success "$name: prefix" \
+	"test '$1' = \"\$(git rev-parse --show-prefix)\""
+	shift
+	[ $# -eq 0 ] && return
+}
+
+mkdir -p work/sub/dir || exit 1
+mv .git repo.git || exit 1
+
+say "core.worktree = relative path"
+export GIT_DIR=repo.git
+export GIT_CONFIG=$GIT_DIR/config
+unset GIT_WORK_TREE
+git config core.worktree ../work
+test_rev_parse 'outside'      false false false
+cd work || exit 1
+export GIT_DIR=../repo.git
+export GIT_CONFIG=$GIT_DIR/config
+test_rev_parse 'inside'       false false true ''
+cd sub/dir || exit 1
+export GIT_DIR=../../../repo.git
+export GIT_CONFIG=$GIT_DIR/config
+test_rev_parse 'subdirectory' false false true sub/dir/
+cd ../../.. || exit 1
+
+say "core.worktree = absolute path"
+export GIT_DIR=$(pwd)/repo.git
+export GIT_CONFIG=$GIT_DIR/config
+git config core.worktree "$(pwd)/work"
+test_rev_parse 'outside'      false false false
+cd work || exit 1
+test_rev_parse 'inside'       false false true ''
+cd sub/dir || exit 1
+test_rev_parse 'subdirectory' false false true sub/dir/
+cd ../../.. || exit 1
+
+say "GIT_WORK_TREE=relative path (override core.worktree)"
+export GIT_DIR=$(pwd)/repo.git
+export GIT_CONFIG=$GIT_DIR/config
+git config core.worktree non-existent
+export GIT_WORK_TREE=work
+test_rev_parse 'outside'      false false false
+cd work || exit 1
+export GIT_WORK_TREE=.
+test_rev_parse 'inside'       false false true ''
+cd sub/dir || exit 1
+export GIT_WORK_TREE=../..
+test_rev_parse 'subdirectory' false false true sub/dir/
+cd ../../.. || exit 1
+
+mv work repo.git/work
+
+say "GIT_WORK_TREE=absolute path, work tree below git dir"
+export GIT_DIR=$(pwd)/repo.git
+export GIT_CONFIG=$GIT_DIR/config
+export GIT_WORK_TREE=$(pwd)/repo.git/work
+test_rev_parse 'outside'              false false false
+cd repo.git || exit 1
+test_rev_parse 'in repo.git'              false true  false
+cd objects || exit 1
+test_rev_parse 'in repo.git/objects'      false true  false
+cd ../work || exit 1
+test_rev_parse 'in repo.git/work'         false false true ''
+cd sub/dir || exit 1
+test_rev_parse 'in repo.git/sub/dir' false false true sub/dir/
+cd ../../../.. || exit 1
+
+test_done
-- 
1.5.2.1.116.g9f308
