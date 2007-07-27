From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 7/8] Make t1501 a little saner, and fix it
Date: Fri, 27 Jul 2007 19:58:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271958370.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Fri Jul 27 20:59:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEV1m-0007jS-0Z
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 20:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbXG0S7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 14:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760975AbXG0S7A
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 14:59:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:35175 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757929AbXG0S67 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 14:58:59 -0400
Received: (qmail invoked by alias); 27 Jul 2007 18:58:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 27 Jul 2007 20:58:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hZMoEeXBhHP9D+VgSMp8Moa9iV2HlNEBCDasEy6
	N48ddGC6o2L43e
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707271851370.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53946>


t1501 is still a PITA to debug, but less so than before.  This patch
fixes also the tests which tested for the wrong (old) work-tree behavior.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1501-worktree.sh |  161 +++++++++++++++++++++++++++++----------------------
 1 files changed, 92 insertions(+), 69 deletions(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index aadeeab..fad9a9e 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -4,89 +4,112 @@ test_description='test separate work tree'
 . ./test-lib.sh
 
 test_rev_parse() {
-	name=$1
-	shift
-
-	test_expect_success "$name: is-bare-repository" \
-	"test '$1' = \"\$(git rev-parse --is-bare-repository)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: is-inside-git-dir" \
-	"test '$1' = \"\$(git rev-parse --is-inside-git-dir)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: is-inside-work-tree" \
-	"test '$1' = \"\$(git rev-parse --is-inside-work-tree)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: prefix" \
-	"test '$1' = \"\$(git rev-parse --show-prefix)\""
-	shift
-	[ $# -eq 0 ] && return
+	name="$1"
+	for option in --is-bare-repository --is-inside-git-dir \
+		--is-inside-work-tree --show-prefix
+	do
+		shift
+		test_expect_success "$name: $option" \
+			"test '$1' = \"\$(git rev-parse $option)\""
+		test $# -eq 1 && return
+	done
 }
 
-mkdir -p work/sub/dir || exit 1
-mv .git repo.git || exit 1
+# usage: set_repo <working directory> [<git dir> [<work tree> [env]]]
+set_repo () {
+	cd "$1"
+	say "switching to $(pwd) with GIT_DIR $2"
+
+	test -z "$2" || {
+		GIT_DIR="$2"
+		GIT_CONFIG="$2"/config
+		export GIT_DIR GIT_CONFIG
+	}
+
+	test -z "$3" ||
+	case "$4" in
+	env)
+		GIT_WORK_TREE="$3"
+		export GIT_WORK_TREE
+		git config core.workTree non-existent
+	;;
+	*)
+		git config core.workTree "$3"
+	esac
+}
+
+test_expect_success 'setup' '
+	mkdir -p work/sub/dir &&
+	mv .git repo.git
+'
 
 say "core.worktree = relative path"
-export GIT_DIR=repo.git
-export GIT_CONFIG=$GIT_DIR/config
-unset GIT_WORK_TREE
-git config core.worktree ../work
-test_rev_parse 'outside'      false false false
-cd work || exit 1
-export GIT_DIR=../repo.git
-export GIT_CONFIG=$GIT_DIR/config
-test_rev_parse 'inside'       false false true ''
-cd sub/dir || exit 1
-export GIT_DIR=../../../repo.git
-export GIT_CONFIG=$GIT_DIR/config
+
+set_repo . repo.git ../work
+test_rev_parse 'outside git dir' false false false
+
+set_repo work ../repo.git
+test_rev_parse 'inside git dir' false false true ''
+
+set_repo sub/dir ../../../repo.git
 test_rev_parse 'subdirectory' false false true sub/dir/
-cd ../../.. || exit 1
+cd ../../..
 
 say "core.worktree = absolute path"
-export GIT_DIR=$(pwd)/repo.git
-export GIT_CONFIG=$GIT_DIR/config
-git config core.worktree "$(pwd)/work"
-test_rev_parse 'outside'      false false false
-cd work || exit 1
-test_rev_parse 'inside'       false false true ''
-cd sub/dir || exit 1
+set_repo . $(pwd)/repo.git $(pwd)/work
+test_rev_parse 'outside git dir' false false false
+
+set_repo work
+test_rev_parse 'inside git dir' false false true ''
+
+set_repo sub/dir
 test_rev_parse 'subdirectory' false false true sub/dir/
-cd ../../.. || exit 1
+cd ../../..
 
 say "GIT_WORK_TREE=relative path (override core.worktree)"
-export GIT_DIR=$(pwd)/repo.git
-export GIT_CONFIG=$GIT_DIR/config
-git config core.worktree non-existent
-export GIT_WORK_TREE=work
-test_rev_parse 'outside'      false false false
-cd work || exit 1
-export GIT_WORK_TREE=.
-test_rev_parse 'inside'       false false true ''
-cd sub/dir || exit 1
-export GIT_WORK_TREE=../..
+
+set_repo . $(pwd)/repo.git work env
+test_rev_parse 'outside git dir' false false false
+
+set_repo work "" . env
+test_rev_parse 'inside git dir' false false true ''
+
+set_repo sub/dir "" ../../ env
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
 
+say "GIT_WORK_TREE=absolute path, work tree below git dir"
+
 mv work repo.git/work
 
-say "GIT_WORK_TREE=absolute path, work tree below git dir"
-export GIT_DIR=$(pwd)/repo.git
-export GIT_CONFIG=$GIT_DIR/config
-export GIT_WORK_TREE=$(pwd)/repo.git/work
-test_rev_parse 'outside'              false false false
-cd repo.git || exit 1
-test_rev_parse 'in repo.git'              false true  false
-cd objects || exit 1
-test_rev_parse 'in repo.git/objects'      false true  false
-cd ../work || exit 1
-test_rev_parse 'in repo.git/work'         false false true ''
-cd sub/dir || exit 1
-test_rev_parse 'in repo.git/sub/dir' false false true sub/dir/
-cd ../../../.. || exit 1
+set_repo . $(pwd)/repo.git $(pwd)/repo.git/work env
+test_rev_parse 'outside git dir' false false false
+
+set_repo repo.git
+test_rev_parse 'in repo.git' false true false
+
+set_repo objects
+test_rev_parse 'in repo.git/objects' false true  false
+
+set_repo ../work
+test_rev_parse 'in repo.git/work' false true true ''
+
+set_repo sub/dir
+test_rev_parse 'in repo.git/sub/dir' false true true sub/dir/
+cd ../../../..
+
+test_expect_success 'repo finds its work tree' '
+	(cd repo.git &&
+	 : > work/sub/dir/untracked &&
+	 test sub/dir/untracked = "$(git ls-files --others)")
+'
+
+test_expect_success 'repo finds its work tree from work tree, too' '
+	(cd repo.git/work/sub/dir &&
+	 : > tracked &&
+	 git --git-dir=../../.. add tracked &&
+	 cd ../../.. &&
+	 test sub/dir/tracked = "$(git ls-files)")
+'
 
 test_done
-- 
1.5.3.rc3.18.g49a1
