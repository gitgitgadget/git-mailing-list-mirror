From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix tests to work with older svn
Date: Sat, 13 Jan 2007 02:47:53 -0800
Message-ID: <20070113104753.GA19580@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 11:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5gQl-0004k1-Eo
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 11:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161296AbXAMKr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 05:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161307AbXAMKr4
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 05:47:56 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37839 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161296AbXAMKrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 05:47:55 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CEAC27DC094;
	Sat, 13 Jan 2007 02:47:53 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 13 Jan 2007 02:47:53 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36745>

Some of the recent changes and shortcuts to the tests broke
things for people using older versions of svn:

t9104-git-svn-follow-parent.sh:
  v1.2.3 (from SuSE 10.0 as reported by riddochc on #git
  (thanks!)) required an extra 'svn up'.  I was also able to
  reproduce this with v1.1.4 (Debian Sarge).

lib-git-svn.sh:
  SVN::Repos bindings in versions up to and including 1.1.4
  (Sarge again) do not pass fs-config options to the underlying
  library.  BerkeleyDB repositories also seem completely broken
  on all my Sarge machines; so not using FSFS does not seem to
  be an option for most people.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/lib-git-svn.sh                 |    5 +++--
 t/t9104-git-svn-follow-parent.sh |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index af42ccc..a0f2814 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -25,14 +25,15 @@ perl -w -e "
 use SVN::Core;
 use SVN::Repos;
 \$SVN::Core::VERSION gt '1.1.0' or exit(42);
-SVN::Repos::create('$svnrepo', undef, undef, undef,
-                           { 'fs-config' => 'fsfs'});
+system(qw/svnadmin create --fs-type fsfs/, '$svnrepo') == 0 or exit(41);
 "
 x=$?
 if test $x -ne 0
 then
 	if test $x -eq 42; then
 		err='Perl SVN libraries must be >= 1.1.0'
+	elif test $x -eq 41; then
+		err='svnadmin failed to create fsfs repository'
 	else
 		err='Perl SVN libraries not found or unusable, skipping test'
 	fi
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 400c21c..8d2e2fe 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -17,6 +17,7 @@ test_expect_success 'initialize repo' "
 	cd wc &&
 	echo world >> trunk/readme &&
 	svn commit -m 'another commit' &&
+	svn up &&
 	svn mv -m 'rename to thunk' trunk thunk &&
 	svn up &&
 	echo goodbye >> thunk/readme &&
-- 
Eric Wong
