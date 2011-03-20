From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Work around broken ln on solaris as used in t8006
Date: Sun, 20 Mar 2011 19:59:46 -0400
Message-ID: <1300665586-24512-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 01:27:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Sxs-0000ta-Nd
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 01:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290Ab1CUA1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 20:27:09 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:50910 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1CUA1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 20:27:08 -0400
X-Greylist: delayed 1634 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Mar 2011 20:27:08 EDT
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:55469 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Q1SXJ-0000hj-J1; Sun, 20 Mar 2011 19:59:53 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Q1SXJ-0006Nz-I5; Sun, 20 Mar 2011 19:59:53 -0400
X-Mailer: git-send-email 1.7.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169540>

The test setup in t8006-blame-textconv.sh used ln -sf to overwrite an
existing symlink.  Unfortunately, both /usr/bin/ln and
/usr/xpg4/bin/ln on solaris 9 don't properly handle -f when -s is
used.  This caused the test setup to fail which caused subsequent
checks to also fail.

This patch uses changes the first check in the test to rm the symlink
and then create the new symlink using only -s.

The upstream Solaris bug (fixed in 10, but not 9) is documented here:
http://bugs.opensolaris.org/view_bug.do?bug_id=4372462

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 t/t8006-blame-textconv.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index ea64cd8..c5362d9 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -24,8 +24,9 @@ test_expect_success 'setup ' '
 	GIT_AUTHOR_NAME=Number1 git commit -a -m First --date="2010-01-01 18:00:00" &&
 	echo "bin: test 1 version 2" >one.bin &&
 	echo "bin: test number 2 version 2" >>two.bin &&
+	rm symlink.bin &&
 	if test_have_prereq SYMLINKS; then
-		ln -sf two.bin symlink.bin
+		ln -s two.bin symlink.bin
 	fi &&
 	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
 '
-- 
1.7.1
