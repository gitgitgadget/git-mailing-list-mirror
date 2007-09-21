From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-svn: handle changed svn command-line syntax
Date: Fri, 21 Sep 2007 14:02:35 +1200
Message-ID: <11903401552164-git-send-email-sam.vilain@catalyst.net.nz>
References: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz>
 <11903401551014-git-send-email-sam.vilain@catalyst.net.nz>
 <11903401551812-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 04:32:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYYJD-00072h-7b
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 04:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbXIUCbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 22:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbXIUCbw
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 22:31:52 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:37000 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbXIUCbw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 22:31:52 -0400
X-Greylist: delayed 1753 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2007 22:31:52 EDT
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1IYXqm-0003ZY-5N; Fri, 21 Sep 2007 14:02:36 +1200
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id 13CBB2C6DE; Fri, 21 Sep 2007 14:02:35 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11903401551812-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58819>

Previously, if you passed a revision and a path to svn, it meant to look
back at that revision and select that path.  New behaviour is to get the
path then go back to the revision.  The old syntax is selected with new
syntax PATH@REV.  This new syntax is not supported by the old tools, so we
have to try both in turn.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 t/t9104-git-svn-follow-parent.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 9eab945..7ba7630 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -51,8 +51,10 @@ test_expect_success 'init and fetch from one svn-remote' "
         "
 
 test_expect_success 'follow deleted parent' "
-        svn cp -m 'resurrecting trunk as junk' \
-               -r2 $svnrepo/trunk $svnrepo/junk &&
+        (svn cp -m 'resurrecting trunk as junk' \
+               $svnrepo/trunk@2 $svnrepo/junk ||
+         svn cp -m 'resurrecting trunk as junk' \
+               -r2 $svnrepo/trunk $svnrepo/junk) &&
         git config --add svn-remote.svn.fetch \
           junk:refs/remotes/svn/junk &&
         git-svn fetch -i svn/thunk &&
-- 
1.5.2.4
