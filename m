From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-svn: handle changed svn command-line syntax
Date: Fri, 21 Sep 2007 15:27:01 +1200
Message-ID: <46F33A05.2000906@vilain.net>
References: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz> <11903401551014-git-send-email-sam.vilain@catalyst.net.nz> <11903401551812-git-send-email-sam.vilain@catalyst.net.nz> <11903401552164-git-send-email-sam.vilain@catalyst.net.nz> <46F33734.3080408@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 05:33:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYZGj-0002Bz-Qb
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 05:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbXIUDdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 23:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbXIUDdY
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 23:33:24 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:49685 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbXIUDdX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 23:33:23 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1IYZGa-0003m8-It; Fri, 21 Sep 2007 15:33:20 +1200
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id 890051FF99; Fri, 21 Sep 2007 15:33:20 +1200 (NZST)
FCC: imap://sam@localhost/INBOX/Sent
X-Identity-Key: id4
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <46F33734.3080408@vilain.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58823>

Sam Vilain wrote:
> Sam Vilain wrote:
>> Previously, if you passed a revision and a path to svn, it meant to look
>> back at that revision and select that path.  New behaviour is to get the
>> path then go back to the revision.  The old syntax is selected with new
>> syntax PATH@REV.  This new syntax is not supported by the old tools, so we
>> have to try both in turn.
> 
> Blast, this analysis is wrong.  Hold off, I'll see what's really going
> on and re-submit.

ok, figured it out :)

I was close!  I was just thrown off by 'svn ls PATH@REV'

The patch is the same, just the description has changed.

Subject: [PATCH] git-svn: handle changed svn cp command-line syntax

Previously, if you passed a revision and a path to svn cp, it meant to look
back at that revision and select that path.  New behaviour is to get the
path then go back to the revision (like other commands that accept @REV
or -rREV do).  The more consistent syntax is not supported by the old
tools, so we have to try both in turn.
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
1.5.3.2.3.g2f2dcc-dirty
