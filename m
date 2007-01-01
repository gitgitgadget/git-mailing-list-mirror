From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: remove svnadmin dependency from the tests
Date: Sun, 31 Dec 2006 21:49:45 -0800
Message-ID: <1167630587505-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 01 06:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1G3V-00033h-Sr
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 06:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbXAAFtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 00:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932908AbXAAFtt
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 00:49:49 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58433 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932907AbXAAFtt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 00:49:49 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B27337DC094;
	Sun, 31 Dec 2006 21:49:47 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 31 Dec 2006 21:49:47 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.g1ed48
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35725>

We require the libraries now, so we can create repositories
using them (and save some executable load time while we're at
it).

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/lib-git-svn.sh |   39 +++++++++++++++++----------------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 99ada71..af42ccc 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -7,26 +7,10 @@ then
 	exit
 fi
 
-perl -e 'use SVN::Core; $SVN::Core::VERSION gt "1.1.0" or die' >/dev/null 2>&1
-if test $? -ne 0
-then
-	test_expect_success 'Perl SVN libraries not found, skipping test' :
-	test_done
-	exit
-fi
-
 GIT_DIR=$PWD/.git
 GIT_SVN_DIR=$GIT_DIR/svn/git-svn
 SVN_TREE=$GIT_SVN_DIR/svn-tree
 
-svnadmin >/dev/null 2>&1
-if test $? -ne 1
-then
-    test_expect_success 'skipping git-svn tests, svnadmin not found' :
-    test_done
-    exit
-fi
-
 svn >/dev/null 2>&1
 if test $? -ne 1
 then
@@ -37,13 +21,24 @@ fi
 
 svnrepo=$PWD/svnrepo
 
-set -e
-
-if svnadmin create --help | grep fs-type >/dev/null
+perl -w -e "
+use SVN::Core;
+use SVN::Repos;
+\$SVN::Core::VERSION gt '1.1.0' or exit(42);
+SVN::Repos::create('$svnrepo', undef, undef, undef,
+                           { 'fs-config' => 'fsfs'});
+"
+x=$?
+if test $x -ne 0
 then
-	svnadmin create --fs-type fsfs "$svnrepo"
-else
-	svnadmin create "$svnrepo"
+	if test $x -eq 42; then
+		err='Perl SVN libraries must be >= 1.1.0'
+	else
+		err='Perl SVN libraries not found or unusable, skipping test'
+	fi
+	test_expect_success "$err" :
+	test_done
+	exit
 fi
 
 svnrepo="file://$svnrepo"
-- 
1.5.0.rc0.g1ed48
