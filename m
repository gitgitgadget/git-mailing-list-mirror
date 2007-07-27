From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 8/8] Fix t1500 for sane work-tree behavior
Date: Fri, 27 Jul 2007 19:59:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271958590.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Fri Jul 27 20:59:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEV25-0007qn-5U
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 20:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761139AbXG0S7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 14:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760975AbXG0S7V
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 14:59:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:47863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756707AbXG0S7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 14:59:21 -0400
Received: (qmail invoked by alias); 27 Jul 2007 18:59:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 27 Jul 2007 20:59:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xvgdZUuuxphnD/TLeXWPWdElGkhytXcYv+ozEP5
	484mf3/P6jfm5m
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707271851370.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53947>


When GIT_DIR=../.git, and no worktree is specified, it is reasonable
to assume that the repository is not bare, that the work tree is ".."
and that the prefix is the basename of the current directory.

This is the sane behavior.

t1500 tested for the old behavior, which was plain wrong.  And this
patch fixes it minimally.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	Yeah, I broke down.  But fixing t1501's style was painful enough.

 t/t1500-rev-parse.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index ec49966..6e792b6 100755
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
+test_rev_parse 'core.bare = true' false false true
 
 git config --unset core.bare
 test_rev_parse 'core.bare undefined' false false true
@@ -53,13 +53,13 @@ export GIT_DIR=../.git
 export GIT_CONFIG="$GIT_DIR"/config
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true ''
+test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true work/
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false true ''
+test_rev_parse 'GIT_DIR=../.git, core.bare = true' false false true work/
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
+test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true work/
 
 mv ../.git ../repo.git || exit 1
 export GIT_DIR=../repo.git
@@ -69,9 +69,9 @@ git config core.bare false
 test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false true ''
+test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' false false true ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' true false true ''
+test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
 test_done
-- 
1.5.3.rc3.18.g49a1
