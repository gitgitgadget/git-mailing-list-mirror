From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 6/7 (amend)] extend rev-parse test for --is-inside-work-tree
Date: Wed, 6 Jun 2007 09:13:26 +0200
Message-ID: <20070606071326.GA32642@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx> <20070603144846.GF20061@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 09:13:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvpi4-0004Cg-Fo
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 09:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbXFFHN3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 03:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbXFFHN3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 03:13:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:57761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751897AbXFFHN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 03:13:28 -0400
Received: (qmail invoked by alias); 06 Jun 2007 07:13:27 -0000
Received: from pD9EBB5B0.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.176]
  by mail.gmx.net (mp037) with SMTP; 06 Jun 2007 09:13:27 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+WNikjouyWSjCxykiKQ32/Qq7gh9TaWM8agzz9vy
	E9IKMviQ9gsviI
Content-Disposition: inline
In-Reply-To: <20070603144846.GF20061@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49251>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
New: tests that cwd is used as working tree when GIT_DIR is set (and
GIT_WORK_TREE/core.worktree are unspecified).
---
 t/t1500-rev-parse.sh |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 66b0e58..ec49966 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -17,30 +17,35 @@ test_rev_parse() {
 	shift
 	[ $# -eq 0 ] && return
 
+	test_expect_success "$name: is-inside-work-tree" \
+	"test '$1' = \"\$(git rev-parse --is-inside-work-tree)\""
+	shift
+	[ $# -eq 0 ] && return
+
 	test_expect_success "$name: prefix" \
 	"test '$1' = \"\$(git rev-parse --show-prefix)\""
 	shift
 	[ $# -eq 0 ] && return
 }
 
-test_rev_parse toplevel false false ''
+test_rev_parse toplevel false false true ''
 
 cd .git || exit 1
-test_rev_parse .git/ false true .git/
+test_rev_parse .git/ false true true .git/
 cd objects || exit 1
-test_rev_parse .git/objects/ false true .git/objects/
+test_rev_parse .git/objects/ false true true .git/objects/
 cd ../.. || exit 1
 
 mkdir -p sub/dir || exit 1
 cd sub/dir || exit 1
-test_rev_parse subdirectory false false sub/dir/
+test_rev_parse subdirectory false false true sub/dir/
 cd ../.. || exit 1
 
 git config core.bare true
-test_rev_parse 'core.bare = true' true
+test_rev_parse 'core.bare = true' true false true
 
 git config --unset core.bare
-test_rev_parse 'core.bare undefined' false
+test_rev_parse 'core.bare undefined' false false true
 
 mkdir work || exit 1
 cd work || exit 1
@@ -48,25 +53,25 @@ export GIT_DIR=../.git
 export GIT_CONFIG="$GIT_DIR"/config
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false ''
+test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true ''
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../.git, core.bare = true' true
+test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false true ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false ''
+test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
 mv ../.git ../repo.git || exit 1
 export GIT_DIR=../repo.git
 export GIT_CONFIG="$GIT_DIR"/config
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false ''
+test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true
+test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false true ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' true
+test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' true false true ''
 
 test_done
-- 
1.5.2.1.116.g9f308
