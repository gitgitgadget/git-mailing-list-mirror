From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git-svn: fix segfaults due to initial SVN pool being cleared
Date: Sun, 13 May 2007 01:04:44 -0700
Message-ID: <11790434862131-git-send-email-normalperson@yhbt.net>
References: <11790434841909-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 10:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn95I-00046Z-QD
	for gcvg-git@gmane.org; Sun, 13 May 2007 10:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769AbXEMIEv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 04:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757970AbXEMIEu
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 04:04:50 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53283 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755769AbXEMIEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 04:04:47 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3C4BF7DC0A4;
	Sun, 13 May 2007 01:04:46 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 13 May 2007 01:04:46 -0700
X-Mailer: git-send-email 1.5.2.rc3.18.gf0c86
In-Reply-To: <11790434841909-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47128>

Some parts of SVN always seem to use it, even if the SVN::Ra
object we're using is no longer used and we've created a new one
in its place.  It's also true that only one SVN::Ra connection
can exist at once...  Using SVN::Pool->new_default when the
SVN::Ra object is created doesn't seem to help very much,
either...

Hopefully this fixes all segfault problems users have been
experiencing over the past few months.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ee69598..5352470 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2904,7 +2904,6 @@ sub new {
 	my ($class, $url) = @_;
 	$url =~ s!/+$!!;
 	return $RA if ($RA && $RA->{url} eq $url);
-	$RA->{pool}->clear if $RA;
 
 	SVN::_Core::svn_config_ensure($config_dir, undef);
 	my ($baton, $callbacks) = SVN::Core::auth_open_helper([
-- 
1.5.2.rc3.18.gf0c86
