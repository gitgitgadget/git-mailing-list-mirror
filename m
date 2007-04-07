From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 2/3] cvsserver: Corrections to the database backend configuration
Date: Sat,  7 Apr 2007 16:58:09 +0200
Message-ID: <11759578901878-git-send-email-frank@lichtenheld.de>
References: <11759575342765-git-send-email-frank@lichtenheld.de> <11759578902278-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 17:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaCP8-0007ux-UM
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 17:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965942AbXDGPAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 11:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965953AbXDGPAL
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 11:00:11 -0400
Received: from mail.lenk.info ([217.160.134.107]:65077 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965942AbXDGPAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 11:00:08 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HaCOw-0003J2-3v; Sat, 07 Apr 2007 17:00:26 +0200
Received: from p54b0f651.dip.t-dialin.net ([84.176.246.81] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HaCOc-0005UD-0C; Sat, 07 Apr 2007 17:00:06 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HaCMk-0007AI-V8; Sat, 07 Apr 2007 16:58:10 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <11759578902278-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43975>

Don't include the scheme name in gitcvs.dbdriver, it is
always 'dbi' anyway.

Don't allow ':' in driver names nor ';' in database names for
sanity reasons.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

 I wasn't sure whether I should send this as a new patch or as a new version of my
 older one?

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 5532ae7..7fe7949 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2149,7 +2149,7 @@ sub new
     die "Git repo '$self->{git_path}' doesn't exist" unless ( -d $self->{git_path} );
 
     $self->{dbdriver} = $cfg->{gitcvs}{$state->{method}}{dbdriver} ||
-        $cfg->{gitcvs}{dbdriver} || "dbi:SQLite";
+        $cfg->{gitcvs}{dbdriver} || "SQLite";
     $self->{dbname} = $cfg->{gitcvs}{$state->{method}}{dbname} ||
         $cfg->{gitcvs}{dbname} || "%Ggitcvs.%m.sqlite";
     $self->{dbuser} = $cfg->{gitcvs}{$state->{method}}{dbuser} ||
@@ -2165,7 +2165,9 @@ sub new
     $self->{dbname} =~ s/%([mauGg])/$mapping{$1}/eg;
     $self->{dbuser} =~ s/%([mauGg])/$mapping{$1}/eg;
 
-    $self->{dbh} = DBI->connect("$self->{dbdriver}:dbname=$self->{dbname}",
+    die "Invalid char ':' in dbdriver" if $self->{dbdriver} =~ /:/;
+    die "Invalid char ';' in dbname" if $self->{dbname} =~ /;/;
+    $self->{dbh} = DBI->connect("dbi:$self->{dbdriver}:dbname=$self->{dbname}",
                                 $self->{dbuser},
                                 $self->{dbpass});
     die "Error connecting to database\n" unless defined $self->{dbh};
-- 
1.5.1
