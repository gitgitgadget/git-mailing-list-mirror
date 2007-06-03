From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 7/7] test GIT_WORK_TREE
Date: Sun, 3 Jun 2007 16:49:25 +0200
Message-ID: <20070603144925.GG20061@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 16:50:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HurPI-0008NF-EI
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 16:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757703AbXFCOt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 10:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760423AbXFCOt3
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 10:49:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:37548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760393AbXFCOt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 10:49:27 -0400
Received: (qmail invoked by alias); 03 Jun 2007 14:49:26 -0000
Received: from pD9EB8AF4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.244]
  by mail.gmx.net (mp010) with SMTP; 03 Jun 2007 16:49:26 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19nt7gTzWFn+2v3QE6bNyl9fLkcW7uOPSFzHi8Thl
	7hbatnWcZ1wrWY
Content-Disposition: inline
In-Reply-To: <20070603144401.GA9518@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49005>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 t/t1501-worktree.sh |  119 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100755 t/t1501-worktree.sh

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
new file mode 100755
index 0000000..d9d9e4a
--- /dev/null
+++ b/t/t1501-worktree.sh
@@ -0,0 +1,119 @@
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
+
+say "fallback work tree (name ending in .git)"
+cd work || exit 1
+export GIT_DIR=../.git
+export GIT_CONFIG=$GIT_DIR/config
+unset GIT_WORK_TREE
+git config core.bare true
+test_rev_parse 'core.bare = true'    true  false false
+git config --unset core.bare
+test_rev_parse 'core.bare undefined' false false true
+git config core.bare false
+test_rev_parse 'core.bare = false'   false false true ''
+cd .. || exit 1
+
+mv .git repo.git || exit 1
+
+say "fallback work tree (name ending in repo.git)"
+cd work || exit 1
+export GIT_DIR=../repo.git
+export GIT_CONFIG=$GIT_DIR/config
+unset GIT_WORK_TREE
+git config core.bare true
+test_rev_parse 'core.bare = true'    true  false false
+git config --unset core.bare
+test_rev_parse 'core.bare undefined' true  false false
+git config core.bare false
+test_rev_parse 'core.bare = false'   false false true ''
+cd .. || exit 1
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
1.5.0.3
