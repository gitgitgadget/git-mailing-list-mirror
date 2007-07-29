From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 9/9] Fix t1500 for sane work-tree behavior
Date: Mon, 30 Jul 2007 00:26:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707300026350.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Mon Jul 30 01:27:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFIAV-0002oI-A3
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936353AbXG2X1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936312AbXG2X1G
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:27:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:34273 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936353AbXG2X1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:27:04 -0400
Received: (qmail invoked by alias); 29 Jul 2007 23:27:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 30 Jul 2007 01:27:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GJN8EXcvGgEbBMndbNiWeOLKji9/3ZwtPl0/zih
	9ypiFIi4DX2kgl
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707300016470.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54158>


When GIT_DIR=../.git, and no worktree is specified, it is reasonable
to assume that the repository is not bare, that the work tree is ".."
and that the prefix is the basename of the current directory.

This is the sane behavior.

t1500 tested for the old behavior, which was plain wrong.  And this
patch fixes it minimally.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1500-rev-parse.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index ec49966..bea40cb 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -31,9 +31,9 @@ test_rev_parse() {
 test_rev_parse toplevel false false true ''
 
 cd .git || exit 1
-test_rev_parse .git/ false true true .git/
+test_rev_parse .git/ true true false ''
 cd objects || exit 1
-test_rev_parse .git/objects/ false true true .git/objects/
+test_rev_parse .git/objects/ true true false ''
 cd ../.. || exit 1
 
 mkdir -p sub/dir || exit 1
@@ -42,7 +42,7 @@ test_rev_parse subdirectory false false true sub/dir/
 cd ../.. || exit 1
 
 git config core.bare true
-test_rev_parse 'core.bare = true' true false true
+test_rev_parse 'core.bare = true' true false false
 
 git config --unset core.bare
 test_rev_parse 'core.bare undefined' false false true
@@ -50,28 +50,28 @@ test_rev_parse 'core.bare undefined' false false true
 mkdir work || exit 1
 cd work || exit 1
 export GIT_DIR=../.git
-export GIT_CONFIG="$GIT_DIR"/config
+export GIT_CONFIG="$(pwd)"/../.git/config
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true ''
+test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true work/
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false true ''
+test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false false ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
+test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true work/
 
 mv ../.git ../repo.git || exit 1
 export GIT_DIR=../repo.git
-export GIT_CONFIG="$GIT_DIR"/config
+export GIT_CONFIG="$(pwd)"/../repo.git/config
 
 git config core.bare false
 test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false true ''
+test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' true false true ''
+test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
 test_done
-- 
1.5.3.rc3.28.g1406
