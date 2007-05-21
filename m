From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] t9400: Add test cases for config file handling
Date: Sun, 20 May 2007 17:57:27 -0700
Message-ID: <7vlkfjhu2w.fsf@assigned-by-dhcp.cox.net>
References: <11797003182642-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon May 21 02:57:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpwDP-0008FJ-MH
	for gcvg-git@gmane.org; Mon, 21 May 2007 02:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbXEUA53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 20:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbXEUA53
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 20:57:29 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47254 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbXEUA52 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 20:57:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521005728.IIEL15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 20:57:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1cxT1X00J1kojtg0000000; Sun, 20 May 2007 20:57:27 -0400
In-Reply-To: <11797003182642-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Mon, 21 May 2007 00:31:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47956>

This part seems to fail for me and gets an "unexpected cvs success".

+rm -fr cvswork2
+test_expect_success 'gitcvs.ext.enabled = false' \
+  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled false &&
+   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
+   if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1
+   then
+     echo unexpected cvs success
+     false
+   else
+     true
+   fi &&
+   cat cvs.log | grep -q "GITCVS emulation disabled" &&
+   test ! -d cvswork2'
+

I think the per-method enablement logic is not quite right.

-- >8 --
git-cvsserver: ignore global config when per-method config disables an access.

When the per-method enable logic disables the access, we should
not even look at the global one.

 git-cvsserver.perl |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index fcfb99d..1de5177 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -192,11 +192,9 @@ sub req_Root
         }
     }
 
-    unless ( ($cfg->{gitcvs}{$state->{method}}{enabled}
-	      and $cfg->{gitcvs}{$state->{method}}{enabled} =~ /^\s*(1|true|yes)\s*$/i)
-	     or ($cfg->{gitcvs}{enabled}
-	      and $cfg->{gitcvs}{enabled} =~ /^\s*(1|true|yes)\s*$/i) )
-    {
+    my $enabled = ($cfg->{gitcvs}{$state->{method}}{enabled}
+		   || $cfg->{gitcvs}{enabled});
+    unless ($enabled && $enabled =~ /^\s*(1|true|yes)\s*$/i) {
         print "E GITCVS emulation needs to be enabled on this repo\n";
         print "E the repo config file needs a [gitcvs] section added, and the parameter 'enabled' set to 1\n";
         print "E \n";
