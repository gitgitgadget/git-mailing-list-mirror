From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Use DBI->table_info instead of DBI->tables
Date: Sat, 31 Mar 2007 15:57:47 +0200
Message-ID: <1175349467524-git-send-email-frank@lichtenheld.de>
References: <11743197614111-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 15:58:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXe65-0001Z5-Rf
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 15:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbXCaN6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 09:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbXCaN6N
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 09:58:13 -0400
Received: from mail.lenk.info ([217.160.134.107]:52630 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbXCaN6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 09:58:13 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HXe6D-0005Eo-Ju; Sat, 31 Mar 2007 15:58:33 +0200
Received: from p3ee3dbc9.dip.t-dialin.net ([62.227.219.201] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HXe5r-0005OK-Bz; Sat, 31 Mar 2007 15:58:11 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HXe5T-0003U5-Kn; Sat, 31 Mar 2007 15:57:47 +0200
X-Mailer: git-send-email 1.5.0.3
In-Reply-To: <11743197614111-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43556>

DBI->table_info is portable across different DBD backends,
DBI->tables is not.

Limit the output to objects of type TABLE.
---
 git-cvsserver.perl |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

 Obviously to be applied on top of my previous
 patch series.
 
 With this patch I was able to use DBD::Pg as backend.
 It is not very comfortable because of the "one db for
 each module" problem, but at least it works.

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 941a91b..5532ae7 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2171,10 +2171,8 @@ sub new
     die "Error connecting to database\n" unless defined $self->{dbh};
 
     $self->{tables} = {};
-    foreach my $table ( $self->{dbh}->tables )
+    foreach my $table ( keys %{$self->{dbh}->table_info(undef,undef,undef,'TABLE')->fetchall_hashref('TABLE_NAME')} )
     {
-        $table =~ s/^"//;
-        $table =~ s/"$//;
         $self->{tables}{$table} = 1;
     }
 
-- 
1.5.0.3
