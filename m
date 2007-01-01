From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: t/t91??-*: optimize the tests a bit
Date: Sun, 31 Dec 2006 21:49:47 -0800
Message-ID: <11676305901855-git-send-email-normalperson@yhbt.net>
References: <1167630587505-git-send-email-normalperson@yhbt.net> <1167630588899-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 01 06:49:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1G3X-00033h-GU
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 06:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbXAAFtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 00:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbXAAFtw
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 00:49:52 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58439 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932910AbXAAFtv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 00:49:51 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 64EB77DC09A;
	Sun, 31 Dec 2006 21:49:50 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 31 Dec 2006 21:49:50 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.g1ed48
In-Reply-To: <1167630588899-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35727>

This removes some unnecessary 'svn up' calls throughout

t9103-git-svn-graft-branches.sh:
  * removed an 'svn log' call that was leftover from debugging
  * removed multiple git-svn calls with a multi-init / multi-fetch
    combination (which weren't tested before, either)
  * replaced `rev-list ... | head -n1` with `rev-parse ...`
    (not sure what I was thinking when I wrote that)

All this saves about 9 seconds from a test run
(53s -> 44s for 'make t91*') on my 1.3GHz Athlon

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9101-git-svn-props.sh          |   11 +++--------
 t/t9103-git-svn-graft-branches.sh |   14 ++++----------
 t/t9104-git-svn-follow-parent.sh  |    1 -
 3 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 5543b07..46fcec5 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -57,13 +57,10 @@ test_expect_success 'setup some commits to svn' \
 	'cd test_wc &&
 		echo Greetings >> kw.c &&
 		svn commit -m "Not yet an Id" &&
-		svn up &&
 		echo Hello world >> kw.c &&
 		svn commit -m "Modified file, but still not yet an Id" &&
-		svn up &&
 		svn propset svn:keywords Id kw.c &&
-		svn commit -m "Propset Id" &&
-		svn up &&
+		svn commit -m "Propset Id"
 	cd ..'
 
 test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
@@ -86,8 +83,7 @@ test_expect_success "propset CR on crlf files" \
 		svn propset svn:eol-style CR empty &&
 		svn propset svn:eol-style CR crlf &&
 		svn propset svn:eol-style CR ne_crlf &&
-		svn commit -m "propset CR on crlf files" &&
-		svn up &&
+		svn commit -m "propset CR on crlf files"
 	 cd ..'
 
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
@@ -111,8 +107,7 @@ cd test_wc
 	 svn propset svn:eol-style CRLF ne_cr &&
 	 svn propset svn:keywords Id cr &&
 	 svn propset svn:keywords Id ne_cr &&
-	 svn commit -m "propset CRLF on cr files" &&
-	 svn up'
+	 svn commit -m "propset CRLF on cr files"'
 cd ..
 test_expect_success 'fetch and pull latest from svn' \
 	'git-svn fetch && git pull . remotes/git-svn'
diff --git a/t/t9103-git-svn-graft-branches.sh b/t/t9103-git-svn-graft-branches.sh
index 293b98f..b5f7677 100755
--- a/t/t9103-git-svn-graft-branches.sh
+++ b/t/t9103-git-svn-graft-branches.sh
@@ -16,25 +16,19 @@ test_expect_success 'initialize repo' "
 	cd wc &&
 	echo feedme >> branches/a/readme &&
 	svn commit -m hungry &&
-	svn up &&
 	cd trunk &&
 	svn merge -r3:4 $svnrepo/branches/a &&
 	svn commit -m 'merge with a' &&
 	cd ../.. &&
-	svn log -v $svnrepo &&
-	git-svn init -i trunk $svnrepo/trunk &&
-	git-svn init -i a $svnrepo/branches/a &&
-	git-svn init -i tags/a $svnrepo/tags/a &&
-	git-svn fetch -i tags/a &&
-	git-svn fetch -i a &&
-	git-svn fetch -i trunk
+	git-svn multi-init $svnrepo -T trunk -b branches -t tags &&
+	git-svn multi-fetch
 	"
 
 r1=`git-rev-list remotes/trunk | tail -n1`
 r2=`git-rev-list remotes/tags/a | tail -n1`
 r3=`git-rev-list remotes/a | tail -n1`
-r4=`git-rev-list remotes/a | head -n1`
-r5=`git-rev-list remotes/trunk | head -n1`
+r4=`git-rev-parse remotes/a`
+r5=`git-rev-parse remotes/trunk`
 
 test_expect_success 'test graft-branches regexes and copies' "
 	test -n "$r1" &&
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 8d2e2fe..400c21c 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -17,7 +17,6 @@ test_expect_success 'initialize repo' "
 	cd wc &&
 	echo world >> trunk/readme &&
 	svn commit -m 'another commit' &&
-	svn up &&
 	svn mv -m 'rename to thunk' trunk thunk &&
 	svn up &&
 	echo goodbye >> thunk/readme &&
-- 
1.5.0.rc0.g1ed48
